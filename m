Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8B639A169
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 14:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhFCMu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 08:50:26 -0400
Received: from gloria.sntech.de ([185.11.138.130]:56356 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229801AbhFCMuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 08:50:22 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lomm1-0005De-UI; Thu, 03 Jun 2021 14:48:34 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: rockchip: remove #phy-cells from usbphy node rk3066/rk3188
Date:   Thu,  3 Jun 2021 14:48:32 +0200
Message-Id: <162272448961.3187654.2931146316551924981.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210603121010.4315-1-jbx6244@gmail.com>
References: <20210603121010.4315-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2021 14:10:10 +0200, Johan Jonker wrote:
> The review process of rockchip-usb-phy.yaml was not finished
> when the patch in the link below was already applied.
> Remove the unneeded #phy-cells property.
> 
> https://lore.kernel.org/r/20210512122346.9463-4-jbx6244@gmail.com

Added a Fixes-tag and applied, thanks!

[1/1] ARM: dts: rockchip: remove #phy-cells from usbphy node rk3066/rk3188
      commit: 60fba46d6e7a6e5de4be2ea158aa6134ec7a161e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
