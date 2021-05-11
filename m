Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA5337A1E9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 10:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhEKI3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 04:29:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:38534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231293AbhEKI3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 04:29:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E74AC616E8;
        Tue, 11 May 2021 08:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620721685;
        bh=plCtlHCNIpWfe9eWJChLXDfOcpe8n0jaIChsmOCFPr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=svusHPziplt7rimI6RlxLuA17HZhb4QM6tlmQM4Y00uOwNA+HMzglt8+jySCjUUi0
         jMQs39+xUOFthkam2OtVEeso/qNtT/XAmQWbxRzHR7NsoT24MTXq56KH2rUdVIHs9R
         7TRK9/tDjVyno3b9V35Ca4komeoizrOCvc9f1CEOdd8l7jdYdQ1EyO6psWcf7AKhj2
         EkIWI4wCbacnztnFShH6rsFjJPH76jBmdrBHOmiNpHGM+d6VEBBHqK4xOn8yqQUoJW
         sS7GYE3dfQL4A9K4MFqe5QANtkSkzZS47Kf60G5oKeoDxUMRf5UziKhgiSjugXj+LS
         n2/ASFw8jtg7g==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, Yang Li <yang.lee@linux.alibaba.com>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        nathan@kernel.org, bgoswami@codeaurora.org, tiwai@suse.com,
        clang-built-linux@googlegroups.com, ndesaulniers@google.com
Subject: Re: [PATCH] ASoC: q6dsp: q6afe: remove unneeded dead-store initialization
Date:   Tue, 11 May 2021 09:25:57 +0100
Message-Id: <162072058167.33157.15111322550243125545.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1619345553-29781-1-git-send-email-yang.lee@linux.alibaba.com>
References: <1619345553-29781-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Apr 2021 18:12:33 +0800, Yang Li wrote:
> Variables 'wait' and 'port_id' are being initialized, however the
> values are never read and updated later on, hence the redundant
> initializations can be removed.
> 
> Cleans up clang warnings:
> sound/soc/qcom/qdsp6/q6afe.c:933:21: warning: Value stored to 'wait'
> during its initialization is never read
> sound/soc/qcom/qdsp6/q6afe.c:1186:6: warning: Value stored to 'port_id'
> during its initialization is never read

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: q6dsp: q6afe: remove unneeded dead-store initialization
      commit: 5f1b95d08de712327e452d082a50fded435ec884

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
