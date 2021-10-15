Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF57342F00C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 13:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238594AbhJOL7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 07:59:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238585AbhJOL7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 07:59:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34F38610E8;
        Fri, 15 Oct 2021 11:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634299059;
        bh=7470HQTsuEHhNH8vRcV6+h0iDuMSGil7mBl6CBs/5Xk=;
        h=From:To:Cc:Subject:Date:From;
        b=gIInWNeW2wC6/Jj8myN3ZdqzFhRa6jyANNKbEM7Z4hnNPpH0aev6L9a2ORZyuhS68
         s9cDjwIsouW+4iU0VA3aeT9KGgK+uFsmL/edWTS06O4OJmJpq/RIs0nD/WH4rn6y55
         U9P1NwkbEz5xSr2jr7KcIkthwE5DVzVKBOXGHZbCxQmVpeIlt4iPpZzHPf7PKWKeC8
         JtIcRMaQRO5oIQLEODjqT4Q4U3ljunGtaTPbjSrt7pTGpX0e4/LqaAZglxXKJd4Rgl
         MQId8OYtYoHiEMaNRjtpxzblLgUb0DkISzuZiQwLYtd4bgUeGm8YT8OKl8yf/PBHKx
         sqbF3wi5AdyBA==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v5.15-rc5
Date:   Fri, 15 Oct 2021 12:57:24 +0100
Message-Id: <20211015115739.34F38610E8@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit dc9660590d106bb58d145233fffca4efadad3655:

  regulator: max14577: Revert "regulator: max14577: Add proper module aliases strings" (2021-09-17 13:16:38 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.15-rc5

for you to fetch changes up to beb76cb4eebf9ac4ff15312e33f97db621b46da7:

  MAINTAINERS: rectify entry for SY8106A REGULATOR DRIVER (2021-10-05 13:03:48 +0100)

----------------------------------------------------------------
regulator: Fix for v5.15

Just a trivial fix to the MAINTAINERS file for an update missed during
conversion of the DT bindings to YAML format.

----------------------------------------------------------------
Lukas Bulwahn (1):
      MAINTAINERS: rectify entry for SY8106A REGULATOR DRIVER

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
