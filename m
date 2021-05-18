Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E26387D96
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 18:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350741AbhERQdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 12:33:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350725AbhERQdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 12:33:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FCB9611AD;
        Tue, 18 May 2021 16:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621355546;
        bh=MtfEqFsM9NpkvPLnkOTKghSZ7LxdsCPng/AwYG+eM08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IpWum8a2kktsj6dKV/nV470MwWin7rM4bR9QhtT6c2p/ZEI6pMOcDHfKybe3/7OOm
         fuVe+t2x4IX29IiECOfFyqeEBI4WS9eckHjb2tO+TXeXYkJGNkw4zmLu2S387+VDFC
         bqIci1lPN77R0ciYb6m20jaKExiWvbEeKfhkYe5wxUrN0gqxz3J+V5dFAZeCy56Yk6
         4/hwTxXuLdcwY22SxxEnJalj0g6f4u4r9pFKuHVb4nwuiZidnfe6oycdqwvlUJIQjG
         mUNnRc11Bkca/z+JFe42WLfUf1gOhDoR+SQk9htjMuvXdDLCfrjuyzBm4eqfJ5Ht/W
         ONljybBPPaDcQ==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Christoph Fritz <chf.fritz@googlemail.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v2 1/2] regulator: fan53880: Fix missing n_voltages setting
Date:   Tue, 18 May 2021 17:31:28 +0100
Message-Id: <162135540359.37947.3720161842499754631.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210517105325.1227393-1-axel.lin@ingics.com>
References: <20210517105325.1227393-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 May 2021 18:53:24 +0800, Axel Lin wrote:
> 


Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: fan53880: Fix missing n_voltages setting
      commit: 34991ee96fd8477479dd15adadceb6b28b30d9b0
[2/2] regulator: fan53880: Convert to use .probe_new
      commit: 7075359c8e0da1b01e34201b09b9ab2fd23b8a7d

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
