Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BAB3FEF2F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 16:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345369AbhIBOKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 10:10:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55431 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233999AbhIBOKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 10:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630591774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pTF4gPrB1r2rsS1RooLpTnHL4loWsxfDN3q9qZohAzI=;
        b=XqArt96pA+lwpiY2RMzFcuKmukzrLB71NAs1tA7m7sQfA+H0E6BjmCXB2VsGhKjPnTK5gO
        q4iX9rUvBjJCcWTxjMXKd1Pk1YDIYOCVCkfTZlw5XVVIx4R3j3jQePTsXDnzX/8X86htws
        AKswLZ+oJ8uoCt1ANAMPATSiGFkm8V8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-l_C7Gu4ONy2V068N4ywxlw-1; Thu, 02 Sep 2021 10:09:31 -0400
X-MC-Unique: l_C7Gu4ONy2V068N4ywxlw-1
Received: by mail-wr1-f72.google.com with SMTP id u2-20020adfdd42000000b001579f5d6779so580020wrm.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 07:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pTF4gPrB1r2rsS1RooLpTnHL4loWsxfDN3q9qZohAzI=;
        b=aUcst1YW38WDMymYFh0NJfoCtEliTMlfGNmHPqwKkXpOyaLfxaSQnbBtiK0wiJn5p6
         wydE6ImoqWCyKJ0TEl9I4VbQHUyw38rnPSkR3sM39iPwgSSxZqTNSzNdBs1tu/hk8KkI
         jzyMsMEHwuMqzegiDL5cIeHUKkWjnLbQIf3ZCuDpv7pUyjwP2/ltvIzHiuereyZjto+z
         AaKV2Fiq4mO83X0WixHjeWf3mVvcwNUJqBrSu/Kok6KxcRtAu7bwxv6g5izA4R3SQ5DJ
         TEgOjdh4ldSKavNYeENuH93l7JyUEs21+7FXSIfmkuHyVXqTjqr0ajt1VRMMi0hNli/8
         ykrA==
X-Gm-Message-State: AOAM533M3dgeQFIw6L1Y3N4hynJuvf+r/g1xRhktY1Jd0C1m6fmOuKPP
        SxzXkAIB+4BCrr3IyZ523fmfH+KnFg9spTfZfIZW84q/L1rR0U9Sgf3yrbKcntFfdnVEn7Lte2o
        LVBzmlTQbMidto6+KX/jc4/oi
X-Received: by 2002:a7b:cbcd:: with SMTP id n13mr3503667wmi.49.1630591770629;
        Thu, 02 Sep 2021 07:09:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9HQHTKySekyMq7LhXiqScOa8G4nrk4G92SdsNddjT+lx6ImqIkL0jnQHzss+8+9JTbIpCCA==
X-Received: by 2002:a7b:cbcd:: with SMTP id n13mr3503636wmi.49.1630591770367;
        Thu, 02 Sep 2021 07:09:30 -0700 (PDT)
Received: from krava ([94.113.247.3])
        by smtp.gmail.com with ESMTPSA id z14sm1729988wmi.24.2021.09.02.07.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 07:09:29 -0700 (PDT)
Date:   Thu, 2 Sep 2021 16:09:27 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Steven Rostedt <srostedt@vmware.com>
Cc:     kbuild@lists.01.org, Jiri Olsa <jolsa@kernel.org>, lkp@intel.com,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [jolsa-perf:ftrace/direct 5/8] kernel/trace/ftrace.c:5150
 register_ftrace_direct() error: uninitialized symbol 'entry'.
Message-ID: <YTDbFyJr80xtAaXf@krava>
References: <202109010541.2HLm1TVa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202109010541.2HLm1TVa-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 01:27:17PM +0300, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git ftrace/direct
> head:   95a037919f1906d8bf164fb0c0066c9f298df139
> commit: b45bdf4de5473d5c15090eceeb72a2d5082cde2d [5/8] ftrace: Add ftrace_add_rec_direct function
> config: x86_64-randconfig-m001-20210831 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>


Steven,
I have fix for this one.. I'll wait if there are any review comments
and then post all together

thanks,
jirka

