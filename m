Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38A633EAFA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhCQIAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:00:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230099AbhCQIAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:00:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BEC8064F7F;
        Wed, 17 Mar 2021 07:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615967997;
        bh=zHlz/DP1LMQdZ4feA4AUsePng/JL/gc3mcPdR5jADsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KzJ3KvrVrK6mhM0cJkQf9V2wrc0cZfOOTvhKUWQp13dj4IQcq6rDqazZ3bsKmlAOI
         SQpg48vUBBSku+AXLMAsxy5Vf1O+bwDZSQiFmRE5duJs0ZHS7PZCmuQIom0r0igEvL
         c/NzXd2wZQItyd8yzVTQ1AfBE5tk5sQAdNUMSnf9kQDNjLH2AFvvKl9C3wqJMA46Qm
         /TPEoE8UXG/RbWt91PmQmk0qLsiti/f2u7WxMOPRyDkudeuzayZYMZApxdGN5Um+ES
         +0G+kYheSI78EXdeSrtDt5QwNBb49LMQpGv8f0to4ylDuVwGVYqAKD/NeV2VX7mEH+
         x+pHFOsCuMz5Q==
Date:   Wed, 17 Mar 2021 15:59:51 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     devicetree@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, kernel@puri.sm, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH v2 0/3] Librem 5 phone dts fixes
Message-ID: <20210317075951.GS11246@dragon>
References: <20210311120259.3310499-1-martin.kepplinger@puri.sm>
 <20210315083531.3743183-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210315083531.3743183-1-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 09:35:28AM +0100, Martin Kepplinger wrote:
> Two fixes for the Librem 5 phone descriptions and one resend of
> https://lore.kernel.org/linux-arm-kernel/20200915141622.14736-1-festevam@gmail.com/
> that enables the hantro vpu staging driver. Feel free to ignore that one
> if we want to wait for it to be out of staging.
> 
> revision history
> ----------------
> v2: (thanks Shawn)
>  * fix commit hash in commit message
> 
> v1:
>  * https://lore.kernel.org/phone-devel/20210311120259.3310499-1-martin.kepplinger@puri.sm/T/
> 
> Fabio Estevam (1):
>   arm64: defconfig: Enable the Hantro decoder
> 
> Guido Günther (1):
>   arm64: dts: imx8mq-librem5: Hog the correct gpio
> 
> Sebastian Krzyszkowiak (1):
>   arm64: dts: imx8mq-librem5-r3: Mark buck3 as always on

Applied all, thanks.
