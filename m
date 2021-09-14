Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09AA140B23A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbhINO4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:56:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234356AbhINO4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:56:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C9BB61107;
        Tue, 14 Sep 2021 14:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631631328;
        bh=alBDq20KeMVwXugn44QFYy0uFf2J68FTXILkw7+b8Dg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EPeRTn6e/lhq0rZsvBQAxaUJb6IhSDMgkJq/zOpI4vm9Jyf1qctexF+oHTEUeegv+
         iaGYlx4mnyS0hnPu3+DhJIfBic2hsfhUPLLxvmiSciEsHVorZOr3mY5sKaPkcyuSba
         2RlSKhjJM7iRh1drCbwIWe5+2bbYDmQjfkLGOxXugfNzj1SXwM6kmbdG8csrUT6xa0
         CXrPTtoa5PXauwboZlB9P+lEyWp1AbHTViBsO73B8dB8/jq2HZSHf9PivwHw7kWb2t
         6qWp1KxrHlQTPjtnbEkLmaLweyD7oFnMegPtkquciPElsvXIY7bj5yYTQjIqEWFU9i
         3yCBh1UGOtRhg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQ9qI-000L6w-N9; Tue, 14 Sep 2021 16:55:26 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/8] ABI: sysfs-devices-power: document some RPM statistics
Date:   Tue, 14 Sep 2021 16:55:17 +0200
Message-Id: <3a94cad2d2997773fb6a58f0c6239ec52d0aa316.1631630792.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631630792.git.mchehab+huawei@kernel.org>
References: <cover.1631630792.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 8d4b9d1bfef1 ("PM / Runtime: Add runtime PM statistics (v3)")
added runtime_active_time and runtime_suspended_time, in order
to allow powertop to identify the amount of time a device is
active/suspended.

Add an ABI description for those.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/testing/sysfs-devices-power | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-power b/Documentation/ABI/testing/sysfs-devices-power
index 1763e64dd152..84694b8fec8e 100644
--- a/Documentation/ABI/testing/sysfs-devices-power
+++ b/Documentation/ABI/testing/sysfs-devices-power
@@ -269,3 +269,17 @@ Description:
 		the current runtime PM status of the device, which may be
 		"suspended", "suspending", "resuming", "active", "error" (fatal
 		error), or "unsupported" (runtime PM is disabled).
+
+What:		/sys/devices/.../power/runtime_active_time
+Date:		Jul 2010
+Contact:	Arjan van de Ven <arjan@linux.intel.com>
+Description:
+		Reports the total time that the device has been active.
+		Used for runtime PM statistics.
+
+What:		/sys/devices/.../power/runtime_suspended_time
+Date:		Jul 2010
+Contact:	Arjan van de Ven <arjan@linux.intel.com>
+Description:
+		Reports total time that the device has been suspended.
+		Used for runtime PM statistics.
-- 
2.31.1

