Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06A7394752
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 20:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhE1S5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 14:57:39 -0400
Received: from gloria.sntech.de ([185.11.138.130]:45084 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229494AbhE1S5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 14:57:33 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lmheG-0006hU-5i; Fri, 28 May 2021 20:55:56 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     daniel@ffwll.ch,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        miquel.raynal@bootlin.com, airlied@linux.ie, hjc@rock-chips.com
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] drm/rockchip: Fix an error handling path
Date:   Fri, 28 May 2021 20:55:52 +0200
Message-Id: <162222814865.2904787.11303263150056915377.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <248220d4815dc8c8088cebfab7d6df5f70518438.1619881852.git.christophe.jaillet@wanadoo.fr>
References: <248220d4815dc8c8088cebfab7d6df5f70518438.1619881852.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 May 2021 17:13:16 +0200, Christophe JAILLET wrote:
> 'ret' is know to be 0 a this point. Checking the return value of
> 'phy_init()' and 'phy_set_mode()' was intended instead.
> 
> So add the missing assignments.

Applied, thanks!

[1/1] drm/rockchip: Fix an error handling path
      commit: 3dfa159f6b0c054eb63673fbf643a5f2cc862e63

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
