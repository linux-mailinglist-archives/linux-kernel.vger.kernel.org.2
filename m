Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A57309943
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 01:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbhAaANo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 19:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbhAaANc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 19:13:32 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CABEC061756
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:12:52 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id b20so7154017ljo.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=batmuya7co49qkeSt7rrFXuUKreU4NnJ2KEEv73JYWE=;
        b=N0Vw6MDTg3MmEUEM+hsk5w+E42bPcuteYfxeiCXtQlJhfysYBf6F1bwNX6K2/ol9lr
         B0dvXiBwRWcYze3Z8zbQLJWoiqu2tcI48i/Hprge8E/0JSEwXILtznma+VmymPNiqkM7
         IXlLDS86Hkhup1wFZEchkUUFQQlHDfH9oadUWwQD/VhYSMrBGHZzx3/3UH1Vl6CcL7Qd
         CIo9JoTeTwUJubikMXXp1EeDoBPogYAbJ7e99aeXUJjvsK3fR2NVQIZXXEdBiKmwcFDp
         CHVz2APc8Y3Q5/w6ZOIOpsNNcqWXJe6SDNurmfiJEcoyhE2CzzTyAkDXsQkUFnMq8Zea
         rZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=batmuya7co49qkeSt7rrFXuUKreU4NnJ2KEEv73JYWE=;
        b=jAXu1pvEkBxowF8SrKprqvGwdFRtRakdYIl3jdVrULNVV2tLq4MeLlA9dFuYWWELOi
         Yg/q/BkD82jDjRtOkNCP8sZp+V79PiPKRO/CW4dZLH9CdNP9l3jzpl7qum7h8GSyfSSh
         qkwPlRPRFN7OOGKx5I8zeNMT6E15a7q9/9dDZaj/S8qJnpYrgBQY65SuJ/dA2Nd0SKpO
         G1X5mhX93LXZX72hOOdCwcTGlkEjp3CG7Zwtmis5+Y3seRNcIMfYNOZVOmzGsMTnxn0B
         xCgEszjac5769OdgVpPnd6wzv0oFHCpHS/7dmCoajC+uDuoatV4br7+ncR6Bj8Vncwr9
         ZOMg==
X-Gm-Message-State: AOAM532c/URla/hCw4Dn18dT2grDtq+zCExlYve3ooFn1GIoauXDCZ13
        FqYLzOvDuCvn1ydviKeGTUU=
X-Google-Smtp-Source: ABdhPJzqdfGT0I5FjeX+bddT2YdZRIrkK9noae0FfxIJ5yXOyUWdWRzU5toIGWdCbQFzZHTJ6XJRSg==
X-Received: by 2002:a2e:86d0:: with SMTP id n16mr6250660ljj.51.1612051970975;
        Sat, 30 Jan 2021 16:12:50 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-164.NA.cust.bahnhof.se. [158.174.22.164])
        by smtp.gmail.com with ESMTPSA id t2sm2503716lfl.141.2021.01.30.16.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 16:12:50 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 2/2] ALSA: hda: Constify static attribute_group
Date:   Sun, 31 Jan 2021 01:12:41 +0100
Message-Id: <20210131001241.2278-3-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210131001241.2278-1-rikard.falkeborn@gmail.com>
References: <20210131001241.2278-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of hdac_dev_attr_group is to put its address in an array
of pointers to const attribute_group structs. Make it const to allow the
compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 sound/hda/hdac_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/hdac_sysfs.c b/sound/hda/hdac_sysfs.c
index e56e83325903..0d7771fca9f0 100644
--- a/sound/hda/hdac_sysfs.c
+++ b/sound/hda/hdac_sysfs.c
@@ -66,7 +66,7 @@ static struct attribute *hdac_dev_attrs[] = {
 	NULL
 };
 
-static struct attribute_group hdac_dev_attr_group = {
+static const struct attribute_group hdac_dev_attr_group = {
 	.attrs	= hdac_dev_attrs,
 };
 
-- 
2.30.0

