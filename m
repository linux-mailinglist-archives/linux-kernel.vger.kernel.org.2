Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9FD8439BCC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 18:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbhJYQme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 12:42:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234023AbhJYQmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 12:42:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E596B60F6F;
        Mon, 25 Oct 2021 16:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635179999;
        bh=K0Kpvc0OulldRog10BpW9uV+5Ap0vvFVLeAAOvO4H6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W3RmhSzVFfh5RJ/cuqvdXTgiBWwrdIADre33R0XA8lX/bYr+rTg2+uE04KMImeqTC
         oK2stpXwEsKB+egrAbxoTI4AoIUlCF/+nhMg20Z4eyryPT8Uf3bOLUpyKLEhoimC5/
         bRbTG3oYIOzbrAjFFvO4CAOZn1J85p0IKWKaLw9nakpAQprfWr0JYltrdn51k+/rnM
         tGSa/1kN/Wt/qqFJwzr/VjZ1DLGaf66v5AhszxT2oYgJ1ZFFJfpN5CejS67BN+hEzi
         d9p+wsT0CUjgOyWms1JexN4NmnBYhH8bFmLOn+FlgpIw4ZxAhAFK1XTaQEioX1xVVc
         7r5dlw/rWjv3Q==
From:   Mark Brown <broonie@kernel.org>
To:     John Keeping <john@metanate.com>, alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] ASoC: doc: update codec example code
Date:   Mon, 25 Oct 2021 17:39:29 +0100
Message-Id: <163517996155.3558038.10361487855050489332.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211024151731.360638-1-john@metanate.com>
References: <20211024151731.360638-1-john@metanate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Oct 2021 16:17:31 +0100, John Keeping wrote:
> As the codec API has evolved the documentation has not kept up and still
> uses old fields that have been removed.  Update the examples to
> represent the current API.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: doc: update codec example code
      commit: a6d968a3e8f01bdc09fc397697ce27ef75392ce7

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
