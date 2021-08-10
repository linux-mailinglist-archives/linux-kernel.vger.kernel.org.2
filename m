Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4BF3E54B7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 09:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237981AbhHJH73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 03:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237732AbhHJH7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 03:59:08 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8896EC061796
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 00:58:46 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id c9so24968185wri.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 00:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8vOzxNlu5NfLvXqdFSx19sPlss9NRbVfvd1D3cx6Wlo=;
        b=hCUQnUYlqyla8ODWNsANP5xwr5ntXLwRwywWNiKydMuoOL0e2F3Cm0hqWTXd2V7zGW
         dTRfn5vTX5cMZrElr+63h2Yvbj0H6vMbSeM7WMwUPEaigXYi08ZQxnvNgfIzR/CuMDu2
         HcTuWCplm7yot7wO9dqvfDjQu3KTSZpm2/JDlH2TraZCJ4N2POkwTWYp2PHmjI9VMF4T
         wjTNGuZ1oLtdl3D37DNAHngAVw5b9qskMeLefCqPz9Rp9m4d/q1jXBasNnKpnTYlkJeO
         iWmhhDMVNsHzoi5cxAqDnh5DogF6ryDrORqpDBUgGnTf55HhVErXOxjVX5s1tvxy+SxB
         CPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8vOzxNlu5NfLvXqdFSx19sPlss9NRbVfvd1D3cx6Wlo=;
        b=VPXMCwIvJ+wkxyT6iGmAaovg4KmYrIuFnussiTluGF9cbRaN/56Al8pnA44vp2whTv
         dYYlVnoOBufnyIAg5rusfeluNb1Z4C4pjDDaLwygG8xIk3+IROKZKysq75CcQ2GSRfEn
         9Gyl3yPw82Q5PRVFMcKKcgCFAlr6d60PUyZ6+tPNKpN34pYX5tCNNievpqk9bF16BfcK
         fUpB+IENhNzzXHVHaxnPlVePWmxYVfA1/ryLba7qmTgivO4LjQ3pS/2yvlK7kYKGS7m5
         B+b3k5MRRRKmRUdxzMGGRVntOuuMrKdb/yGDtiJnBYVOQtnKyefuWNgH0QN+rn9sapot
         Htpg==
X-Gm-Message-State: AOAM531FfbaXPeOBcguHr3JN2GToQx/qXBGm0zGJhREL69T/AgwqwDUA
        DQ3l32CMutMo65R/3jXf6UtZHg==
X-Google-Smtp-Source: ABdhPJz1UdCSUcy7AiFkdb/onnCvFYJbCuqHXA45ykrkxib/zGQ+1SGggLyKGKHSaSIyEZ7STNj34g==
X-Received: by 2002:a5d:64ce:: with SMTP id f14mr29390738wri.17.1628582325021;
        Tue, 10 Aug 2021 00:58:45 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:b710:2b6e:27aa:f0a0])
        by smtp.gmail.com with ESMTPSA id d5sm22175380wre.77.2021.08.10.00.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 00:58:44 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     linux-amlogic@lists.infradead.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH] arm64: dts: meson: add audio playback to nexbox-a1
Date:   Tue, 10 Aug 2021 09:58:34 +0200
Message-Id: <162858223387.1486110.3448385617438726477.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210804140029.4445-1-christianshewitt@gmail.com>
References: <20210804140029.4445-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 4 Aug 2021 14:00:29 +0000, Christian Hewitt wrote:
> Add initial support limited to HDMI i2s and SPDIF (LPCM).

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.15/dt64)

[1/1] arm64: dts: meson: add audio playback to nexbox-a1
      https://git.kernel.org/amlogic/c/c7f5675b345224f212a0006c73a643182e953a5f

-- 
Neil
