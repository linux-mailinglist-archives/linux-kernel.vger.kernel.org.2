Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C357542BBE2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 11:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237836AbhJMJqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 05:46:47 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:28933 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235811AbhJMJqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 05:46:46 -0400
Received: from dggeme762-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HTnZQ1sD3zbn3P;
        Wed, 13 Oct 2021 17:40:14 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Wed, 13 Oct 2021 17:44:42 +0800
Subject: Re: [PATCH -next] audit: return early if the rule has a lower
 priority
To:     Dan Carpenter <dan.carpenter@oracle.com>, <kbuild@lists.01.org>,
        Richard Guy Briggs <rgb@redhat.com>, <paul@paul-moore.com>,
        <eparis@redhat.com>
CC:     <lkp@intel.com>, <kbuild-all@lists.01.org>,
        <linux-audit@redhat.com>, <linux-kernel@vger.kernel.org>,
        <xiujianfeng@huawei.com>, <wangweiyang2@huawei.com>
References: <202110130344.odiZFWOO-lkp@intel.com>
From:   cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <2346b716-b705-47cd-e884-244b59342f82@huawei.com>
Date:   Wed, 13 Oct 2021 17:44:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <202110130344.odiZFWOO-lkp@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.176]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have resubmitted a patch to fix the issue, thanks for your advice.

https://patchwork.kernel.org/project/linux-audit/list/?series=562507 
<https://patchwork.kernel.org/project/linux-audit/list/?series=562507>

Cheers,

