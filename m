Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3A935B6ED
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 22:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236579AbhDKUuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 16:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235963AbhDKUuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 16:50:05 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD5BC061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 13:49:48 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 12so5638719wmf.5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 13:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=y8zmAuB0V1uZek5By6kezUe2gvROS9UhWxNto8Rl44U=;
        b=M4gznb84QcKSBB549xNmVxUrXXVflXsDoyhxXQNId/1d7wQU1E2DR0+iSsEhduWIUX
         Bmz04jOkQX/ViVBUtOnIUVFLhoW87y8dismExesc0+Yk8Z955x/t3naySYReAsa4a8eA
         bNfyuSD8kLrbi+9TGce7F8YeZ0knW1Bf6ustTvdUjw//DlrlK2INVFynblezbWTD6Fde
         kk30rty8ShSs3VzwQCKIBP75fQ8oN8F3yLeMGZUgIApzQZgvsWfeJD9NOxxufZGkYLsB
         6pe1w+wsvLzmXLQyRXnfxFPQ33GXmvcYh41UQAIOCfUUvgSipq2Dk9Yge952jUkgKFEZ
         ARuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=y8zmAuB0V1uZek5By6kezUe2gvROS9UhWxNto8Rl44U=;
        b=Hw4ASBqhfRSgCsvcidM4cBrZV9V0RrpoC0GmPg9ENx8uOcS5mnOdB7q9/ynvlFTm+Q
         uQwFUXo3bhG4SqhrUC4NYeWo4LVSVaAiHgWOi5Xosow1I+92b3uEPkxiHBGpmOV4BY7y
         IXBz/rsW8CNmNmq42AnnFmvimVYsfS/LWthSjyUg5us7fNyBjIn6fwviI6odYs4VDG3k
         uQATuLYfJ2VdywWsd3cyF22u+g2UAVteL8bZ5113mR4Tg5ECSSFlJwzYriNyASgB5vg0
         QACGWpFXpyQCHK711b3zcnw4kkPhjq8HX6RadvKOQ+Tipw5Jh6lF3xfuRB2P3cnSEHzi
         VgOg==
X-Gm-Message-State: AOAM533ecYR6YS/W/szuEco3hDydU8VxPz2Hi4kMrIwzTPKZODC3eyfB
        Cwuyna0hDyNxVUc8s5e/t5k=
X-Google-Smtp-Source: ABdhPJxBS3Z/+lUzJp5cOGYT3zY1AwXP81gIiuaHg0aB/hMcvgCl3bl4hwHB+WYYJnP08NPP8cEkZw==
X-Received: by 2002:a1c:3:: with SMTP id 3mr22651982wma.32.1618174187234;
        Sun, 11 Apr 2021 13:49:47 -0700 (PDT)
Received: from peggy-Lenovo-V130-15IKB ([154.72.153.206])
        by smtp.gmail.com with ESMTPSA id o18sm6953940wmp.26.2021.04.11.13.49.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Apr 2021 13:49:46 -0700 (PDT)
Date:   Sun, 11 Apr 2021 16:49:38 -0400
From:   tawahpeggy <tawahpeggy98@gmail.com>
To:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com,
        tawahpeggy <tawahpeggy98@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: Remove line to fix checkpatch error
Message-ID: <20210411204933.GA3524@peggy-Lenovo-V130-15IKB>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove one empty line.CHECK: Please don't use multiple blank lines

Signed-off-by: tawahpeggy <tawahpeggy98@gmail.com>

---
 drivers/staging/comedi/comedi_pcmcia.mod.c | 1 -
 1 file changed, 0 insertion(+), 1 deletion(-)
 create mode 100644 drivers/staging/comedi/comedi_pcmcia.mod.c

diff --git a/drivers/staging/comedi/comedi_pcmcia.mod.c b/drivers/staging/comedi/comedi_pcmcia.mod.c
index 0904b8765afs96..3984db1a39c8
--- /dev/null
+++ b/drivers/staging/comedi/comedi_pcmcia.mod.c
@@ -0,0 +1,31 @@
#include <linux/module.h>
#define INCLUDE_VERMAGIC
#include <linux/build-salt.h>
#include <linux/vermagic.h>
#include <linux/compiler.h>

BUILD_SALT;

MODULE_INFO(vermagic, VERMAGIC_STRING);
MODULE_INFO(name, KBUILD_MODNAME);

__visible struct module __this_module
__section(".gnu.linkonce.this_module") = {
	.name = KBUILD_MODNAME,
	.init = init_module,
#ifdef CONFIG_MODULE_UNLOAD
	.exit = cleanup_module,
#endif
	.arch = MODULE_ARCH_INIT,
};

#ifdef CONFIG_RETPOLINE
MODULE_INFO(retpoline, "Y");
#endif

MODULE_INFO(staging, "Y");

MODULE_INFO(depends, "pcmcia,comedi");

-  
MODULE_INFO(srcversion, "ED971F2E01020DFA2B04486");
-- 
2.17.1
h-Hartman <gregkh@linuxfoundation.org>

