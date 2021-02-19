Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021FE31F6C2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 10:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhBSJs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 04:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhBSJsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 04:48:53 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCC8C061756
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 01:48:13 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id z68so3602918pgz.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 01:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eXTn3zOUMXGAyBukHeWslQDjuh7yzOFRAU7s48iWGXY=;
        b=zNgYaMrXXz6+R4FybaHK/hQx49PQbMvGjdW+JliE/hIJY13cHiHHZV0UTIdXwJwJ6j
         7/LMQuIDF+c5ojsQdJlqV1Qh71w9MLzaCt4a60bIOi7irShdmyLAGGWV9T5wTyAKKh7I
         cUhE5h9bwzDXEfsR5a1S3DH4Zuiui5hsnDl6KcSS5wJxwbdsZnjPAu9KXm2ZDoAR77DY
         NleVaeMEhbhTTux/hiZVLPyYTP9N1wiUJu6CgvWM7vgPNLLzyWrJdmght2M66wwJSAds
         hv4XBex5Camt9avhNo4xuMOaPqH+W89IMsYHHP7y7q2CLhAY+77HpSvV8PGivaW4e6D+
         cmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eXTn3zOUMXGAyBukHeWslQDjuh7yzOFRAU7s48iWGXY=;
        b=kYqEDdD50K0uqF8qDc+NZRcNQBx3kTMK19u3BJj/oqXt8h2GfQbl9pCbLKs6qQgYR2
         nyWKbyo+P6HA/odSgznKASxrTUwXskm+3xoesEeKFlDkeZtwybx/+AqUlV84i5gcy7sD
         YjdWUUjT72333Z1c0IBrHQIHezCWGP+U0wih3T3I+tM/+AH+ItwB33OpkDzEFWZUovr1
         ptXIpxWS0c5AY1D/0g7mpH30/bCWf96gNNJM87w5LCXuwoeOtg6CL2Rmokt6b/RRgQDY
         harWXnOWjsHY/+q9a7aw1DP5jfQDUiZKDxOGMyC3DAAxe13A/tobQibF0GLmlq0zHEsw
         zjYg==
X-Gm-Message-State: AOAM531zYCiESWqqngrY+Y4/3wd62yFcfoQ1pzqG2v5qUyEd1i++a9RY
        O4lGhndWEfN8r9z5Oh4lVP717NRrEpX5Zw==
X-Google-Smtp-Source: ABdhPJwFlEMElb1VfgOFhwzwo+Ug/EgvHNFmYS3/8CpID39RYcy97gnkJFxUH41+HKt0qMYD6KDPiA==
X-Received: by 2002:a63:5d59:: with SMTP id o25mr7657009pgm.322.1613728092545;
        Fri, 19 Feb 2021 01:48:12 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id t18sm8094602pjs.57.2021.02.19.01.48.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Feb 2021 01:48:11 -0800 (PST)
Date:   Fri, 19 Feb 2021 15:18:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V3 1/2] topology: Allow multiple entities to provide
 sched_freq_tick() callback
Message-ID: <20210219094809.ktvwx3pggnvatl3q@vireshk-i7>
References: <cover.1611829953.git.viresh.kumar@linaro.org>
 <d398729676f3d2b0d2ab024a2c9ea6e9ee1d0dca.1611829953.git.viresh.kumar@linaro.org>
 <20210203114521.GA6380@arm.com>
 <20210205091424.3od3tme3f7mh7ebp@vireshk-i7>
 <20210217002422.GA17422@arm.com>
 <20210218093304.3mt3o7kbeymn5ofl@vireshk-i7>
 <20210218163635.GA23622@arm.com>
 <20210219045823.beeijwaymd63prk7@vireshk-i7>
 <20210219094440.GA29843@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219094440.GA29843@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-02-21, 09:44, Ionela Voinescu wrote:
> On Friday 19 Feb 2021 at 10:28:23 (+0530), Viresh Kumar wrote:
> > The very core routines (cpufreq_freq_transition_end() and
> > cpufreq_driver_fast_switch()) of the cpufreq core call
> > arch_set_freq_scale() today and this isn't going to change anytime
> > soon. If something gets changed there someone will need to see other
> > parts of the kernel which may get broken with that.
> > 
> 
> Yes, but it won't really be straightforward to notice this breakage if
> that happens, so in my opinion it was worth to keep that condition.

Right, but chances of that happening are close to zero right now. I
don't see any changes being made there in near future and so as we
agreed, lets leave it as is.

Btw, thanks for your feedback, it was indeed very valuable.

-- 
viresh
