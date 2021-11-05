Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB030446656
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 16:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbhKEPt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 11:49:28 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:55430
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232412AbhKEPtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 11:49:25 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 77DB240027
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 15:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636127205;
        bh=AZ2gloRjaGSelBDHUs66L2AD8OBUvTDJdaiIuuRPNLk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=MOO6V6euXmonRjdtomUUcwBcD7caUKuI7B/cxcg/hUMs9k5hwTOJ786Yj3F++gpit
         MkjC5PCnFblCEhF5INVYvrEnPxeX9nj5Hg81CUuiVu0gSjznYyYaX1wY/AsDeXYO0w
         XQF+eKtNqIH2ig9VsK/o6yuewY2Iu/B8V6QmMpC29jlzUOVQKVP8l5RC92r7euvU3b
         6PQSXNfJCAkZj7QjWlfZGjV+ZuM65wRVp6jmWlXhKg6TuWkczNd9jvhpJkGAH5wuEy
         3Q64+4ynyQJhw1Ks8j/FmC5Oar7NuOZwytTramb6I8LLBuqrW0idgsG7RvEKhR9ZJh
         5bEAMbaAdMMUA==
Received: by mail-wm1-f72.google.com with SMTP id o18-20020a05600c511200b00332fa17a02eso3375450wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 08:46:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AZ2gloRjaGSelBDHUs66L2AD8OBUvTDJdaiIuuRPNLk=;
        b=SNHCtB0DcdUVAiNFtsTOqi0lzJ3ArLmP64J15X+bcLmD0jnFEKrsPaPoPQHVVlwAab
         yq9Uw/toQv+6Eg9So8f1SIs6L2Km0WTy04K39+iSJ85aFHp14fJ15OYjYj3iti5gBG1u
         doCIkTI+ZYS/50TydSBiGqHvVhYE9bsPjRTNuMvzxJpE18ONuMOYbODBNr/D+oZ5y/8x
         fsrSYO/zQG4A4PVp2UwWweakyEc5wimQEWyarlACxf61u739yWY+eahXwe4zklZPiKmv
         3E1l7TvIOo8zvHu27t3q4ZM3R80KqJmICZ3nNyBdK7UZIprp+Lndo8OJYQ1o1yaU7AIN
         uJHQ==
X-Gm-Message-State: AOAM533gAl5SfaugY00BOvTGKIJohOkfJJ0rcJMimpuJQbeKWnopA5S8
        A9Cz1z+T5a6UrEsL5euD6IZF26Gj3AtNPx0o5KjJExQC6o5VERKn/CrW4Dfa4SoBWJZp7IIlA8b
        kjQIP6OfPHaGQgu1dPgREHCO3fyAVHAZ7qi/vDWVoiA==
X-Received: by 2002:a5d:648e:: with SMTP id o14mr36228308wri.69.1636127203652;
        Fri, 05 Nov 2021 08:46:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5k996q02AvLPMDT6zp/eTqKcLpYZhxXm5GjlYrXrZ8v9D6rr2qQHoIq1Cs+RM4w+4Mx4VtA==
X-Received: by 2002:a5d:648e:: with SMTP id o14mr36228265wri.69.1636127203485;
        Fri, 05 Nov 2021 08:46:43 -0700 (PDT)
Received: from localhost.localdomain (lfbn-lyo-1-470-249.w2-7.abo.wanadoo.fr. [2.7.60.249])
        by smtp.gmail.com with ESMTPSA id 6sm8070834wma.48.2021.11.05.08.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:46:43 -0700 (PDT)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Steve French <sfrench@samba.org>, Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jeff Layton <jlayton@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Subject: [PATCH 3/7] Documentation, arch: Remove leftovers from CIFS_WEAK_PW_HASH
Date:   Fri,  5 Nov 2021 16:43:30 +0100
Message-Id: <20211105154334.1841927-4-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211105154334.1841927-1-alexandre.ghiti@canonical.com>
References: <20211105154334.1841927-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This config was removed so remove all references to it.

Fixes: 76a3c92ec9e0 ("cifs: remove support for NTLM and weaker authentication algorithms")
Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 Documentation/admin-guide/cifs/usage.rst    | 7 +++----
 arch/arm/configs/cm_x300_defconfig          | 1 -
 arch/arm/configs/ezx_defconfig              | 1 -
 arch/arm/configs/imote2_defconfig           | 1 -
 arch/arm/configs/nhk8815_defconfig          | 1 -
 arch/arm/configs/pxa_defconfig              | 1 -
 arch/mips/configs/fuloong2e_defconfig       | 1 -
 arch/mips/configs/malta_qemu_32r6_defconfig | 1 -
 arch/mips/configs/maltaaprp_defconfig       | 1 -
 arch/mips/configs/maltasmvp_defconfig       | 1 -
 arch/mips/configs/maltasmvp_eva_defconfig   | 1 -
 arch/mips/configs/maltaup_defconfig         | 1 -
 arch/mips/configs/nlm_xlp_defconfig         | 1 -
 arch/mips/configs/nlm_xlr_defconfig         | 1 -
 arch/powerpc/configs/ppc6xx_defconfig       | 1 -
 arch/sh/configs/titan_defconfig             | 1 -
 16 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/Documentation/admin-guide/cifs/usage.rst b/Documentation/admin-guide/cifs/usage.rst
