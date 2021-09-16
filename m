Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDCF40D57B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237279AbhIPJDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:03:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235384AbhIPJBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:01:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55B786124E;
        Thu, 16 Sep 2021 09:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631782802;
        bh=XrTWM3XUmOYwQg4h4rg2YNW0ywb33mfG3HDzuCggoYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DvR3Qf+k/Q7sPFc4MBwz51EaAvKJS/UdfZCZtp+fB1aWz64p5452UgaJQB9pPj/zp
         hLzgdD/QRhw/OolRl3HCzN1sJh16kiv/KsNRlX1Ctq4AR0ZNfAFA49X1DkNaf0Noay
         B4JL2Li/HCzg75I1BvoIthtAizZt+XXqqucULD095PIBbsiz3UL1RDtPbx0eDE9DMP
         wD8yqKixtftLzR8uJ02DFLSLfTmpCacw6lvBbNGbqECFGwQWHX+WqwQWqPnCUqiQXy
         NEoDShuOX4la3jiqsqPAUrDhCbZ6n8JoWdSl+u1zr3HzG5/CRgj4Voj4ewc+dx3E4d
         DZgGY/TiMbHpw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQnFQ-001qjz-IM; Thu, 16 Sep 2021 11:00:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 07/30] ABI: sysfs-class-cxl: place "not in a guest" at description
Date:   Thu, 16 Sep 2021 10:59:34 +0200
Message-Id: <cb1f2af183369d682a46efa4e5c01ad5f66e99c4.1631782432.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631782432.git.mchehab+huawei@kernel.org>
References: <cover.1631782432.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The What: field should have just the location of the ABI.
Anything else should be inside the description.

This fixes its parsing by get_abi.pl script.

Acked-by: Andrew Donnellan <ajd@linux.ibm.com>
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