在 2021/10/13 15:16, Dan Carpenter 写道:
> [ It's Gaosheng's patch which triggers the warning but I think it's
>    actually the dereference which should be changed.  I've added Richard
>    to the CC list. -dan ]
>
> Hi Gaosheng,
>
> url:    https://github.com/0day-ci/linux/commits/Gaosheng-Cui/audit-return-early-if-the-rule-has-a-lower-priority/20211012-093102
> base:    d3134eb5de8546a214c028fb7195e764b89da7d4
> config: x86_64-randconfig-m001-20211012 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> smatch warnings:
> kernel/auditsc.c:653 audit_filter_rules() error: we previously assumed 'ctx' could be null (see line 473)
>
> vim +/ctx +653 kernel/auditsc.c
>
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  461  static int audit_filter_rules(struct task_struct *tsk,
> 93315ed6dd12da Amy Griffis        2006-02-07  462  			      struct audit_krule *rule,
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  463  			      struct audit_context *ctx,
> f368c07d7214a7 Amy Griffis        2006-04-07  464  			      struct audit_names *name,
> f562988350361b Tony Jones         2011-04-27  465  			      enum audit_state *state,
> f562988350361b Tony Jones         2011-04-27  466  			      bool task_creation)
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  467  {
> f562988350361b Tony Jones         2011-04-27  468  	const struct cred *cred;
> 5195d8e217a786 Eric Paris         2012-01-03  469  	int i, need_sid = 1;
> 3dc7e3153eddfc Darrel Goeddel     2006-03-10  470  	u32 sid;
> 8fae47705685fc Richard Guy Briggs 2016-11-20  471  	unsigned int sessionid;
> 3dc7e3153eddfc Darrel Goeddel     2006-03-10  472
> 046a8e46eefb9d Gaosheng Cui       2021-10-12 @473  	if (ctx && rule->prio <= ctx->prio)
>                                                              ^^^
> Checked here.
>
> 046a8e46eefb9d Gaosheng Cui       2021-10-12  474  		return 0;
> 046a8e46eefb9d Gaosheng Cui       2021-10-12  475
> f562988350361b Tony Jones         2011-04-27  476  	cred = rcu_dereference_check(tsk->cred, tsk == current || task_creation);
> f562988350361b Tony Jones         2011-04-27  477
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  478  	for (i = 0; i < rule->field_count; i++) {
> 93315ed6dd12da Amy Griffis        2006-02-07  479  		struct audit_field *f = &rule->fields[i];
> 5195d8e217a786 Eric Paris         2012-01-03  480  		struct audit_names *n;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  481  		int result = 0;
> f1dc4867ff41b7 Richard Guy Briggs 2013-12-11  482  		pid_t pid;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  483
> 93315ed6dd12da Amy Griffis        2006-02-07  484  		switch (f->type) {
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  485  		case AUDIT_PID:
> fa2bea2f5cca5b Paul Moore         2016-08-30  486  			pid = task_tgid_nr(tsk);
> f1dc4867ff41b7 Richard Guy Briggs 2013-12-11  487  			result = audit_comparator(pid, f->op, f->val);
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  488  			break;
> 3c66251e573219 Al Viro            2006-05-06  489  		case AUDIT_PPID:
> 419c58f11fb732 Alexander Viro     2006-09-29  490  			if (ctx) {
> 419c58f11fb732 Alexander Viro     2006-09-29  491  				if (!ctx->ppid)
> c92cdeb45eea38 Richard Guy Briggs 2013-12-10  492  					ctx->ppid = task_ppid_nr(tsk);
> 3c66251e573219 Al Viro            2006-05-06  493  				result = audit_comparator(ctx->ppid, f->op, f->val);
> 419c58f11fb732 Alexander Viro     2006-09-29  494  			}
> 3c66251e573219 Al Viro            2006-05-06  495  			break;
> 34d99af52ad40b Richard Guy Briggs 2015-08-05  496  		case AUDIT_EXE:
> 34d99af52ad40b Richard Guy Briggs 2015-08-05  497  			result = audit_exe_compare(tsk, rule->exe);
> 23bcc480dac204 Ondrej Mosnáček    2018-04-09  498  			if (f->op == Audit_not_equal)
> 23bcc480dac204 Ondrej Mosnáček    2018-04-09  499  				result = !result;
> 34d99af52ad40b Richard Guy Briggs 2015-08-05  500  			break;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  501  		case AUDIT_UID:
> ca57ec0f00c3f1 Eric W. Biederman  2012-09-11  502  			result = audit_uid_comparator(cred->uid, f->op, f->uid);
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  503  			break;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  504  		case AUDIT_EUID:
> ca57ec0f00c3f1 Eric W. Biederman  2012-09-11  505  			result = audit_uid_comparator(cred->euid, f->op, f->uid);
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  506  			break;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  507  		case AUDIT_SUID:
> ca57ec0f00c3f1 Eric W. Biederman  2012-09-11  508  			result = audit_uid_comparator(cred->suid, f->op, f->uid);
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  509  			break;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  510  		case AUDIT_FSUID:
> ca57ec0f00c3f1 Eric W. Biederman  2012-09-11  511  			result = audit_uid_comparator(cred->fsuid, f->op, f->uid);
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  512  			break;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  513  		case AUDIT_GID:
> ca57ec0f00c3f1 Eric W. Biederman  2012-09-11  514  			result = audit_gid_comparator(cred->gid, f->op, f->gid);
> 37eebe39c9731a Matvejchikov Ilya  2011-12-13  515  			if (f->op == Audit_equal) {
> 37eebe39c9731a Matvejchikov Ilya  2011-12-13  516  				if (!result)
> af85d1772e31fe Ondrej Mosnáček    2018-06-05  517  					result = groups_search(cred->group_info, f->gid);
> 37eebe39c9731a Matvejchikov Ilya  2011-12-13  518  			} else if (f->op == Audit_not_equal) {
> 37eebe39c9731a Matvejchikov Ilya  2011-12-13  519  				if (result)
> af85d1772e31fe Ondrej Mosnáček    2018-06-05  520  					result = !groups_search(cred->group_info, f->gid);
> 37eebe39c9731a Matvejchikov Ilya  2011-12-13  521  			}
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  522  			break;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  523  		case AUDIT_EGID:
> ca57ec0f00c3f1 Eric W. Biederman  2012-09-11  524  			result = audit_gid_comparator(cred->egid, f->op, f->gid);
> 37eebe39c9731a Matvejchikov Ilya  2011-12-13  525  			if (f->op == Audit_equal) {
> 37eebe39c9731a Matvejchikov Ilya  2011-12-13  526  				if (!result)
> af85d1772e31fe Ondrej Mosnáček    2018-06-05  527  					result = groups_search(cred->group_info, f->gid);
> 37eebe39c9731a Matvejchikov Ilya  2011-12-13  528  			} else if (f->op == Audit_not_equal) {
> 37eebe39c9731a Matvejchikov Ilya  2011-12-13  529  				if (result)
> af85d1772e31fe Ondrej Mosnáček    2018-06-05  530  					result = !groups_search(cred->group_info, f->gid);
> 37eebe39c9731a Matvejchikov Ilya  2011-12-13  531  			}
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  532  			break;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  533  		case AUDIT_SGID:
> ca57ec0f00c3f1 Eric W. Biederman  2012-09-11  534  			result = audit_gid_comparator(cred->sgid, f->op, f->gid);
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  535  			break;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  536  		case AUDIT_FSGID:
> ca57ec0f00c3f1 Eric W. Biederman  2012-09-11  537  			result = audit_gid_comparator(cred->fsgid, f->op, f->gid);
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  538  			break;
> 8fae47705685fc Richard Guy Briggs 2016-11-20  539  		case AUDIT_SESSIONID:
> 5b71388663c092 Ondrej Mosnáček    2018-05-17  540  			sessionid = audit_get_sessionid(tsk);
> 8fae47705685fc Richard Guy Briggs 2016-11-20  541  			result = audit_comparator(sessionid, f->op, f->val);
> 8fae47705685fc Richard Guy Briggs 2016-11-20  542  			break;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  543  		case AUDIT_PERS:
> 93315ed6dd12da Amy Griffis        2006-02-07  544  			result = audit_comparator(tsk->personality, f->op, f->val);
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  545  			break;
> 2fd6f58ba6efc8 David Woodhouse    2005-04-29  546  		case AUDIT_ARCH:
> 2fd6f58ba6efc8 David Woodhouse    2005-04-29  547  			if (ctx)
> 93315ed6dd12da Amy Griffis        2006-02-07  548  				result = audit_comparator(ctx->arch, f->op, f->val);
> 2fd6f58ba6efc8 David Woodhouse    2005-04-29  549  			break;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  550
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  551  		case AUDIT_EXIT:
> ba59eae7238572 Alex Shi           2020-11-06  552  			if (ctx && ctx->return_valid != AUDITSC_INVALID)
> 93315ed6dd12da Amy Griffis        2006-02-07  553  				result = audit_comparator(ctx->return_code, f->op, f->val);
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  554  			break;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  555  		case AUDIT_SUCCESS:
> ba59eae7238572 Alex Shi           2020-11-06  556  			if (ctx && ctx->return_valid != AUDITSC_INVALID) {
> 93315ed6dd12da Amy Griffis        2006-02-07  557  				if (f->val)
> 93315ed6dd12da Amy Griffis        2006-02-07  558  					result = audit_comparator(ctx->return_valid, f->op, AUDITSC_SUCCESS);
> b01f2cc1c37ac3 David Woodhouse    2005-08-27  559  				else
> 93315ed6dd12da Amy Griffis        2006-02-07  560  					result = audit_comparator(ctx->return_valid, f->op, AUDITSC_FAILURE);
> b01f2cc1c37ac3 David Woodhouse    2005-08-27  561  			}
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  562  			break;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  563  		case AUDIT_DEVMAJOR:
> 16c174bd95cb07 Eric Paris         2012-01-03  564  			if (name) {
> 16c174bd95cb07 Eric Paris         2012-01-03  565  				if (audit_comparator(MAJOR(name->dev), f->op, f->val) ||
> 16c174bd95cb07 Eric Paris         2012-01-03  566  				    audit_comparator(MAJOR(name->rdev), f->op, f->val))
> 16c174bd95cb07 Eric Paris         2012-01-03  567  					++result;
> 16c174bd95cb07 Eric Paris         2012-01-03  568  			} else if (ctx) {
> 5195d8e217a786 Eric Paris         2012-01-03  569  				list_for_each_entry(n, &ctx->names_list, list) {
> 16c174bd95cb07 Eric Paris         2012-01-03  570  					if (audit_comparator(MAJOR(n->dev), f->op, f->val) ||
> 16c174bd95cb07 Eric Paris         2012-01-03  571  					    audit_comparator(MAJOR(n->rdev), f->op, f->val)) {
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  572  						++result;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  573  						break;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  574  					}
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  575  				}
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  576  			}
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  577  			break;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  578  		case AUDIT_DEVMINOR:
> 16c174bd95cb07 Eric Paris         2012-01-03  579  			if (name) {
> 16c174bd95cb07 Eric Paris         2012-01-03  580  				if (audit_comparator(MINOR(name->dev), f->op, f->val) ||
> 16c174bd95cb07 Eric Paris         2012-01-03  581  				    audit_comparator(MINOR(name->rdev), f->op, f->val))
> 16c174bd95cb07 Eric Paris         2012-01-03  582  					++result;
> 16c174bd95cb07 Eric Paris         2012-01-03  583  			} else if (ctx) {
> 5195d8e217a786 Eric Paris         2012-01-03  584  				list_for_each_entry(n, &ctx->names_list, list) {
> 16c174bd95cb07 Eric Paris         2012-01-03  585  					if (audit_comparator(MINOR(n->dev), f->op, f->val) ||
> 16c174bd95cb07 Eric Paris         2012-01-03  586  					    audit_comparator(MINOR(n->rdev), f->op, f->val)) {
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  587  						++result;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  588  						break;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  589  					}
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  590  				}
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  591  			}
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  592  			break;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  593  		case AUDIT_INODE:
> f368c07d7214a7 Amy Griffis        2006-04-07  594  			if (name)
> db510fc5cd9b9d Richard Guy Briggs 2013-07-04  595  				result = audit_comparator(name->ino, f->op, f->val);
> f368c07d7214a7 Amy Griffis        2006-04-07  596  			else if (ctx) {
> 5195d8e217a786 Eric Paris         2012-01-03  597  				list_for_each_entry(n, &ctx->names_list, list) {
> 5195d8e217a786 Eric Paris         2012-01-03  598  					if (audit_comparator(n->ino, f->op, f->val)) {
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  599  						++result;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  600  						break;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  601  					}
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  602  				}
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  603  			}
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  604  			break;
> efaffd6e441786 Eric Paris         2012-01-03  605  		case AUDIT_OBJ_UID:
> efaffd6e441786 Eric Paris         2012-01-03  606  			if (name) {
> ca57ec0f00c3f1 Eric W. Biederman  2012-09-11  607  				result = audit_uid_comparator(name->uid, f->op, f->uid);
> efaffd6e441786 Eric Paris         2012-01-03  608  			} else if (ctx) {
> efaffd6e441786 Eric Paris         2012-01-03  609  				list_for_each_entry(n, &ctx->names_list, list) {
> ca57ec0f00c3f1 Eric W. Biederman  2012-09-11  610  					if (audit_uid_comparator(n->uid, f->op, f->uid)) {
> efaffd6e441786 Eric Paris         2012-01-03  611  						++result;
> efaffd6e441786 Eric Paris         2012-01-03  612  						break;
> efaffd6e441786 Eric Paris         2012-01-03  613  					}
> efaffd6e441786 Eric Paris         2012-01-03  614  				}
> efaffd6e441786 Eric Paris         2012-01-03  615  			}
> efaffd6e441786 Eric Paris         2012-01-03  616  			break;
> 54d3218b31aee5 Eric Paris         2012-01-03  617  		case AUDIT_OBJ_GID:
> 54d3218b31aee5 Eric Paris         2012-01-03  618  			if (name) {
> ca57ec0f00c3f1 Eric W. Biederman  2012-09-11  619  				result = audit_gid_comparator(name->gid, f->op, f->gid);
> 54d3218b31aee5 Eric Paris         2012-01-03  620  			} else if (ctx) {
> 54d3218b31aee5 Eric Paris         2012-01-03  621  				list_for_each_entry(n, &ctx->names_list, list) {
> ca57ec0f00c3f1 Eric W. Biederman  2012-09-11  622  					if (audit_gid_comparator(n->gid, f->op, f->gid)) {
> 54d3218b31aee5 Eric Paris         2012-01-03  623  						++result;
> 54d3218b31aee5 Eric Paris         2012-01-03  624  						break;
> 54d3218b31aee5 Eric Paris         2012-01-03  625  					}
> 54d3218b31aee5 Eric Paris         2012-01-03  626  				}
> 54d3218b31aee5 Eric Paris         2012-01-03  627  			}
> 54d3218b31aee5 Eric Paris         2012-01-03  628  			break;
> f368c07d7214a7 Amy Griffis        2006-04-07  629  		case AUDIT_WATCH:
> 0223fad3c98a95 Richard Guy Briggs 2019-05-22  630  			if (name) {
> 0223fad3c98a95 Richard Guy Briggs 2019-05-22  631  				result = audit_watch_compare(rule->watch,
> 0223fad3c98a95 Richard Guy Briggs 2019-05-22  632  							     name->ino,
> 0223fad3c98a95 Richard Guy Briggs 2019-05-22  633  							     name->dev);
> 0223fad3c98a95 Richard Guy Briggs 2019-05-22  634  				if (f->op == Audit_not_equal)
> 0223fad3c98a95 Richard Guy Briggs 2019-05-22  635  					result = !result;
> 0223fad3c98a95 Richard Guy Briggs 2019-05-22  636  			}
> f368c07d7214a7 Amy Griffis        2006-04-07  637  			break;
> 74c3cbe33bc077 Al Viro            2007-07-22  638  		case AUDIT_DIR:
> 0223fad3c98a95 Richard Guy Briggs 2019-05-22  639  			if (ctx) {
> 74c3cbe33bc077 Al Viro            2007-07-22  640  				result = match_tree_refs(ctx, rule->tree);
> 0223fad3c98a95 Richard Guy Briggs 2019-05-22  641  				if (f->op == Audit_not_equal)
> 0223fad3c98a95 Richard Guy Briggs 2019-05-22  642  					result = !result;
> 0223fad3c98a95 Richard Guy Briggs 2019-05-22  643  			}
> 74c3cbe33bc077 Al Viro            2007-07-22  644  			break;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  645  		case AUDIT_LOGINUID:
> 38f80590486e38 Richard Guy Briggs 2018-05-16  646  			result = audit_uid_comparator(audit_get_loginuid(tsk),
> 38f80590486e38 Richard Guy Briggs 2018-05-16  647  						      f->op, f->uid);
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  648  			break;
> 780a7654cee8d6 Eric W. Biederman  2013-04-09  649  		case AUDIT_LOGINUID_SET:
> 780a7654cee8d6 Eric W. Biederman  2013-04-09  650  			result = audit_comparator(audit_loginuid_set(tsk), f->op, f->val);
> 780a7654cee8d6 Eric W. Biederman  2013-04-09  651  			break;
> bf361231c295d9 Richard Guy Briggs 2019-05-09  652  		case AUDIT_SADDR_FAM:
> bf361231c295d9 Richard Guy Briggs 2019-05-09 @653  			if (ctx->sockaddr)
>                                                                              ^^^^^^^^^^^^^
> Everywhere else checks if "ctx" is NULL before dereferencing it.
>
> bf361231c295d9 Richard Guy Briggs 2019-05-09  654  				result = audit_comparator(ctx->sockaddr->ss_family,
> bf361231c295d9 Richard Guy Briggs 2019-05-09  655  							  f->op, f->val);
> bf361231c295d9 Richard Guy Briggs 2019-05-09  656  			break;
> 3a6b9f85c641a3 Darrel Goeddel     2006-06-29  657  		case AUDIT_SUBJ_USER:
> 3a6b9f85c641a3 Darrel Goeddel     2006-06-29  658  		case AUDIT_SUBJ_ROLE:
> 3a6b9f85c641a3 Darrel Goeddel     2006-06-29  659  		case AUDIT_SUBJ_TYPE:
> 3a6b9f85c641a3 Darrel Goeddel     2006-06-29  660  		case AUDIT_SUBJ_SEN:
> 3a6b9f85c641a3 Darrel Goeddel     2006-06-29  661  		case AUDIT_SUBJ_CLR:
> 3dc7e3153eddfc Darrel Goeddel     2006-03-10  662  			/* NOTE: this may return negative values indicating
> 3dc7e3153eddfc Darrel Goeddel     2006-03-10  663  			   a temporary error.  We simply treat this as a
> 3dc7e3153eddfc Darrel Goeddel     2006-03-10  664  			   match for now to avoid losing information that
> 3dc7e3153eddfc Darrel Goeddel     2006-03-10  665  			   may be wanted.   An error message will also be
> 3dc7e3153eddfc Darrel Goeddel     2006-03-10  666  			   logged upon error */
> 04305e4aff8b05 Ahmed S. Darwish   2008-04-19  667  			if (f->lsm_rule) {
> 2ad312d2093ae5 Steve Grubb        2006-04-11  668  				if (need_sid) {
> 4ebd7651bfc899 Paul Moore         2021-02-19  669  					security_task_getsecid_subj(tsk, &sid);
> 2ad312d2093ae5 Steve Grubb        2006-04-11  670  					need_sid = 0;
> 2ad312d2093ae5 Steve Grubb        2006-04-11  671  				}
> d7a96f3a1ae279 Ahmed S. Darwish   2008-03-01  672  				result = security_audit_rule_match(sid, f->type,
> 3dc7e3153eddfc Darrel Goeddel     2006-03-10  673  								   f->op,
> 90462a5bd30c6e Richard Guy Briggs 2019-01-31  674  								   f->lsm_rule);
> 2ad312d2093ae5 Steve Grubb        2006-04-11  675  			}
> 3dc7e3153eddfc Darrel Goeddel     2006-03-10  676  			break;
> 6e5a2d1d325968 Darrel Goeddel     2006-06-29  677  		case AUDIT_OBJ_USER:
> 6e5a2d1d325968 Darrel Goeddel     2006-06-29  678  		case AUDIT_OBJ_ROLE:
> 6e5a2d1d325968 Darrel Goeddel     2006-06-29  679  		case AUDIT_OBJ_TYPE:
> 6e5a2d1d325968 Darrel Goeddel     2006-06-29  680  		case AUDIT_OBJ_LEV_LOW:
> 6e5a2d1d325968 Darrel Goeddel     2006-06-29  681  		case AUDIT_OBJ_LEV_HIGH:
> 6e5a2d1d325968 Darrel Goeddel     2006-06-29  682  			/* The above note for AUDIT_SUBJ_USER...AUDIT_SUBJ_CLR
> 6e5a2d1d325968 Darrel Goeddel     2006-06-29  683  			   also applies here */
> 04305e4aff8b05 Ahmed S. Darwish   2008-04-19  684  			if (f->lsm_rule) {
> 6e5a2d1d325968 Darrel Goeddel     2006-06-29  685  				/* Find files that match */
> 6e5a2d1d325968 Darrel Goeddel     2006-06-29  686  				if (name) {
> d7a96f3a1ae279 Ahmed S. Darwish   2008-03-01  687  					result = security_audit_rule_match(
> 90462a5bd30c6e Richard Guy Briggs 2019-01-31  688  								name->osid,
> 90462a5bd30c6e Richard Guy Briggs 2019-01-31  689  								f->type,
> 90462a5bd30c6e Richard Guy Briggs 2019-01-31  690  								f->op,
> 90462a5bd30c6e Richard Guy Briggs 2019-01-31  691  								f->lsm_rule);
> 6e5a2d1d325968 Darrel Goeddel     2006-06-29  692  				} else if (ctx) {
> 5195d8e217a786 Eric Paris         2012-01-03  693  					list_for_each_entry(n, &ctx->names_list, list) {
> 90462a5bd30c6e Richard Guy Briggs 2019-01-31  694  						if (security_audit_rule_match(
> 90462a5bd30c6e Richard Guy Briggs 2019-01-31  695  								n->osid,
> 90462a5bd30c6e Richard Guy Briggs 2019-01-31  696  								f->type,
> 90462a5bd30c6e Richard Guy Briggs 2019-01-31  697  								f->op,
> 90462a5bd30c6e Richard Guy Briggs 2019-01-31  698  								f->lsm_rule)) {
> 6e5a2d1d325968 Darrel Goeddel     2006-06-29  699  							++result;
> 6e5a2d1d325968 Darrel Goeddel     2006-06-29  700  							break;
> 6e5a2d1d325968 Darrel Goeddel     2006-06-29  701  						}
> 6e5a2d1d325968 Darrel Goeddel     2006-06-29  702  					}
> 6e5a2d1d325968 Darrel Goeddel     2006-06-29  703  				}
> 6e5a2d1d325968 Darrel Goeddel     2006-06-29  704  				/* Find ipc objects that match */
> a33e6751003c5a Al Viro            2008-12-10  705  				if (!ctx || ctx->type != AUDIT_IPC)
> 6e5a2d1d325968 Darrel Goeddel     2006-06-29  706  					break;
> a33e6751003c5a Al Viro            2008-12-10  707  				if (security_audit_rule_match(ctx->ipc.osid,
> a33e6751003c5a Al Viro            2008-12-10  708  							      f->type, f->op,
> 90462a5bd30c6e Richard Guy Briggs 2019-01-31  709  							      f->lsm_rule))
> a33e6751003c5a Al Viro            2008-12-10  710  					++result;
> 6e5a2d1d325968 Darrel Goeddel     2006-06-29  711  			}
> 6e5a2d1d325968 Darrel Goeddel     2006-06-29  712  			break;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  713  		case AUDIT_ARG0:
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  714  		case AUDIT_ARG1:
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  715  		case AUDIT_ARG2:
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  716  		case AUDIT_ARG3:
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  717  			if (ctx)
> 93315ed6dd12da Amy Griffis        2006-02-07  718  				result = audit_comparator(ctx->argv[f->type-AUDIT_ARG0], f->op, f->val);
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  719  			break;
> 5adc8a6adc91c4 Amy Griffis        2006-06-14  720  		case AUDIT_FILTERKEY:
> 5adc8a6adc91c4 Amy Griffis        2006-06-14  721  			/* ignore this field for filtering */
> 5adc8a6adc91c4 Amy Griffis        2006-06-14  722  			result = 1;
> 5adc8a6adc91c4 Amy Griffis        2006-06-14  723  			break;
> 55669bfa141b48 Al Viro            2006-08-31  724  		case AUDIT_PERM:
> 55669bfa141b48 Al Viro            2006-08-31  725  			result = audit_match_perm(ctx, f->val);
> 0223fad3c98a95 Richard Guy Briggs 2019-05-22  726  			if (f->op == Audit_not_equal)
> 0223fad3c98a95 Richard Guy Briggs 2019-05-22  727  				result = !result;
> 55669bfa141b48 Al Viro            2006-08-31  728  			break;
> 8b67dca9420474 Al Viro            2008-04-28  729  		case AUDIT_FILETYPE:
> 8b67dca9420474 Al Viro            2008-04-28  730  			result = audit_match_filetype(ctx, f->val);
> 0223fad3c98a95 Richard Guy Briggs 2019-05-22  731  			if (f->op == Audit_not_equal)
> 0223fad3c98a95 Richard Guy Briggs 2019-05-22  732  				result = !result;
> 8b67dca9420474 Al Viro            2008-04-28  733  			break;
> 02d86a568c6d2d Eric Paris         2012-01-03  734  		case AUDIT_FIELD_COMPARE:
> 02d86a568c6d2d Eric Paris         2012-01-03  735  			result = audit_field_compare(tsk, cred, f, ctx, name);
> 02d86a568c6d2d Eric Paris         2012-01-03  736  			break;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  737  		}
> f562988350361b Tony Jones         2011-04-27  738  		if (!result)
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  739  			return 0;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  740  	}
> 0590b9335a1c72 Al Viro            2008-12-14  741
> 0590b9335a1c72 Al Viro            2008-12-14  742  	if (ctx) {
> 0590b9335a1c72 Al Viro            2008-12-14  743  		if (rule->filterkey) {
> 0590b9335a1c72 Al Viro            2008-12-14  744  			kfree(ctx->filterkey);
> 5adc8a6adc91c4 Amy Griffis        2006-06-14  745  			ctx->filterkey = kstrdup(rule->filterkey, GFP_ATOMIC);
> 0590b9335a1c72 Al Viro            2008-12-14  746  		}
> 0590b9335a1c72 Al Viro            2008-12-14  747  		ctx->prio = rule->prio;
> 0590b9335a1c72 Al Viro            2008-12-14  748  	}
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  749  	switch (rule->action) {
> 66b12abc846d31 Paul Moore         2016-06-16  750  	case AUDIT_NEVER:
> 619ed58ac4e2fb Sergey Nazarov     2021-06-08  751  		*state = AUDIT_STATE_DISABLED;
> 66b12abc846d31 Paul Moore         2016-06-16  752  		break;
> 66b12abc846d31 Paul Moore         2016-06-16  753  	case AUDIT_ALWAYS:
> 619ed58ac4e2fb Sergey Nazarov     2021-06-08  754  		*state = AUDIT_STATE_RECORD;
> 66b12abc846d31 Paul Moore         2016-06-16  755  		break;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  756  	}
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  757  	return 1;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  758  }
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>
> .
