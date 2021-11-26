Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4515545ED89
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 13:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbhKZML4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 07:11:56 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49454 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377247AbhKZMJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 07:09:51 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 0B9681F46858
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637928397; bh=e+ewKhzLthVTrZjBWWjI+guar4R9HCTxQLF6gS+C6RM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CkfIM/SDpQ7veDRI+cwsOlvDBTqGu9VT6/BB7+rplxlLCkIe1Dea/z3Q2YD+RrAwO
         3iLZGrnHvTQ95MZJ8Q8Okw1YVE2g65EdjHr7ll2QvMGuXMf7huhst9IO93Hibx2ar4
         jxfdEPoMGQIYNxBMsYNFv+PJo/b1N/lfal3I7yNWIjFi6yq/JcIvCdXlG2VqdeBkiw
         nanezsBchHRuoRz40KMy0tmx2OeKwlTlTLOoAmEYtp9IxQfZMsq7GI3PYvr2R4XQOo
         6Uygz9zGzcDfYQuxx89EtP9vANhHFvO/lX1Y46bmdnQ7fvDlBXX+qCsmQ6aOGe4isk
         XatmarWjPF45g==
Subject: Re: [PATCH v2 6/8] ASoC: SOF: mediatek: Add dai driver dsp ops
 callback for mt8195
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        daniel.baluta@nxp.com, daniel.baluta@gmail.com,
        linux-kernel@vger.kernel.org, yc.hung@mediatek.com,
        linux-mediatek@lists.infradead.org,
        =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
References: <20211118100749.54628-1-daniel.baluta@oss.nxp.com>
 <20211118100749.54628-7-daniel.baluta@oss.nxp.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <3510b65f-082a-2d1f-4222-7f2c9930b26e@collabora.com>
Date:   Fri, 26 Nov 2021 13:06:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211118100749.54628-7-daniel.baluta@oss.nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/11/21 11:07, Daniel Baluta ha scritto:
> From: YC Hung <yc.hung@mediatek.com>
> 
> Add dsp ops callback to register AFE DL2/DL3/UL4/UL5 sof dai's with ALSA
> 
> Signed-off-by: YC Hung <yc.hung@mediatek.com>
> Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
