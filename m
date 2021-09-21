Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBBF413124
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 12:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhIUKFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 06:05:42 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38136 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231484AbhIUKFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 06:05:37 -0400
Received: from ip5f5a6e92.dynamic.kabel-deutschland.de ([95.90.110.146] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mScdB-0001rd-Ti; Tue, 21 Sep 2021 12:04:06 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     hjc@rock-chips.com, linux-rockchip@lists.infradead.org,
        Andy Yan <andy.yan@rock-chips.com>,
        dri-devel@lists.freedesktop.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: Check iommu itself instead of it's parent for device_is_available
Date:   Tue, 21 Sep 2021 12:03:30 +0200
Message-Id: <163221857585.2031971.16493849753912180569.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210627084737.309163-1-andy.yan@rock-chips.com>
References: <20210627084737.309163-1-andy.yan@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jun 2021 16:47:37 +0800, Andy Yan wrote:
> When iommu itself is disabled in dts, we should
> fallback to non-iommu buffer, check iommu parent
> is meanless here.

Applied, thanks!

[1/1] drm/rockchip: Check iommu itself instead of it's parent for device_is_available
      commit: e1202c7a65b10258f9a11c1d2613c2aa91fe11cd

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
