Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC3345EE3A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 13:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353282AbhKZMpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 07:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377567AbhKZMn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 07:43:26 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4C5C061A27
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 04:05:56 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 60C4C1F46847
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637928355; bh=9EQmaihFqroyudxA2nA0/OcsptHnfOtG3O895b09Y2g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=K+tqyBcSzgn/XvTEwoARRUXVoMuW3VR0M9EJZTrKV9TMaA4ZotGcziOvZbCNrw41p
         pHq4wvsIvn8Q5xf9YZdYQ1uiP5mc80hNRnx2/L0yihFqoteGv4FLcufgZWWvU2C4fY
         NCsXfU0pXXYcjLceWyeUw5nTPz9U5WnL1F71zb/cZPUtqSbfFUIsEpu4fd7AJnVAB5
         JyceM4BHVE6oINAM2tfDRm0WPMyWCN93FMT38lrYdAt9Cf+a2U54bzWHfrZS7p4RtG
         RyoDhRVdHRLraYo2Iy+54YEBZ5o8LJnicgOrfOg/+IJKu5QplQbUIutlZ4jEruBHQo
         H0kZmjJQ2Da4Q==
Subject: Re: [PATCH v2 4/8] ASoC: SOF: mediatek: Add fw loader and mt8195 dsp
 ops to load firmware
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
 <20211118100749.54628-5-daniel.baluta@oss.nxp.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <9521a830-bf02-8232-368e-1afb4b978bf4@collabora.com>
Date:   Fri, 26 Nov 2021 13:05:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211118100749.54628-5-daniel.baluta@oss.nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/11/21 11:07, Daniel Baluta ha scritto:
> From: YC Hung <yc.hung@mediatek.com>
> 
> Add mt8195-loader module with ops callback to load and run firmware
> on mt8195 platform.
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
