Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A19C4192DF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 13:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbhI0LM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 07:12:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233968AbhI0LMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 07:12:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C4CD610FC;
        Mon, 27 Sep 2021 11:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632741062;
        bh=GDm/y+SZJct8F+bbfQLLdd3wmy7Mr0IXRMgYbbWldCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mefTENAzdipTgV/vUeadWr8Adn3GeVp3fa9NLIyB9n44b5WLXVLmpoHU2B/8wufjc
         6v2WLZOZxG6fElr69SBInt5Y9JoboJZqspuk4Ttdj/+GGdAqn5BWTmKMJhXr9z0owM
         J5SVY/H4PTIPv3OVI9H+xRzAqdPMfSQh6VkQhysnfoYzvs4FMmG/r9oKGARdqfzcf6
         NPtE22lQ830NkpEbrLWv5drbfEHx2cYaxPOJmXK7HoghAL2R8L0YOBfZILWMlIG8Ua
         83vOgB9OfxLBFTb3KNbPlQ6A3oF/oRiYaI4agCdiLBx3seJPCi4h2m1ULz3FKBY9iu
         gg3vITPh3C4zQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mUoXE-0005yX-IH; Mon, 27 Sep 2021 13:11:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David E Box <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        Tamar Mashiah <tamar.mashiah@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 7/7] ABI: sysfs-platform-intel-pmc: add blank lines to make it valid for ReST
Date:   Mon, 27 Sep 2021 13:10:56 +0200
Message-Id: <3673e1a255ad4100c933af215b60d68ba126f820.1632740376.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632740376.git.mchehab+huawei@kernel.org>
References: <cover.1632740376.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ReST format requires blank lines before/after identation changes,
for it to properly detect lists.

Fixes: ee7abc105e2b ("platform/x86: intel_pmc_core: export platform global reset bits via etr3 sysfs file")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH 0/7] at: https://lore.kernel.org/all/cover.1632740376.git.mchehab+huawei@kernel.org/T/#t

 Documentation/ABI/testing/sysfs-platform-intel-pmc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-intel-pmc b/Documentation/ABI/testing/sysfs-platform-intel-pmc
index ef199af75ab0..f31d59b21f9b 100644
--- a/Documentation/ABI/testing/sysfs-platform-intel-pmc
+++ b/Documentation/ABI/testing/sysfs-platform-intel-pmc
@@ -11,8 +11,10 @@ Description:
 		to take effect.
 
 		Display global reset setting bits for PMC.
+
 			* bit 31 - global reset is locked
 			* bit 20 - global reset is set
+
 		Writing bit 20 value to the etr3 will induce
 		a platform "global reset" upon consequent platform reset,
 		in case the register is not locked.
-- 
2.31.1

