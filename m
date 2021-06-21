Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3D73AF574
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 20:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhFUStf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 14:49:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232268AbhFUStb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 14:49:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A7ED361356;
        Mon, 21 Jun 2021 18:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624301237;
        bh=Iubxdx/A0LOWkRzH0XmE/PG82jZyYbybm0iqM02k/K8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iqNceW4JN57jLG5Cs8HM5C2aCBREYT0iAMSkFQ3FxmKkF8VfhFGk7B/IQqRzuxyTm
         bQorA7OJGw9Oss8sHHun5CHwxxMEoL1ZPNYFwhVrJgXuSwIAjyYTxyrBii37TJRKSG
         y2S2Rd+AnA7W9dK1TkGJCHX0qr210qDIaprrGaU7PO4RFJZ+UbwHARmz9EWhE2d3nT
         LbxBjnYiRsHFINZBN9I/s3t3c1YNRzO2H2j2C+LtF3KUsfT1E5/o/AGybp+d2NoL0F
         kWBuO0XOemln3vP0s71JCwyEkMiw6uCKsDM4ubZhtiGESGZht8Vx7ZGPsJsgcg4836
         wSVPkXW9UdXug==
From:   Mark Brown <broonie@kernel.org>
To:     Xiubo.Lee@gmail.com, tiwai@suse.com, nicoleotsuka@gmail.com,
        perex@perex.cz, timur@kernel.org, alsa-devel@alsa-project.org,
        festevam@gmail.com, Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: fsl_xcvr: disable all interrupts when suspend happens
Date:   Mon, 21 Jun 2021 19:46:06 +0100
Message-Id: <162430055263.9224.18141192734216884293.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1624019913-3380-1-git-send-email-shengjiu.wang@nxp.com>
References: <1624019913-3380-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2021 20:38:33 +0800, Shengjiu Wang wrote:
> There is an unhandled interrupt after suspend, which cause endless
> interrupt when system resume, so system may hang.
> 
> Disable all interrupts in runtime suspend callback to avoid above
> issue.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_xcvr: disable all interrupts when suspend happens
      commit: ea837090b388245744988083313f6e9c7c9b9699

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
