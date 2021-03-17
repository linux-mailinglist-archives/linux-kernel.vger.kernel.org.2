Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1CB33F163
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 14:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhCQNpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 09:45:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50332 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbhCQNop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 09:44:45 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615988681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Na+lFphqen2NhJnca/iDnlIX9jB2yGBpu0dnslPP3Sw=;
        b=HmUZWUBLmn6IAB3L/OM0jdkjjpByEGtn3jIScf64PRbx6uAxEa4vTw4TQuU5dcuSOK/pQd
        FI8U9OTk0XC/Ml44VVtYPvAeihelwWzOUPx3wgFOc/H0ivDHWgGZ4OdCG3iZGh4w+M/S06
        dTY6zFWHshdB5gH9sX9NwttZbSE/ZDxpgTeh2IxUYfyQTIrQpE8CVz+qPc532KTN9PpFbN
        UKo+1U56NqTvPEu88mMbijZQboYLwJGAsNwaGkqIu99lrximURty+NqlZV51q3X4ZiC25j
        BmKc+RJk7bDOyZnnJRt3T6zyOh8Swser+Sw+EXcbbhwHh6Ml8Ze41lBnmg7ifw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615988681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Na+lFphqen2NhJnca/iDnlIX9jB2yGBpu0dnslPP3Sw=;
        b=HUpjtwTiM1ZfaIhIpFSFCRXTSkUIEtOdYop18jg+Kl52yrYCCq6Ur7Oa6SFFH/JVvO8v44
        oLa6tVDrcamOwbBw==
To:     Ira Weiny <ira.weiny@intel.com>,
        Oliver Sang <oliver.sang@intel.com>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        David Sterba <dsterba@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "hch\@infradead.org" <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp\@lists.01.org" <lkp@lists.01.org>,
        "lkp\@intel.com" <lkp@intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: Re: [mm/highmem] 61b205f579: WARNING:at_mm/highmem.c:#__kmap_local_sched_out
In-Reply-To: <20210316073756.GQ3014244@iweiny-DESK2.sc.intel.com>
References: <20210304083825.GB17830@xsang-OptiPlex-9020> <BYAPR04MB496507720FEEF2B77FB639E186929@BYAPR04MB4965.namprd04.prod.outlook.com> <20210311160220.GS3014244@iweiny-DESK2.sc.intel.com> <20210312062755.GA5022@xsang-OptiPlex-9020> <20210316073756.GQ3014244@iweiny-DESK2.sc.intel.com>
Date:   Wed, 17 Mar 2021 14:44:41 +0100
Message-ID: <87blbhzygm.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16 2021 at 00:37, Ira Weiny wrote:
>
> I think I see the issue.  I think this is an invalid configuration.
>
> 00:26:43 > grep DEBUG_KMAP config-5.11.0-rc7-00002-g61b205f57991 
> CONFIG_DEBUG_KMAP_LOCAL=y
> CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP=y
>
> 00:26:48 > grep DEBUG_HIGHMEM config-5.11.0-rc7-00002-g61b205f57991 
> # CONFIG_DEBUG_HIGHMEM is not set

No. It's valid so you can test that crap on 64bit.

> DEBUG_KMAP_LOCAL causes guard pages to be added to the kmap_ctrl array.  But
> DEBUG_HIGHMEM is used in __kmap_local_sched_out() to check the guard pages.
>
> DEBUG_HIGHMEM is supposed to select DEBUG_KMAP_LOCAL...  but apparently that
> did not happen when this configuration was made.
>
> I still have not hit this condition in my testing.  Could you ensure that
> DEBUG_HIGMEM is set and rerun the test to see if I am correct?

Why? The whole point of CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is to allow
testing of this kmap_local/atomic stuff w/o HIGHMEM, e.g. on 64 bit.

> Thomas wouldn't the following enable checks make more sense?  Or perhaps be
> more consistent with the processing of kmap_ctrl?

Neither nor. It's simply required to make DEBUG_KMAP_LOCAL=y &&
HIGHMEM=n case work.

Please add:
Fixes: 0e91a0c6984c ("mm/highmem: Provide CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP")

which should have contained exactly that change:

> -               if (IS_ENABLED(CONFIG_DEBUG_HIGHMEM) && !(i & 0x01)) {
> +               if (IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL) && !(i & 0x01)) {
>                         WARN_ON_ONCE(!pte_none(pteval));
>                         continue;
>                 }
> @@ -654,7 +654,7 @@ void __kmap_local_sched_in(void)
>                 int idx;
>  
>                 /* With debug all even slots are unmapped and act as guard */
> -               if (IS_ENABLED(CONFIG_DEBUG_HIGHMEM) && !(i & 0x01)) {
> +               if (IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL) && !(i & 0x01)) {
>                         WARN_ON_ONCE(!pte_none(pteval));
>                         continue;
>                 }

Thanks,

        tglx
