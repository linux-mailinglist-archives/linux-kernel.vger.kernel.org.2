Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18BDE394753
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 20:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhE1S5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 14:57:40 -0400
Received: from gloria.sntech.de ([185.11.138.130]:45104 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229571AbhE1S5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 14:57:35 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lmheG-0006hU-Lv; Fri, 28 May 2021 20:55:56 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Colin King <colin.king@canonical.com>,
        Chris Zhong <zyw@rock-chips.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sandy Huang <hjc@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org,
        Guenter Roeck <groeck@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: cdn-dp: fix sign extension on an int multiply for a u64 result
Date:   Fri, 28 May 2021 20:55:53 +0200
Message-Id: <162222814865.2904787.9681017201633439176.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20200915162049.36434-1-colin.king@canonical.com>
References: <20200915162049.36434-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Sep 2020 17:20:49 +0100, Colin King wrote:
> The variable bit_per_pix is a u8 and is promoted in the multiplication
> to an int type and then sign extended to a u64. If the result of the
> int multiplication is greater than 0x7fffffff then the upper 32 bits will
> be set to 1 as a result of the sign extension. Avoid this by casting
> tu_size_reg to u64 to avoid sign extension and also a potential overflow.

Applied, thanks!

[1/1] drm/rockchip: cdn-dp: fix sign extension on an int multiply for a u64 result
      commit: ce0cb93a5adb283f577cd4661f511047b5e39028

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
