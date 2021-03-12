Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21DF5338490
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 05:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbhCLEHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 23:07:19 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:53088 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbhCLEHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 23:07:04 -0500
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 42982891AF;
        Fri, 12 Mar 2021 17:07:03 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1615522023;
        bh=U3faApYRT+tAxJHHsdKKCL10VQ6+BdUPKUiOv/rmBvg=;
        h=From:To:Cc:Subject:Date;
        b=vwaBTZhqQ86TRT1Dvn8YJ/0lk1io3SQ1uv49DCrlPp9lymwLX2zx5RFl2e7rsOvem
         LGa2z95hm0OuFHlgfrJuPH/mbGTu6Iyx9pdosWQMIn6kjYqvrVLoTd/xT+P4Xyy2Xn
         KjoTykPztSFJqo0OczEUUeuyJlUUyXGeyihhB4Cg1+r2ZZsM5yERvgB1Bv49wrYMFT
         gB9qIUTEq9Ihi7oO7dUY410CYHr7aZjKfRTynnX0eBtUCFHB+2PJ5pzru95MxG/d7O
         6RYB1O3QhZ0bQp0RRADtf2ROcshWIHdgMJ9SjPD1e/W3MH06WjmlM8aJvOrsS5fyxE
         xPh3VzyJL1rxA==
Received: from smtp (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B604ae8e70000>; Fri, 12 Mar 2021 17:07:03 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 0EA1013EEFA;
        Fri, 12 Mar 2021 17:07:16 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 2384E284092; Fri, 12 Mar 2021 17:07:03 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linux@roeck-us.net, jdelvare@suse.com
Cc:     corbet@lwn.net, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] hwmon: (pmbus): Fix Documentation kernel-doc warning
Date:   Fri, 12 Mar 2021 17:06:56 +1300
Message-Id: <20210312040656.3884-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=GfppYjfL c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=dESyimp9J3IA:10 a=3snwsuHfZ-UOVdroPSwA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix Documentation/hwmon/ kernel-doc warning:

Documentation/hwmon/ir36021.rst:34: WARNING: Malformed table.
No bottom table border found.

Fixes: 0be9fee30ff9 ("hwmon: (pmbus) Add driver for Infineon IR36021")
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 Documentation/hwmon/ir36021.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/hwmon/ir36021.rst b/Documentation/hwmon/ir3602=
1.rst
index 36ef8d518b81..ca3436b04e20 100644
--- a/Documentation/hwmon/ir36021.rst
+++ b/Documentation/hwmon/ir36021.rst
@@ -60,3 +60,4 @@ temp1_alarm             Temperature alarm
=20
 temp2_input             Measured other loop temperature
 temp2_alarm             Temperature alarm
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
--=20
2.30.2

