Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D91545EACE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 10:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376583AbhKZJ6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 04:58:03 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47872 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343626AbhKZJ4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 04:56:02 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 197401F467A2
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637920369; bh=zslmW9/PFiYDQ+DRo3zkfuW6OCwzVJ/ZFwDUVo+hOCM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VRoNhI8cdNgWvKGTf//ErjUq8JQw2dZultSRKAjLrzTbFCfIsM0Mdc+owr4Genbhe
         xmEcxKK2pFswEOuOepmhTfRtDd5xQMt91xCF1meAFcNHqj3OA7NXm7rhMEdv2b23Vz
         pDdymjSGAO/QlE3W6Nzhu+/UEECfEYySoO1795IJo/RGVpb3aMjnnpJUbhr+BPbJuY
         FB+qCBiOzOmVupGVzOtPIbEsAR0TXhhAYITLpfagsQhXIXgbS+SGS3KZzP6VnXMHtb
         MbZ5gLdU/+mA4GRIZbMqKLkb5CmysYTYf12GOmb2fCnMQkXazuMcOQ9HtQxldv9VY3
         /C7bCaXRMHsyQ==
Subject: Re: [v6 2/5] soc: mediatek: pm-domains: Add wakeup capacity support
 in power domain
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20211116025045.5401-1-chun-jie.chen@mediatek.com>
 <20211116025045.5401-3-chun-jie.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <a01440d6-39e1-a346-3d48-53a9ba0fec64@collabora.com>
Date:   Fri, 26 Nov 2021 10:52:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211116025045.5401-3-chun-jie.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 16/11/21 03:50, Chun-Jie Chen ha scritto:
> Due to some power domain needs to keep on for wakeup in system suspend,
> so add GENPD_FLAG_ACTIVE_WAKEUP support in Mediatek power domain driver.
> 
> Fixes: 59b644b01cf4 ("soc: mediatek: Add MediaTek SCPSYS power domains")
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
