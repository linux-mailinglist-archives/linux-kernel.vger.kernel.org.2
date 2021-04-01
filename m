Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57841351333
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 12:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbhDAKRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 06:17:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233650AbhDAKRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 06:17:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 643446108B;
        Thu,  1 Apr 2021 10:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617272238;
        bh=P6MNOdaWHxHkb23Ta5r2u+eFDKM+94LggzIXr7z73p8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bB3/q6L8wHVEBuWb4vrWXDawqc5HI321BuQs70r9pD5Pu42UnjT6pkIbR6IWVa/mD
         vsF8pLjzApOgQsY3A0LV+dpgxaiKjF4kSwNLi47X9Wl5YSypl0yctlKKxpEJJ4ILX4
         QMLUcTNRE18NB6aHIwa3/L2EJnvwMxtcsAP7vSfh863CF2Yi6Q2q7smLGs7Oc9bYWd
         seRR/vMn2JsgIWWvJlwmGtXnaWZvMl4/qp4JfyO1qOhv7bVIK2wfRAMz4wzcXr4MF4
         WHUE7W5JOnOCTtF9DUar7vCERshPb4292dTQ4+OWUcXwH8/0Sm08eydElEzmwv0iOP
         6I2PQnpXcKrEw==
From:   Mark Brown <broonie@kernel.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        cezary.rojewski@intel.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com, tiwai@suse.com,
        liam.r.girdwood@linux.intel.com, linux-kernel@vger.kernel.org,
        yang.jie@linux.intel.com, gustavoars@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>, rdunlap@infradead.org
Subject: Re: [PATCH] ASoC: Intel: Fix a typo
Date:   Thu,  1 Apr 2021 11:16:24 +0100
Message-Id: <161726938995.2219.9727885151861979594.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210322210105.1575758-1-unixbhaskar@gmail.com>
References: <20210322210105.1575758-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2021 02:31:05 +0530, Bhaskar Chowdhury wrote:
> s/defintions/definitions/

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: Fix a typo
      commit: bb0f78e59777d55e0065d16d070b5d43ae80b769

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
