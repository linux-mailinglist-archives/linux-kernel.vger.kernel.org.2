Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1E5403C12
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 16:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352017AbhIHPAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 11:00:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351930AbhIHPAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 11:00:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C39A61104;
        Wed,  8 Sep 2021 14:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631113142;
        bh=ki4td2MFWNbZVRLxp5SDjFPg8foyU6N+QHzIjpS9V0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gmKJL9h7ewxp3XpCKCYyQTuflGoQ2yxGFAvLZJGi6HGhDYMsu5eOSVKSGfu5U8A3p
         c4RK2UV80jUGY9L+GyFqrEXL0+Z6z9ahiUd/DaX1tDMhV9rm+9htu7m2fy2HUCsDKP
         SJFioRELBcvDRA+gzDvLGF7wg6F5glPkprb7jq2twPdAOPPLJIGADsD1l/z2eN6xbP
         uzZTXfZqEL5/6zEXaCOqeEWGGIHVkqpQSzYAq9RJ6KSVAub/eLRdXbqUhlbbyxkbRg
         UwQbmylybRK+QDSgcOPqvd8Pq4Fb1X0oBdHssRGsZ8DQ+XqYf4HsNzre5JJqGuW2pw
         KRkCm/bBZHUgw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mNz2T-006r4A-0Q; Wed, 08 Sep 2021 16:59:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] ABI: sysfs-module: document initstate
Date:   Wed,  8 Sep 2021 16:58:56 +0200
Message-Id: <9c7686a613ebab34f9717472e564c595905c1607.1631112725.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631112725.git.mchehab+huawei@kernel.org>
References: <cover.1631112725.git.mchehab+huawei@kernel.org>
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

