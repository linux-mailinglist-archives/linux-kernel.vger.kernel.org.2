Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAAB733EC1E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhCQJCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhCQJCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:02:14 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEADC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:02:14 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id a132-20020a1c668a0000b029010f141fe7c2so699388wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QwuxtgiCCCuVkfcX8LM9ZlMzlOT2xbL3vCInW5yBpfg=;
        b=HsNDgrTfHb6lenOiS0yb3OIwab0Slx0F9OO942wg+fn+VlF4z18b5ZjUwJ5ayQLqBw
         1cz9cCd1Nv+02O1Rqqjepf1YSKlqAh0hYm9nIVh7SbxX4Wg/JU0BYAkuNWhzdrhQeATV
         XibT9bPRb/CpKBHxXIPKH+whD+T+vjYz0aBBC0pzwSPl4RX5m+qV+z9OkK8tjsNVZEKY
         +pXJcZCtdNMJpuEDhLRYniinjapSEsGfkadsD11XQg7ZFr9csC42N6vMQTY0etWdwe3v
         5vk0Ig3JaHNCU4LAjWpkrkmh4iDxgHMukVezMg07LTrKr3QdI9t+lDSOKJdxppyMxUyH
         buMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QwuxtgiCCCuVkfcX8LM9ZlMzlOT2xbL3vCInW5yBpfg=;
        b=HbXLV0T+kQ/0whhV04HLpxMbkz2+7o7DevAkyJQgVQQCdkRxOkBEZaKtx0WvFPa1PD
         zDkgJEjOQBQJniABzrE4rWiRSJLqF5bHB5VxP5i49TqGvQmhHq2XrCc5+dQpmalhMUan
         y12tMXgLI6rKVEsfuWob+CVfW6Ai5QyGGGeyXOaOg4S9zIKi+yzXq6YKFDLEcesQG6vJ
         lo1tbDwF6+tGWURW74t74goZCN7lBBmjrCsGefzTng0Ca1CNoKT4U9OA4nK58sL5Sfq/
         9nWuki+CPaaU5EuzQs1x5YuXd0KuhcIWTMQ44lAW2C6dL/D+rRRVFEkjQMgL+dj7civk
         EDYg==
X-Gm-Message-State: AOAM531W+x2zZJPs34Y+H+6fmKGS5mzHqgoXARWLq1zFhZyAVD+IzLCn
        d7UP+ZZRgU4K5iY448EPVEuKJA==
X-Google-Smtp-Source: ABdhPJzFjLJUUKNKs+1TXyYF2RPilOCv4q5TrU8XPy3DPss8s4W20rOFuDvU8NaXimf62US3JuyGtw==
X-Received: by 2002:a05:600c:4112:: with SMTP id j18mr2656665wmi.143.1615971732589;
        Wed, 17 Mar 2021 02:02:12 -0700 (PDT)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id u2sm2315302wmm.5.2021.03.17.02.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 02:02:12 -0700 (PDT)
Date:   Wed, 17 Mar 2021 09:02:09 +0000
From:   Quentin Perret <qperret@google.com>
To:     Mate Toth-Pal <mate.toth-pal@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com, android-kvm@google.com, seanjc@google.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com, nd@arm.com
Subject: Re: [PATCH v5 33/36] KVM: arm64: Wrap the host with a stage 2
Message-ID: <YFHFkaKZyAEheWZV@google.com>
References: <20210315143536.214621-1-qperret@google.com>
 <20210315143536.214621-34-qperret@google.com>
 <ec9df9a4-a419-089c-469f-1a1509597dd9@arm.com>
 <YFCqYT3Ib8kAN7/c@google.com>
 <YFDAyhjPEsnZ4N3P@google.com>
 <eb70a071-4d4a-885f-36a7-3b20358e5513@arm.com>
 <YFDvAqgimPvpgiwQ@google.com>
 <da9e7839-6d12-c69d-9f23-a091219e1da8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da9e7839-6d12-c69d-9f23-a091219e1da8@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 Mar 2021 at 09:41:09 (+0100), Mate Toth-Pal wrote:
> On 2021-03-16 18:46, Quentin Perret wrote:
> > On Tuesday 16 Mar 2021 at 16:16:18 (+0100), Mate Toth-Pal wrote:
> > > On 2021-03-16 15:29, Quentin Perret wrote:
> > > > On Tuesday 16 Mar 2021 at 12:53:53 (+0000), Quentin Perret wrote:
> > > > > On Tuesday 16 Mar 2021 at 13:28:42 (+0100), Mate Toth-Pal wrote:
> > > > > > Changing the value of MT_S2_FWB_NORMAL to 7 would change this behavior, and
> > > > > > the resulting memory type would be device.
> > > > > 
> > > > > Sounds like the correct fix here -- see below.
> > > > 
> > > > Just to clarify this, I meant this should be the configuration for the
> > > > host stage-2. We'll want to keep the existing behaviour for guests I
> > > > believe.
> > > 
> > > I Agree.
> > 
> > OK, so the below seems to boot on my non-FWB-capable hardware and should
> > fix the issue. Could you by any chance give it a spin?
> > 
> 
> Sure, I can give it a go. I was trying to apply the patch on top of https://android-kvm.googlesource.com/linux/+/refs/heads/qperret/host-stage2-v5
> but it seems that your base is significantly different. Can you give some
> hints what should I use as base?

Oh interesting, it _should_ apply on v5. I just pushed a branch with
everything applied if that helps:

  https://android-kvm.googlesource.com/linux qperret/wip/fix-fwb-host-stage2

Thanks again!
Quentin
