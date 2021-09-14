Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D040340B23F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbhINO45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:56:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234438AbhINO4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:56:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DD306113E;
        Tue, 14 Sep 2021 14:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631631328;
        bh=ki4td2MFWNbZVRLxp5SDjFPg8foyU6N+QHzIjpS9V0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FOBsADcoE1BUoS6MdZ/vEa6s2InXpuEzmcn2yA86IxuXdxmggKvsUI6eEmWIXy51u
         b3jmyWjHXSvMjJ5qKoGKVneQPaNohWP4Fc8rRl0veY5+fLo+zDQWmX+0HTAuKlmW9p
         gxNbkkAq3t481/eoyeoS4WsngsjywL3JAJtxRGs10Ak/8swb41kOKO/4HorHjf9Mma
         gG0TGPA+PzqKioEuLittN7/TM0JI6Z6hr0oQzEBmBpvbmbaxeGGbd4WfrcndOA+OeN
         TTLio5WsByyL7OPd6BgvGvRE2Ct8P3vPuORTUlOimHb8aPJH3uk+i7lgYjbdVgcbln
         iznO+4JlsYgsw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQ9qI-000L6s-LN; Tue, 14 Sep 2021 16:55:26 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] ABI: testing/sysfs-module: document initstate
Date:   Tue, 14 Sep 2021 16:55:16 +0200
Message-Id: <71f413776d93dbe9489627617944bc9a1069dd4a.1631630792.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631630792.git.mchehab+huawei@kernel.org>
References: <cover.1631630792.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Despite being an old ABI, present on all modules, its documentation
is missing. Add it, based on the original commit.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/testing/sysfs-module | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-module b/Documentation/ABI/testing/sysfs-module
index 88bddf192ceb..08886367d047 100644
--- a/Documentation/ABI/testing/sysfs-module
+++ b/Documentation/ABI/testing/sysfs-module
@@ -41,6 +41,13 @@ KernelVersion:	3.3
 Contact:	Kay Sievers <kay.sievers@vrfy.org>
 Description:	Module size in bytes.
 
+What:		/sys/module/*/initstate
+Date:		Nov 2006
+KernelVersion:	2.6.19
+Contact:	Kay Sievers <kay.sievers@vrfy.org>
+Description:	Show the initialization state(live, coming, going) of
+		the module.
+
 What:		/sys/module/*/taint
 Date:		Jan 2012
 KernelVersion:	3.3
-- 
2.31.1

