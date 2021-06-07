Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D2139D600
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 09:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhFGH3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 03:29:46 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:46824 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbhFGH3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 03:29:45 -0400
Received: by mail-pl1-f174.google.com with SMTP id e1so8126866pld.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 00:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UH4ITteZ0Gxnyn4y+x9sWM2vqjBorgoraSHazduYHes=;
        b=Vi/O2uI3D/XIoi5FEulXYwE/WTB9L4hz/zxp5mTrNXmZKWthsYzk5+EggOkpfIwUkb
         LvT5G/82KCA32xeDgvcYcF5gYVt3mkGsrKZIHuh62jfWHLKAXl4bNCeA2evK97k2Ksh1
         AZiicUW4KjpxhA43L8fvpKdHQELjJA/HX2nchQU43pDuNU2oB5Mhc/FbxXgvLm9tpkHh
         3eR9T5EXf5MXaJSCREAMSmg7BZPIy3k1XgqG8onvgWz1gi3kw2b8dSmt5L5cnREIdH/W
         RPWgHqoxy8jjho9di0z7p/fSqemE/zRn8D5Amjg/De6BgRQxZlIg7YFC86FtuI+FJ9q9
         kJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UH4ITteZ0Gxnyn4y+x9sWM2vqjBorgoraSHazduYHes=;
        b=Ch6gmMYlFTgRs9FgiEWLLl6ZpkbtJk7yJdxVxWH9ujdl912QSIsTCe7R5kv/4Fd5Vh
         vkSDAWiHAzLiK2Q3hsZGhLgriPcb9spTrPoSM1A1SPPMUN/EWkvxDw8kX7/exIZb+P6i
         ZZbefE04y/pEwuJIaeSPvuNlAbmlQJ3XPgGvn+R2E8rFghOIX4sbhkLQEiytpDGT1APp
         VdFqzGdt1A+67PutTCPyAxfa7Jzjln1UyA+km4CUfWGcOdrUCtjNoCpIRmFbwFbILAqM
         s3LM36DpzZAFljGrVQ51dU3FeQc7C4A5T4zG0b1qAlIWzI7Z5dnnBxLyY93GWnM3uHjt
         AnqA==
X-Gm-Message-State: AOAM530NRN5SLQHZTsmSUdXAAp9lXQqSfINqm+8f6VQSR2CRhgK5NFDJ
        Q36w3zJ0+Vh/fxCPNbsX5/HoXg==
X-Google-Smtp-Source: ABdhPJzTMrIyipw4qtNzpiN3xMLwN8qa1zPVA0HvJmlnl+IqGFBhPPAzSA1q7Fgs3WmypBcMsKzgOA==
X-Received: by 2002:a17:902:b482:b029:10f:39f1:67de with SMTP id y2-20020a170902b482b029010f39f167demr15552688plr.19.1623050799941;
        Mon, 07 Jun 2021 00:26:39 -0700 (PDT)
Received: from localhost ([136.185.169.128])
        by smtp.gmail.com with ESMTPSA id k25sm7396690pfk.33.2021.06.07.00.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 00:26:39 -0700 (PDT)
Date:   Mon, 7 Jun 2021 12:56:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     kyle.meyer@hpe.com, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] acpi-cpufreq: Skip cleanup if initialization didn't occur
Message-ID: <20210607072637.b5mwcalab7y2vikx@vireshk-i7>
References: <20210604170500.46875-1-kyle.meyer@hpe.com>
 <20210607032550.qdnl2sxnny42rtwa@vireshk-i7>
 <s5h35tuf8qd.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h35tuf8qd.wl-tiwai@suse.de>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-06-21, 09:13, Takashi Iwai wrote:
> The missing key information is that it's a fix for the recent change
> for 5.14, i.e. 
> Fixes: c1d6d2fd2f64 ("cpufreq: acpi-cpufreq: Skip initialization if cpufreq driver is present")
> 
> The change made the module left even if it exits before registering
> the cpufreq driver object.

The original patch looks buggy to me, I was never able to review it :(

I have replied on the original thread instead.

-- 
viresh
