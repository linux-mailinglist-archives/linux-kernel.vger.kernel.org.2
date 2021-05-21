Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738C738C2D9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 11:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235935AbhEUJSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 05:18:04 -0400
Received: from gloria.sntech.de ([185.11.138.130]:51592 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234727AbhEUJSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 05:18:03 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lk1Gh-0004vA-Bn; Fri, 21 May 2021 11:16:31 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        xxm@rock-chips.com, robin.murphy@arm.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: Re: [PATCH v5 3/4] iommu: rockchip: Add internal ops to handle variants
Date:   Fri, 21 May 2021 11:16:30 +0200
Message-ID: <4753042.QJadu78ljV@diego>
In-Reply-To: <20210521083637.3221304-4-benjamin.gaignard@collabora.com>
References: <20210521083637.3221304-1-benjamin.gaignard@collabora.com> <20210521083637.3221304-4-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 21. Mai 2021, 10:36:36 CEST schrieb Benjamin Gaignard:
> Add internal ops to be able to handle incoming variant v2.
> The goal is to keep the overall structure of the framework but
> to allow to add the evolution of this hardware block.
> 
> The ops are global for a SoC because iommu domains are not
> attached to a specific devices if they are for a virtuel device like
> drm. Use a global variable shouldn't be since SoC usually doesn't
> embedded different versions of the iommu hardware block.
> If that happen one day a WARN_ON will be displayed at probe time.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



