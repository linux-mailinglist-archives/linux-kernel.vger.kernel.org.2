Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92BE8322BF8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 15:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhBWOLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 09:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbhBWOLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 09:11:40 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6A2C061786
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 06:10:59 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id t11so34725906ejx.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 06:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nn10UrN2ZiAmFLW+MlxnU9RSUn18Is+Qx2gx2VgeSH0=;
        b=nAoDsaQtkRg+Gyg6s6bQmsZpF5msicLBwyqF5y5mpe22lCqudl5DhFl4DCii0NEGEs
         Wkl1/AMnf9vGdERk2mrULrar2ticASTWiRoaAq32XuerPxSK71VT+YN/+GTN+YEFylzc
         qZS3j/P504twqXrVKeWU1juhDpIDndleqP3of3REWI8FAPy+64piZST7ocKJqJ1zawKr
         Xjk5Ahfm3QLD82fJs+ePwcAI/rgp97w6CuK0l97j/G8d50/PAMvj2/jQKJ8Siuy/QqnW
         yPRxdm1ea3D/EYULkqJUSuzTpG6nLTfl00dTtCnrg3wVYkmuAtEOYCqAa6ygfhSWOlER
         OcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nn10UrN2ZiAmFLW+MlxnU9RSUn18Is+Qx2gx2VgeSH0=;
        b=A/FakhCdVUQyKRBVlD/nDbUuN7xpt4useUbJ5L4o9ZZszjNsVj0iKCqWHDc0HJoZxD
         gOwWOa3EST1TMeqVy3oMWU/m4ZeQFmJYRoCCkZS7QB5PIY/2r+ICo0KHP56CdxuyYwlA
         Ux6SlXRKWw5tL0WVrBW6ynp+nvtt9Sylk7asTjVm+k+HpnmxmwpkP6BtsElcuMvcHC5k
         ZMusrEHI+AYgKBZkY6U3dI3aggPonkigd5cLTDJclInMqnOMycMQeuIjdJGJFJFfx81P
         8ufqbnfzUHKOCbbHDrbTna+BD3U4oHuwrucrcnnenVrSlvvPdLuWASdVC1OCwmZC0CGc
         XjMg==
X-Gm-Message-State: AOAM531CWlxF28PVNlp2rkDx3N/4d8LU4ILk0tcIRt9w09yDGq93DLcV
        4T5dUSMpPYGXbOfHT765hQ==
X-Google-Smtp-Source: ABdhPJyKYt39d7GtLJ164Jr+8JRd1UhDfpKgEIqrlZqPrGPa/cMoz952RwvhpBFoebTiRPRrrynjGg==
X-Received: by 2002:a17:906:af84:: with SMTP id mj4mr26895576ejb.84.1614089458682;
        Tue, 23 Feb 2021 06:10:58 -0800 (PST)
Received: from merlot.localdomain ([185.103.236.75])
        by smtp.gmail.com with ESMTPSA id m26sm7592702eja.6.2021.02.23.06.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 06:10:58 -0800 (PST)
From:   Julian Blaauboer <julian.blaauboer@gmail.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Julian Blaauboer <julian.blaauboer@gmail.com>
Subject: [PATCH] scripts/gdb: fix 'lx-symbols' section parsing
Date:   Tue, 23 Feb 2021 15:09:47 +0100
Message-Id: <20210223140947.55693-1-julian.blaauboer@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Loading a module using 'lx-symbols' in GDB would result in a
gdb.MemoryError when parsing the section names and addresses because of
the way GDB handles flexible array members. This patch fixes that issue
by converting the 'struct module_sect_attr[]' into a pointer before
accessing it.

Signed-off-by: Julian Blaauboer <julian.blaauboer@gmail.com>
---
 scripts/gdb/linux/symbols.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
index 1be9763cf8bb..6d3a33a00189 100644
--- a/scripts/gdb/linux/symbols.py
+++ b/scripts/gdb/linux/symbols.py
@@ -94,7 +94,8 @@ lx-symbols command."""
             sect_attrs = module['sect_attrs'].dereference()
         except gdb.error:
             return ""
-        attrs = sect_attrs['attrs']
+        # Convert from struct module_sect_attr[] to struct module_sect_attr*
+        attrs = sect_attrs['attrs'].dereference().address
         section_name_to_address = {
             attrs[n]['battr']['attr']['name'].string(): attrs[n]['address']
             for n in range(int(sect_attrs['nsections']))}
-- 
2.30.1

