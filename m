Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0048745EACA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 10:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376543AbhKZJ5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 04:57:55 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47850 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376511AbhKZJzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 04:55:51 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 9EA781F4679E
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637920358; bh=LdPocqzS4c6NVM+Baxa36Ld7y/IQX48Z9ZuMAP9HvrM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Wzgy5oin6NcR25FUZZ3ZxFAJmQM2xuX8VDR2OJ1F92bJILJnsTZTM3jJUVfn5GGn+
         vszQpkw4CpY62E755VNz8/n8hQJNlaMbeeeb33BYVvptTVLAFBkcnkgWR1Eow4f0B3
         +tI0//f8Agkimoji60o5oEqv/g2gfovtETC1ZYOCLp5jo1glUVYIclPXS1EPp/So/5
         OgZuiqZDj9le0VgT3QrYt4NmQ5h+Qx3Wy59QcBT9vTLrb5y6d8GKcnUndK8slFla1v
         718A2NkRdbaFRpPAH3DgntP403auZougDHygpnvAc5wjGt5AwWj12E2+TXnp+qD0mg
         ZcBTtlTzRiiIw==
Subject: Re: [v6 4/5] soc: mediatek: pm-domains: Move power status offset to
 power domain data
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
 <20211116025045.5401-5-chun-jie.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <ea30ee01-0eb9-31bc-366e-ef5a1a12f969@collabora.com>
Date:   Fri, 26 Nov 2021 10:52:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211116025045.5401-5-chun-jie.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 16/11/21 03:50, Chun-Jie Chen ha scritto:
> MT8195 has more than 32 power domains so it needs
> two set of pwr_sta and pwr_sta2nd registers,
> so move the register offset from soc data into power domain data.
> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
