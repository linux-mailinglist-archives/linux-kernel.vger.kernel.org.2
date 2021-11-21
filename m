Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD51D4584A0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 17:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238420AbhKUQQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 11:16:46 -0500
Received: from o1.ptr2625.egauge.net ([167.89.112.53]:62966 "EHLO
        o1.ptr2625.egauge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238362AbhKUQQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 11:16:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
        h=from:subject:mime-version:to:cc:content-transfer-encoding:
        content-type;
        s=sgd; bh=0m8oub9Sqbg42DmQixWK/323NaRfv+ybWQ1cHvrIgqQ=;
        b=PuNI8kvtIzVk6YOaGiH1KRzwP4fB6SSwsEMtdGjENDIBH/Ereoaixqvaz0zgOQTnojGv
        lUXnh7jV48f26P9q8t9I//dp0STMDcZNgWgTdKvnVXppkoAE0AMtU7utEk0qIipZ2UaIHc
        51BAgByw/jwmw80OkFLmOpADrzETUayAGBceH73ylt1tRSPfCipvKww6QeHRvk3hRVx8SR
        A3y5yqyJ+WHrtyWizmeaFUkpz0oCCsiEjl85sP3N/v+lFXdEzXLO3iZ5UAewMX4/hV0idO
        FvNsuWXXpT3p0/r9DiXgdc2u6mRkAO5qkZKr6mf+vofaBDlqGpLGtdEro0kOFOGA==
Received: by filterdrecv-656998cfdd-phncc with SMTP id filterdrecv-656998cfdd-phncc-1-619A7034-1D
        2021-11-21 16:13:40.544532967 +0000 UTC m=+5244381.730779738
Received: from pearl.egauge.net (unknown)
        by geopod-ismtpd-6-0 (SG)
        with ESMTP
        id Cw5TBdvfRU6QLFIHqCUgHg
        Sun, 21 Nov 2021 16:13:40.381 +0000 (UTC)
Received: by pearl.egauge.net (Postfix, from userid 1000)
        id A2C78700479; Sun, 21 Nov 2021 09:13:39 -0700 (MST)
From:   David Mosberger-Tang <davidm@egauge.net>
Subject: [PATCH] Update trivial-devices.yaml with Sensirion,sht4x
Date:   Sun, 21 Nov 2021 16:13:40 +0000 (UTC)
Message-Id: <20211121161320.2312393-1-davidm@egauge.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?+kMxBqj35EdRUKoy8diX1j4AXmPtd302oan+iXZuF8m2Nw4HRW2irNspffT=2Fkh?=
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvAeiqsadiSQ8w=2FuBS?=
 =?us-ascii?Q?BMnK0k2GmOJBAl=2FRrGN7842LA4GasdWthoSPZHY?=
 =?us-ascii?Q?3tlR4fYpfB0VqglU1i4=2FHaEFMUjw=2FL3mtC=2FQ=2Fqp?=
 =?us-ascii?Q?pLKHUI7QcsMGzeQJIlAYyEupwqvDOHcJspi6rqY?=
 =?us-ascii?Q?ADD0tbeSLDCAXoZ4=2FU7vQ10cMyEwI9zdCefwKM1?=
 =?us-ascii?Q?=2FyDsLJ3CNanB5cpDku7+w=3D=3D?=
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Rob Herring <robh+dt@kernel.org>, Jiri Kosina <trivial@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Mosberger-Tang <davidm@egauge.net>
X-Entity-ID: Xg4JGAcGrJFIz2kDG9eoaQ==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Sensirion SHT4x, a precision temperature and humidity sensor, to
trivial-devices.yaml.

Signed-off-by: David Mosberger-Tang <davidm@egauge.net>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 1e4b3464d734..bbd1f49faa88 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -277,6 +277,8 @@ properties:
           - sensirion,sgp30
             # Sensirion gas sensor with I2C interface
           - sensirion,sgp40
+            # Sensirion temperature & humidity sensor with I2C interface
+          - sensirion,sht4x
             # Sensortek 3 axis accelerometer
           - sensortek,stk8312
             # Sensortek 3 axis accelerometer
-- 
2.25.1

