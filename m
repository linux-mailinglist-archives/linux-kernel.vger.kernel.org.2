Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767B5340D2F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 19:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbhCRSgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 14:36:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232465AbhCRSg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 14:36:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A585664F1B;
        Thu, 18 Mar 2021 18:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616092586;
        bh=wr6Q6HZlXVnrsvtuBWNvxU1f0G1sRfiETnfGyiruHHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oGCu4tBQOHmvRwv/HU6Dh19XQUZDGKUlQm6VVm2fPvFPoXw6GcUmPCFsp/GsHgJwj
         d7Huhwe/jSsuYByelgdo5WWzL/o8QuwV789+Jtmsf0nWlslfrGmpl865DeMaEQTcFp
         sVKe9AJlIdDF5ZERJ8hEvsH56Ac2UfTO+sogVMhezNKR7+ocSEFvYA41ho3C/Lxgqx
         5SLU42N9i0sZY3rKjKURkua4hkgecTAEyxMv/Ng1YR3Io009vVP9cnmE1Oq2CcfjJf
         t0koZKMThl0TPipO8vmRvnt4t4VSQ5/Y7cG6dnEhKCRC9t3/Urho011Lo0QcxqyaG8
         TjeDNaJKqu3cA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, rdunlap@infradead.org
Subject: Re: [PATCH] docs: devicetree: bindings: sound: Fix a typo in the file rt5682.txt
Date:   Thu, 18 Mar 2021 18:36:06 +0000
Message-Id: <161609213719.41838.12776145581293380370.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210313231850.17278-1-unixbhaskar@gmail.com>
References: <20210313231850.17278-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Mar 2021 04:48:50 +0530, Bhaskar Chowdhury wrote:
> s/drving/driving/

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] docs: devicetree: bindings: sound: Fix a typo in the file rt5682.txt
      commit: 8dd855334736f275e9de71096d816c8d9da46bf7

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
