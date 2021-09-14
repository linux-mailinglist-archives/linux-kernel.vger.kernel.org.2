Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B5C40B0F0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbhINOge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:36:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:57498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233842AbhINOeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:34:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE89461178;
        Tue, 14 Sep 2021 14:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631629970;
        bh=Z72e1xGJDZNoxeXYP/lSlOs8KrotL5uzTpC7h3fHJ/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r07tKTzMERUkVXKloGCI/FlKmIqkMkPdBMQI56zn8c7xehMXDShG90e5YfLWk5sTE
         j9czIZZrN9UlFlhIlKbbTV6I05siiucdp7fYP/eXGDcEHo/1bu+U8J61nvOzkcOzkh
         w/VEJ2g2q7RPDPnoUxjvPZsAUVWTjiQjywKZwQOVias5xX9z/HS/Ao+uRZ2faT/znX
         BWnekSrHcGLf2lr3i2iF8KdKRFeNodLtZcJk+WP6s4PwlZNnCrGexp5HRM4z5pGwGM
         +4VvWpk3vDCbdjb7QOJm2BN66usu3e4HylecuBZdGNKrkftXkZOmTg412zXHdzqmUw
         cRc3FBvzzkrHg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQ9UN-000Kki-Ma; Tue, 14 Sep 2021 16:32:47 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/29] ABI: sysfs-class-devfreq-event: use the right wildcards on What
Date:   Tue, 14 Sep 2021 16:32:23 +0200
Message-Id: <7f25d0955d93ab4effbb766ec165287dc422c443.1631629496.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631629496.git.mchehab+huawei@kernel.org>
References: <cover.1631629496.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On most ABI files, the wildcards are used as <x>, instead of (x).

Replace it to make it using a more standard wildcard. That helps
get_abi.pl to convert it into a regex.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/testing/sysfs-class-devfreq-event | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-devfreq-event b/Documentation/ABI/testing/sysfs-class-devfreq-event
index ceaf0f686d4a..dbe48495e55a 100644
--- a/Documentation/ABI/testing/sysfs-class-devfreq-event
+++ b/Documentation/ABI/testing/sysfs-class-devfreq-event
@@ -1,25 +1,25 @@
-What:		/sys/class/devfreq-event/event(x)/
+What:		/sys/class/devfreq-event/event<x>/
 Date:		January 2017
 Contact:	Chanwoo Choi <cw00.choi@samsung.com>
 Description:
 		Provide a place in sysfs for the devfreq-event objects.
 		This allows accessing various devfreq-event specific variables.
-		The name of devfreq-event object denoted as 'event(x)' which
+		The name of devfreq-event object denoted as 'event<x>' which
 		includes the unique number of 'x' for each devfreq-event object.
 
-What:		/sys/class/devfreq-event/event(x)/name
+What:		/sys/class/devfreq-event/event<x>/name
 Date:		January 2017
 Contact:	Chanwoo Choi <cw00.choi@samsung.com>
 Description:
-		The /sys/class/devfreq-event/event(x)/name attribute contains
+		The /sys/class/devfreq-event/event<x>/name attribute contains
 		the name of the devfreq-event object. This attribute is
 		read-only.
 
-What:		/sys/class/devfreq-event/event(x)/enable_count
+What:		/sys/class/devfreq-event/event<x>/enable_count
 Date:		January 2017
 Contact:	Chanwoo Choi <cw00.choi@samsung.com>
 Description:
-		The /sys/class/devfreq-event/event(x)/enable_count attribute
+		The /sys/class/devfreq-event/event<x>/enable_count attribute
 		contains the reference count to enable the devfreq-event
 		object. If the device is enabled, the value of attribute is
 		greater than zero.
-- 
2.31.1

