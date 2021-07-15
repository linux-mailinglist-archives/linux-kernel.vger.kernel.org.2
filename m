Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8103B3CAF5A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 00:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbhGOWqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 18:46:02 -0400
Received: from gloria.sntech.de ([185.11.138.130]:53582 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230506AbhGOWpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 18:45:54 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1m4A4G-0005t7-M8; Fri, 16 Jul 2021 00:42:56 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org,
        Dennis Gilmore <dgilmore@redhat.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: Re: [PATCH v2 1/3] arm64: dts: rockchip: helios64: set stdout-path
Date:   Fri, 16 Jul 2021 00:42:49 +0200
Message-Id: <162638886253.651069.4205401236048151204.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210715025635.70452-2-dgilmore@redhat.com>
References: <20210715025635.70452-1-dgilmore@redhat.com> <20210715025635.70452-2-dgilmore@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2021 21:56:29 -0500, Dennis Gilmore wrote:
> set the default output path to uart2

Applied, thanks!

[1/3] arm64: dts: rockchip: helios64: set stdout-path
      commit: a1536b7fd2d75a6836094cfce513807f0b6f8b2c
[2/3] arm64: dts: rockchip: helios64: add SPI support
      commit: 0ead44ed102d6391c9535395a99164fe44038b21
[3/3] arm64: dts: rockchip: helios64: enable tsadc on helios64
      commit: ae2a8a1ed3283ebb5abe21be04773cebada16b9c

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
