Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37E936AB07
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 05:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhDZDT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 23:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhDZDTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 23:19:55 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802E2C061574
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 20:19:13 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 10so2590700pfl.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 20:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sslab.ics.keio.ac.jp; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1idmU5oasi5s8yake1E5MV/fuZG36GG+m+QfyCDPPAg=;
        b=FFBBiEbKdwEOvS0oHpkmceh8YwkI8JWzk9aEm6Q2tDb7iK0USLW0QEKvQG1ZV1P/N7
         1ynXAijGp5Rvm//DBC+C5zYnIQmGDnQQMASRr8Tnlv271bcyXtY12nHSD+2I2PAl6+Ga
         OkXJOSqpveQOemOW3Ls3p2DmZP5lUBE4R/ncQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1idmU5oasi5s8yake1E5MV/fuZG36GG+m+QfyCDPPAg=;
        b=BjMBeklKxO56WvC+EXd3TNofSPXGgE9oCZ36nDiDPI/rBbwEtTg+0Z4cZRd7j58eMJ
         FLfa+1JlGnwNr1SPPfNHivLyZQlWnAdRyXyOv44eQONFicJPe9sSw5lUSwwrdRWgGv/R
         8vrIHJ0E0ptaAE8c9gjYeNQocalJC+1WEH1RbEbZ9M1VvvtaOyxxtotrg+hsiSn6Z0uG
         FCppI7FRMxZpKU8to+PY9j2ZHHUOtT5T08LgSICrPfnyt+z+XCOhm41qzxE4P2jHYDtx
         nOA6hpnAg8dPKYY5bRkVprnfiDoEMV0vpGtfj1Zj/xivRYAo2QpFKH0umwieIH1V3uIY
         pvnQ==
X-Gm-Message-State: AOAM531mCUFA+A5DSo+aBFD4odejunS2+OupFLyrvixBAW3LIg0KbKmy
        DIPFwbfj3mdh6j0OEauvgKonww==
X-Google-Smtp-Source: ABdhPJw2NvtElpce5Tsiply0Pczv0FCmrOEKJ1UaVHlZ+QzzAJJ0woA/MGNFNFMfXQxSQ5/2tsFmNg==
X-Received: by 2002:a65:56cc:: with SMTP id w12mr14980759pgs.334.1619407153036;
        Sun, 25 Apr 2021 20:19:13 -0700 (PDT)
Received: from haraichi.dnlocal (113x36x239x145.ap113.ftth.ucom.ne.jp. [113.36.239.145])
        by smtp.googlemail.com with ESMTPSA id s32sm96035pfw.2.2021.04.25.20.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 20:19:12 -0700 (PDT)
From:   Kenta Ishiguro <kentaishiguro@sslab.ics.keio.ac.jp>
To:     kernellwp@gmail.com
Cc:     david@redhat.com, jmattson@google.com, joro@8bytes.org,
        kentaishiguro@sslab.ics.keio.ac.jp, kono@sslab.ics.keio.ac.jp,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, pl@sslab.ics.keio.ac.jp, seanjc@google.com,
        vkuznets@redhat.com, wanpengli@tencent.com
Subject: Re: [RFC PATCH 0/2] Mitigating Excessive Pause-Loop Exiting in VM-Agnostic KVM
Date:   Mon, 26 Apr 2021 12:18:58 +0900
Message-Id: <20210426031858.12003-1-kentaishiguro@sslab.ics.keio.ac.jp>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANRm+CzoS=HhiHg6w6dy8P+r3POeP3uMZqFvJr4oHMa1aNJqxg@mail.gmail.com>
References: <CANRm+CzoS=HhiHg6w6dy8P+r3POeP3uMZqFvJr4oHMa1aNJqxg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the reply.

My question is about following scenario:
1. running vCPU receives IPI and the vCPU's ipi_received gets true
2. the vCPU responds to the IPI
3. the vCPU exits
4. the vCPU is preempted by KVM
5. the vCPU is boosted, but it has already responded to the IPI
6. the vCPU enters and the vCPU's ipi_received is cleaned

In this case, I think the check of vcpu->preempted does not limit the candidate vCPUs.

