Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC2F45ED8C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 13:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352993AbhKZMMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 07:12:35 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49508 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377383AbhKZMKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 07:10:34 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 3EA201F46821
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637928440; bh=dj2wyPkbyn7gApbtIg2geaaFyZHLewmQWww8/OOcwjY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Az76iqIeCUTTCWBpk7fpTJfqJeU1u4CPWP9K+xYrfFGv/0dB9VO/tXACSwBiWAL3F
         EAqKvqKUkb3xqeMHFuUetdTIX36FVVSmXMgxlkgGCAD4IUsFDxspbvkIve/RwXv/jX
         BJinM1irXDoV2KqilKafoYDmYfGrpMrelH7XbbcEIDLWaL9rwjkx5nNFAqR+qG9nfn
         BAvUfweBRwMsRh5DMb2yXS/4MRvo0f05BeZ3j3Mq3ufsrhqtn+KKqwhfZ52Olvrwfj
         dk+ow6aRijgPT/AJ/d+smDIR/0l4IRuWql8CmwMqRs71yCO7jPA36E1WjRffyzF9to
         HbbVCD2458/lw==
Subject: Re: [PATCH v2 8/8] ASoC: SOF: mediatek: Add DSP system PM callback
 for mt8195
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        daniel.baluta@nxp.com, daniel.baluta@gmail.com,
        linux-kernel@vger.kernel.org, yc.hung@mediatek.com,
        linux-mediatek@lists.infradead.org
References: <20211118100749.54628-1-daniel.baluta@oss.nxp.com>
 <20211118100749.54628-9-daniel.baluta@oss.nxp.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <3cc9c55c-16ad-26aa-c41b-2f3f9302f021@collabora.com>
Date:   Fri, 26 Nov 2021 13:07:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211118100749.54628-9-daniel.baluta@oss.nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/11/21 11:07, Daniel Baluta ha scritto:
> From: YC Hung <yc.hung@mediatek.com>
> 
> Add DSP system PM callback for suspend and resume
> 
> Signed-off-by: YC Hung <yc.hung@mediatek.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


