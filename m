Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038BB37AE5E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbhEKSXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:23:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232127AbhEKSXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:23:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 389BC61919;
        Tue, 11 May 2021 18:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620757347;
        bh=6LyIfVWgCo8W6u0PB+CEWuh5xcAoNiXo4isFP8g6BSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cCSRWkO0/iaGoe0oMsT/3o593/44QO7lwFDZOwhDGKv8r4hAWHz4wYqgzLqzsDzzr
         FqeFq845AhH+VEVnq8ZA8aHJnJMWdmljCLEQwm871u1xiPBx/G1AzxcMUqRCYWV749
         z0n8hQ4jkzR9PfL5UkyOt/bBIuSFyg5aO52w84H8jEAlY3DvxxxW5CCDzDITt0PKpN
         pk3jRYHujQ4wn5ZLkIwHFgF5vlq2baA15fNAzce8U/MQK02fCBe51ne3FZHy3eU2s6
         LoX6nfDciLht/US2sUyMUqv3nWweuGYcyElJv3KQc6ppUJHEKlWDQRhbPEoXHOT9ZC
         xkCl2rd3jzYLQ==
From:   Mark Brown <broonie@kernel.org>
To:     mhiramat@kernel.org, hayashi.kunihiko@socionext.com,
        Zou Wei <zou_wei@huawei.com>, lgirdwood@gmail.com
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] regulator: uniphier: Add missing MODULE_DEVICE_TABLE
Date:   Tue, 11 May 2021 19:21:28 +0100
Message-Id: <162075722774.18118.6559658360126627576.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1620705198-104566-1-git-send-email-zou_wei@huawei.com>
References: <1620705198-104566-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2021 11:53:18 +0800, Zou Wei wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: uniphier: Add missing MODULE_DEVICE_TABLE
      commit: d019f38a1af3c6015cde6a47951a3ec43beeed80

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
