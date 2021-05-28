Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8023946D2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 20:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhE1SLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 14:11:41 -0400
Received: from gloria.sntech.de ([185.11.138.130]:44724 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229450AbhE1SLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 14:11:30 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lmgvd-0006Ve-LQ; Fri, 28 May 2021 20:09:49 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     hjc@rock-chips.com, Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, airlied@linux.ie,
        linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drm/rockchip: remove unused function
Date:   Fri, 28 May 2021 20:09:41 +0200
Message-Id: <162222530163.2887132.15884573129584763057.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <1618476421-114429-1-git-send-email-jiapeng.chong@linux.alibaba.com>
References: <1618476421-114429-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2021 16:47:01 +0800, Jiapeng Chong wrote:
> Fix the following clang warning:
> 
> drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c:320:20: warning: unused
> function 'dsi_set' [-Wunused-function].

Applied, thanks!

[1/1] drm/rockchip: remove unused function
      commit: 7455cedf7c4d4d5d808913e14d859705612c54ce

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
