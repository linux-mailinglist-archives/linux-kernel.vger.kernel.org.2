Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85111413126
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 12:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbhIUKFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 06:05:45 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38226 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229833AbhIUKFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 06:05:39 -0400
Received: from ip5f5a6e92.dynamic.kabel-deutschland.de ([95.90.110.146] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mScdC-0001rd-Fv; Tue, 21 Sep 2021 12:04:06 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Daniel Vetter <daniel@ffwll.ch>,
        Sandy Huang <hjc@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>
Subject: Re: [PATCH] drm/rockchip: Make use of the helper function devm_platform_ioremap_resource()
Date:   Tue, 21 Sep 2021 12:03:32 +0200
Message-Id: <163221857584.2031971.6000201413622226231.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210831135721.4726-1-caihuoqing@baidu.com>
References: <20210831135721.4726-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Aug 2021 21:57:21 +0800, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately

Applied, thanks!

[1/1] drm/rockchip: Make use of the helper function devm_platform_ioremap_resource()
      commit: 61735698103fafb5bc0df4ab208fc140c27cabc6

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
