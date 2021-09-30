Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC6C41DCDA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 17:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352098AbhI3PB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 11:01:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:47056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351826AbhI3PBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 11:01:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0067F619E2;
        Thu, 30 Sep 2021 14:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633014000;
        bh=Myi37bbes7ETlK+tTGsWiTVP6FIl//3fgtuWHuTBhDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OFFtJpMcjNsnftt04Ivbz2T2tRgic6D9Un4vw/o86TzAuw9aJ/aVTnxLUIiw6q8S1
         5N1Wli7R4d/+eV/aLakuxtvB58TpqKU5Ksx7n0Oe+fzVohhFpe9gQLq0wHbjcixAMy
         S64RJCx92qqJyp8NDpP7rivlmJXDq/lVgkeFUoUs/+W30FXMngGBLg8U0nE6sAELcK
         RSeIEBODMRHyFDhb/X5LHRZyWM/seesrrLlaA9/PAT6ozZUZ4nuLbUAjIhxBNn5xCN
         q5zBnzFViNN+x2qr7L+ibzDa6BiJIybpr5EqAzNeEFB9uNFugRxEJ6G2QQeAA8GExu
         lY+F4mWsgq/wg==
From:   Mark Brown <broonie@kernel.org>
To:     Xiubo.Lee@gmail.com, tiwai@suse.com, alsa-devel@alsa-project.org,
        festevam@gmail.com, Shengjiu Wang <shengjiu.wang@nxp.com>,
        nicoleotsuka@gmail.com, perex@perex.cz, lgirdwood@gmail.com
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] ASoC: fsl_rpmsg: Add rpmsg audio support for i.MX8ULP
Date:   Thu, 30 Sep 2021 15:58:53 +0100
Message-Id: <163301248179.43045.2909499493214533743.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1632972413-22130-1-git-send-email-shengjiu.wang@nxp.com>
References: <1632972413-22130-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Sep 2021 11:26:53 +0800, Shengjiu Wang wrote:
> On i.MX8ULP the audio interface and codec are controlled
> by Cortex-M domain, Cortex-M core provides audio service
> over rpmsg.
> 
> The rpmsg audio function is almost same as i.MX7ULP
> platform, so share same configuration.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_rpmsg: Add rpmsg audio support for i.MX8ULP
      commit: 2cbf90a6d52d52fc017f3caf36f7b516f689150e

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