> 
> smatch warnings:
> kernel/trace/ftrace.c:5150 register_ftrace_direct() error: uninitialized symbol 'entry'.
> 
> vim +/entry +5150 kernel/trace/ftrace.c
> 
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5111) int register_ftrace_direct(unsigned long ip, unsigned long addr)
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5112) {
> 013bf0da047481 Steven Rostedt (VMware  2019-11-08  5113) 	struct ftrace_direct_func *direct;
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5114) 	struct ftrace_func_entry *entry;
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5115) 	struct ftrace_hash *free_hash = NULL;
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5116) 	struct dyn_ftrace *rec;
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5117) 	int ret = -EBUSY;
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5118) 
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5119) 	mutex_lock(&direct_mutex);
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5120) 
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5121) 	/* See if there's a direct function at @ip already */
> ff205766dbbee0 Alexei Starovoitov      2019-12-08  5122  	if (ftrace_find_rec_direct(ip))
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5123) 		goto out_unlock;
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5124) 
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5125) 	ret = -ENODEV;
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5126) 	rec = lookup_rec(ip, ip);
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5127) 	if (!rec)
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5128) 		goto out_unlock;
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5129) 
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5130) 	/*
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5131) 	 * Check if the rec says it has a direct call but we didn't
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5132) 	 * find one earlier?
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5133) 	 */
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5134) 	if (WARN_ON(rec->flags & FTRACE_FL_DIRECT))
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5135) 		goto out_unlock;
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5136) 
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5137) 	/* Make sure the ip points to the exact record */
> 406acdd32d3e7d Steven Rostedt (VMware  2019-11-15  5138) 	if (ip != rec->ip) {
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5139) 		ip = rec->ip;
> 406acdd32d3e7d Steven Rostedt (VMware  2019-11-15  5140) 		/* Need to check this ip for a direct. */
> ff205766dbbee0 Alexei Starovoitov      2019-12-08  5141  		if (ftrace_find_rec_direct(ip))
> 406acdd32d3e7d Steven Rostedt (VMware  2019-11-15  5142) 			goto out_unlock;
> 406acdd32d3e7d Steven Rostedt (VMware  2019-11-15  5143) 	}
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5144) 
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5145) 	ret = -ENOMEM;
> 013bf0da047481 Steven Rostedt (VMware  2019-11-08  5146) 	direct = ftrace_find_direct_func(addr);
> 013bf0da047481 Steven Rostedt (VMware  2019-11-08  5147) 	if (!direct) {
> 8a141dd7f7060d Alexei Starovoitov      2021-03-16  5148  		direct = ftrace_alloc_direct_func(addr);
> 013bf0da047481 Steven Rostedt (VMware  2019-11-08  5149) 		if (!direct) {
> 013bf0da047481 Steven Rostedt (VMware  2019-11-08 @5150) 			kfree(entry);
> 
> Delete this kfree.  "entry" isn't initialized yet.
> 
> 013bf0da047481 Steven Rostedt (VMware  2019-11-08  5151) 			goto out_unlock;
> 013bf0da047481 Steven Rostedt (VMware  2019-11-08  5152) 		}
> 013bf0da047481 Steven Rostedt (VMware  2019-11-08  5153) 	}
> 013bf0da047481 Steven Rostedt (VMware  2019-11-08  5154) 
> b45bdf4de5473d Jiri Olsa               2021-05-18  5155  	entry = ftrace_add_rec_direct(ip, addr, &free_hash);
>                                                                 ^^^^^^
> 
> b45bdf4de5473d Jiri Olsa               2021-05-18  5156  	if (!entry)
> b45bdf4de5473d Jiri Olsa               2021-05-18  5157  		goto out_unlock;
> 
> This patch should probably do free direct or something.  The error
> handling in this function is quite confusing so I'm not exactly sure.
> 
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5158) 
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5159) 	ret = ftrace_set_filter_ip(&direct_ops, ip, 0, 0);
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5160) 	if (ret)
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5161) 		remove_hash_entry(direct_functions, entry);
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5162) 
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5163) 	if (!ret && !(direct_ops.flags & FTRACE_OPS_FL_ENABLED)) {
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5164) 		ret = register_ftrace_function(&direct_ops);
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5165) 		if (ret)
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5166) 			ftrace_set_filter_ip(&direct_ops, ip, 1, 0);
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5167) 	}
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5168) 
> 013bf0da047481 Steven Rostedt (VMware  2019-11-08  5169) 	if (ret) {
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5170) 		kfree(entry);
> 013bf0da047481 Steven Rostedt (VMware  2019-11-08  5171) 		if (!direct->count) {
> 013bf0da047481 Steven Rostedt (VMware  2019-11-08  5172) 			list_del_rcu(&direct->next);
> 013bf0da047481 Steven Rostedt (VMware  2019-11-08  5173) 			synchronize_rcu_tasks();
> 013bf0da047481 Steven Rostedt (VMware  2019-11-08  5174) 			kfree(direct);
> 013bf0da047481 Steven Rostedt (VMware  2019-11-08  5175) 			if (free_hash)
> 013bf0da047481 Steven Rostedt (VMware  2019-11-08  5176) 				free_ftrace_hash(free_hash);
> 013bf0da047481 Steven Rostedt (VMware  2019-11-08  5177) 			free_hash = NULL;
> a3ad1a7e396890 Steven Rostedt (VMware  2019-11-08  5178) 			ftrace_direct_func_count--;
> 013bf0da047481 Steven Rostedt (VMware  2019-11-08  5179) 		}
> 013bf0da047481 Steven Rostedt (VMware  2019-11-08  5180) 	} else {
> 013bf0da047481 Steven Rostedt (VMware  2019-11-08  5181) 		direct->count++;
> 013bf0da047481 Steven Rostedt (VMware  2019-11-08  5182) 	}
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5183)  out_unlock:
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5184) 	mutex_unlock(&direct_mutex);
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5185) 
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5186) 	if (free_hash) {
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5187) 		synchronize_rcu_tasks();
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5188) 		free_ftrace_hash(free_hash);
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5189) 	}
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5190) 
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5191) 	return ret;
> 763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5192) }
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

