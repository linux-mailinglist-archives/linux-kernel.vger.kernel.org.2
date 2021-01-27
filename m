Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69DD730580D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 11:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbhA0KQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 05:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbhA0KN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 05:13:56 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97378C06178A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 02:13:15 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id p15so968200pjv.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 02:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mcz+n2KoieLg/hGSE9zSgqjZ3omTpFzpCsqi6lR9mNU=;
        b=Ahc7KfA/dLG+hjxO7xTdu6fZyx4C/906vWzeWofgUe/6CaRU1DHJK5ISHOazKQP5WJ
         6Vr0BDQGq7izi6Zn6QRim0jmb2b6k/ej8k7bpDdHpa5p7vjSA66sXk+yi8r7Wk4ZxBdK
         0vjhlayifatx1tNVCOOMy7OzKOILKO1D2MdZtwr1NEKPX+evVrs1X4d+OaEmBPBbeg0a
         VhQAb6Hd2g/Hj48lrIqzrVc/5eHLCCXWWmd/g6BXpMz5HYGQYEWSpMqIkEWsvnVHlCAF
         f/1roVVMKousaGUqN2vEgwIuZjT8K4EthxaOI0uOgvWfvSCS+axfIg7UDkBVdN3KVuxT
         VJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mcz+n2KoieLg/hGSE9zSgqjZ3omTpFzpCsqi6lR9mNU=;
        b=Utjg9gZC9DpCopRGOnnn+Ze5RVx6Wj6Z97myOGY/9AEHPX7Gy0iYN34c2/rq6D+ei6
         JemTbk0OmowmF7y7mWsron49WMw7Fi/5dCVZ1G0iTAKLcd1MfqD+OvMXRj3kacAGXQzJ
         1ENLviad9mK3Ct2jtLS2CgnjdcgAupfe6gGWsrtyGjkltm7W9/YVgsHFJM6TY6xi3wk1
         EIl90WLNsvsotJ872dH2DYZalLe0amGYz242ODkupVgmdN7LSKm/JJUwphvMeyvsISMi
         eMTWM677SdVe9MWvScjlahHmJwvHfu9ifT2y1HvjpoSDGkNXMm7+oAsir/WQqim+eefj
         SSLQ==
X-Gm-Message-State: AOAM533ihywu0pNTB1Gq7EFXzuTKMiHKHL4sADN8cBR9GSi4vofl3dBe
        Oikwyt44kGnGHhA/1v9q58wByg==
X-Google-Smtp-Source: ABdhPJzEix8bPHI1p6ys7MVr2aWJCOVZqkIIlbL9JmuGH0aKPJCG52MhIgXpVz4ZqkPs7cmilM6n5w==
X-Received: by 2002:a17:90a:c705:: with SMTP id o5mr4935503pjt.64.1611742395169;
        Wed, 27 Jan 2021 02:13:15 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id a189sm2056145pfd.117.2021.01.27.02.13.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 02:13:14 -0800 (PST)
Date:   Wed, 27 Jan 2021 15:43:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        vireshk@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        Dietmar.Eggemann@arm.com, amitk@kernel.org, rui.zhang@intel.com,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
Subject: Re: [RFC][PATCH 0/3] New thermal interface allowing IPA to get max
 power
Message-ID: <20210127101312.ve7qlpvda6tabquu@vireshk-i7>
References: <20210126104001.20361-1-lukasz.luba@arm.com>
 <20210127091540.xesvwoeavyaf37jn@vireshk-i7>
 <9aecd2cd-771e-58b8-6672-f133600b70b5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9aecd2cd-771e-58b8-6672-f133600b70b5@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-01-21, 10:11, Lukasz Luba wrote:
> 
> 
> On 1/27/21 9:15 AM, Viresh Kumar wrote:
> > On 26-01-21, 10:39, Lukasz Luba wrote:
> > > As it's a RFC, it still misses the cpufreq sysfs implementation, but would
> > > be addressed if all agree.
> > 
> > Not commenting on the whole stuff but if you ever need something for cpufreq, it
> > is already there. Look for these.
> > 
> > store_one(scaling_min_freq, min);
> > store_one(scaling_max_freq, max);
> > 
> > Hopefully they will work just fine.
> > 
> 
> So, can I assume you don't mind to plumb it into these two?

No :)

As I said at the top, I am not commenting on the whole thing yet, may
need to think over a bit and Rafael will comment as well.

-- 
viresh
