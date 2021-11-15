Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77F3451EE2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240190AbhKPAhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:37:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:45406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344656AbhKOTZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:25:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6AD8B636AA;
        Mon, 15 Nov 2021 19:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637002898;
        bh=JBjV7wngq4Rkj9K8sQ8MeDghj+sDm9AWrpEq3Ga2Uik=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=i2/gmbi7T8K57io1O/3jasrvwEYrYDAUYZ+M7ha4OGh1tVvwoj2/uP4hhVoi0zofe
         6DBssv0VBUlx4JwEsBl6UvTgL71GsfSYTBLdBxyvCL5TOTG3LnfjcFgzNhMfDTYjzz
         DfAZ59ODl45GHkpfveE/nfTY7Bn1JpJyk6okIzhPIwfbPpyFaZef6pioIVtTqVjvXH
         tOcAvAkxWSQNMSbuGulDxJi8GHhXE4Od5wNym0q5oLabCzb/3BTjUZ9juAL92PMpL/
         auorfZYTlk3aDuePEZLM+Y2DaHQG5d5jOnqWG4Bc0idjvJ+IxGeuJ15fiIQw5kOmRE
         tUEdznaSlmM+g==
From:   Mark Brown <broonie@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
In-Reply-To: <20211104150040.1260-1-ansuelsmth@gmail.com>
References: <20211104150040.1260-1-ansuelsmth@gmail.com>
Subject: Re: [PATCH v2] regmap: allow to define reg_update_bits for no bus configuration
Message-Id: <163700289717.628026.7747075154907625845.b4-ty@kernel.org>
Date:   Mon, 15 Nov 2021 19:01:37 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Nov 2021 16:00:40 +0100, Ansuel Smith wrote:
> Some device requires a special handling for reg_update_bits and can't use
> the normal regmap read write logic. An example is when locking is
> handled by the device and rmw operations requires to do atomic operations.
> Allow to declare a dedicated function in regmap_config for
> reg_update_bits in no bus configuration.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: allow to define reg_update_bits for no bus configuration
      commit: 02d6fdecb9c38de19065f6bed8d5214556fd061d

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
