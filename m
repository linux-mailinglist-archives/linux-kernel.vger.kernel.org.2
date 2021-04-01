Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0EB35100C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 09:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbhDAHXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 03:23:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233050AbhDAHXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 03:23:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46EBF6023C;
        Thu,  1 Apr 2021 07:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617261784;
        bh=J709AUoNNYTejo2qFGwK4/6PgplsILaGpLmxycENUFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yl3QqHt0VGFiJEHeSvxsHq86JpTpo5/0af2t5FhNqpzsvHgqdbsS+EXWRArF+53xQ
         ATGYc3aoAfDRy/8m/946DbHam5H+hlHdw9fDht0in934LvojraXlB8xW1DPyyZ/M6n
         4znVEh9Xn71D+36Sg/ot6/u6T4vB+HHHHPbHTzGW94LeEe35KKC22uxHDBgDAuaIEg
         hf9Kvz6AuEIwRPXAd7srfbunXUCAtWYruuzu+Sq2MWKlDhEN7/PVyw7pOg2/o2IICM
         NmwI0/UVk/+hyEZibRbk46rvj4bfhjo+S6gnZTsm10S3DHScqtxG3BgDGOW0gbALkI
         yO8hUyhMr7UJw==
Date:   Thu, 1 Apr 2021 12:52:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
        yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v4 0/5] soundwire: add static port map support
Message-ID: <YGV009kiiArJsFMM@vkoul-mobl.Dlink>
References: <20210315165650.13392-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315165650.13392-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-03-21, 16:56, Srinivas Kandagatla wrote:
> In some cases, SoundWire device ports are statically mapped to Controller
> ports during design, however there is no way to expose this information
> to the controller. Controllers like Qualcomm ones use this info to setup
> static bandwidth parameters for those ports.
> 
> A generic port allocation is not possible in this cases!
> This patch adds a new member m_port_map to SoundWire device so that
> it can populate the static master port map and share it with controller
> to be able to setup correct bandwidth parameters.
> 
> As a user of this feature this patchset also adds new bindings for
> wsa881x smart speaker which has 4 ports which are statically mapped
> to the 3 output and 1 input port of the controller.
> 
> Tested it on DB845c and SM8250 MTP.
> 
> thanks,
> srini
> 
> Changes since v3:
> 	- updated kernel doc for more clarity on m_port_map
> 
> Srinivas Kandagatla (5):
>   soundwire: add static port mapping support
>   soundwire: qcom: update port map allocation bit mask
>   soundwire: qcom: add static port map support

Applied all sdw patches, thanks

>   ASoC: dt-bindings: wsa881x: add bindings for port mapping
>   ASoC: codecs: wsa881x: add static port map support
> 
>  .../bindings/sound/qcom,wsa881x.yaml          |  9 ++++++
>  drivers/soundwire/qcom.c                      | 31 +++++++++++++++----
>  include/linux/soundwire/sdw.h                 |  2 ++
>  sound/soc/codecs/wsa881x.c                    |  7 +++++
>  4 files changed, 43 insertions(+), 6 deletions(-)
> 
> -- 
> 2.21.0

-- 
~Vinod
