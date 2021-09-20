Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F5941183C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 17:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241503AbhITPdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 11:33:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241472AbhITPdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 11:33:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E043160F36;
        Mon, 20 Sep 2021 15:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632151897;
        bh=A0tS1t9WkUvxRLJYiwr5ukuS3gTDThaOppci635m+B8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IlME46U2amjNIUmATwMLZ+GJsCYdMJpvF4MfkqqA2GjoO9jGadQYo31BBtQrZ58DT
         ESY892Y2/eCjdekn6UQstrhLde2xEnHYV5nnsyEPoWEQWjdi7pidtFCumHRBRCEs8p
         GJLkDbps/FP8/MuFf/LC4PTQ08d3A44Ga+RM/925RIj921LCkXRd5j7pKbKvuFP2ns
         cO3z9eeDm4tW9I0zKmBHEq/U+fqqNFIEz4QwhcYoVV7GmMDDo3dytwguBwvqKDMis+
         OPcZ8jEVO/+BKLLW3GLBwIW9Pu+hYXgL9xugEGCPSq17Y8B02w9BEI1dXRSj3xGEyb
         29/zb3s3i9eeg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Ramona Alexandra Nechita <ramona.nechita@analog.com>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com
Subject: Re: [PATCH v2] regulators: fix typo in Kconfig and max8973-regulator
Date:   Mon, 20 Sep 2021 16:30:43 +0100
Message-Id: <163215166457.38552.5108147347475492562.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210920061137.10884-1-ramona.nechita@analog.com>
References: <20210920061137.10884-1-ramona.nechita@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Sep 2021 09:11:37 +0300, Ramona Alexandra Nechita wrote:
> MAX8973 is supposed to be MAX8973A. Kconfig and the
> initial comment of max8973-regulator.c were modified
> accordingly.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulators: fix typo in Kconfig and max8973-regulator
      commit: f1e5ecc5b7cc9d91ce975680a2f1f84b235f7e07

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
