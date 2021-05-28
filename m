Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8153946CC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 20:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhE1SLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 14:11:36 -0400
Received: from gloria.sntech.de ([185.11.138.130]:44712 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229563AbhE1SL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 14:11:29 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lmgve-0006Ve-27; Fri, 28 May 2021 20:09:50 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Alex Bee <knaerzche@gmail.com>, linux-rockchip@lists.infradead.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, Sandy Huang <hjc@rock-chips.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Subject: Re: [PATCH v3 0/5] drm: rockchip: various ports for older VOPs
Date:   Fri, 28 May 2021 20:09:42 +0200
Message-Id: <162222530163.2887132.16504920564913843311.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210528130554.72191-1-knaerzche@gmail.com>
References: <20210528130554.72191-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 May 2021 15:05:49 +0200, Alex Bee wrote:
> this is v3 of a series I posted almost 1 year ago. I considered now all
> feedback I got at that time.
> It mainly ports existining functionality to older SoCs - most importantly
> enables alpha blending for RK3036, RK3066, RK3126 and RK3188
> 
> Note some of the patches are required to let VOP correctly process the
> data that comes from the video decoder - I recently posted a series that
> adds support for those older SoCs at [1].
> 
> [...]

Applied, thanks!

[1/5] drm: rockchip: add scaling for RK3036 win1
      commit: 53c2710c0d92e615c9fffcc64aa963dfa0e100a7
[2/5] drm: rockchip: add missing registers for RK3188
      commit: ab64b448a175b8a5a4bd323b8f74758c2574482c
[3/5] drm: rockchip: add missing registers for RK3066
      commit: 742203cd56d150eb7884eb45abb7d9dbc2bdbf04
[4/5] drm: rockchip: add alpha support for RK3036, RK3066, RK3126 and RK3188
      commit: d099fa672cbe8766d9182e0fd04c65058200128a
[5/5] drm: rockchip: set alpha_en to 0 if it is not used
      commit: 046e0db975695540c9d9898cdbf0b60533d28afb

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
