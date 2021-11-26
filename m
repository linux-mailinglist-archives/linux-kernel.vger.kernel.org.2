Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7874745EE3B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 13:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377598AbhKZMph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 07:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhKZMna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 07:43:30 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CD5C061A30
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 04:06:05 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 113451F46847
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637928364; bh=aM0ClwaIkOmOfA+rtGLm+e5bAyYY0Zq25jWi1025T0c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JF/U3uhAHtR6EdQ445+C0XbYA4x29h0BiVIWW8wSkx1Zgnc16eGul/QWwC1PvfyKF
         vy8D1+ng+YFmi5qvs2vouJKqMpqS1ZIEeU2akp6YZiGz61nNpxo1SY5PPRN2OV6VOu
         iOr3i+GwrhlHPvVaUh3LI1TRnqc6hW4eIDWgwjcsbEwseIp3wYEkNp1NB6CcHVhvkw
         VnTc10G1xNOGojto08EIklEGpGGg/Yq3vIvn7NBHTHmBT4dmJeUJkcQ/6IRECGv/ce
         FoOGU17fHfwanYGFx87pKEk4XqExcOI+rG0gEwoWu5h8g/79bcmJx62QxNuV4124RF
         qkKN1hv3wFtzQ==
Subject: Re: [PATCH v2 2/8] ASoC: SOF: tokens: add token for Mediatek AFE
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        daniel.baluta@nxp.com, daniel.baluta@gmail.com,
        linux-kernel@vger.kernel.org, yc.hung@mediatek.com,
        linux-mediatek@lists.infradead.org,
        =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
References: <20211118100749.54628-1-daniel.baluta@oss.nxp.com>
 <20211118100749.54628-3-daniel.baluta@oss.nxp.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <fd9aec72-9bf8-9700-afa8-ec9860265be5@collabora.com>
Date:   Fri, 26 Nov 2021 13:06:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211118100749.54628-3-daniel.baluta@oss.nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/11/21 11:07, Daniel Baluta ha scritto:
> From: YC Hung <yc.hung@mediatek.com>
> 
> Add the definition for Mediatek audio front end(AFE) tokens,include
> AFE sampling rate, channels, and format.
> 
> Signed-off-by: YC Hung <yc.hung@mediatek.com>
> Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
