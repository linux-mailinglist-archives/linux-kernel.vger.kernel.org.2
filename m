Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC083194B1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 21:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhBKUrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 15:47:08 -0500
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21304 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhBKUrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 15:47:05 -0500
X-Greylist: delayed 988 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Feb 2021 15:47:04 EST
ARC-Seal: i=1; a=rsa-sha256; t=1613075385; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Nl8lnYSomWul+PxseJtO1bAT0ivdAV7voSyTGNfk4k74tRBkqWvP02f/gokxPw/CnzU7HoHWvZm3INaELhqtn/2LvPCq/CN9T3+3le0C06WwG7++Kuypql0vGQeUequzZPjr+eUwnGIWWI24yZxubIkaGMDorLiRTz0IHyOzH3s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1613075385; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=QL6scrjpr0rKzcnmUg99LHglhMJLPiiSDVWbEgsLSHw=; 
        b=mT+K789bY4NH9lDG/CBs5cEc4BHCUmvuK4KIoooS+yU4VYnMvKL0JT4qHBls5+iMg71UP2cL/dliK51FUu96hRbEfXTEsFCyUK2duL0xUF/GRep7CJLyTcaW+j4wQ+C35IxLyFtLaNkObDnYmj1ZscaAavAlGBTkZQLj/dPakTQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com> header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1613075385;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=QL6scrjpr0rKzcnmUg99LHglhMJLPiiSDVWbEgsLSHw=;
        b=jRqGwqZMKscaJSxiYPXObkqOLwiDzRDidfJOxPjslUAqgMVwVVxbsqjO1P5ogWRV
        bR4I5+KDD4rZJNzxqApoY2vwwlh5XoKssKGLHQsVBvVT7Mi1l3TKOBHjEctRRZNmEJ5
        Md8u5R6d2IMTiDcEdF5wYwf3SOTrQgQh/j59nQpk=
Received: from localhost.localdomain (49.207.58.1 [49.207.58.1]) by mx.zohomail.com
        with SMTPS id 1613075380231560.0918248835499; Thu, 11 Feb 2021 12:29:40 -0800 (PST)
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     lee.jones@linaro.org, kuba@kernel.org, johannes@sipsolutions.net,
        colin.king@canonical.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     Anirudh Rayabharam <mail@anirudhrb.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Message-ID: <20210211202908.4604-1-mail@anirudhrb.com>
Subject: [PATCH] staging: wimax/i2400m: fix some byte order issues found by sparse
Date:   Fri, 12 Feb 2021 01:59:08 +0530
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
 drivers/staging/wimax/i2400m/fw.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/wimax/i2400m/fw.c b/drivers/staging/wimax/i240=
0m/fw.c
index b2fd4bd2c5f9..bce651a6b543 100644
--- a/drivers/staging/wimax/i2400m/fw.c
+++ b/drivers/staging/wimax/i2400m/fw.c
@@ -189,12 +189,16 @@ void i2400m_bm_cmd_prepare(struct i2400m_bootrom_head=
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


