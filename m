Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D9B45EAC9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 10:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376521AbhKZJ5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 04:57:53 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47838 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343615AbhKZJzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 04:55:49 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 792001F4679C
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637920356; bh=J8iIrBEHqGRvAu0pRdEOnxWRHiYQBg+NSmXWzt0Ut7g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nfL0inx1Vr5uqHHJZ0LYLXwFzP9VEIotaqUxW4yLID8EW9kkE7I0v63OhaWOx94q5
         lMmHuK6G97iNSbyL2NNHxG8agCTKbdhXJGdrXR7UrCyL6TSdAIpAOw8kelaR/9p6Gx
         o6kIVqQ2re1RYbM1KuYWyON4rS+lh5qG/2RQUX2dVljCcQrV7rEaaQkiGhfgi7EqVY
         YQD1scAuJMLD81ZoSFSfkOWY8dfVyS6D/yhAQClcZvUdCVAZrmVdqJtAS1n2kbE+n6
         qEzoxgWs4f7m6EjUvJ/67I4fguEraR0zM1Pojy3bUrHlEehvoDTuA0dt9leQAzAzGI
         M8R72POuodYkQ==
Subject: Re: [v6 3/5] soc: mediatek: pm-domains: Remove unused macro
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
 <20211116025045.5401-4-chun-jie.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <d5a7ab04-bc42-8897-d549-a759f97bdd5b@collabora.com>
Date:   Fri, 26 Nov 2021 10:52:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211116025045.5401-4-chun-jie.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 16/11/21 03:50, Chun-Jie Chen ha scritto:
> Due to clk resource data will be allocated dynamically by
> searching parent count of clk in power domain node, so remove
> the unused marco MAX_SUBSYS_CLKS for static allocation.
> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
