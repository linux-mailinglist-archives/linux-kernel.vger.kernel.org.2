Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F8033EBBA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhCQImM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhCQIlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:41:47 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7ECC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:41:36 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v4so898102wrp.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AZXjjiZhVyFBNC01MUIZ1qNze1V3aeU2JGzuMmNoJUQ=;
        b=rw72FBt9i1i4U5+EB98PUw+MkyjLy98FpimTMCfw4VotyyNI70irI5V/HvQ3ooS/U0
         rviojx/vyagQOi2d1sY4t/CGkVpQplCuIIqJic5PDYgG5R3XPj0SUAwUMrAi730ELv5o
         NKq3Wc5e9VQYl/5VNxzETd+T4HjFnyu7IQbJ7tkPrICNZBIGnAd2YHaYtXg7iCJT+3V5
         dkbMpxBUaOdsjx47nT/j/rILInKWzMrh/anDQeXd4Sz1v8mTkOB/OTEC+OeskTSjJZuW
         ttAGZa6Kcj9Zfib2tGAQe424SPc9bIY9WLZzscv14UPkLcvRkt5tXnO8ImMPzx1FHG18
         Ljtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=AZXjjiZhVyFBNC01MUIZ1qNze1V3aeU2JGzuMmNoJUQ=;
        b=OFL3uS6u+0rBdlg8dZx4i4+qtcaaRaqVO8BHxpNtUHl7jQXHsEO8XXYkKDCav3owzL
         ZF8iv3RbcN7joNK/kRb40LOiUvn9ewU5tidjcho/8n62W10DysbKkISuXjiGyzlGjtCM
         oF2XR1BQ10NNTsKF4uRjtQfJFlwrYtsvCrHVIC6qmSjJ2Cdz4xNhcqDgoSbUkVXNnDF/
         eHbWpQH5Jgb52We5kZgkze69tlH42oJSLKX6ITpPHjl2D1RTJWl1G7VIF/w9sgV0iYL4
         iZUR7coDvwStDXscjINrD7UI1nfMrPyGCr4zTtyKxxqZQMb7dS63ooTkalhtGF+GfMLD
         rzMA==
X-Gm-Message-State: AOAM532210lKUD3diCLuEDwSfpZj89owyCfylg10X3tEWBfNaCDBqxER
        sWNoNZTnMWXgqFCHUKs5a4Y=
X-Google-Smtp-Source: ABdhPJxM1elKKeRjF2FRYdMt1tAad/s9NP5emeLKUPUA83Ws/3eyHs0MZEeWTn5opOWhYA2u/jQ8qA==
X-Received: by 2002:adf:fac1:: with SMTP id a1mr3309750wrs.98.1615970494954;
        Wed, 17 Mar 2021 01:41:34 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id a75sm1779746wme.10.2021.03.17.01.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 01:41:34 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 17 Mar 2021 09:41:32 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: replace if (cond) BUG() with BUG_ON()
Message-ID: <20210317084132.GA378908@gmail.com>
References: <1615949121-70877-1-git-send-email-jiapeng.chong@linux.alibaba.com>
 <20210317083947.GD3881262@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317083947.GD3881262@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:
> 
> > Fix the following coccicheck warnings:
> > 
> > ./kernel/sched/core.c:8039:2-5: WARNING: Use BUG_ON instead of if
> > condition followed by BUG.
> > 
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> > ---
> >  kernel/sched/core.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 9819121..7392bc0 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -8035,8 +8035,7 @@ void __init sched_init_smp(void)
> >  	mutex_unlock(&sched_domains_mutex);
> >  
> >  	/* Move init over to a non-isolated CPU */
> > -	if (set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_FLAG_DOMAIN)) < 0)
> > -		BUG();
> > +	BUG(set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_FLAG_DOMAIN)) < 0);
> 
> The patch doesn't quite do what the title & changelog claims...

More importantly, we use this pattern when we don't want !CONFIG_BUG 
to remove the 'condition'.

I.e. the "side effect" here is important scheduler logic. It must 
never be optimized out.

Thanks,

	Ingo
