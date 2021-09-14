Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4FB240B103
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbhINOh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:37:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233863AbhINOeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:34:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA76861211;
        Tue, 14 Sep 2021 14:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631629970;
        bh=FL//ARyKpVZvvzBsfsKotKPtQwCMgGn355bElMoK46s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HJ03/l+7VPxsuHZGMwOG5NTszRWIyNHPKXAi2qFi1S7ozrWncMovti01/qK3iQIl7
         G17X9pGqNohvpQB14/ORTmDc/kD0WN72y5+3CozxFFH7fxy1ydhH/drproEdJIzH+E
         ogGWZuAVFPVeLkNgzdG67TA5o1z5YKTrbi7+BxdX/8FQZFZyqJh+NtED9Day820eb2
         e4MLOTDys66ZOOM/kaeBDSDPOMqjAUt0n4EwzHzOAFB4g+75Vtiz/ugH5sNb/9Yy+g
         j7UmeHErsELX2iFFT2hP5kOmyvXrQXdvUR7dWLUfs0G7fZHKJaMM7yT4MR60zT248h
         7hSqh9n3JYbdA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQ9UN-000Kke-Kx; Tue, 14 Sep 2021 16:32:47 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 07/29] ABI: sysfs-class-cxl: place "not in a guest" at description
Date:   Tue, 14 Sep 2021 16:32:22 +0200
Message-Id: <88ce67c9eed1ae08af3d3992415032723184af9e.1631629496.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631629496.git.mchehab+huawei@kernel.org>
References: <cover.1631629496.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The What: field should have just the location of the ABI.
Anything else should be inside the description.

This fixes its parsing by get_abi.pl script.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/testing/sysfs-class-cxl | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-cxl b/Documentation/ABI/testing/sysfs-class-cxl
index 818f55970efb..3c77677e0ca7 100644
--- a/Documentation/ABI/testing/sysfs-class-cxl
+++ b/Documentation/ABI/testing/sysfs-class-cxl
@@ -166,10 +166,11 @@ Description:    read only
                 Decimal value of the Per Process MMIO space length.
 Users:		https://github.com/ibm-capi/libcxl
 
-What:           /sys/class/cxl/<afu>m/pp_mmio_off (not in a guest)
+What:           /sys/class/cxl/<afu>m/pp_mmio_off
 Date:           September 2014
 Contact:        linuxppc-dev@lists.ozlabs.org
 Description:    read only
+                (not in a guest)
                 Decimal value of the Per Process MMIO space offset.
 Users:		https://github.com/ibm-capi/libcxl
 
@@ -190,28 +191,31 @@ Description:    read only
                 Identifies the revision level of the PSL.
 Users:		https://github.com/ibm-capi/libcxl
 
-What:           /sys/class/cxl/<card>/base_image (not in a guest)
+What:           /sys/class/cxl/<card>/base_image
 Date:           September 2014
 Contact:        linuxppc-dev@lists.ozlabs.org
 Description:    read only
+                (not in a guest)
                 Identifies the revision level of the base image for devices
                 that support loadable PSLs. For FPGAs this field identifies
                 the image contained in the on-adapter flash which is loaded
                 during the initial program load.
 Users:		https://github.com/ibm-capi/libcxl
 
-What:           /sys/class/cxl/<card>/image_loaded (not in a guest)
+What:           /sys/class/cxl/<card>/image_loaded
 Date:           September 2014
 Contact:        linuxppc-dev@lists.ozlabs.org
 Description:    read only
+                (not in a guest)
                 Will return "user" or "factory" depending on the image loaded
                 onto the card.
 Users:		https://github.com/ibm-capi/libcxl
 
-What:           /sys/class/cxl/<card>/load_image_on_perst (not in a guest)
+What:           /sys/class/cxl/<card>/load_image_on_perst
 Date:           December 2014
 Contact:        linuxppc-dev@lists.ozlabs.org
 Description:    read/write
+                (not in a guest)
                 Valid entries are "none", "user", and "factory".
                 "none" means PERST will not cause image to be loaded to the
                 card.  A power cycle is required to load the image.
@@ -235,10 +239,11 @@ Description:    write only
                 contexts on the card AFUs.
 Users:		https://github.com/ibm-capi/libcxl
 
-What:		/sys/class/cxl/<card>/perst_reloads_same_image (not in a guest)
+What:		/sys/class/cxl/<card>/perst_reloads_same_image
 Date:		July 2015
 Contact:	linuxppc-dev@lists.ozlabs.org
 Description:	read/write
+                (not in a guest)
 		Trust that when an image is reloaded via PERST, it will not
 		have changed.
 
-- 
2.31.1

