Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C115343E171
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 14:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhJ1NBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 09:01:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:58718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230271AbhJ1NBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 09:01:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB746610C8;
        Thu, 28 Oct 2021 12:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635425949;
        bh=GvK75DH60GBTMF2oKEW8i6qrOQxPMn6ekQ4+MJmZ6rQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jryR/6kmEOc/UVWIyCd9yFf/i7ocGgBx9sI3KtCpt7b1HQnic1yGImQ7QIU6g5dOa
         uSfLFjDzArFHaKAeMz+MdikYOVmFDLW4hoHO8u7AND9R4Xu6edn/2upW49z2RXgxCR
         FmYq13061g1dc2Hruvs1uyVd5jLI9GUJOU/qpJxRGU326P1yHO+bnXYKhld3uTBhxj
         c8LaZfkPD7WwhwQ3MvGMjqn13Cr+8YtJxdL8fKn49oUpfW8ivSc34AH6gpdM2q6o8f
         TrjpI25S26SLxPcb92Ll6wFm+uxVw12rPp9/ua5y6b1P+0VTSAzyg8d2WANbvz/iqD
         8jyYZyRrXPQ/A==
From:   Mark Brown <broonie@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     llvm@lists.linux.dev, alsa-devel@alsa-project.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211027190823.4057382-1-nathan@kernel.org>
References: <20211027190823.4057382-1-nathan@kernel.org>
Subject: Re: [PATCH] ASoC: qdsp6: audioreach: Fix clang -Wimplicit-fallthrough
Message-Id: <163542594755.950250.9661229895167446444.b4-ty@kernel.org>
Date:   Thu, 28 Oct 2021 13:59:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2021 12:08:23 -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> sound/soc/qcom/qdsp6/topology.c:465:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
>                 default:
>                 ^
> sound/soc/qcom/qdsp6/topology.c:465:3: note: insert 'break;' to avoid fall-through
>                 default:
>                 ^
>                 break;
> 1 warning generated.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qdsp6: audioreach: Fix clang -Wimplicit-fallthrough
      commit: c6c203bc4dfed6812cf77e7737074b9cff8dd78d

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
