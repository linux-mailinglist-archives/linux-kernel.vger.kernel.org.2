Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E1A41CB88
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 20:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345719AbhI2SLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 14:11:11 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52792 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345682AbhI2SLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 14:11:10 -0400
Received: from notapiano (unknown [IPv6:2804:14c:1a9:2434:b693:c9:5cb6:b688])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C9D6B1F44852;
        Wed, 29 Sep 2021 19:09:25 +0100 (BST)
Date:   Wed, 29 Sep 2021 15:09:20 -0300
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org,
        Sandy Huang <hjc@rock-chips.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Thomas Hebb <tommyhebb@gmail.com>
Subject: Re: [PATCH v3 3/4] drm/rockchip: dsi: Fix unbalanced clock on probe
 error
Message-ID: <20210929180920.mczakda7msbojrxx@notapiano>
References: <20210928213552.1001939-1-briannorris@chromium.org>
 <20210928143413.v3.3.Ie8ceefb51ab6065a1151869b6fcda41a467d4d2c@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210928143413.v3.3.Ie8ceefb51ab6065a1151869b6fcda41a467d4d2c@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 02:35:51PM -0700, Brian Norris wrote:
> Our probe() function never enabled this clock, so we shouldn't disable
> it if we fail to probe the bridge.
> 
> Noted by inspection.
> 
> Fixes: 2d4f7bdafd70 ("drm/rockchip: dsi: migrate to use dw-mipi-dsi bridge driver")
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