index f170d8820258..3766bf8a1c20 100644
--- a/Documentation/admin-guide/cifs/usage.rst
+++ b/Documentation/admin-guide/cifs/usage.rst
@@ -734,10 +734,9 @@ SecurityFlags		Flags which control security negotiation and
 			using weaker password hashes is 0x37037 (lanman,
 			plaintext, ntlm, ntlmv2, signing allowed).  Some
 			SecurityFlags require the corresponding menuconfig
-			options to be enabled (lanman and plaintext require
-			CONFIG_CIFS_WEAK_PW_HASH for example).  Enabling
-			plaintext authentication currently requires also
-			enabling lanman authentication in the security flags
+			options to be enabled.  Enabling plaintext
+			authentication currently requires also enabling
+			lanman authentication in the security flags
 			because the cifs module only supports sending
 			laintext passwords using the older lanman dialect
 			form of the session setup SMB.  (e.g. for authentication
diff --git a/arch/arm/configs/cm_x300_defconfig b/arch/arm/configs/cm_x300_defconfig
index 502a9d870ca4..45769d0ddd4e 100644
--- a/arch/arm/configs/cm_x300_defconfig
+++ b/arch/arm/configs/cm_x300_defconfig
@@ -146,7 +146,6 @@ CONFIG_NFS_V3_ACL=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_CIFS=m
-CONFIG_CIFS_WEAK_PW_HASH=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_ISO8859_1=m
diff --git a/arch/arm/configs/ezx_defconfig b/arch/arm/configs/ezx_defconfig
index a49e699e52de..ec84d80096b1 100644
--- a/arch/arm/configs/ezx_defconfig
+++ b/arch/arm/configs/ezx_defconfig
@@ -314,7 +314,6 @@ CONFIG_NFSD_V3_ACL=y
 CONFIG_SMB_FS=m
 CONFIG_CIFS=m
 CONFIG_CIFS_STATS=y
-CONFIG_CIFS_WEAK_PW_HASH=y
 CONFIG_CIFS_XATTR=y
 CONFIG_CIFS_POSIX=y
 CONFIG_NLS_CODEPAGE_437=m
diff --git a/arch/arm/configs/imote2_defconfig b/arch/arm/configs/imote2_defconfig
index 118c4c927f26..6db871d4e077 100644
--- a/arch/arm/configs/imote2_defconfig
+++ b/arch/arm/configs/imote2_defconfig
@@ -288,7 +288,6 @@ CONFIG_NFSD_V3_ACL=y
 CONFIG_SMB_FS=m
 CONFIG_CIFS=m
 CONFIG_CIFS_STATS=y
-CONFIG_CIFS_WEAK_PW_HASH=y
 CONFIG_CIFS_XATTR=y
 CONFIG_CIFS_POSIX=y
 CONFIG_NLS_CODEPAGE_437=m
diff --git a/arch/arm/configs/nhk8815_defconfig b/arch/arm/configs/nhk8815_defconfig
index 23595fc5a29a..907d6512821a 100644
--- a/arch/arm/configs/nhk8815_defconfig
+++ b/arch/arm/configs/nhk8815_defconfig
@@ -127,7 +127,6 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_ROOT_NFS=y
 CONFIG_CIFS=m
-CONFIG_CIFS_WEAK_PW_HASH=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index 58f4834289e6..dedaaae3d0d8 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -699,7 +699,6 @@ CONFIG_NFSD_V3_ACL=y
 CONFIG_NFSD_V4=y
 CONFIG_CIFS=m
 CONFIG_CIFS_STATS=y
-CONFIG_CIFS_WEAK_PW_HASH=y
 CONFIG_CIFS_XATTR=y
 CONFIG_CIFS_POSIX=y
 CONFIG_NLS_DEFAULT="utf8"
diff --git a/arch/mips/configs/fuloong2e_defconfig b/arch/mips/configs/fuloong2e_defconfig
index 5c24ac7fdf56..ba47c5e929b7 100644
--- a/arch/mips/configs/fuloong2e_defconfig
+++ b/arch/mips/configs/fuloong2e_defconfig
@@ -206,7 +206,6 @@ CONFIG_NFSD_V3_ACL=y
 CONFIG_NFSD_V4=y
 CONFIG_CIFS=m
 CONFIG_CIFS_STATS2=y
-CONFIG_CIFS_WEAK_PW_HASH=y
 CONFIG_CIFS_XATTR=y
 CONFIG_CIFS_POSIX=y
 CONFIG_CIFS_DEBUG2=y
diff --git a/arch/mips/configs/malta_qemu_32r6_defconfig b/arch/mips/configs/malta_qemu_32r6_defconfig
index 614af02d83e6..6fb9bc29f4a0 100644
--- a/arch/mips/configs/malta_qemu_32r6_defconfig
+++ b/arch/mips/configs/malta_qemu_32r6_defconfig
@@ -165,7 +165,6 @@ CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_CIFS=m
-CONFIG_CIFS_WEAK_PW_HASH=y
 CONFIG_CIFS_XATTR=y
 CONFIG_CIFS_POSIX=y
 CONFIG_NLS_CODEPAGE_437=m
diff --git a/arch/mips/configs/maltaaprp_defconfig b/arch/mips/configs/maltaaprp_defconfig
index 9c051f8fd330..eb72df528243 100644
--- a/arch/mips/configs/maltaaprp_defconfig
+++ b/arch/mips/configs/maltaaprp_defconfig
@@ -166,7 +166,6 @@ CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_CIFS=m
-CONFIG_CIFS_WEAK_PW_HASH=y
 CONFIG_CIFS_XATTR=y
 CONFIG_CIFS_POSIX=y
 CONFIG_NLS_CODEPAGE_437=m
diff --git a/arch/mips/configs/maltasmvp_defconfig b/arch/mips/configs/maltasmvp_defconfig
index 2e90d97551d6..1fb40d310f49 100644
--- a/arch/mips/configs/maltasmvp_defconfig
+++ b/arch/mips/configs/maltasmvp_defconfig
@@ -167,7 +167,6 @@ CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_CIFS=m
-CONFIG_CIFS_WEAK_PW_HASH=y
 CONFIG_CIFS_XATTR=y
 CONFIG_CIFS_POSIX=y
 CONFIG_NLS_CODEPAGE_437=m
diff --git a/arch/mips/configs/maltasmvp_eva_defconfig b/arch/mips/configs/maltasmvp_eva_defconfig
index d1f7fdb27284..75cb778c6149 100644
--- a/arch/mips/configs/maltasmvp_eva_defconfig
+++ b/arch/mips/configs/maltasmvp_eva_defconfig
@@ -169,7 +169,6 @@ CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_CIFS=m
-CONFIG_CIFS_WEAK_PW_HASH=y
 CONFIG_CIFS_XATTR=y
 CONFIG_CIFS_POSIX=y
 CONFIG_NLS_CODEPAGE_437=m
diff --git a/arch/mips/configs/maltaup_defconfig b/arch/mips/configs/maltaup_defconfig
index 48e5bd492452..7b4f247dc60c 100644
--- a/arch/mips/configs/maltaup_defconfig
+++ b/arch/mips/configs/maltaup_defconfig
@@ -165,7 +165,6 @@ CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_CIFS=m
-CONFIG_CIFS_WEAK_PW_HASH=y
 CONFIG_CIFS_XATTR=y
 CONFIG_CIFS_POSIX=y
 CONFIG_NLS_CODEPAGE_437=m
diff --git a/arch/mips/configs/nlm_xlp_defconfig b/arch/mips/configs/nlm_xlp_defconfig
index c97f00ece828..1c8b73d03263 100644
--- a/arch/mips/configs/nlm_xlp_defconfig
+++ b/arch/mips/configs/nlm_xlp_defconfig
@@ -459,7 +459,6 @@ CONFIG_NFSD=m
 CONFIG_NFSD_V3_ACL=y
 CONFIG_NFSD_V4=y
 CONFIG_CIFS=m
-CONFIG_CIFS_WEAK_PW_HASH=y
 CONFIG_CIFS_UPCALL=y
 CONFIG_CIFS_XATTR=y
 CONFIG_CIFS_POSIX=y
diff --git a/arch/mips/configs/nlm_xlr_defconfig b/arch/mips/configs/nlm_xlr_defconfig
index 60ea102783d9..11acfc173058 100644
--- a/arch/mips/configs/nlm_xlr_defconfig
+++ b/arch/mips/configs/nlm_xlr_defconfig
@@ -411,7 +411,6 @@ CONFIG_NFSD=m
 CONFIG_NFSD_V3_ACL=y
 CONFIG_NFSD_V4=y
 CONFIG_CIFS=m
-CONFIG_CIFS_WEAK_PW_HASH=y
 CONFIG_CIFS_UPCALL=y
 CONFIG_CIFS_XATTR=y
 CONFIG_CIFS_POSIX=y
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index 6697c5e6682f..bb549cb1c3e3 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -1022,7 +1022,6 @@ CONFIG_NFSD=m
 CONFIG_NFSD_V3_ACL=y
 CONFIG_NFSD_V4=y
 CONFIG_CIFS=m
-CONFIG_CIFS_WEAK_PW_HASH=y
 CONFIG_CIFS_UPCALL=y
 CONFIG_CIFS_XATTR=y
 CONFIG_CIFS_POSIX=y
diff --git a/arch/sh/configs/titan_defconfig b/arch/sh/configs/titan_defconfig
index ba887f1351be..cd5c58916c65 100644
--- a/arch/sh/configs/titan_defconfig
+++ b/arch/sh/configs/titan_defconfig
@@ -242,7 +242,6 @@ CONFIG_NFSD=y
 CONFIG_NFSD_V3=y
 CONFIG_SMB_FS=m
 CONFIG_CIFS=m
-CONFIG_CIFS_WEAK_PW_HASH=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_ASCII=m
-- 
2.32.0

