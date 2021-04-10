Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D52035AE9F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 16:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbhDJO6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 10:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234839AbhDJO6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 10:58:01 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA48C06138A
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:57:47 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id q10so5999896pgj.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kTHysmRZ8s5smpNVRM3C08qgpRu8+4XsyWnC1M27hGc=;
        b=XGXa15ZdfE/uvEjmYyqVg2CK70tcGiE1U1uAfjvWmmDx1O0MP+pbhPYC++Jd7x3T8x
         7PgAAjA3Ue8AeLms10TODNA0IdSqNQitvW0qCq7pUNw9Q47BEJ1Hkpf5VebS1lKbhmdo
         XYQ1c7so8dmeRKAMr4bfZNYNMFGpa+XF2MfAF2YyS0b5q9/DVz+BiKegoaFI/IC+Vqh+
         j7oBq7kLr8sM/52nfYm6CubmmLMOwS6tsp7TGt3ENkPBnOM5JGffUDIKLGdZYaQZqw8F
         +xPJ1BKYShTGUvzsoyJMziAqjnPfw6oxIICRGWAUUdR6Z8MyG/foeI1y39kPdGP9Pf7l
         0IAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kTHysmRZ8s5smpNVRM3C08qgpRu8+4XsyWnC1M27hGc=;
        b=iun91xmNsNIQ222jDYidKwDQAy5FUwdNmRpoy2E+coPveJctue5R8I9rwidUVBLEgE
         kxyx700skrcQLZUGeU+AxOZ6lQMXzyN3bEFFJFZKMsu1H2mKQfEx+Ya7DkyMOtzFxyRe
         P8FWz+o7I4jYOEllqSK41TY9kYQr8AiQ5z/gEWKw6g+rdsmpLJzGSpPz7s7/C1CcjW0j
         Y4lExQpYqwO3NUeuPuzQ79eStBpmF52n8yCtMom4Y24R2AFxY48HA5SnHPe6DaiQV9v6
         jyMJvuW9nk4jg6SbUQDJVefPHrtl0Q54FUJsXugBkVo3uaB2hUbJVFwczPZRHqAPKWlC
         ClNA==
X-Gm-Message-State: AOAM5303cNmHXeT+JbbtGXJE/ys2ttJOHvYL0tXNTDc2rbevv0Rm/Cj0
        u5FamluoEwGSGIo5kn40OpaZjQ==
X-Google-Smtp-Source: ABdhPJwax96dH52jyitXWUjYp46GrjWLRPC/v1nP4sxtNjZCRgfjCq2C7BjiNOtqcPh9lKZc2AQk4g==
X-Received: by 2002:a63:c145:: with SMTP id p5mr17600808pgi.451.1618066666742;
        Sat, 10 Apr 2021 07:57:46 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id e3sm5151417pfm.43.2021.04.10.07.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 07:57:45 -0700 (PDT)
Date:   Sat, 10 Apr 2021 22:57:41 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf session: Dump PERF_RECORD_TIME_CONV event
Message-ID: <20210410145741.GA6012@leoy-ThinkPad-X240s>
References: <20210410031930.18064-1-leo.yan@linaro.org>
 <9e100c55-16b1-090e-1e81-334a55bd4b15@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e100c55-16b1-090e-1e81-334a55bd4b15@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Sat, Apr 10, 2021 at 11:46:10AM +0300, Adrian Hunter wrote:

[...]

> Hi Leo
> 
> I think there might be some more work related to this.
> 
> Pedantically, shouldn't you cater for backward compatibility and
> not assume the following were in the perf.data file:
>                                                                                                                                            
>        __u64                    time_cycles;                                                                                                                                             
>        __u64                    time_mask;                                                                                                                                               
>        bool                     cap_user_time_zero;                                                                                                                                      
>        bool                     cap_user_time_short;   
> 
> That means checking the event size.
> 
> Also PERF_RECORD_TIME_CONV should have its own byte-swapper instead of  
> perf_event__all64_swap() - also checking event size.
> 
> i.e. fixes for:
> 
>   commit d110162cafc80dad0622cfd40f3113aebb77e1bb
>   Author: Leo Yan <leo.yan@linaro.org>
>   Date:   Mon Sep 14 19:53:09 2020 +0800
> 
>     perf tsc: Support cap_user_time_short for event TIME_CONV

Indeed!  IIUC, should have three fixes with event size checking:

- One fix for dumping TIME_CONV event;
- One fix for byte-swapper (especially for bool values);
- One fix for commit d110162cafc80dad0622cfd40f3113aebb77e1bb;

Will follow up for the suggestions.  Thanks a lot for your insight
review.

Leo
