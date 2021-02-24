Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDFF323820
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 08:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbhBXH4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 02:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhBXH4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 02:56:51 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74442C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 23:56:11 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id v64so828382qtd.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 23:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=piJQ2+eVg7Z4RtyyaGqKuQT5hzrDLRvoDnnVb4fGjF8=;
        b=ZKxcX7ci+X9BoqAJguVITDxBXaOs0nGZWnSD8GyXV8+ZXAE972NYOlkdRyqGrq3/Kq
         ig8kXx+QWZp4gGOt11Xb2bkQvXkDBmx/0rSRjEOKd6UWdPpT+okWRUpPDZlouNA/d4d+
         4S+GQ+0hP1y28/6ROgy6oZ/qcn5PEoOWu6KzbAzCzzK4PDXCSi0GsugdEYmcqLY8rtWv
         TADSRWlcFvTZ/auDcEsJzoJK1efPsUQQyNwYlCGHQD7ikdYZR+yfWGoMPxop52jsBfOu
         53e/HiZIMaHT5xGRh5PPl7uz14mSI/sVwFRkxYeDJV3PHGiBTHqyol79sA1bo1MEAkA5
         Wapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=piJQ2+eVg7Z4RtyyaGqKuQT5hzrDLRvoDnnVb4fGjF8=;
        b=ekjIq3oKxtEieZA8yCEXZ0ni6IxJbXTw5yqNtpayNJHXyYtWhvQwsDWKYmKp4tZ51I
         Zw/UR8zuGFfXcDS3V5lihnN3uX5wpYBFCkU20Tg7d6kw3EiBkIWkfFx0ol7f0Dsrge1x
         cTtU6nP7xgmf8oCQYMynCVMn8K0GqjBjTR8dArkEThvOZZqUJCB2MMJfxloQMJkHCDMB
         RGUvuptFqzjw3dt8s2VlNHUsBUG94hFudm3OBLVHO8hLnWeqtJw6mvSqeHCIZtmI3H0E
         /YBdvpRIkt2xnz8A7ccoTnYXtm6RUi3AGa9pxgtKk1SewNtd5EGiNMbFG1cAsM0arKfO
         MaVA==
X-Gm-Message-State: AOAM531mlgG7bEp6ZpNhhGa4stbf/k+wPSzksKgdHaQYmTnPRXnzdsxp
        8slK9a4FFoFibjD+TDNpdL/YNixt8Ul6RbP5
X-Google-Smtp-Source: ABdhPJwDKkaHSAlJ7clDw+zIhE/tpefzRxBFPn/L3xDOvQo5JYZDZ0XnhiQ25PIJpDfXIHl9llXV0A==
X-Received: by 2002:ac8:5ac9:: with SMTP id d9mr27112093qtd.123.1614153370751;
        Tue, 23 Feb 2021 23:56:10 -0800 (PST)
Received: from localhost.localdomain ([156.146.55.69])
        by smtp.gmail.com with ESMTPSA id i75sm960295qke.47.2021.02.23.23.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 23:56:09 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        christophe.leroy@csgroup.eu, npiggin@gmail.com, jniethe5@gmail.com,
        alistair@popple.id.au, mikey@neuling.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] arch: powerpc: kernel: Change droping to dropping in the file traps.c
Date:   Wed, 24 Feb 2021 13:25:47 +0530
Message-Id: <20210224075547.763063-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/droping/dropping/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/powerpc/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 1583fd1c6010..83a53b67412a 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -405,7 +405,7 @@ void hv_nmi_check_nonrecoverable(struct pt_regs *regs)
 	 * Now test if the interrupt has hit a range that may be using
 	 * HSPRG1 without having RI=0 (i.e., an HSRR interrupt). The
 	 * problem ranges all run un-relocated. Test real and virt modes
-	 * at the same time by droping the high bit of the nip (virt mode
+	 * at the same time by dropping the high bit of the nip (virt mode
 	 * entry points still have the +0x4000 offset).
 	 */
 	nip &= ~0xc000000000000000ULL;
--
2.30.1

