Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C7543FE75
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 16:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbhJ2Od0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 10:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbhJ2OdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 10:33:24 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBC1C061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 07:30:56 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id j1so447156plx.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 07:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=8Bxs4F85A7oXItV71QS1XAq1zhuitRsW57m5eFPOxyA=;
        b=OOXxXvvbN6upCnhe8T+anV/C8IhTYpGLQMXwY+hZXoPSDW3zc5XTMqPBgicGbt2/7f
         +f/wyYVYB2X00UX1TePTkEGBTruTx6g/q4LeBPi41qhb2gRnVsThTJIb3puObQzc9fTV
         YDZvAD4fUi3F5zp6wdzPPCZ3zARuG6A7i/QDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=8Bxs4F85A7oXItV71QS1XAq1zhuitRsW57m5eFPOxyA=;
        b=glTjywowR6Z1GIOfRlH50J/nu9OVs9EPke3JzyF1HfMXwYcGD52iZ26LW/1UFCqWpr
         ux1rDk7fPJmxBckuJD/7yBcSBeEmZbBF0+dY/FlRX4teaL8ZS6S15UEjXWmkhMWmXY4A
         Va62ZZ3eYxD7wTKg8NP6ycqwBWrqpVz10eRXbihoT51jkUNAzYEJbHpb0UZt3gsfjkkB
         Dh2RAaqq7PXCYtqQbtxwJcZYo07PYXsGwfonBe0ulsm+++aYqN3FLLzTKQ3nJwZfEXGP
         WZQmMebroJpsDVOauDA2gDEyjPK9QviUy/q3XjiMAMJl4eb/tc0muJENCk+LlN3c2hyg
         +TRw==
X-Gm-Message-State: AOAM531vba4iyt2H4dQHwtVb/IztydWVuSf8Dh1hXRgp7j49F5bMS1fH
        Qmpij9A2Yzqo6TtF/OnL4bPzmw==
X-Google-Smtp-Source: ABdhPJzwVqF9ymgQCiLJqBddRnm0de8/pxD4Fy6hKvCO+eGNjpF8HUHADqJR6jAGSbhSst6jy5PFHw==
X-Received: by 2002:a17:902:b492:b0:13f:4f30:88de with SMTP id y18-20020a170902b49200b0013f4f3088demr9770889plr.35.1635517855639;
        Fri, 29 Oct 2021 07:30:55 -0700 (PDT)
Received: from [127.0.0.1] (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i184sm5649953pgc.56.2021.10.29.07.30.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 07:30:55 -0700 (PDT)
Date:   Fri, 29 Oct 2021 07:30:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Zhenguo Zhao <zhenguo6858@gmail.com>, nianfu.bai@unisoc.com,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com
CC:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] pstore: Add pstore back-end choice method in kconfig
User-Agent: K-9 Mail for Android
In-Reply-To: <1635490280-8798-2-git-send-email-zhenguo6858@gmail.com>
References: <1635490280-8798-1-git-send-email-zhenguo6858@gmail.com> <1635490280-8798-2-git-send-email-zhenguo6858@gmail.com>
Message-ID: <B5B678EA-303B-4F16-AD89-EE7C31AFC4ED@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On October 28, 2021 11:51:19 PM PDT, Zhenguo Zhao <zhenguo6858@gmail=2Ecom=
> wrote:
>From: Zhenguo Zhao <Zhenguo=2EZhao1@unisoc=2Ecom>
>
>The pstore has one storage device for back-end,so it should be
>use choice method to config=2E
>
>When ramoops config,insmod pstore_blk=2Eko,it will print unexpected,the
>module will insmod failed=2E
>
>    if (backend && strcmp(backend, psi->name)) {
>        pr_warn("ignoring unexpected backend '%s'\n", psi->name);
>        return -EPERM;
>    }

This is by design: all the backends can be built as modules, and each can =
be loaded and unloaded as desired=2E If it's a "choice" only one can be bui=
lt at a time=2E

-Kees


>
>Signed-off-by: Zhenguo Zhao <Zhenguo=2EZhao1@unisoc=2Ecom>
>---
> fs/pstore/Kconfig | 57 ++++++++++++++++++++++++++++++-------------------=
------
> 1 file changed, 31 insertions(+), 26 deletions(-)
>
>diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
>index 8adabde=2E=2E288ed3c 100644
>--- a/fs/pstore/Kconfig
>+++ b/fs/pstore/Kconfig
>@@ -146,21 +146,40 @@ config PSTORE_FTRACE
>=20
> 	  If unsure, say N=2E
>=20
>-config PSTORE_RAM
>-	tristate "Log panic/oops to a RAM buffer"
>+choice
>+	prompt "Choice pstore device"
> 	depends on PSTORE
>-	depends on HAS_IOMEM
>-	select REED_SOLOMON
>-	select REED_SOLOMON_ENC8
>-	select REED_SOLOMON_DEC8
>+	default PSTORE_RAM
> 	help
>-	  This enables panic and oops messages to be logged to a circular
>-	  buffer in RAM where it can be read back at some later point=2E
>-
>-	  Note that for historical reasons, the module will be named
>-	  "ramoops=2Eko"=2E
>+	  This option chooses ram or blk to use pstore device=2E
>+	config PSTORE_RAM
>+		tristate "Log panic/oops to a RAM buffer"
>+		depends on HAS_IOMEM
>+		select REED_SOLOMON
>+		select REED_SOLOMON_ENC8
>+		select REED_SOLOMON_DEC8
>+		help
>+		  This enables panic and oops messages to be logged to a circular
>+		  buffer in RAM where it can be read back at some later point=2E
>+
>+		  Note that for historical reasons, the module will be named
>+		  "ramoops=2Eko"=2E
>+
>+		  For more information, see Documentation/admin-guide/ramoops=2Erst=2E
>+
>+	config PSTORE_BLK
>+		tristate "Log panic/oops to a block device"
>+		depends on BLOCK
>+		select PSTORE_ZONE
>+		help
>+		  This enables panic and oops message to be logged to a block dev
>+		  where it can be read back at some later point=2E
>+
>+		  For more information, see Documentation/admin-guide/pstore-blk=2Erst
>+
>+		  If unsure, say N=2E
>=20
>-	  For more information, see Documentation/admin-guide/ramoops=2Erst=2E
>+endchoice
>=20
> config PSTORE_ZONE
> 	tristate
>@@ -169,20 +188,6 @@ config PSTORE_ZONE
> 	  The common layer for pstore/blk (and pstore/ram in the future)
> 	  to manage storage in zones=2E
>=20
>-config PSTORE_BLK
>-	tristate "Log panic/oops to a block device"
>-	depends on PSTORE
>-	depends on BLOCK
>-	select PSTORE_ZONE
>-	default n
>-	help
>-	  This enables panic and oops message to be logged to a block dev
>-	  where it can be read back at some later point=2E
>-
>-	  For more information, see Documentation/admin-guide/pstore-blk=2Erst
>-
>-	  If unsure, say N=2E
>-
> config PSTORE_BLK_BLKDEV
> 	string "block device identifier"
> 	depends on PSTORE_BLK

--=20
Kees Cook
