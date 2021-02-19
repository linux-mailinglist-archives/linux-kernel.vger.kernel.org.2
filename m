Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902C931FE71
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 18:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhBSR6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 12:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhBSR6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 12:58:01 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C723C061756
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 09:57:21 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id a132so7834387wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 09:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wSDGwoocflGRIUHKyKkTZr409vUlF3AWV+fTAIOXUPE=;
        b=AbfIdFqm4xyNtnKCriEj3ztzc1Gjd0MbqggKgNzwhkA6aOPx4NDOMFXEbkrYmINjj+
         OQJPGkY1UUu8x/fxguDXcyrrmF49OM/RHXgd6Sx3aZHa+CJl4T/2OnbwQ5L7ekAc6M1O
         IfRGreUXZxsoxJV/XuAcGQ5c12V3pS5+ymb4O66tkz8SnvrOu2D2h3sp4vwdnkn8oEMK
         bPmvFRBOLUC1OospurDh44uj/mV8ZMWnixELHFmVBA6m46hKDa389j7U9f2+T3BROkpm
         lj+fo31DFiEsNYIWeNVM0CIqFRZj4Kv5LO2Ngx2paI/QjR7ITufSwvouov6dBeZcBdQU
         Lhyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wSDGwoocflGRIUHKyKkTZr409vUlF3AWV+fTAIOXUPE=;
        b=U3DOTVcRKhX3odaUK83go2v8Aqrclq0sMbKKsglv2Lg//LstlpdUwd5j2Cm0FXx4Sz
         gtTurWFcVgut4TIHcGW8bDU9dterNbPFoVKrioPyiFpKtwdMGH+6w6pese9uHv/BJ/8h
         vp8aHq1l1nGqXl25/MRcrWABrzcJHfh+EA9Zt+qERbYZfjz4HHMjUcFYDidub9wtdcPf
         nRXkgKaU/z55r2HAQIeb4MHClnXXFUi4K7KXTRwLQvzVGGxrUpMYvWCyBulL8ZoT4gHW
         iTuwHgXoUN3gigQW3G3FOC4tZLLLuscyfSXUU9+AnLwrjhla4VSWqxXyA+oxVn5/CdAh
         LtZg==
X-Gm-Message-State: AOAM531gn02arc6lrDp/ND1CKlWre5Hr4PNfjmB/i/0Eqx2GB+tMGKzF
        ydK3Mphoh1DgYVffCgLN1A5R3g==
X-Google-Smtp-Source: ABdhPJxsiiByL8wUUfnZSNR07gNAM/FJ7VrbvCTpRolHBc5LKfAskVcQmZEzfpvfHkY0MiFCvM+Z4Q==
X-Received: by 2002:a05:600c:48a8:: with SMTP id j40mr9105297wmp.57.1613757439910;
        Fri, 19 Feb 2021 09:57:19 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id c2sm14302124wrx.70.2021.02.19.09.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 09:57:19 -0800 (PST)
Date:   Fri, 19 Feb 2021 17:57:17 +0000
From:   Quentin Perret <qperret@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, android-kvm@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>
Subject: Re: [RFC PATCH v2 00/26] KVM/arm64: A stage 2 for the host
Message-ID: <YC/7/fOJ7IAfo61D@google.com>
References: <20210108121524.656872-1-qperret@google.com>
 <YC/7XuB30N8C3sNx@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC/7XuB30N8C3sNx@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 Feb 2021 at 09:54:38 (-0800), Sean Christopherson wrote:
> On Fri, Jan 08, 2021, Quentin Perret wrote:
> > [2] https://kvmforum2020.sched.com/event/eE24/virtualization-for-the-masses-exposing-kvm-on-android-will-deacon-google
> 
> I couldn't find any slides on the official KVM forum site linked above.  I was
> able to track down a mirror[1] and the recorded presentation[2].
> 
> [1] https://mirrors.edge.kernel.org/pub/linux/kernel/people/will/slides/kvmforum-2020-edited.pdf
> [2] https://youtu.be/wY-u6n75iXc

Much nicer, I'll make sure to link those in the next cover letter.

Thanks Sean!
Quentin
