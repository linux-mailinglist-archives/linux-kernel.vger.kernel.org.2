Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB9D31F567
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 08:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhBSHnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 02:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhBSHnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 02:43:33 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72291C061756
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 23:42:53 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id z68so3245737pgz.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 23:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oTFV9rPg1nPKbc9S7atXr9xERXEJXr62YRZ7PlLRGUk=;
        b=xHtaDBHF7cktpEpSmtIRptUM9MJbSCfCaiDkWIKvn4yYB2AOGab4GnEgjtxosNTgPh
         J3Qf/G13bv3gmXK8nmp5j5aSQ4wg3VVUSHyaH9VA8GCdVZnLLOavPb5LWgdVZwLJTC0b
         qvOLeoI384u9Ib9X5PbZJ0WYH/f6aCzuKBV/4sdMom3XdoMCITMWRWjkTEWsaZbHxwgC
         KQCxGanO1yyWT+Dbf68TwYy5Jcf5rysXBje0TdXQ+puw2Km/BNmMWQHmZSJotqPm6muu
         5dDEyEbDOZoGRsB+Cob/9wauVxeFRVVv9G5DVlRGdcx+tSYPPmhj5leRDE1F87BYXVea
         cx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oTFV9rPg1nPKbc9S7atXr9xERXEJXr62YRZ7PlLRGUk=;
        b=a+1+74REu/LAU7xFU2BQ0KMAHMWdjiVrdohVSN69LzFbMPrWQPF8+JHdiERqTjV81N
         N3M4jqZP2vblx6Yvn+joltEICF3ZC9xXSyj7H8IMrfmvr6yonbHQ5aUXNGPsxhnIWudf
         Ur3hk6M/JvK6Rvk+uoy5acCmroj2Yj9ri0LGrA4b3Xvc4rwjFXSR0GRYdLVx5z1u/PqA
         mSqxyHNlp0+JTj7T5qTpJouTNkPYQLh2FBUxJ1nXRGkOZC8QdQGpQzXcwG+jTP4p+tyL
         2KYVEhbwqLwrdWfAwKga9M+V5rXZFGWjsZnkdJIco9sYqFylwqXULEtaauM9HtEMrkPp
         CS3w==
X-Gm-Message-State: AOAM530lTXtk8GpBLSzgMNqkrLntKmJngo8dxwPk538MP3sz2rKRmiRP
        lh0/R5EG3q4KLRc2OhVfHC/fZQ==
X-Google-Smtp-Source: ABdhPJz6R8WPmQ9rp60/dvOE+XJsbB0+8/Dm92/fkVTd1/DwYDSv+2yUtyeKHhWJ04dPWq5SWTHmjQ==
X-Received: by 2002:a63:5705:: with SMTP id l5mr2747337pgb.223.1613720572970;
        Thu, 18 Feb 2021 23:42:52 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id b14sm8200562pfi.74.2021.02.18.23.42.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Feb 2021 23:42:51 -0800 (PST)
Date:   Fri, 19 Feb 2021 13:12:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     rjw@rjwysocki.net, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] cpufreq: schedutil: Don't consider freq reduction to
 busy CPU if need_freq_update is set
Message-ID: <20210219074249.2hcwcnakihor343h@vireshk-i7>
References: <20210218082514.1437-1-zbestahu@gmail.com>
 <20210218102029.syj6vkltlbtoxsig@vireshk-i7>
 <20210219113804.00004a7e.zbestahu@gmail.com>
 <20210219040933.2o5hhbjb6emf3xl4@vireshk-i7>
 <20210219144140.00004de9.zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219144140.00004de9.zbestahu@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-02-21, 14:41, Yue Hu wrote:
> On Fri, 19 Feb 2021 09:39:33 +0530
> Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> > On 19-02-21, 11:38, Yue Hu wrote:
> > > There's a possibility: we will use the previous freq to update if
> > > next_f is reduced for busy CPU if need_freq_update is set in
> > > sugov_update_next_freq().  
> > 
> > Right.
> > 
> > > This possibility would happen now? And this
> > > update is what we want if it happens?  
> > 
> > This is exactly what we want here, don't reduce speed for busy CPU,
> 
> I understand it should not skip this update but set the same freq as
> previous one again for the special case if need_freq_update is set. Am
> i rt?

The special check, about not reducing freq if CPU had been busy
recently, doesn't have anything to do with need_freq_update.

Though previously we added the need_freq_update check there to make
sure we account for any recent policy min/max change and don't skip
freq update anymore. That won't happen anymore and so we don't need
any check here related to need_freq_update.

If you still have doubt, please explain your concern in detail with an
example as I am failing to understand it.

-- 
viresh
