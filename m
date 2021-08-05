Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6643E198E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 18:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbhHEQbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 12:31:31 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42786 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbhHEQbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 12:31:06 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1FB5B1FE71;
        Thu,  5 Aug 2021 16:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628181050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+MrL1b1drtqy4Gk/f99uTn3RiVNrzzkbJ+aPk2fxvUY=;
        b=rya49p0E6Erptk8iv1IoR/F0mMJMMqmeOD5nl1AgPFk0fueFOi3ifYPlCnUeWDmZzoSriD
        afWd7rL8J7TP1tNHeOtkeY0mYDM4bVc3f9cfGoaCFKGbrlpvl/wtn/AyvW3MqRaR2gg475
        4D1IAGy3LkBypTYpu8RWjHTtU31EoKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628181050;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+MrL1b1drtqy4Gk/f99uTn3RiVNrzzkbJ+aPk2fxvUY=;
        b=9W6cV2W1NIICTx3Ipt8xPAkCTBDZDAZ8qqzAB6y/k+O4Xwa1yYc/hLhrcopn3EP+k88f3q
        Yu2k+jnte4XiJcAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD4BD13DB3;
        Thu,  5 Aug 2021 16:30:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MHWKHTgSDGG9CgAAMHmgww
        (envelope-from <colyli@suse.de>); Thu, 05 Aug 2021 16:30:48 +0000
Subject: Re: [bcache:nvdimm-meta 11/12] drivers/md/bcache/journal.c:114
 journal_read_bucket() error: potentially dereferencing uninitialized 'j'.
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, kbuild@lists.01.org
References: <202108050754.7KPm2WwN-lkp@intel.com>
From:   Coly Li <colyli@suse.de>
Message-ID: <2c46204f-0baf-e1d1-cd9e-f37224f70dd4@suse.de>
Date:   Fri, 6 Aug 2021 00:30:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <202108050754.7KPm2WwN-lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/21 7:18 PM, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/colyli/linux-bcache.git nvdimm-meta
> head:   a12f8ec824edd1317f14882c7d0aee5e5c941edd
> commit: 5f408d113974d2bb3eb1b237d549724f7509ab23 [11/12] bcache: read jset from NVDIMM pages for journal replay
> config: x86_64-randconfig-m001-20210804 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> smatch warnings:
> drivers/md/bcache/journal.c:114 journal_read_bucket() error: potentially dereferencing uninitialized 'j'.
>
> vim +/j +114 drivers/md/bcache/journal.c
>
> cafe563591446c Kent Overstreet   2013-03-23  106  
> cafe563591446c Kent Overstreet   2013-03-23  107  		/* This function could be simpler now since we no longer write
> cafe563591446c Kent Overstreet   2013-03-23  108  		 * journal entries that overlap bucket boundaries; this means
> cafe563591446c Kent Overstreet   2013-03-23  109  		 * the start of a bucket will always have a valid journal entry
> cafe563591446c Kent Overstreet   2013-03-23  110  		 * if it has any journal entries at all.
> cafe563591446c Kent Overstreet   2013-03-23  111  		 */
>
> On my kernel there is a "j = data;" line here, but I guess it got
> removed so that's why Smatch is complaining?

Removing "j = data" is on purpose, the jset *j is initialized by the
previous code block which I list here,
  96         while (offset < ca->sb.bucket_size) {
  97 reread:         left = ca->sb.bucket_size - offset;
  98                 len = min_t(unsigned int, left, PAGE_SECTORS <<
JSET_BITS);
  99
 100                 if (!bch_has_feature_nvdimm_meta(&ca->sb))
 101                         j = __jnl_rd_bkt(ca, bucket_index, len,
offset, &cl);
 102 #if defined(CONFIG_BCACHE_NVM_PAGES)
 103                 else
 104                         j = __jnl_rd_nvm_bkt(ca, bucket_index, len,
offset);
 105 #endif
 106
 107                 /* This function could be simpler now since we no
longer write
 108                  * journal entries that overlap bucket boundaries;
this means
 109                  * the start of a bucket will always have a valid
journal entry
 110                  * if it has any journal entries at all.
 111                  */
 112                 while (len) {

jset *j is initialized at line 101 for non CONFIG_BCACHE_NVM_PAGES
condition, and at line 104 for configed CONFIG_BCACHE_NVM_PAGES condition.

The warning might be from a missing condition check for "else if
(bch_has_feature_nvdimm_meta(&ca->sb))" in code block line 100 to line
105. The static checking tool may think for such condition branch, jset
*j is undefined and referenced by the following code. But if
CONFIG_BCACHE_NVM_PAGES is not configured, such condition branch won't
happen, the supported feature set checking will make sure if the cache
device is formatted to use nvdimm but the kernel does not support yet,
the kernel will report unsupported feature and fail the registration.

Your remind is informative and helpful, before reconstruct  the source
code files to handle the config condition more clean, I will add code
comments at line 102 to explain how the undefined jset *j won't happen.

Thanks.

Coly Li

> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>

