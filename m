Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9312B3D1D1A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 06:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhGVEBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 00:01:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42871 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229530AbhGVEBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 00:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626928926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Np6AqHl19Qnq+fc5f537Pv3JR0dA3FodDzznrUqUHhY=;
        b=FsXiL2oiSzcD+cmasOKS1IJnYxS6DXFlpVywpFcG1c0GDf+n28ODTfU3oCWzoNYiaBqg9K
        V3KbqoRYOfkpfaHX/qSeG3kqz8wwi4P1R/JkuSpj+ES7yI330/8R2MuVvJdNTdSydMIciu
        VQSbD/fsu5/rlfQYklZT73lseTH4wOA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-i4mYyLp0NEeGk8vXOVNawg-1; Thu, 22 Jul 2021 00:42:05 -0400
X-MC-Unique: i4mYyLp0NEeGk8vXOVNawg-1
Received: by mail-wr1-f71.google.com with SMTP id r18-20020adfce920000b029013bbfb19640so1928307wrn.17
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 21:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Np6AqHl19Qnq+fc5f537Pv3JR0dA3FodDzznrUqUHhY=;
        b=kVb0uhQkoOAAzA4mP2QCe7YsE2TsEeAB1Nd1nP8HtAOkM6eSCFr1nw94K6BAtbRBrq
         NO2RD0enhdix+Tn3ZEP0qvNLA4dwSELD/30Gy9aM+JNSCR2zwPZP/viQTez8GUPigBHj
         SiSsC0SOFcjtoCVGCvatktCO3A1RXiXYNZ1uJpsL4mmXo6WD62HQmNLmRc6x3nRGduoK
         QQqXICuwCprisfeT0nKGsdFObixDoxBukQ3qwcBfLNoc+VHlEB681UkoWZNSvVSbPOKD
         68FzObVcmPrwUvT6zJMiXDb1Y9FiqLpqd/Gg9cXIL7ZJ+WY53ky+6OBVgiNNgbLWSCYt
         PjRw==
X-Gm-Message-State: AOAM5326h8x3GPYapkFIU9EQ/1nyXX3jboolA651gljSw0jwf8KLyVx9
        6pzwhFGNIOvIvVsrOznpl5CeYkEIs38bR5FVBzLFmwT2ii4mU4yW5WD+4A6RmrSr+KzmNqK0C6r
        OuyzkiNcFkoti7pzXtH+hjMAyP332gtg0rflvkq87A5WW0wV8j1c5D49qDqNdubqfn0MD7cYLgh
        E=
X-Received: by 2002:a7b:ca43:: with SMTP id m3mr40451645wml.74.1626928924104;
        Wed, 21 Jul 2021 21:42:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUBIHXzIjYaGO626+bK+iEh/ZLJSTjEs8WPcf4a0Ua/24DBKA4+HNNFqg4Xi4bHPzxIz4asg==
X-Received: by 2002:a7b:ca43:: with SMTP id m3mr40451618wml.74.1626928923871;
        Wed, 21 Jul 2021 21:42:03 -0700 (PDT)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id e6sm33694588wrg.18.2021.07.21.21.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 21:42:02 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        kernel test robot <lkp@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        He Ying <heying24@huawei.com>,
        John Stultz <john.stultz@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Subject: [PATCH] drivers/firmware: fix sysfb depends to prevent build failures
Date:   Thu, 22 Jul 2021 06:41:55 +0200
Message-Id: <20210722044155.864600-1-javierm@redhat.com>
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
enabled. And also, because the sysfb code is only used for EFI on these
architectures. For !EFI the "simple-framebuffer" device is registered by
OF when parsing the Device Tree Blob (if a DT node for this is defined).

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/firmware/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index af6719cc576..897f5f25c64 100644
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

