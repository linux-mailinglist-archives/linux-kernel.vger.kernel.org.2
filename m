Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE2239AA45
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 20:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhFCSo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 14:44:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230149AbhFCSoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:44:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8AFAF613BA;
        Thu,  3 Jun 2021 18:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622745758;
        bh=jQYaV2cfvoXc16qoljiYIKMi2Mx7T5eMyKFOL62d+tM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FjUAK/Lvl8kKjR7kZC2ty+tq4HX6I3/8MMrKJVUs+0Ks926INH8+pIkCJs9A4rGno
         QDJwNSL1vk6HsEV78ZMQToLk1Pk4DsrtnL2JZFPKF8yxqlzCYsbsqVRUmNWwO96Bk5
         4M6DW7QhvbHBwStsypMp0CzwE7jAJvq/dua3x3QApUdn4ZfKgpKMXMDS4bhJ9WW8NU
         RpUjSyfjR0c2zDg+D5QkaklbJZMS03yyVojat+IXR76WI+vu0M4qGkOhfq1SZCoijK
         UvSIwUZslwRHdYry55rMeA7lQRs0I+cAz6GNhiSTnggY27m5T08y2yxVXcWKE38RB5
         dnNb5fkDr2dHA==
From:   Mark Brown <broonie@kernel.org>
To:     cy_huang <u0084500@gmail.com>, robh+dt@kernel.org,
        lgirdwood@gmail.com
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, cy_huang@richtek.com
Subject: Re: [PATCH v6 1/2] regulator: rt6160: Add DT binding document for Richtek RT6160
Date:   Thu,  3 Jun 2021 19:41:52 +0100
Message-Id: <162274566700.14958.5478994918465215118.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1622558352-19750-1-git-send-email-u0084500@gmail.com>
References: <1622558352-19750-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jun 2021 22:39:11 +0800, cy_huang wrote:
> Add DT binding document for Richtek RT6160 voltage regulator.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: rt6160: Add DT binding document for Richtek RT6160
      commit: bce18e52c866ff6ded13ac8ac37e9271f786c005
[2/2] regulator: rt6160: Add support for Richtek RT6160
      commit: de20b747c5836ffc6768914b95d7617139fac4f4

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
