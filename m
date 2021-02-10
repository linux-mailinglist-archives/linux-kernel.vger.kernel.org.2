Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E58315CAA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbhBJB4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235152AbhBJAL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 19:11:26 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CDAC06121F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 16:08:10 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id p12so69794qvv.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 16:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ppuq/KZFrn9+jxLzC4CJINR+3m1F6NDzElghV98D7B0=;
        b=UW3N3OfKTCbQTt3ljB/RqC7aMcXoo7h6HWheSRWT5GgvtpQQgaTEejnPFpacQzaUUs
         ZtcgfGYQIkq3iGaGvlnWLZ5IvQL8JnpX76NTZ80yc0vIROANnYVeUl3UxqdPO/QU2eWu
         PFG5IlNTB9Sy0p33V4IOs8slmuC9I8HFGlnlbLUG3AMR4ev5PAo2Zw4fleek3XdFl4Rx
         rF0CyUapeVpsEpqkU/6LuOHsv2aWumv3GeqwLDzFPDaL71aWjTHkmCdTLcCvHVqPYwFS
         r0nlhEn4mlvM2Zb3xq93XDtVDtCBFKnTexl0OAiq+tzW+DPmqZYaXKLZxVDu1EhQIHqU
         ZK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ppuq/KZFrn9+jxLzC4CJINR+3m1F6NDzElghV98D7B0=;
        b=dOQdoTLh/wsWiqJ7mWTmIOECyoYCC6bIIdCer4yuRAerdIgtAZcrlG0T7/sm6atUP2
         HnKharUs6sJBytmc2I0x5f6XoaNktAmieQsQYNsDiBh5C+B1n5XbBOTCiZYpPvr2RUVU
         tzuATb/XXvDZrX5txo7TuhMaFoknn9o8PWZipEK7v3iVUGecjOx0zC11xcs66x33SozL
         EqMsW2EiScyJ/5hnER73JuCiXIInD/VbP4MMcgZyQ9kH3cQEoe82/Prd6IQ9v/pnZaBe
         E/fSV1XKHzIyQz1Sn0GDf97ObEhBvGo6GB+TNwaCK5HEzrvuVlzhyoLhWUSXEQnZCiuv
         anKQ==
X-Gm-Message-State: AOAM532RZcP2rz+D4AwvZH8JZY8A+bg/mUCsyd/nRtwi5ili72hbJ+/d
        evp0kdC+9aFzXRDONQkhn2E=
X-Google-Smtp-Source: ABdhPJwxeeApg+mF6lT0TKD5wtpDZ21ECd1gynQ2ZJPAlJVfjZKQRcyrX5EMjqyTtpDoJFUdeOpRsg==
X-Received: by 2002:ad4:4431:: with SMTP id e17mr634576qvt.45.1612915689205;
        Tue, 09 Feb 2021 16:08:09 -0800 (PST)
Received: from tong-desktop.local ([2601:5c0:c200:27c6:7408:b5fb:1cd8:ad04])
        by smtp.googlemail.com with ESMTPSA id 196sm265011qkn.64.2021.02.09.16.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 16:08:08 -0800 (PST)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Cc:     ztong0001@gmail.com
Subject: [PATCH v1] x86/vdso: fix CE on non-compatible cflags
Date:   Tue,  9 Feb 2021 19:07:49 -0500
Message-Id: <20210210000749.3952313-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting some compilation error on when using CONFIG_X86_32 kernel
configuration

arch/x86/entry/vdso/vdso32/../vclock_gettime.c:29:1:
 error: ‘-mindirect-branch’ and ‘-fcf-protection’ are not compatible

add -fcf-protection=none when CONFIG_RETPOLINE=y

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 arch/x86/entry/vdso/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 02e3e42f380b..37885336b53f 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -159,6 +159,7 @@ KBUILD_CFLAGS_32 += -DDISABLE_BRANCH_PROFILING
 ifdef CONFIG_RETPOLINE
 ifneq ($(RETPOLINE_VDSO_CFLAGS),)
   KBUILD_CFLAGS_32 += $(RETPOLINE_VDSO_CFLAGS)
+  KBUILD_CFLAGS_32 += $(call cc-option,-fcf-protection=none)
 endif
 endif
 
-- 
2.25.1

