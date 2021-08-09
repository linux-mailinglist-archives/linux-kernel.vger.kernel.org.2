Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966063E461A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 15:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbhHINHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 09:07:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234804AbhHING4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 09:06:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 568FE60EC0;
        Mon,  9 Aug 2021 13:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628514395;
        bh=rEqpI+98X4LE1B1t+KYLHnIXl5RlP80YLG32eZNXOmI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cu+4tcj+XnrmFi/P7Ieyo7BZGQvQSh3FkJUTbhEUYkkselfWLN3mcrT/KPcdT9Q/S
         i/JxpQUTbx+5x4T9bduFoK7sywtyojgwar9HgG/OxUI8Kgbp3wg9NAKI8wSo6cjTPO
         4Lpmx0q3WYGpSJeT/6yiwQPwZlfAdbv5d+rA7WLUxzW+kUIObNgaUPjXu0vW0hjoBM
         oGCZY3pmh5UC5m/gZLAbKxvliRlpHk9WUH82buBbE2hly6tK9JK7eg+H52c7WEQPjh
         sebU95EvUlYJK9+xU6ab2/ypTS5eiXa2cBtEpynB3s6u3hVSnilb0N9iI3p2PNhezF
         Dw0Fbyk/d+1QQ==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, tiwai@suse.com,
        Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, bgoswami@codeaurora.org,
        srinivas.kandagatla@linaro.org, stephan@gerhold.net,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v2] ASoC: qcom: apq8016_sbc: Add SEC_MI2S support
Date:   Mon,  9 Aug 2021 14:06:07 +0100
Message-Id: <162851391370.50969.18431436313519006594.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210806114116.895473-1-vincent.knecht@mailoo.org>
References: <20210806114116.895473-1-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Aug 2021 13:41:16 +0200, Vincent Knecht wrote:
> This patch adds external codec support on secondary mi2s.
> It is used for headphones on some devices, eg. alcatel-idol347.
> 
> 
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: apq8016_sbc: Add SEC_MI2S support
      commit: 1e2c7845421b785282c098712a81556a2b8917a5

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
