Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC373946D1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 20:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhE1SLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 14:11:39 -0400
Received: from gloria.sntech.de ([185.11.138.130]:44730 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229579AbhE1SLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 14:11:30 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lmgvf-0006Ve-Em; Fri, 28 May 2021 20:09:51 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, hjc@rock-chips.com
Subject: Re: [PATCH -next] drm/rockchip: cdn-dp-core: add missing clk_disable_unprepare() on error in cdn_dp_grf_write()
Date:   Fri, 28 May 2021 20:09:46 +0200
Message-Id: <162222530163.2887132.4102330356244489861.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210519134928.2696617-1-yangyingliang@huawei.com>
References: <20210519134928.2696617-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 May 2021 21:49:28 +0800, Yang Yingliang wrote:
> After calling clk_prepare_enable(), clk_disable_unprepare() need
> be called when calling regmap_write() failed.

Applied, thanks!

[1/1] drm/rockchip: cdn-dp-core: add missing clk_disable_unprepare() on error in cdn_dp_grf_write()
      commit: ae41d925c75b53798f289c69ee8d9f7d36432f6d

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
