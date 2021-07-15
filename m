Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150B73CAF59
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 00:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbhGOWqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 18:46:00 -0400
Received: from gloria.sntech.de ([185.11.138.130]:53546 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229791AbhGOWpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 18:45:53 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1m4A4I-0005t7-1w; Fri, 16 Jul 2021 00:42:58 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] soc: rockchip: ROCKCHIP_GRF should not default to y, unconditionally
Date:   Fri, 16 Jul 2021 00:42:52 +0200
Message-Id: <162638886252.651069.16002951650407635275.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210208143855.418374-1-geert+renesas@glider.be>
References: <20210208143855.418374-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Feb 2021 15:38:55 +0100, Geert Uytterhoeven wrote:
> Merely enabling CONFIG_COMPILE_TEST should not enable additional code.
> To fix this, restrict the automatic enabling of ROCKCHIP_GRF to
> ARCH_ROCKCHIP, and ask the user in case of compile-testing.

Applied, thanks!

[1/1] soc: rockchip: ROCKCHIP_GRF should not default to y, unconditionally
      commit: 2a1c55d4762dd34a8b0f2e36fb01b7b16b60735b

I actually found the old one deep down in my inbox some days ago,
so had applied that one already. Hope nothing changed with your
RESEND.


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
