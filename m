Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88B0406ABD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 13:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbhIJLdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 07:33:07 -0400
Received: from 3.mo178.mail-out.ovh.net ([46.105.44.197]:37253 "EHLO
        3.mo178.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbhIJLdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 07:33:06 -0400
X-Greylist: delayed 1202 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Sep 2021 07:33:06 EDT
Received: from player758.ha.ovh.net (unknown [10.109.146.132])
        by mo178.mail-out.ovh.net (Postfix) with ESMTP id 8F5C6D9795
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 12:51:54 +0200 (CEST)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player758.ha.ovh.net (Postfix) with ESMTPSA id BA65621F68EE9;
        Fri, 10 Sep 2021 10:51:49 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-97G0024541a0f2-7580-44e4-9d72-f6fc93e3f470,
                    C73725976D6A61EA55E4E62C2A2E1C1EB10F42AA) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH] docs: block: fix discard_max_bytes references
Date:   Fri, 10 Sep 2021 12:51:42 +0200
Message-Id: <20210910105142.2116749-1-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 4092083213097797254
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrudeguddgfedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeetgedugfelkeeikeetgeegteevfeeufeetuefgudeiiedthfehtdeffeekvdeffeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeehkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When discard_max_hw_bytes was introduced, in commit 0034af036554
("block: make /sys/block/<dev>/queue/discard_max_bytes writeable"),
the discard_max_bytes documentation section was renamed to
discard_max_hw_bytes, but the references it contains to
discard_max_bytes weren't updated.

This patch refers to discard_max_hw_bytes instead. It also reflows the
paragraph so that sentences end lines.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 Documentation/block/queue-sysfs.rst | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/block/queue-sysfs.rst b/Documentation/block/queue-sysfs.rst
index 4dc7f0d499a8..5fb4299cdb23 100644
--- a/Documentation/block/queue-sysfs.rst
+++ b/Documentation/block/queue-sysfs.rst
@@ -40,10 +40,11 @@ discard_max_hw_bytes (RO)
 -------------------------
 Devices that support discard functionality may have internal limits on
 the number of bytes that can be trimmed or unmapped in a single operation.
-The discard_max_bytes parameter is set by the device driver to the maximum
-number of bytes that can be discarded in a single operation. Discard
-requests issued to the device must not exceed this limit. A discard_max_bytes
-value of 0 means that the device does not support discard functionality.
+The `discard_max_hw_bytes` parameter is set by the device driver to the
+maximum number of bytes that can be discarded in a single operation.
+Discard requests issued to the device must not exceed this limit.
+A `discard_max_hw_bytes` value of 0 means that the device does not support
+discard functionality.
 
 discard_max_bytes (RW)
 ----------------------

base-commit: 7c60610d476766e128cc4284bb6349732cbd6606
-- 
2.27.0

