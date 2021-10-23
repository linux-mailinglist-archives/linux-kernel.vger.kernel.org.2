Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F7843837B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 13:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhJWLpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 07:45:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229778AbhJWLpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 07:45:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 001226101D;
        Sat, 23 Oct 2021 11:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634989393;
        bh=4XWHzvmtR+wyqWJ4k/FFXOcBIOC+UMb5i8hvEybrro0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uWCGOpFmHw594t9/j++tNZ7cvKVnwFfIjur8Dpcc3JvolLixfuvhgG1g/5Oo1xcXa
         AZ7p2MhfmHV2WPD+O4Qr7W3+nus7oJfwYzkbflMYWs/tjR/vtvUjqsNL2SBYQC7UGV
         jmOwmNkEJzZZxfObAQpQAI5lsi8ycht9r4PTQe7e7vGklxvQwwu4d5BGaRN34To6/A
         HF19/YOvnOwOWJaylnNX2swke+U48ymfnJh9IIrVVZu+OTWGcq7BTTkspM6LGtk1mf
         8WJdowxh3AeO0X0IxODhQkZ3BWQQMvVjympSsStSHLRMHOGq8foun88Pmk9L8zKajZ
         EA/LhrRymdTHg==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: cs42l42: Remove unused runtime_suspend/runtime_resume callbacks
Date:   Sat, 23 Oct 2021 12:43:08 +0100
Message-Id: <163498938018.2020965.16977108609282715073.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018164431.5871-1-rf@opensource.cirrus.com>
References: <20211018164431.5871-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2021 17:44:31 +0100, Richard Fitzgerald wrote:
> The driver has runtime_suspend and runtime_resume callbacks, but
> pm_runtime is never enabled so these functions won't be called. They
> could not be used anyway because the runtime_suspend would cause jack
> detect to stop working.
> 
> These functions are unused - delete them.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l42: Remove unused runtime_suspend/runtime_resume callbacks
      commit: c778c01d3e665045d29d548d946f7cd64aec0ff9

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
