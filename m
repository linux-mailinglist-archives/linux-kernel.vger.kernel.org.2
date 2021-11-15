Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E497C451C66
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355812AbhKPARS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:17:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:45374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355090AbhKOXjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 18:39:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A5E26324A;
        Mon, 15 Nov 2021 23:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637019294;
        bh=Pdcmps+Wn75c6JYbY9VoGfURQ8Z1Y05nyXoNRHD+OTQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=h9m4ZIUrYZJK46lFpAoZLfySpdLpVZ0GK2DIqZpF4Kd0mSTzKJDj1FQ/zbaXv1DKC
         I4ww6c5oL8jCQN9zyRfWz4qeFdHA9E477Ud1xYqSQDJT3YpP0TJtRYpZZb2xnN25LO
         SL5TlCs6J8u6IgIkKayqz51CIECSrK2/LeYuQWJ07RRWTC8gdaJIVAGkKHSuK4lR/D
         3lssK6vcRJDHyoDQB7BNFPz59inGpI3WBdA05DzkArcjxptyVeoYJRzxm4eyUP2Uuv
         8ptP4okq7Fyp/mAa69PaljWPI87N5APdtfYYOeJ+S35ncK2+sf/uuKEAxEaXS0HY4V
         iYDsatuTKTQZA==
From:   Mark Brown <broonie@kernel.org>
To:     Simon Trimmer <simont@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kernel test robot <lkp@intel.com>
In-Reply-To: <20211115120154.56782-1-simont@opensource.cirrus.com>
References: <20211115120154.56782-1-simont@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: wm_adsp: wm_adsp_control_add() error: uninitialized symbol 'ret'
Message-Id: <163701929291.675332.10025590314980830752.b4-ty@kernel.org>
Date:   Mon, 15 Nov 2021 23:34:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2021 12:01:54 +0000, Simon Trimmer wrote:
> This patch fixes the static analysis warning as it is correctly
> indicating a possible code path, it cannot know that for the affected
> firmware versions subname would always be NULL.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/1] ASoC: wm_adsp: wm_adsp_control_add() error: uninitialized symbol 'ret'
      commit: a6e849d0007b374fc7fbb18d55941c77aa7c3923

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
