Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDAC5452F28
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 11:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbhKPKe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 05:34:56 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:41558
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234190AbhKPKer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 05:34:47 -0500
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 086A03F1A5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 10:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637058710;
        bh=92zi+uaozVd3dQpRcG3KZ4gZNNYCSn9kCZHl66TmEQ4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=ks2G1AW76fezCOyY+JlrvsDWz/7MBvC5Fcr62Pr6PBypV0tEXQN5y8ydzXhsTFk0E
         xYZmgG7koPd1I2Wlo1vy1XAiUuOjFXUo+Ngv+QwjU9Of5LZ+z8YgRIKMSwBmeAVg7A
         V9RRJ4kBciX6HnR8EmVrckmYb9QeuldAxum3YD1tLlXBPOf4zZV0d2AnOMI8AOB3rU
         1YqB2Yxenyn72PckXMgPJM3aW78fwtzskX4kmJ4krtniUDin3RAX8XmKTacYdSqJH7
         de0Zu12hU0PwmFJdgeuWGjB4BJMY7WTWlnKtVu03qG/4iZfkLfQ/yd4Vi8M0ax/vFa
         OZBDDFKyW+i/A==
Received: by mail-lf1-f72.google.com with SMTP id w2-20020a0565120b0200b004036bc9597eso7961891lfu.14
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 02:31:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=92zi+uaozVd3dQpRcG3KZ4gZNNYCSn9kCZHl66TmEQ4=;
        b=b77tI4SGvDdaNXZAvRTJQOC5ziYMFCftdeDZytOKBDbx0rYCR+XV2BQuCF+LFhKW1V
         PsDHzo4otHi9RMdLR2bag8KnvgESVJimLN6vUQ3Uv7XJF3a2Z9RCzvLCJ2Xg9qIrFdWS
         ATXVqhrii8vus7cFMaDSas7sFad63DZ9ONt/Nt6etyW0Fpbm76jnESzNZXFplpiQDWth
         /vJpmHj0l5IuaYNzwv8OTnsSeKof9vVfLg3ajrU8ghbb6vC00ZCr1YWJXDj7vcICecz7
         ziXJ4qVg5+iVK6Pu3KgWyH/qU4FDo+od8AL+41qM0+4xbWxGm/pHi5cYXv+/hr0KMFJJ
         K1ug==
X-Gm-Message-State: AOAM532kpH2nHuGNzJbeGFwtHpuIzzUtw5kjtK6T8MziYZTmfix/mwdJ
        qy3XvuhhXHCb0cRawyY7pOeF1EinF9CeX6wK/UP3/zNkA6ft1E6lsgTXrlBI9Q2D2NscgIqtT6B
        Lwyk/1nfdmsZN5yPUVwOVWpkNIAE5FnnSMuZKGtdDbQ==
X-Received: by 2002:a05:6512:1093:: with SMTP id j19mr5749229lfg.340.1637058706574;
        Tue, 16 Nov 2021 02:31:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwFJQ83v72RjqgTGJjKyb8RGySZcPwWRf/nb5XIMU/rZuTUXd/qfX1IRjsZ+BlY4jF7IoGErg==
X-Received: by 2002:a05:6512:1093:: with SMTP id j19mr5749196lfg.340.1637058706395;
        Tue, 16 Nov 2021 02:31:46 -0800 (PST)
Received: from localhost.localdomain (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id j5sm1114418lfe.219.2021.11.16.02.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 02:31:45 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v2 6/7] memory: renesas-rpc-if: Drop usage of RPCIF_DIRMAP_SIZE macro
Date:   Tue, 16 Nov 2021 11:31:05 +0100
Message-Id: <163705866144.26823.8540217279898779126.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211025205631.21151-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211025205631.21151-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20211025205631.21151-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2021 21:56:30 +0100, Lad Prabhakar wrote:
> RPCIF_DIRMAP_SIZE may differ on various SoC's. Instead of using
> RPCIF_DIRMAP_SIZE macro use resource size to get dirmap size
> which is already part of struct rpcif.
> 
> 

Applied, thanks!

[6/7] memory: renesas-rpc-if: Drop usage of RPCIF_DIRMAP_SIZE macro
      commit: 5da9b59b23d8112709034a07338e03dcc65fa11f

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
