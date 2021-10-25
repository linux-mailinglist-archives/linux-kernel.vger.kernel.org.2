Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD19439BC3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 18:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbhJYQmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 12:42:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234025AbhJYQmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 12:42:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3A9F60F9B;
        Mon, 25 Oct 2021 16:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635179980;
        bh=/+1k99dardJpt43GXzNTf7jcp7+7Kejj39Ekr6ZBxmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c/qh8KSmYDq/kS4yWOtElCF2X7RXbxQ+koGDUEJEyBax0tOOfevxflJunpTtnbzYA
         9vC+j9w7MMOV3tvdqEzoIO2IRPqDRBKXCyXYwF/FS3nzD1Sw2VsylXb3p/K9nbGhk2
         sajBgRL2xLO59wpKOyyWRMkU3KF6w3bMRnQIpx48HmconRLGDmSsIWUa6YMRbLogDx
         rPyCh3V0nzMkfoKWNzPfqOHH55FiltYPz5xJzeujzZFyXGQybtNgfYGm3irFFudyfT
         OmRmQ9H/Ti8KM9SxTaMvnBtl47A8Cgz/xxghUfOqxp+n2tZmQV89FoQtK/Yd9qvkFZ
         nLZpaNC7+pq6w==
From:   Mark Brown <broonie@kernel.org>
To:     Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>, Basavaraj.Hiregoudar@amd.com,
        Jaroslav Kysela <perex@perex.cz>, Sunil-kumar.Dommati@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Vijendar.Mukunda@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Alexander.Deucher@amd.com, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] ASoC: amd: acp: Add acp_machine struct for renoir platform.
Date:   Mon, 25 Oct 2021 17:39:22 +0100
Message-Id: <163517996155.3558038.16782674915140335935.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211025074808.471333-1-AjitKumar.Pandey@amd.com>
References: <20211025074808.471333-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2021 13:18:00 +0530, Ajit Kumar Pandey wrote:
> Add acpi_mach struct for renoir platform to select machine driver
> based on codec and amp ACPI id.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: Add acp_machine struct for renoir platform.
      commit: 8a8e1b90bd2cc7db85ba544e63c8dc01fe113fa9

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
