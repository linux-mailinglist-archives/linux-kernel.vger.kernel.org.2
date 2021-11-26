Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7BEA45EACC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 10:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbhKZJ56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 04:57:58 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47858 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376512AbhKZJz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 04:55:57 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 7AEC41F467A0
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637920364; bh=rVOstqiVmOsKMfWEUSvwqUjE3oNqTc8x3v1FWlLX+Z4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FDgBPLPD0nXzVR6W3alw6qetAhJNcx4e2owuUkbCUZuZ55Y41SQF/bq2zPfrOVrYX
         Oii6a4hQl12UEYfLbjbhQu2psmE7CGah7VFRY7lQnNXlYH9lMVokExY/howpToA3RP
         RpjPYiVOfVC54t0SVFSLTAjZ8D6zpX6ULRaIozlSFRNm7Z4ZVlMFDr9T/PWpRLhV2Y
         GzCs8o4wlmolDQPSEj0DEYd/Ijk4pOUkXYluc/yHwQ1lncjXiKMDBikjQhJZPFzCER
         4KK8DUyAU6rhWHVj8Gx06PtNUC+QZxnGbAnczEhZghuwk366G7UZLYmHhBpjvoIuAN
         3DDQMYibBg0fA==
Subject: Re: [v6 5/5] soc: mediatek: pm-domains: Add support for mt8195
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
 <20211116025045.5401-6-chun-jie.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <41c192ff-0b37-653a-f43d-2ca6c804077e@collabora.com>
Date:   Fri, 26 Nov 2021 10:52:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211116025045.5401-6-chun-jie.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 16/11/21 03:50, Chun-Jie Chen ha scritto:
> Add domain control data including bus protection data size
> change due to more protection steps in mt8195.
> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

