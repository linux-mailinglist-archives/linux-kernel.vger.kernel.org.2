Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9B045EAC6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 10:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376493AbhKZJ5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 04:57:49 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47824 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376510AbhKZJzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 04:55:47 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 7164A1F4679A
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637920354; bh=ZnUEJaaKUjaX1sEaOS2pZbx+Nlz+4IKw336B3gebOgw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aqKDZVo2Y3+c0Tusu4OXJGfNVBhioufcXcm+G+Ehwbg8l40L7DGZfgGPOJatNfGxW
         B98b1uKhzg0XGQ8S+ECcG+Z5wMYpifHc9iSgBHOlL5mZl/FrsrVlTpCWw4A+z1RUXk
         WAYMzZvO5o0O7W/SJCckSr7pdLsPCp9famlYbkTiKmSAWPT+t30z2C7kwANfdp3q2i
         PWIRW4VDCLdiThjsD6agDbl4tOpgdQyKMxedgdCbLjBQ8iqVo3voIe2eu+JiYcWEjv
         uExdfmpdI2UPcXP9UatSOjB0bLK57W2qVqTQOekft51X+NuwS5XsVi5Lr1ND8hhEx0
         nof9ggJyD5ifg==
Subject: Re: [v6 1/5] dt-bindings: power: Add MT8195 power domains
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
 <20211116025045.5401-2-chun-jie.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <ad71b562-87aa-2eda-e998-8ae8233e7e3d@collabora.com>
Date:   Fri, 26 Nov 2021 10:52:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211116025045.5401-2-chun-jie.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 16/11/21 03:50, Chun-Jie Chen ha scritto:
> Add power domains dt-bindings for MT8195.
> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
