Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3014731A1E8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 16:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbhBLPj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 10:39:59 -0500
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21388 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhBLPjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 10:39:53 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1613144343; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=UYtQ38llVNSYOW1HYnCHSjmIVqlSd+YbAXCUgIPzF7BnwKMv3H3JVOb8W9T1TB30koMNlGky1l4z2qG00GewWSLs1ltbgHx2HKCk9Z+5d1ymPm8T4evKK6llv5wsPv1eyZ7+F2RsTiEOkA3PTfqnLD+ri1I2N98zAhOV1m7wPfs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1613144343; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=z0kfGYOxxoK+U2IPEdWl2M3pzO6VU6Sp2m3F7jsKCns=; 
        b=hnOzTK10xfKETwntpkvhGR1nKm49ojdA2qCzjwDdb91YQAFoWWOeW4ZDLKLiOMzgvRReiWkz1YGGL5Ib2T/AlV9c7z6cVZH3NdTQEXm7d5B4HiquHE2yw1vxZ0BTh+4ZECfJM0IF0Imc2FI+YmV9MPaVG9W/6MB/HijvdeBD/YI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com> header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1613144343;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=z0kfGYOxxoK+U2IPEdWl2M3pzO6VU6Sp2m3F7jsKCns=;
        b=MWAyjzcUe5jD64nKpKGntkQj2JWi8tl2lz01Y9wxoGRPEO1VQIAATKEn8w0sUsFN
        m571LVxGuJXuVH8CXPwFPnGcufuRzxbyVGtC4TYsJcGpyxP1GtxcN7PhuSLT1FTDOVY
        j1Ay5o2XVO9zcXz+gOAr45x053fVXjWsmy+7ROkk=
Received: from localhost.localdomain (106.51.104.65 [106.51.104.65]) by mx.zohomail.com
        with SMTPS id 1613144339759754.5354612594876; Fri, 12 Feb 2021 07:38:59 -0800 (PST)
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     gregkh@linuxfoundation.org, lee.jones@linaro.org, arnd@arndb.de,
        colin.king@canonical.com
Cc:     Anirudh Rayabharam <mail@anirudhrb.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Message-ID: <20210212153843.8554-1-mail@anirudhrb.com>
Subject: [PATCH v2] staging: wimax/i2400m: fix some byte order issues found by sparse
Date:   Fri, 12 Feb 2021 21:08:43 +0530
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse byte-order warnings in the i2400m_bm_cmd_prepare()
function:

wimax/i2400m/fw.c:194:36: warning: restricted __le32 degrades to integer
wimax/i2400m/fw.c:195:34: warning: invalid assignment: +=3D
wimax/i2400m/fw.c:195:34:    left side has type unsigned int
wimax/i2400m/fw.c:195:34:    right side has type restricted __le32
wimax/i2400m/fw.c:196:32: warning: restricted __le32 degrades to integer
wimax/i2400m/fw.c:196:47: warning: restricted __le32 degrades to integer
wimax/i2400m/fw.c:196:66: warning: restricted __le32 degrades to integer

Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
---
 drivers/staging/wimax/i2400m/fw.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/wimax/i2400m/fw.c b/drivers/staging/wimax/i240=
0m/fw.c
index b2fd4bd2c5f9..92ea5c101e76 100644
--- a/drivers/staging/wimax/i2400m/fw.c
+++ b/drivers/staging/wimax/i2400m/fw.c
@@ -189,12 +189,17 @@ void i2400m_bm_cmd_prepare(struct i2400m_bootrom_head=
er *cmd)
 {
 =09if (i2400m_brh_get_use_checksum(cmd)) {
 =09=09int i;
-=09=09u32 checksum =3D 0;
+=09=09__le32 checksum =3D 0;
 =09=09const u32 *checksum_ptr =3D (void *) cmd->payload;
-=09=09for (i =3D 0; i < cmd->data_size / 4; i++)
-=09=09=09checksum +=3D cpu_to_le32(*checksum_ptr++);
-=09=09checksum +=3D cmd->command + cmd->target_addr + cmd->data_size;
-=09=09cmd->block_checksum =3D cpu_to_le32(checksum);
+
+=09=09for (i =3D 0; i < le32_to_cpu(cmd->data_size) / 4; i++)
+=09=09=09le32_add_cpu(&checksum, *checksum_ptr++);
+
+=09=09le32_add_cpu(&checksum, le32_to_cpu(cmd->command));
+=09=09le32_add_cpu(&checksum, le32_to_cpu(cmd->target_addr));
+=09=09le32_add_cpu(&checksum, le32_to_cpu(cmd->data_size));
+
+=09=09cmd->block_checksum =3D checksum;
 =09}
 }
 EXPORT_SYMBOL_GPL(i2400m_bm_cmd_prepare);
--=20
2.26.2


