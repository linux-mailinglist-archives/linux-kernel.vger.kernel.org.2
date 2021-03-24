Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8CC3476AC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 11:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbhCXK64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 06:58:56 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33900 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbhCXK6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 06:58:46 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: rcn)
        with ESMTPSA id BE82D1F4598C
Date:   Wed, 24 Mar 2021 11:58:41 +0100
From:   Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Ben Ho <Ben.Ho@mediatek.com>
Subject: Re: [PATCH v4 4/4] arm64: dts: mt8183: Add kukui-jacuzzi-juniper
 board
Message-ID: <20210324105841.anhogvmawrlpnyqy@rcn-XPS-13-9360>
Mail-Followup-To: Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Ben Ho <Ben.Ho@mediatek.com>
References: <20210319035245.2751911-1-hsinyi@chromium.org>
 <20210319035245.2751911-4-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210319035245.2751911-4-hsinyi@chromium.org>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On vie 19-03-2021 11:52:45, Hsin-Yi Wang wrote:
> Juniper is known as Acer Chromebook Spin 311 (CP311-3H).
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

I picked this patch in the current rc4 kernel and booted it successfully
on an Acer Chromebook Spin 311 with no noticeable problems, so:

Tested-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
