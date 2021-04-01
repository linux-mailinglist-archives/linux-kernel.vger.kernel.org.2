Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1796E351330
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 12:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbhDAKR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 06:17:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233834AbhDAKRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 06:17:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C023610A5;
        Thu,  1 Apr 2021 10:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617272220;
        bh=/jx/jQje8kkrqXjx7RDy/j90nb/SyqP/To3rfuqgLRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EacqhlpbFRD8tiLhUf3EBRi8BL3pSQsYZP4uO0NUsCbH7hNwKiN4h+EwQUwiLX9I6
         3uUeZ9WZinW9kPKN3kmD4uErSHQfuRxTNZJasfIkVg8/UPNe9JZ6QpZbIAWq6AuWEv
         foHXsC7yNXxmnhc7Ewn7UEZlLRLAOlg9tCj1VUU7+aI0Z5LLk5s2lK2gxgRDMPbPR1
         bQvazsZq3EGhCCSl3dlT86VpG3oPBc8JmJycBeV7SdPvrq4v9IjIJYojI57kD//YlI
         6Lla4hBTNNaRwDEBm0AyIKljMX6leB+RH0UWkFsublfyHZLuLCI7QCOGc2HWbJ/OBa
         3mFqkk1ozhpvA==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
        alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: ak5558: Add support for ak5552
Date:   Thu,  1 Apr 2021 11:16:19 +0100
Message-Id: <161726938994.2219.919053802022134922.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1617176686-25528-1-git-send-email-shengjiu.wang@nxp.com>
References: <1617176686-25528-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2021 15:44:45 +0800, Shengjiu Wang wrote:
> AK5552 is a 32-bit 2ch ADC and has the same register
> map as AK5558.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: ak5558: Add support for ak5552
      commit: d8c5c82e4e5b641404c65bfc6cdf57b5d0a6c836
[2/2] ASoC: dt-bindings: ak5558: Add compatible string for ak5552
      commit: 8d246806d510c1bf7da9aab0473dc0f9c9f99308

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
