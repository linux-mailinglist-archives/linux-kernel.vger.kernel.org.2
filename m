Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A776325DA1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 07:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhBZGlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 01:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhBZGlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 01:41:19 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FF9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 22:40:38 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id k66so6805573wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 22:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qBv4V4EmN8qA0cU5ivOCn36uSWbsf+UfWEMpu3Xsvg0=;
        b=u0HvfMPQE6pgcPWA3xteryuDihSM8934hE5IHWnPWPUtjWK/vGj+L1Wo0s/0YqsQB8
         mmW8iareV9clEPA2G0t0P3KrdessD2h8zGt3dU0/v2hoQA31XQnWn6rndiL+j0E/KDiH
         0sd8OA8566yoKpvZojRGS3DGW3usPrHj5gQcQpKVyGDs8Ng9SPdeUmDjrnYu64y2iA5M
         3haiRUgQNXKZaIoC47EMaqfkvz4PYqWC3UGouNmH65kUiBYcnxu5qLMOXrKkZOIO1RpR
         hmOqd57ufYWZRsB1oTOX5DsStg0xz99eTiwGwobAp2oWxPP9uZEQnd7ygq+AzyCpAi1b
         6GDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qBv4V4EmN8qA0cU5ivOCn36uSWbsf+UfWEMpu3Xsvg0=;
        b=eX2KeD9CCueaRkmMx3yWI41vMt8QInrHj7X2IXwUj4OA7V17AbV7zClanLeNHXR9Ue
         wlMRIZ3GSJe6ZLH+33SxCUExcH59nDrP8H60+DEpwMm3DNGfXfBOblc4uXOp+Wz/uRKB
         MpAKaFFi1DHonjxFTR9e1o2lOOOmQ3V3+8HSpZXbjRAmKw0M8O6bgT6MvdWr40zXXIQm
         +/qbRrAptIamaOFboNVSlGXWL939LBzl1DBus9jksvKixBWgXXsbu0ekr21JJ0Lp/NxK
         6sYDKNkoOre7M1aunMJsmpM/YA8wvdCJenhHDnAtlD8LKK23+yoHS5QOaZbPS75f0ZhK
         PtzA==
X-Gm-Message-State: AOAM533RHSLKXPz21rZ5wbZ0vkaTrooxyurtk5dVrHuoB/Oprh/lDco+
        hjf7zRb5Gvk0gQhVXb0aoJB8jSHKuB3xxw==
X-Google-Smtp-Source: ABdhPJwwamyIgSijLzbYxxqyCfR/axISib20Qfp6SAN1d2ny0CIzlWWodzGRYHoYobaPdAY/SNRRkA==
X-Received: by 2002:a1c:a5c7:: with SMTP id o190mr1221496wme.172.1614321637313;
        Thu, 25 Feb 2021 22:40:37 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d82:8b00:f574:4738:807d:ed97])
        by smtp.gmail.com with ESMTPSA id 4sm11512687wma.0.2021.02.25.22.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 22:40:36 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org
Cc:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH for Dwaipayan] MAINTAINERS: clarify responsibility for checkpatch documentation
Date:   Fri, 26 Feb 2021 07:40:29 +0100
Message-Id: <20210226064029.1143-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed, Dwaipayan and Lukas take the responsibility for maintaining
the checkpatch documentation that is currently being built up.

To be sure that the checkpatch maintainers and the corresponding
documentation maintainers can keep the content synchronized, add them as
reviewers to the counterpart.

Link: https://lore.kernel.org/lkml/bcee822d1934772f47702ee257bc735c8f467088.camel@perches.com/
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on next-20210226

Dwaipayan, you probably want to add this patch to your patch series for checkpatch
documentation.

Feel free to add your Signed-off-by tag just following mine. 

 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 16ada1a4b751..6b48b79ba284 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4181,9 +4181,18 @@ X:	drivers/char/tpm/
 CHECKPATCH
 M:	Andy Whitcroft <apw@canonical.com>
 M:	Joe Perches <joe@perches.com>
+R:	Dwaipayan Ray <dwaipayanray1@gmail.com>
+R:	Lukas Bulwahn <lukas.bulwahn@gmail.com>
 S:	Maintained
 F:	scripts/checkpatch.pl
 
+CHECKPATCH DOCUMENTATION
+M:	Dwaipayan Ray <dwaipayanray1@gmail.com>
+M:	Lukas Bulwahn <lukas.bulwahn@gmail.com>
+R:	Joe Perches <joe@perches.com>
+S:	Maintained
+F:	Documentation/dev-tools/checkpatch.rst
+
 CHINESE DOCUMENTATION
 M:	Harry Wei <harryxiyou@gmail.com>
 M:	Alex Shi <alex.shi@linux.alibaba.com>
-- 
2.17.1

