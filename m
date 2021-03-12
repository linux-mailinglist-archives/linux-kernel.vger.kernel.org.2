Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC857338865
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbhCLJP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbhCLJPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:15:35 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED178C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:15:34 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id o26so3339166wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8hyTObTnA8b0Pah5w5x3EX45G+4aGq3Qg+uSFkSPcCo=;
        b=jVs4+SZBOncaHTNZfrQPmfUwVYzNZgKm+iL7UkFzH2hi1esIn3UON4srQWsKqCTzIQ
         v8JzJSmZb/Dt5o4ziJlrUAEwS2Rozm3WkV8g21rcbXUuZHVDSd9g6MygPJfvd2G8gKRX
         3xEtqIHBTd95yzydjWyupkUBpp0DkDmseSBNQCM/Y3SQORaEXSfQuWSVT+Wi/qtY403j
         YJ3N/tL9sTiVdHVw4vpjyxqiknFYfbN3qfQSohG7eu56ZkuMaenkzlbqQRqucppZa6wJ
         nURlMd0nasN1vXl7gtLFx739nu6Zg3c9ItV3TJWROADQH4DX2TjRm0RCnbCQlLC6+RnZ
         apjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8hyTObTnA8b0Pah5w5x3EX45G+4aGq3Qg+uSFkSPcCo=;
        b=gst4XZmrL++LjgJVM9cyRfqqNA7OPNZ6rVenLf8KDw6mz+ZUcPpNPpEL9QrYZ551un
         jGTtGq3UEDLtSRnP9EQPhOXs9xLvuvfIjJZIW7hPJ6qbqLsw8poP1nV4WiHMeZBj3o4J
         l4/JaKwDEeXMbcSU7+0vMl4r/O2sZ0d39FFmkzWWSK7YHVeELTAGpx9FfKwp/z/+2ZLD
         Qg0sl8POkSfblPJrOBSlfYS59ZJmwy3CMzSZdKXvgScUdpuuWifdIIuRMPGiQRTHGxnv
         joleFgTo4dKw/b8JOgY4RvqtfcX5BLvODQFzqtkemOWzS5p1gU5DRutCxAnmluAd56Tg
         QKCg==
X-Gm-Message-State: AOAM531THs/ThkASXny+E5ahKUU8Higg16l+QqbXZDOsIH/9fQ6dLCfA
        OIO+NpHCtm7D3i2yB+cbddmkVQ==
X-Google-Smtp-Source: ABdhPJyo6oi+MSsftqzukHAyRgFvWhaTOLTqQm++oJ1mRSO/qD8ZSQ8ap6nF6e9hdN/8C+ctlvX1pg==
X-Received: by 2002:a1c:8041:: with SMTP id b62mr12506853wmd.0.1615540533351;
        Fri, 12 Mar 2021 01:15:33 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id j203sm1510033wmj.40.2021.03.12.01.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:15:33 -0800 (PST)
Date:   Fri, 12 Mar 2021 09:15:30 +0000
From:   Quentin Perret <qperret@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org, ardb@kernel.org
Subject: Re: [PATCH v4 27/34] KVM: arm64: Always zero invalid PTEs
Message-ID: <YEsxMgNncoVLdkjo@google.com>
References: <20210310175751.3320106-1-qperret@google.com>
 <20210310175751.3320106-28-qperret@google.com>
 <20210311173338.GB31378@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311173338.GB31378@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 Mar 2021 at 17:33:38 (+0000), Will Deacon wrote:
> On Wed, Mar 10, 2021 at 05:57:44PM +0000, Quentin Perret wrote:
> > kvm_set_invalid_pte() currently only clears bit 0 from a PTE because
> > stage2_map_walk_table_post() needs to be able to follow the anchor. In
> > preparation for re-using bits 63-02 from invalid PTEs, make sure to zero
> 
> Why do you exclude bit 1 from this range?

Hmm, no good reason really. I wanted to play games with invalid table
mappings at some point, but dropped the idea and forgot to update the
commit message. My bad, I'll fix it up.

Thanks,
Quentin
