Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A86E340CCF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 19:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbhCRSVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 14:21:06 -0400
Received: from sender4-pp-o95.zoho.com ([136.143.188.95]:25538 "EHLO
        sender4-pp-o95.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbhCRSVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 14:21:00 -0400
X-Greylist: delayed 907 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Mar 2021 14:21:00 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1616090738; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=BS/ASwiksSXVdIJ92RQT6DVJKHn8N2W0DBGY8sSZthgQrmH8e1HAiUuj02L20lBQAmBi4fzvRKdQ0JM786LWGNh5D/idd7gAz8LZ6oYw39Esg/B73DdVL6/DK33Hzoj2Tcmt5OWIFRYaGmY8BzcUGHbR5YjzlzBd/TKHQGCb1VA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1616090738; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=Pn/0VpxY8zVzBsgLDARP/LTfh1s0NNX1FtijvDvEPk0=; 
        b=Pt1FJCJMNoHvERfa70btvSLvYBavcGij0lZ5yAz+dHNwBRYjvtwmz0V50fAtcH1/pTKySPq9ls6wnjK3TnHLligd9AKczI6zHzBPCRJiLTx+ggOat/5eaBiHJt6sgWHPowDPyVQ+9pCoTTP0wYempInig7v5POM4ObtZo8etMZ0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=mdjurovic@zohomail.com;
        dmarc=pass header.from=<mdjurovic@zohomail.com> header.from=<mdjurovic@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1616090738;
        s=zm2020; d=zohomail.com; i=mdjurovic@zohomail.com;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=Pn/0VpxY8zVzBsgLDARP/LTfh1s0NNX1FtijvDvEPk0=;
        b=kKIZzsA2xGhnUnZuyeke2YkLkN0LK66b3+BQzkhd2Qyt9muRHFMD2IMgPrex9vVk
        UbiVn1EbLj1D6F3IqJ8FUynhAclboyAuPOsIKAdJGyxcP21iMeoJAZDZgDgqifKLSTI
        P98gFw4fXtHPStfeRkRCvPsi6kofeawdK1Lu2zzo=
Received: from milan-pc.attlocal.net (107-220-151-69.lightspeed.sntcca.sbcglobal.net [107.220.151.69]) by mx.zohomail.com
        with SMTPS id 1616090732821295.0170783118647; Thu, 18 Mar 2021 11:05:32 -0700 (PDT)
From:   Milan Djurovic <mdjurovic@zohomail.com>
To:     linux@armlinux.org.uk
Cc:     linux-kernel@vger.kernel.org,
        Milan Djurovic <mdjurovic@zohomail.com>
Message-ID: <20210318180443.53546-1-mdjurovic@zohomail.com>
Subject: [PATCH] amba: bus: Export symbols directly after function
Date:   Thu, 18 Mar 2021 11:04:43 -0700
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch.pl warnings:

drivers/amba/bus.c:832: WARNING: EXPORT_SYMBOL(foo); should immediately fol=
low its function/variable
drivers/amba/bus.c:833: WARNING: EXPORT_SYMBOL(foo); should immediately fol=
low its function/variable
drivers/amba/bus.c:834: WARNING: EXPORT_SYMBOL(foo); should immediately fol=
low its function/variable
drivers/amba/bus.c:835: WARNING: EXPORT_SYMBOL(foo); should immediately fol=
low its function/variable
drivers/amba/bus.c:836: WARNING: EXPORT_SYMBOL(foo); should immediately fol=
low its function/variable
drivers/amba/bus.c:837: WARNING: EXPORT_SYMBOL(foo); should immediately fol=
low its function/variable
drivers/amba/bus.c:838: WARNING: EXPORT_SYMBOL(foo); should immediately fol=
low its function/variable

Signed-off-by: Milan Djurovic <mdjurovic@zohomail.com>
---
 drivers/amba/bus.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 939ca220bf78..dba3f890f681 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -349,6 +349,7 @@ int amba_driver_register(struct amba_driver *drv)
=20
 =09return driver_register(&drv->drv);
 }
+EXPORT_SYMBOL(amba_driver_register);
=20
 /**
  *=09amba_driver_unregister - remove an AMBA device driver
@@ -362,6 +363,7 @@ void amba_driver_unregister(struct amba_driver *drv)
 {
 =09driver_unregister(&drv->drv);
 }
+EXPORT_SYMBOL(amba_driver_unregister);
=20
=20
 static void amba_device_release(struct device *dev)
@@ -707,6 +709,7 @@ int amba_device_register(struct amba_device *dev, struc=
t resource *parent)
=20
 =09return amba_device_add(dev, parent);
 }
+EXPORT_SYMBOL(amba_device_register);
=20
 /**
  *=09amba_device_put - put an AMBA device
@@ -733,6 +736,7 @@ void amba_device_unregister(struct amba_device *dev)
 {
 =09device_unregister(&dev->dev);
 }
+EXPORT_SYMBOL(amba_device_unregister);
=20
=20
 struct find_data {
@@ -793,6 +797,7 @@ amba_find_device(const char *busid, struct device *pare=
nt, unsigned int id,
=20
 =09return data.dev;
 }
+EXPORT_SYMBOL(amba_find_device);
=20
 /**
  *=09amba_request_regions - request all mem regions associated with device
@@ -814,6 +819,7 @@ int amba_request_regions(struct amba_device *dev, const=
 char *name)
=20
 =09return ret;
 }
+EXPORT_SYMBOL(amba_request_regions);
=20
 /**
  *=09amba_release_regions - release mem regions associated with device
@@ -828,11 +834,4 @@ void amba_release_regions(struct amba_device *dev)
 =09size =3D resource_size(&dev->res);
 =09release_mem_region(dev->res.start, size);
 }
-
-EXPORT_SYMBOL(amba_driver_register);
-EXPORT_SYMBOL(amba_driver_unregister);
-EXPORT_SYMBOL(amba_device_register);
-EXPORT_SYMBOL(amba_device_unregister);
-EXPORT_SYMBOL(amba_find_device);
-EXPORT_SYMBOL(amba_request_regions);
 EXPORT_SYMBOL(amba_release_regions);
--=20
2.30.1


