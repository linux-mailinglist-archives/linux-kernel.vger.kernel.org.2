Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6B038AD8A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242422AbhETMFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242274AbhETMFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:05:33 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318BBC06917D
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 03:34:03 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so5112722wmk.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 03:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5n6riXCd1vkZQcoH0r5gYShL1+XQ6uXaF5ZA75ztkS4=;
        b=hqF1evK4XE7TofUsWGxTL13k2AC6u5yfZPjf37ZMM6wuWy4eazgaoxsdsj4w7FSenB
         Suqt0myWlzhpBr4iWL3CsiFkL/KE7Ot/esZP0uWdz+8wuYpAeWgNHUhcdGNl1UCxRO0o
         xS7CdKhyi4jGanQWWI3xKFxQoVoLb0IgGRFJFihhHtx1/zac3eiqhaf4dQiBOq1/4wtv
         NA81yyGUp5grSRuRZJXK9aOYqLiCPSGIBXZMPG+fCpkyfbmRJtHyQT5RogbOGlMwsNl9
         J0kUIoAY1OFO8I9n2tDAiqXGl8FZmhYDVgkNikPJkpp1EwxNbAQeqAp+aiWzdWKTMlfH
         K6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5n6riXCd1vkZQcoH0r5gYShL1+XQ6uXaF5ZA75ztkS4=;
        b=H9OInu3o0pYxcFwoKwtdih95/XZwZKKr9+LcdsAy1NNuyA3eqjCLyp5/1COQBCzVlb
         iLr+OxB0abInj5ImKbavC46FXYlWY9MnRCuXFPhKbQ0KegD8Znktwt+xb5NjqiY4OKzq
         85MJN2pMoUeK301tob8NotiwOpTI5Pj8nMx1MLeUY4n8SWiyfQmC80Rfwq2vZRLsA2I1
         nZdOZvVVRmsKEtJzT6ViP2HwqpkWprHiJ2nSeOjJsSeEHijPhR/2y6Z4VHcpR3DGSx80
         cBzpKabI3Gr5F8fVGsLYUqQsH0nQetECBnNgFvkM9hqkJzLfyEzSS9Rp6uvKm6xuXceq
         PrBQ==
X-Gm-Message-State: AOAM531LPqMmKo5xeg0+HX8XLrKHfhqKJDMi4etECcL9sdjaG6/KYy4O
        Ami2H8JPMwU+vNy5AaZP+b5lcg==
X-Google-Smtp-Source: ABdhPJxq6/OQqdBrhuKZaLq+XaCRlIoDOoH49bUkTeQ3q8Q0V8pTmzOTJi3JYtKP3tAWP/lop7kWOg==
X-Received: by 2002:a7b:cc15:: with SMTP id f21mr3398343wmh.86.1621506841514;
        Thu, 20 May 2021 03:34:01 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id r1sm2649161wrt.67.2021.05.20.03.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 03:34:00 -0700 (PDT)
Date:   Thu, 20 May 2021 10:33:58 +0000
From:   Quentin Perret <qperret@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v6 13/21] sched: Admit forcefully-affined tasks into
 SCHED_DEADLINE
Message-ID: <YKY7FvFeRlXVjcaA@google.com>
References: <20210518094725.7701-1-will@kernel.org>
 <20210518094725.7701-14-will@kernel.org>
 <YKOU9onXUxVLPGaB@google.com>
 <20210518102833.GA7770@willie-the-truck>
 <YKObZ1GcfVIVWRWt@google.com>
 <20210518105951.GC7770@willie-the-truck>
 <YKO+9lPLQLPm4Nwt@google.com>
 <YKYoQ0ezahSC/RAg@localhost.localdomain>
 <20210520101640.GA10065@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520101640.GA10065@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20 May 2021 at 11:16:41 (+0100), Will Deacon wrote:
> Ok, thanks for the insight. In which case, I'll go with what we discussed:
> require admission control to be disabled for sched_setattr() but allow
> execve() to a 32-bit task from a 64-bit deadline task with a warning (this
> is probably similar to CPU hotplug?).

Still not sure that we can let execve go through ... It will break AC
all the same, so it should probably fail as well if AC is on IMO

