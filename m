Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA03413131
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 12:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhIUKGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 06:06:05 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38236 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231599AbhIUKFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 06:05:40 -0400
Received: from ip5f5a6e92.dynamic.kabel-deutschland.de ([95.90.110.146] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mScdD-0001rd-53; Tue, 21 Sep 2021 12:04:07 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     hjc@rock-chips.com, Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, daniel@ffwll.ch,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        airlied@linux.ie
Subject: Re: [PATCH] drm/rockchip: dsi: make hstt_table static
Date:   Tue, 21 Sep 2021 12:03:34 +0200
Message-Id: <163221857584.2031971.7282418488874554364.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <1628218664-14230-1-git-send-email-jiapeng.chong@linux.alibaba.com>
References: <1628218664-14230-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Aug 2021 10:57:44 +0800, Jiapeng Chong wrote:
> This symbol is not used outside of dw-mipi-dsi-rockchip.c, so marks
> it static.
> 
> Fix the following sparse warning:
> 
> drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c:646:13: warning: symbol
> 'hstt_table' was not declared. Should it be static?

Applied, thanks!

[1/1] drm/rockchip: dsi: make hstt_table static
      commit: adfeef9370ff8b53c5f73cda3a63531d92b1ca64

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
