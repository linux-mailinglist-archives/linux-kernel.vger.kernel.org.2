Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0581A34C2DE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 07:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhC2FQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 01:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhC2FQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 01:16:03 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E20C061574;
        Sun, 28 Mar 2021 22:16:02 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id g24so8554675qts.6;
        Sun, 28 Mar 2021 22:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qrac6Y8n7VJp0ETI9GDKy6Zy5spiCaL0e3a0AJeAsJw=;
        b=va5JCICcydH63gN0PTtUNguBea12LnzZBpuWl4fBHLQ24hAod08cBWRTJukCeAyNIG
         2LPFwemzFzMyTDq8ehDNgh0vgD5y28PNIxcL3bFkdPaHZzAAzKrZddZz84PgVB3C/mof
         SkB2txXHV4FbcVYhaYebAfA+zhyGhM6X5s/wCs9mWjwTyqzDCgmDBDfvt8AOoCLNlTjM
         zhxAPm9HQ60IuUZFeLAjgEuKxnLpnWHObPekJ1eI0nqCfL33ARHRdH2ozQUbaWlEw4t5
         DDg1m20U89bAl3rXD4bKj8kbMQSvbrph6/J3chqsfHnwS/ee62jk8thfUDf7ZDUgIhBX
         4JxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qrac6Y8n7VJp0ETI9GDKy6Zy5spiCaL0e3a0AJeAsJw=;
        b=tZl7KR+SnWFSuiB22b0NazWRDFToPLM4RPeoEe9wVl49TGTLfegqq0YP+G5xKWNWBt
         CsA5ihUxfNQLw0iYlkG8Px0VU32/98sAJSLbPNewnlIybPefs1QbbL8JrPsXidwPr9ku
         G0XcumlPWSP7LtSLoHuOsOKnzNRH/sXE+YO6dJ5ZSioUc3H9d+ceZUaVSxX+neA/yjA5
         BlUfqctRK6xsz+XuRnMhFjCf2h9wErsaVRV6YA4eItKdjdCxpfCsyByqLxNeHGebcX/c
         GT+w25gDn10M13XZ/A6slcTSauKkmk7iF0A1Pws6V/8q4OQm8tcs1j1YWZBugOusjmBR
         9D5w==
X-Gm-Message-State: AOAM531/0z6RU5/aBrnCd5j0LCH4/wunbBk187YydFvJRLOkZcjig5oT
        J7zEDEU1N3a4HPN5uc57gxg=
X-Google-Smtp-Source: ABdhPJxDvI2aPHPNx8ed2o0+nvEAL5XLq6bJF3ZSxgmogXSlKVnIHcAPdGgWbWoh+yiF6fBsX2Kyeg==
X-Received: by 2002:ac8:6e85:: with SMTP id c5mr20693234qtv.299.1616994962102;
        Sun, 28 Mar 2021 22:16:02 -0700 (PDT)
Received: from localhost.localdomain ([156.146.37.195])
        by smtp.gmail.com with ESMTPSA id z124sm12993181qke.36.2021.03.28.22.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 22:16:01 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/23] virt: user_mode_linux_howto_v2.rst: Few typo fixes
Date:   Mon, 29 Mar 2021 10:42:47 +0530
Message-Id: <f5a9688aa0254f60512b711fc8813e005d8cb89f.1616992679.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616992679.git.unixbhaskar@gmail.com>
References: <cover.1616992679.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/absense/absence/
s/sripts/scripts/
s/resultion/resolution/
s/desireable/desirable/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/virt/uml/user_mode_linux_howto_v2.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
index 312e431695d9..0e1371c3e235 100644
--- a/Documentation/virt/uml/user_mode_linux_howto_v2.rst
+++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
@@ -317,7 +317,7 @@ Shared Options
 * ``v6=[0,1]`` to specify if a v6 connection is desired for all
   transports which operate over IP. Additionally, for transports that
   have some differences in the way they operate over v4 and v6 (for example
-  EoL2TPv3), sets the correct mode of operation. In the absense of this
+  EoL2TPv3), sets the correct mode of operation. In the absence of this
   option, the socket type is determined based on what do the src and dst
   arguments resolve/parse to.

@@ -726,7 +726,7 @@ kernel.  When you boot UML, you'll see a line like::

    mconsole initialized on /home/jdike/.uml/umlNJ32yL/mconsole

-If you specify a unique machine id one the UML command line, i.e.
+If you specify a unique machine id one the UML command line, i.e.
 ``umid=debian``, you'll see this::

    mconsole initialized on /home/jdike/.uml/debian/mconsole
@@ -1073,7 +1073,7 @@ If you have something to contribute such as a patch, a bugfix, a
 new feature, please send it to ``linux-um@lists.infradead.org``

 Please follow all standard Linux patch guidelines such as cc-ing
-relevant maintainers and run ``./sripts/checkpatch.pl`` on your patch.
+relevant maintainers and run ``./scripts/checkpatch.pl`` on your patch.
 For more details see ``Documentation/process/submitting-patches.rst``

 Note - the list does not accept HTML or attachments, all emails must
@@ -1131,7 +1131,7 @@ This is a typical picture from a mostly idle UML instance
 * The sequence of ptrace calls is part of MMU emulation and runnin the
   UML userspace
 * ``timer_settime`` is part of the UML high res timer subsystem mapping
-  timer requests from inside UML onto the host high resultion timers.
+  timer requests from inside UML onto the host high resolution timers.
 * ``clock_nanosleep`` is UML going into idle (similar to the way a PC
   will execute an ACPI idle).

@@ -1195,7 +1195,7 @@ between a driver and the host at the UML command line is OK
 security-wise. Allowing it as a loadable module parameter
 isn't.

-If such functionality is desireable for a particular application
+If such functionality is desirable for a particular application
 (e.g. loading BPF "firmware" for raw socket network transports),
 it should be off by default and should be explicitly turned on
 as a command line parameter at startup.
--
2.26.3

