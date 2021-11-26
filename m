Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F47445EE39
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 13:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377577AbhKZMpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 07:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377568AbhKZMn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 07:43:26 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EEDC061A29
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 04:06:01 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 76D361F46849
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637928360; bh=YOscnsoeA6Wvoqn1LuX19RmPd8uIS9PuwPxrBOZyGaA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=g/a95erAcsTOZwS3imAuBf5UcjVPdb48Lz/U8800KEzzklkmxys4QC6C423leKXOW
         zr5gr7qQACvLxQ/uuPtaVvRMvLY0ZVM7Et/E+mVgHEde+tyV/m7FSo2ThLcnMEoRjo
         dwPjTkZJKbxU3fbZQBB/rTtCm6HXxbzb9bDJccehiTqcOZxiXnJBzoZmjEshIpw7yi
         AlybkUVc44QkONqI0LfNhB8Apt+YXuL1DBX1rWxeJsQZ7Z1RCAmS6tt81ec5/QAV3L
         v5shkkX4NS0T61AzgMNb1FlAWDp465nrCI/9QG6W7RHOOCLRcgDIzwj96KVidbB8+Y
         aJfkdDspYTvYQ==
Subject: Re: [PATCH v2 3/8] ASoC: SOF: topology: Add support for Mediatek AFE
 DAI
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
 <20211118100749.54628-4-daniel.baluta@oss.nxp.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <c31d5fd8-4f11-9f8b-f607-ea9191bc1d1b@collabora.com>
Date:   Fri, 26 Nov 2021 13:05:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211118100749.54628-4-daniel.baluta@oss.nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/11/21 11:07, Daniel Baluta ha scritto:
> From: YC Hung <yc.hung@mediatek.com>
> 
> Add new sof dai and config to pass topology file configuration
> to SOF firmware running on Mediatek platform DSP core.
> Add mediatek audio front end(AFE) to the list of supported sof_dais
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
