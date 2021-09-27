Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5204195BA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 16:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbhI0OBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 10:01:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234645AbhI0OBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 10:01:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 447DC61058;
        Mon, 27 Sep 2021 13:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632751197;
        bh=7/0nXXe6FTjtAGNNc9itkh+KHZ3W1UuStnEnt56IR0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cdq8fZw126fGDknzAezkHoemIBHTzOElIla/7AiBxWbSAKOPlACqd8ltLQcH3mpg5
         DgVv/IZvQpiIraztc/ObOF/tqZLHJ4QjAbgAKBpkS5LE8JTOtIxkejAoIQDeqO7YQ2
         BHR3z3qHbTs57j4QGuB891XJ9SBRGAgMK7tLK6IKvGpTikgrr+FHSd62N4PgErOkBs
         y4vx+6YL3UC98CKtQa2eAqOhCTJ/od0LccFt0BWYP1xntZytf1eNsZDtpN7qhyDLxo
         ujvQnFRWflUDcqh/k6smhhwkq4AShw9J6FPQpDnwUWQN5nEaE0ukwBXhdvAUN3nsqe
         PZiNZq2gut5Ew==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mUrAh-000Atm-CU; Mon, 27 Sep 2021 15:59:55 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 04/17] ABI: sysfs-devices-power: document some RPM statistics
Date:   Mon, 27 Sep 2021 15:59:37 +0200
Message-Id: <d5524b966d081c650121c4c496c2f7ab3df524e9.1632750608.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632750608.git.mchehab+huawei@kernel.org>
References: <cover.1632750608.git.mchehab+huawei@kernel.org>
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

See [PATCH 00/17] at: https://lore.kernel.org/all/cover.1632750608.git.mchehab+huawei@kernel.org/

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

