Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE7F3D7209
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 11:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbhG0JbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 05:31:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23259 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235946AbhG0JbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 05:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627378284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=P4kqHtesmMxT6t4DNtHwJ5aBPP2dWdjSVvEEwfsLZAk=;
        b=QDRIURKKWdVO6VUJxFFR/iIgdxdnwx0TLzf652Sk9TqJRi4k6O2a/LsMJky4H8oABP/3uJ
        L0ON1ZtSRNUANmxY6C2mmZu82NMmAOr3xTgXP7iSzhJmnlypPhryRfnnocthxMPCmJh+b5
        jMlcb6/BuC3UOASi2mDm8y11eUDchAU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-sdFckv-5O1mK0xRtMH3e2Q-1; Tue, 27 Jul 2021 05:31:23 -0400
X-MC-Unique: sdFckv-5O1mK0xRtMH3e2Q-1
Received: by mail-wm1-f70.google.com with SMTP id r125-20020a1c2b830000b0290197a4be97b7so1111460wmr.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 02:31:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P4kqHtesmMxT6t4DNtHwJ5aBPP2dWdjSVvEEwfsLZAk=;
        b=WdjrkS/mgaPN0Oz6pByfYhKAukbTyvqHmSTxSo7p4wRi3MXtCiZsqDvGUtDdAeTqyw
         wEB3q1Kr1+1dgxBonuWzSrtnWa5g51fhG89apOilCF8iFBw7agxp6oNONQQKiPtrU8cc
         YVh43o0b71eyGdgtGLiYcpkGIWmdafx3dRfMpMbIqI5PFweTYnewR15/TJ636l1MhUer
         iCu8kV1FEilqJ7tsEWavu5/PMwHD30pe3vba8JOEsRJvQMi82CameMTpXuVm2YXuhpfM
         stYPcee3kprPNF8bRhh5lqU+P9/ssi10gxZogvrWc8Pt+bLVMgugcnCETaUj+wu7yfDX
         Drrg==
X-Gm-Message-State: AOAM531q24MpIvMdrL8AzDq6g4KQAgCFmgcIBErqlAIdJDSX1HUy0ewh
        g+FlmfBqrF3LlPkKtKJsDyhpizEObIbw0/TTn67jpqaFWt9rOPW5ji6afgimuPDf8S0RYvOKLv8
        YMmMB8c5i+y0+fibonMPcS0H3CX7B5ID+7a6dVSwXeXEdTmi8GmsQPBB/uMnj4DNzy4EbpoFs+L
        I=
X-Received: by 2002:a7b:c5c8:: with SMTP id n8mr3130338wmk.124.1627378281932;
        Tue, 27 Jul 2021 02:31:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtSTRdORJi+3HQuQAfNqDh30m4N7FIkb5NYH9m4pyGW2FleIaHfUZvmh/dqu5ySf57m+HabA==
X-Received: by 2002:a7b:c5c8:: with SMTP id n8mr3130294wmk.124.1627378281543;
        Tue, 27 Jul 2021 02:31:21 -0700 (PDT)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id p18sm2035812wmg.46.2021.07.27.02.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 02:31:20 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Peter Robinson <pbrobinson@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        kernel test robot <lkp@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Colin Ian King <colin.king@canonical.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v2] drivers/firmware: fix SYSFB depends to prevent build failures
Date:   Tue, 27 Jul 2021 11:30:15 +0200
Message-Id: <20210727093015.1225107-1-javierm@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Generic System Framebuffers support is built when the COMPILE_TEST
option is enabled. But this wrongly assumes that all the architectures
declare a struct screen_info.

This is true for most architectures, but at least the following do not:
arc, m68k, microblaze, openrisc, parisc and s390.

By attempting to make this compile testeable on all architectures, it
leads to linking errors as reported by the kernel test robot for parisc:

  All errors (new ones prefixed by >>):

     hppa-linux-ld: drivers/firmware/sysfb.o: in function `sysfb_init':
     (.init.text+0x24): undefined reference to `screen_info'
  >> hppa-linux-ld: (.init.text+0x28): undefined reference to `screen_info'

To prevent these errors only allow sysfb to be built on systems that are
going to need it, which are x86 BIOS and EFI.

The EFI Kconfig symbol is used instead of (ARM || ARM64 || RISC) because
some of these architectures only declare a struct screen_info if EFI is
enabled. And also, because the SYSFB code is only used for EFI on these
architectures. For !EFI the "simple-framebuffer" device is registered by
OF when parsing the Device Tree Blob (if a DT node for this was defined).

Fixes: d391c5827107 ("drivers/firmware: move x86 Generic System Framebuffers support")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v2:
- Add a Fixes tag to the changelog.

 drivers/firmware/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index af6719cc576b..897f5f25c64e 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -254,7 +254,7 @@ config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
 config SYSFB
 	bool
 	default y
-	depends on X86 || ARM || ARM64 || RISCV || COMPILE_TEST
+	depends on X86 || EFI
 
 config SYSFB_SIMPLEFB
 	bool "Mark VGA/VBE/EFI FB as generic system framebuffer"
-- 
2.31.1

