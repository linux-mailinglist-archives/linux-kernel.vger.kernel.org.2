Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86CF2424585
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 20:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238955AbhJFSEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 14:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbhJFSD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 14:03:59 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B37C061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 11:02:07 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id cs11-20020a17090af50b00b0019fe3df3dddso4114776pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 11:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EG8j31Vcr06OO0AkEnbVwb8A1TK2ZuJTLW5vJccv8+U=;
        b=kyQfZHTuGRS3x7+q3DhtYRabFYQAZrB1mJCuvDtH0mtIVLxEp9hNPNBVAAN+IX2wqk
         NT3vGYdNyZVngtG5ikkNHpFN609iBkyuh+oeZfjl7lW5OiiZzRUzXS0+Zrbn5Cj8aAzA
         hoewaqxmzmvm1GgQcd5QguIU3FyNTea9K8U2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EG8j31Vcr06OO0AkEnbVwb8A1TK2ZuJTLW5vJccv8+U=;
        b=XkPvs8YGrNPmnA6G9C9/GI8O2I2ei6Pu3BXHsFdTE6XgAhUVXb0JP3/N1WEowl+F8h
         CsFAnMM+ZsTfnLv4VpC6gqcuI9DvyCTcuv1coryrk+KcclhzyR6VoBxMq0+Eazbl/P6p
         GlHNQtlHKpbH9xFS0EU75pFZ0DFKD6QEgo7fIYwlNfT5/UeQrfSwRH76Q29R0Wezfx/v
         JoRuAksG1OLDXNFD1+y/A9DFU+BY6kfOYaerOgtfxsFiVZUBnzhAG4p3/Kcye6G6jaVF
         37N2uwBDn3XuMLe2IVeP0quBQb6ep6skzjTHjaMNW67YHkcR3jCYP+DykcwqHnhegwaz
         E2wQ==
X-Gm-Message-State: AOAM532wHgPcogcxFHj/shn2X3hhAXTSBerOLBNf3O/+Dz2WxIhXv2zh
        TZtRcX03Q04KEUK5c8H6wJ8g5w==
X-Google-Smtp-Source: ABdhPJwqIGhj94Z4ChDqPf3S3GPhPLzwMf56i1qKB0Ek4TOHgDRWvJKzVHuMHSC0/GVQpPuDvZVk/A==
X-Received: by 2002:a17:902:aa88:b0:13a:95d:d059 with SMTP id d8-20020a170902aa8800b0013a095dd059mr12467927plr.65.1633543326814;
        Wed, 06 Oct 2021 11:02:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u12sm20908080pgi.21.2021.10.06.11.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 11:02:06 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add "exec & binfmt" section with myself and Eric
Date:   Wed,  6 Oct 2021 11:02:00 -0700
Message-Id: <20211006180200.1178142-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1037; h=from:subject; bh=jlsQHm8XF6DHzxt252D/9lsthhPYy3DOfgA1oJ7BBOw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhXeSXH/CxB/y5SqE2evX8LGc7ACYrGw3tQMmBRWjg AVLxizCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYV3klwAKCRCJcvTf3G3AJp2bD/ wNmn1qQtT+QZu4DMDVwK2/i1mB14z/WYMDA28LxFDVQOYP8gs5jv+jjVfPP0foOfM4ftnrIDsdaozc sq22UDQfs68bVgMl5lv6R9u28m0YR34PiaBosKsBfwN8c4pQ7Vcl+4n52RO0xG62hgHdz/M2q8oi/L xHjB+IBXiaCPyG7ViEPF12AEOIGsbGJxpEtych+5bpp6aiQ0PHxQhCO6XA5N1nRs8GuAOWM8OfRsmo Ha7MfK/2cgUtN3rxtZPitucPLKP2+TwBIbTMnfJ8RIUrcKNy/xUU6XH21Ib9LXIr9eXMRcQQexrV92 cfR3+tUvz90Vs7Za7KKLS1TYT5hFGsOVDyTdOIPZjHGJGwkPWFJEvHh+IN+q43tRb7jTQ3DeQKQki+ QzYWfWQKch2vZx8Ym6LcTryFJsiSt+OHNq5UhLedweZ+zy/cJ6K2KOHrQRZCufqw4VJKqHhDlNtpXA QOVzsQJlZQuicB0FxzRDf7CcbpN+Cgdib0k0VQ99jId9vjvjZocVhcSwUoyHfltJ3MMYInKI4XuD/U QkajEB6ZV5TtfS3oUQBeyS5gCadoBq+Twfz0FvUHTHO5dQXED4J7RIjHDqrt+TukT2/3tU/yfFJvmN ltwqWWAyPL6e6uM927ZV/rDxVdM1dlsdAfD3aoT8csskbbMcwPqsnMNqF8hQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like more continuity of review for the exec and binfmt (and ELF)
stuff. Eric and I have been the most active lately, so list us as
reviewers.

Cc: Eric Biederman <ebiederm@xmission.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index abdcbcfef73d..385b12e37c43 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7020,6 +7020,20 @@ F:	include/trace/events/mdio.h
 F:	include/uapi/linux/mdio.h
 F:	include/uapi/linux/mii.h
 
+EXEC & BINFMT API
+R:	Eric Biederman <ebiederm@xmission.com>
+R:	Kees Cook <keescook@chromium.org>
+F:	arch/alpha/kernel/binfmt_loader.c
+F:	arch/x86/ia32/ia32_aout.c
+F:	fs/*binfmt_*.c
+F:	fs/exec.c
+F:	include/linux/binfmts.h
+F:	include/linux/elf.h
+F:	include/uapi/linux/binfmts.h
+F:	tools/testing/selftests/exec/
+N:	asm/elf.h
+N:	binfmt
+
 EXFAT FILE SYSTEM
 M:	Namjae Jeon <linkinjeon@kernel.org>
 M:	Sungjong Seo <sj1557.seo@samsung.com>
-- 
2.30.2

