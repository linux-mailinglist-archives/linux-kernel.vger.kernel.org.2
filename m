Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F3B375481
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 15:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbhEFNQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 09:16:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229946AbhEFNQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 09:16:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91694610FA;
        Thu,  6 May 2021 13:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620306915;
        bh=iK5LPujzM68XwfVrW5opfDHlAEC1spsQjEQ6K9YqZnc=;
        h=From:To:Cc:Subject:Date:From;
        b=DVTRwGCbOIFepl9I2tiDnyzfpo3iDQtHJXTC5A9+xFlE4ihwYWossLnDm3ag3t7Dc
         0+7go3ao3k2yXKCgCr12zSdgltcbsQhKfuLboi8DmNfZhyulK5QQNo1HrHS2ROwcPe
         Q18Sja8XIOb89JP+fwwrYMV294csv7gILoLrgTawbkVhaz/k7FinOE8PvABDWdbZKh
         hjdPu5YbgOSfBRM5RNS3yM8CvrJkv39/q4jHMyAsF/ruCi0Wxb5TpOZlO3nNdSHGkD
         SJdvLIgv+p++iTTB5dhXsFN1mVXd+KhitpnzPWyEb04c/IF5n6l5dyhZ0MvrrC86ij
         3DV9XBrhnDP8Q==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 0/3] torture: Update bare metal config generation
Date:   Thu,  6 May 2021 15:15:07 +0200
Message-Id: <20210506131510.51488-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been using these changes for my bare-metal testings for a few weeks
now and I figured I should share even though I bet I'm the only one who
runs rcutorture on bare-metal, but who knows?

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	rcu/dev

HEAD: 2ffb53f35976a1e12c481fd059701e66a6cd28ae

Thanks,
	Frederic
---

Frederic Weisbecker (3):
      torture: Add --cmdline-to-config parameter to kvm.sh
      torture: Add --configonly parameter for kvm.sh
      torture: Update bare metal advices to latest kvm.sh options


 .../testing/selftests/rcutorture/bin/configinit.sh | 13 +++++
 .../testing/selftests/rcutorture/bin/kvm-build.sh  |  9 ++-
 .../selftests/rcutorture/bin/kvm-recheck.sh        |  6 +-
 .../selftests/rcutorture/bin/kvm-test-1-run.sh     | 67 +++++++++++++---------
 tools/testing/selftests/rcutorture/bin/kvm.sh      | 32 ++++++++---
 5 files changed, 91 insertions(+), 36 deletions(-)
