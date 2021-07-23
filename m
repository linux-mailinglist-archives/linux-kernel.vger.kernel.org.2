Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68BE3D405C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 20:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhGWSB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 14:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhGWSB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 14:01:27 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4A0C061575;
        Fri, 23 Jul 2021 11:42:01 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id 1EA4E1F44C5D
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [PATCH 2/2] char: tpm: cr50_i2c: convert to new probe interface
Date:   Fri, 23 Jul 2021 21:41:50 +0300
Message-Id: <20210723184150.2596604-2-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210723184150.2596604-1-adrian.ratiu@collabora.com>
References: <20210723184150.2596604-1-adrian.ratiu@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Way back when this driver was written the i2c framework
used to insist an ID table be defined even if the driver
did not use it in favor of ACPI/OF matching, so it was
added just to placate the hard i2c framework requirement.

This is no longer the case so we can drop the table and
also convert the driver to the new probe interface.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 drivers/char/tpm/tpm_tis_i2c_cr50.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
index 44dde2fbe2fb..c89278103703 100644
--- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
+++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
@@ -639,12 +639,6 @@ static const struct tpm_class_ops cr50_i2c = {
 	.req_canceled = &tpm_cr50_i2c_req_canceled,
 };
 
-static const struct i2c_device_id cr50_i2c_table[] = {
-	{"cr50_i2c", 0},
-	{}
-};
-MODULE_DEVICE_TABLE(i2c, cr50_i2c_table);
-
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id cr50_i2c_acpi_id[] = {
 	{ "GOOG0005", 0 },
@@ -670,8 +664,7 @@ MODULE_DEVICE_TABLE(of, of_cr50_i2c_match);
  * - 0:		Success.
  * - -errno:	A POSIX error code.
  */
-static int tpm_cr50_i2c_probe(struct i2c_client *client,
-			      const struct i2c_device_id *id)
+static int tpm_cr50_i2c_probe(struct i2c_client *client)
 {
 	struct tpm_i2c_cr50_priv_data *priv;
 	struct device *dev = &client->dev;
@@ -774,8 +767,7 @@ static int tpm_cr50_i2c_remove(struct i2c_client *client)
 static SIMPLE_DEV_PM_OPS(cr50_i2c_pm, tpm_pm_suspend, tpm_pm_resume);
 
 static struct i2c_driver cr50_i2c_driver = {
-	.id_table = cr50_i2c_table,
-	.probe = tpm_cr50_i2c_probe,
+	.probe_new = tpm_cr50_i2c_probe,
 	.remove = tpm_cr50_i2c_remove,
 	.driver = {
 		.name = "cr50_i2c",
-- 
2.32.0

