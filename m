Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309EC37AA21
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 17:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhEKPCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 11:02:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:35100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231561AbhEKPCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 11:02:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76936610FA;
        Tue, 11 May 2021 15:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620745297;
        bh=MtFihL4ObMWeoa+SfB0LUN/U9nJZVcN+hbmIOjgAsyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VFGbiWjeMDCf83D23jg4vr/+SOo65nJZhBa6wH11JIdNPN5G6q/ZDpz0TJIgpEuJr
         CBdp0GfwWHtQvJvtNynAZOiHyQw34qJQcwdxz5IHhVxFt2DX+Gy3Ek39g+oOlLFVO/
         IM9IQ5fbStYqKcren/UHsWYna+sWCRYwCrApQycdR0/9WEmyWnkrBZkqyg9zgeZGa1
         JLe4vIx5rEpmrECxUYMPfuaKtxOaDeuP6b/HCQHpOLg7yMyPCKM3CfRcjGO3XQL57T
         A7ag8uWDEUo58+vEioY2lEwUi/LFVIeSKFpGodtB8ELYG9CLafTKqnZ4y3wQIwuGw6
         grL/X9VyH13Jg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lgTt7-000k1E-UG; Tue, 11 May 2021 17:01:33 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] docs: hwmon: tmp103.rst: fix bad usage of UTF-8 chars
Date:   Tue, 11 May 2021 17:01:31 +0200
Message-Id: <73b3c7c1eef5c12ddc941624d23689313bd56529.1620744606.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620744606.git.mchehab+huawei@kernel.org>
References: <cover.1620744606.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While UTF-8 characters can be used at the Linux documentation,
the best is to use them only when ASCII doesn't offer a good replacement.
So, replace the occurences of the following UTF-8 characters:

	- U+2013 ('–'): EN DASH

In this specific case, EN DASH was used instead of a minus
sign. So, replace it by a single hyphen.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/hwmon/tmp103.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/hwmon/tmp103.rst b/Documentation/hwmon/tmp103.rst
index e195a7d14309..b3ef81475cf8 100644
--- a/Documentation/hwmon/tmp103.rst
+++ b/Documentation/hwmon/tmp103.rst
@@ -21,10 +21,10 @@ Description
 The TMP103 is a digital output temperature sensor in a four-ball
 wafer chip-scale package (WCSP). The TMP103 is capable of reading
 temperatures to a resolution of 1°C. The TMP103 is specified for
-operation over a temperature range of –40°C to +125°C.
+operation over a temperature range of -40°C to +125°C.
 
 Resolution: 8 Bits
-Accuracy: ±1°C Typ (–10°C to +100°C)
+Accuracy: ±1°C Typ (-10°C to +100°C)
 
 The driver provides the common sysfs-interface for temperatures (see
 Documentation/hwmon/sysfs-interface.rst under Temperatures).
-- 
2.30.2

