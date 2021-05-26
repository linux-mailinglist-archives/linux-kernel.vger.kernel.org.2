Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207C839225E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 23:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbhEZVyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 17:54:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32900 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233801AbhEZVyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 17:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622065963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2ooIrO6+PnLW9RdU2+GIho8vABniPqVAPdMUszZt5uE=;
        b=cj1SZ5pWr8EzGGozjqMn0LwX7m6IMMK/ixyBZThsUvnADTXyfeRDbtr7dboRSWxEP1m0i3
        2YIie27l2s71yvsfdYjCDvw2P3MitVTYSb08m0tjNSoH+rO79OMisy1Ja/16gy+Cc+iQwJ
        WCx+p7/U1gdByU8hvvBTf1n2cOrMC04=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-oU8tpAjqM0mNpw6PzxAClQ-1; Wed, 26 May 2021 17:52:41 -0400
X-MC-Unique: oU8tpAjqM0mNpw6PzxAClQ-1
Received: by mail-wm1-f71.google.com with SMTP id o3-20020a05600c3783b029017dca14ec2dso765737wmr.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 14:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2ooIrO6+PnLW9RdU2+GIho8vABniPqVAPdMUszZt5uE=;
        b=dL+gTRb2cRUUwbYP3mkXkucVgqQfOeG2J6Hkvp39D4aFJ2U63rbgIcNIXMJRuyjaTX
         st0y1meJIuXCKRiTNDjDNXJmHbT9fNK/fLdPoRdMVjShSNnqLoT7YksBsYOaqL2ieB43
         aGytHtPitv6e2U6eIHMuCUNFUfql5t2+qVxZuh4dCYkQx17+KgWXNR//h7KryOxUBJ4a
         hxgiR2vBdKkixA7fjduAh18E5TZwd+SPCWgkn67B8PF+1nS2np6xf2DPgqHKe5DOskOn
         iAPq94KvgAW8F9KqlKuzdPs1wu/zdmVH5EnhvSSkMHewTUGpTmNOSRSg3J3JEnciiq8H
         MePA==
X-Gm-Message-State: AOAM530RFBidqiilGfyesPLXgKOHGB0bWiKW33774Oj7eVFDUC/58+lG
        iLhzLdMA/wh0yzwzVajOLQAAXX7ZKliLIWyFJEhMHvinMZI5L9sotOehm9jZM40Cm/KCEylRJwq
        8LHfszJt9gQ/6Iwj4KQpPyNzK/A2tAu9ffKfaHXlYKG4maU2WOKGv9mEcvZqXbxAKf6KD4QGMvp
        w=
X-Received: by 2002:a05:6000:11ce:: with SMTP id i14mr80407wrx.221.1622065960196;
        Wed, 26 May 2021 14:52:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpR2jhnqwvB6Ifd8antV8AzpNPZsvRhuhOfJO+5wlVtFi9SUKlsBy9gkyhhjnjvo1hBm188Q==
X-Received: by 2002:a05:6000:11ce:: with SMTP id i14mr80383wrx.221.1622065959965;
        Wed, 26 May 2021 14:52:39 -0700 (PDT)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id q5sm388996wmc.0.2021.05.26.14.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 14:52:39 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>, bpf@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org
Subject: [PATCH v2] kbuild: quote OBJCOPY var to avoid a pahole call break the build
Date:   Wed, 26 May 2021 23:52:28 +0200
Message-Id: <20210526215228.3729875-1-javierm@redhat.com>
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
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---

Changes in v2:
- Add collected Acked-by tags.
- Also quote on a similar assignment in scripts/link-vmlinux.sh (masahiroy)

 scripts/Makefile.modfinal | 2 +-
 scripts/link-vmlinux.sh   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index f4de4c97015..0e0f6466b18 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -240,7 +240,7 @@ gen_btf()
 	fi
 
 	info "BTF" ${2}
-	LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${extra_paholeopt} ${1}
+	LLVM_OBJCOPY="${OBJCOPY}" ${PAHOLE} -J ${extra_paholeopt} ${1}
 
 	# Create ${2} which contains just .BTF section but no symbols. Add
 	# SHF_ALLOC because .BTF will be part of the vmlinux image. --strip-all
-- 
2.31.1

