Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACED430E340
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 20:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhBCT2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 14:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbhBCT1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 14:27:51 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC16C061794
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 11:27:10 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id q20so461321pfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 11:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JvxyoG9Ug7rD2/QwyyqWOcJJzbOkgd8c1QabMsrGK+4=;
        b=wbLe/h7fZW5nuvUmAaSsEyaZ7RpzIuLEKRn7oWLXHzPrSJ9gcmGZb6gEsvu7NWUeoh
         M80XTZDflp5g8PLYsyX4tspBLbPJYwnsAjnMUCsik23dF/hObd7Cep5Xt1ylznZj7QON
         RbxTJ+HzscH3wctX+qUSETrlkGHNg9hzMCvly0ZScGMEsC8gG0nOCrqiWrZODTxr9tAf
         GNr/Zoo9aG+SHB0sRr1nsqaCYf9o4avxgAWSiosaYAERhqNlHp9c11G9uNWZWP1J5wUk
         GrkMmGKgsiA22X9Jhgn3KF+bxfgjNzDLNMh8NM+5s7st6zcw4Oh9vzqalzyEhyOFXAjk
         7C+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JvxyoG9Ug7rD2/QwyyqWOcJJzbOkgd8c1QabMsrGK+4=;
        b=RaZ13o6lTqR3XuQdxy7PNnVIOaGFoc4yrbcyZ44/j8R+CLmNMGcDcH+NFzrQdKC1Zp
         qGUtCTxYlPpXVkUkrqBx7cav67MC2sFSqBalnJvCLTdVY+nNIJaUA78l7aUifFY0g4ss
         VMFr7MrMDpDTewqDUAzxXYa739GQBc6tcA5AvNboNav3CNv0jvjsrUghpsDghQKctvlK
         1K1oxk6VdxFtxgxeqRXVQKm35d5+lTSNyDPnONRAFHoRG0gYHAWl+tgYY0nLsZElhnpP
         X/Rxbyc4ug57VEqHus9zMjaWVl8G8IMIJr6a3AOx+czLYQomnmktM0/17nWXG20S2sOD
         KVJw==
X-Gm-Message-State: AOAM531hwdUyfnvIo/T8w92haePi5K79QByqOms9F6+/NYq87yBYtGm9
        zB06AlyW2qboHWZJIZZdJNY/qQ==
X-Google-Smtp-Source: ABdhPJx2eX0AFr/RFnr8uK0lyitK4xaSk/d2OQaMpOV5TL5Wgvs15NKxIjyU70od3pXEKUP6SNmu6A==
X-Received: by 2002:a63:4644:: with SMTP id v4mr5246382pgk.440.1612380430481;
        Wed, 03 Feb 2021 11:27:10 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id q2sm3111565pfg.190.2021.02.03.11.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 11:27:09 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Artem Lapkin <email2tema@gmail.com>, narmstrong@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, christianshewitt@gmail.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        jbrunet@baylibre.com, art@khadas.com,
        martin.blumenstingl@googlemail.com, gouwa@khadas.com,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        nick@khadas.com
Subject: Re: [PATCH] arm64: dts: meson: fix broken wifi node for Khadas VIM3L
Date:   Wed,  3 Feb 2021 11:27:08 -0800
Message-Id: <161238042310.26843.5846763712461703228.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210129085041.1408540-1-art@khadas.com>
References: <20210129085041.1408540-1-art@khadas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jan 2021 16:50:40 +0800, Artem Lapkin wrote:
> move &sd_emmc_a ... from /* */ commented area, because cant load wifi fw
> without sd-uhs-sdr50 option on VIM3L
> 
> [   11.686590] brcmfmac: brcmf_chip_cores_check: CPU core not detected
> [   11.696382] brcmfmac: brcmf_sdio_probe_attach: brcmf_chip_attach failed!
> [   11.706240] brcmfmac: brcmf_sdio_probe: brcmf_sdio_probe_attach failed
> [   11.715890] brcmfmac: brcmf_ops_sdio_probe: F2 error, probe failed -19...
> [   13.718424] brcmfmac: brcmf_chip_recognition: chip backplane type 15 is not supported

Applied, thanks!

[1/1] arm64: dts: meson: fix broken wifi node for Khadas VIM3L
      commit: 39be8f441f78908e97ff913571e10ec03387a63a

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
