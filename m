Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5EC387B0D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 16:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbhEROYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 10:24:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35186 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230505AbhEROYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 10:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621347797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=f8IzFIOzbsxUCqwXiXd4bDeaGDFMJm7rKWjjlTMeQkU=;
        b=B3AFKQQkqvZW8ywEbsV31CAmIPjpImY5l/2/LFbYzMwzJb4nLRhRTx6lAV/1LUcBiicPTN
        2FN6JdCpZiWqAg51fEZ/FPD6CfH2Cu0ohnLEHAy51vKGnp6fMzoApw3UEwvOqlmYo99Qsr
        Vx0BxrhosTtJ4uFujsRxl9gihMJktoY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-nthR3L_GNtO_vaKuCLajNg-1; Tue, 18 May 2021 10:23:16 -0400
X-MC-Unique: nthR3L_GNtO_vaKuCLajNg-1
Received: by mail-wm1-f69.google.com with SMTP id x7-20020a7bc2070000b0290149dcabfd85so325131wmi.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 07:23:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f8IzFIOzbsxUCqwXiXd4bDeaGDFMJm7rKWjjlTMeQkU=;
        b=ftudE4X+PXNePZXWK9nqa9GXE3ufQkfkyRnY7XHB8/cXj08qkn/ydQ6XXsTe+x7yEu
         0LJOXGWB823VYqGXQkOoRzK5MJ7/3dPZvytF0iYm/B6UQ59reUhDrS0A39UjP++DeTOT
         KalnJBybc06oNZ+wuT4UMinncSqs2CZNg90CYCxd90i6+jASnTI8CCj6/ZjElAAQdITL
         88WegRCIc8bfADIeSRMDSZsW6KPfRbIHc60qpMtyZwjC6yGirkrgqkB/Y405BDPA5l4H
         tB7yZXOYxYyiC9XC2NjQVx6eZZEewF3rGfihebwo1cWUUJczIp0GSTqLN794Vta++M/4
         14ZA==
X-Gm-Message-State: AOAM533sTJV90FPL5Z7hlZsH45Ra88+dqS1cGPnIDMesN7aCGcFnsdD3
        0P1J5P0QCi44u7u3cj5TRIuWR2aajjFBFjwxwrvBnKfre/dizbvF0tcWoAL6UzrY7mH1DgLv1s1
        s+z8pFRhkIstJf3esmhX8ungAEOLqaBfgDVE7tiU1rJJxmCLarqipJJ4AKRg1WToZ6ZZ8aXFpHm
        Q=
X-Received: by 2002:adf:f907:: with SMTP id b7mr7312907wrr.357.1621347794502;
        Tue, 18 May 2021 07:23:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6E1MI1XSdj+/UrQccO5djZLBo0D5vzJ6188cg66WvIejc4itI68QMz8MWHG8lIVM4l7oV0g==
X-Received: by 2002:adf:f907:: with SMTP id b7mr7312863wrr.357.1621347794154;
        Tue, 18 May 2021 07:23:14 -0700 (PDT)
Received: from minerva.redhat.com ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id i1sm10700145wrp.51.2021.05.18.07.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 07:23:13 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org
Subject: [PATCH] kbuild: quote OBJCOPY var to avoid a pahole call break the build
Date:   Tue, 18 May 2021 16:23:02 +0200
Message-Id: <20210518142302.1046718-1-javierm@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ccache tool can be used to speed up cross-compilation, by calling the
compiler and binutils through ccache. For example, following should work:

    $ export ARCH=arm64 CROSS_COMPILE="ccache aarch64-linux-gnu-"

    $ make M=drivers/gpu/drm/rockchip/

but pahole fails to extract the BTF info from DWARF, breaking the build:

      CC [M]  drivers/gpu/drm/rockchip//rockchipdrm.mod.o
      LD [M]  drivers/gpu/drm/rockchip//rockchipdrm.ko
      BTF [M] drivers/gpu/drm/rockchip//rockchipdrm.ko
    aarch64-linux-gnu-objcopy: invalid option -- 'J'
    Usage: aarch64-linux-gnu-objcopy [option(s)] in-file [out-file]
     Copies a binary file, possibly transforming it in the process
    ...
    make[1]: *** [scripts/Makefile.modpost:156: __modpost] Error 2
    make: *** [Makefile:1866: modules] Error 2

this fails because OBJCOPY is set to "ccache aarch64-linux-gnu-copy" and
later pahole is executed with the following command line:

    LLVM_OBJCOPY=$(OBJCOPY) $(PAHOLE) -J --btf_base vmlinux $@

which gets expanded to:

    LLVM_OBJCOPY=ccache aarch64-linux-gnu-objcopy pahole -J ...

instead of:

    LLVM_OBJCOPY="ccache aarch64-linux-gnu-objcopy" pahole -J ...

Fixes: 5f9ae91f7c0 ("kbuild: Build kernel module BTFs if BTF is enabled and pahole supports it")
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 scripts/Makefile.modfinal | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index dd87cea9fba..a7883e45529 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -59,7 +59,7 @@ quiet_cmd_ld_ko_o = LD [M]  $@
 quiet_cmd_btf_ko = BTF [M] $@
       cmd_btf_ko = 							\
 	if [ -f vmlinux ]; then						\
-		LLVM_OBJCOPY=$(OBJCOPY) $(PAHOLE) -J --btf_base vmlinux $@; \
+		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J --btf_base vmlinux $@; \
 	else								\
 		printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
 	fi;
-- 
2.31.1

