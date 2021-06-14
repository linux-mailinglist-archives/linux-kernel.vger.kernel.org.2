Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCFD3A5E07
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 10:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbhFNIDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 04:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbhFNIDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 04:03:48 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63834C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 01:01:28 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z8so13444301wrp.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 01:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L3lbqWZTEszNETQXU+jhXVvtElOXfGcCoN5XqLAJJws=;
        b=YgR1ctmLRMdXS9l9GQnO/y/kmcq4SDIqC2bGXJwz9Ol620nwEb9vnEUDQxPZr2SRxW
         QK8Wo+dXhWQBINn+pnWrUeg/HOVzn8BavWIGdZ8MP4Ue6ka/zFuPICSDl91OF08k/gRX
         NjsIgk+ljTV0Sz1XbvDUVW9dZGS3tjbM67vcFUGCur+/s9P2LBr4BZR4XzQNzwnpPiTy
         /F4xi3aZjTjIpAwKXJRY4Ylp3CajAsHonmqcsCENUeiXZui/M70D4nS1mwzCI8Hkcdp5
         XOW9tpNG84HzdaNKE5a0pPIAOt2djX6tzJJL1QH9lGtAUa9THR8sczRHNDinfWY/Vr4A
         KRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L3lbqWZTEszNETQXU+jhXVvtElOXfGcCoN5XqLAJJws=;
        b=QpH+SmXkfBVdb/MPInpxnB1kdkfIrLFiYToJH8KFWKmSsabtE7bD964g1/RzbPy4jM
         XCSD4+pFp9N7M8fRUWfOepG/fgHPJTMa3lNuWfC0V5FD4GV0tYWgE4RWlJqihOfblRlT
         pqxI2QT3q3q6RMNdXE3e+FdamtBNB4vMg6o/joVrqynAsNNUGF6XgUWo2tnGOdQda8Eg
         YSHQ3VIbM6l1dVJWWnh2b+UGXwO6zwRkYwT4dOCaGNUamHEXgVqcj+iVcCau4lO3cT1a
         mx/juDSvr8UGOb9r3LW11uzevIpfW+z/UnjEtc5eaYgiTJ7h+8Vy6dmX7Tl1J1KF/sAz
         QaNA==
X-Gm-Message-State: AOAM530dYK1GqwDZzp0De1lLv/8il5t5Owe3tjPkBR3TsmPHje4bhEyq
        32+tC1+GNeCiSRgj4aGaAR04wQ==
X-Google-Smtp-Source: ABdhPJy3GrxHrAITne9gl53/cvM/13scb2PdbnRj0oH6g7HVlaW5iLq1RYGExS4z050i+vVDy5Mi7w==
X-Received: by 2002:adf:f907:: with SMTP id b7mr17086296wrr.357.1623657686850;
        Mon, 14 Jun 2021 01:01:26 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:71f0:4862:1742:37fd])
        by smtp.gmail.com with ESMTPSA id o5sm15825751wrw.65.2021.06.14.01.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 01:01:26 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jbrunet@baylibre.com
Subject: Re: [PATCH] ARM: dts: meson: Set the fifo-size of uart_A to 128 bytes
Date:   Mon, 14 Jun 2021 10:01:24 +0200
Message-Id: <162365768004.30373.6312960282628075528.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210604170844.2201229-1-martin.blumenstingl@googlemail.com>
References: <20210604170844.2201229-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 4 Jun 2021 19:08:44 +0200, Martin Blumenstingl wrote:
> The first UART controller in the "Everything-Else" power domain is
> called uart_A. Unlike all other UARTs (which use a 64 byte fifo-size in
> hardware) uart_A has a fifo-size of 128 bytes. This UART controller is
> typically used for Bluetooth HCI.
> The fifo-size of 128 bytes is valid from all SoCs from Meson6 (or
> possibly even earlier) all the way up to the latest 64-bit ones.

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.14/dt)

[1/1] ARM: dts: meson: Set the fifo-size of uart_A to 128 bytes
      https://git.kernel.org/amlogic/c/7db3cde5123e2acdd65ff7458628a9835c804b27

-- 
Neil
