Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666BF3A5FCA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 12:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbhFNKP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 06:15:28 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:56996 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbhFNKPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 06:15:21 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 233A9A59;
        Mon, 14 Jun 2021 12:13:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1623665597;
        bh=8sfjki0UsWmUH2syJae6b5ofFcxpZFRbmNtSRrH89kU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PNkVAar8AcEWUhomLs8XPC17AM9eKFJTZEOgxZHCE0kvPCkzmm82n7djIxw7PXqYp
         TmGn+Jmir/Qm9i9VXot8TMkooEoJorDEWqJjprVphtpeaL4aFEzZtP4BC1cLGNjD8e
         +AYhRE1U6IXYVqAUA4Im3BpwtR5Ueppo8IMSlkxE=
Date:   Mon, 14 Jun 2021 13:12:56 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Robert Foss <robert.foss@linaro.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, Torsten Duwe <duwe@lst.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sheng Pan <span@analogixsemi.com>,
        Bernie Liang <bliang@analogixsemi.com>,
        Zhen Li <zhenli@analogixsemi.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH v7 3/4] drm/bridge: anx7625: add MIPI DPI input feature
Message-ID: <YMcrqIpHTa8ghObz@pendragon.ideasonboard.com>
References: <cover.1623402115.git.xji@analogixsemi.com>
 <19c0d381ed2911c04878f83ae40dad4d3a086d74.1623402115.git.xji@analogixsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <19c0d381ed2911c04878f83ae40dad4d3a086d74.1623402115.git.xji@analogixsemi.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xin,

Thank you for the patch.

On Fri, Jun 11, 2021 at 05:13:33PM +0800, Xin Ji wrote:
> Add MIPI rx DPI input feature support.

Could you expand the commit message to explain what this feature is ?

> Reviewed-by: Robert Foss <robert.foss@linaro.org>
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 245 ++++++++++++++++------
>  drivers/gpu/drm/bridge/analogix/anx7625.h |  18 +-
>  2 files changed, 203 insertions(+), 60 deletions(-)

[snip]

-- 
Regards,

Laurent Pinchart
