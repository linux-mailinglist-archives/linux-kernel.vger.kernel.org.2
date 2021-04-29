Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F192736E4AB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 08:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236966AbhD2GBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 02:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhD2GBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 02:01:14 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B93CC06138B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 23:00:28 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id g26-20020a0caada0000b02901b93eb92373so8707577qvb.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 23:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=zm+O/Qq20Co4E8EekZlwvxA5d89XqR6ilK7cJRDGIHI=;
        b=PQ5LAgrrjZYFZHr0feIUhMAgkQEqJvlq1d3k5jmEznQhOAYGvJjgLThWHXMHCEMJKB
         A3aMYGiO5OiN8eDOwGAoFIO9jRqscIQdxxuiF9S6xdeX7WRhrIb5DIK0ILpcjEYvXtH2
         gF7Pjd3Ac8arM7HO03q3ovdJfiQHOC83YQzlNiQ3ejpCcveipsgum0RZzVrFz+aM0EVR
         y4A5ASujsc4hCZOM6Gkrxcnu9gM5OEIzOI3tNPCC+1yGg69UBLxUzHYe6Qfk0jOhYNbe
         TX+Euz+rbHgqCDbr7rC5S4eHL+lKaAucqRrIXSODfHQlhY9f86QVmBJJNp28llS3tqaw
         tBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=zm+O/Qq20Co4E8EekZlwvxA5d89XqR6ilK7cJRDGIHI=;
        b=T06CB3c9cUMG1k6lv+jwPCI2aGMqCgSM8iRQEy81St87tP1Z83EqL64EUeJ/s1rN0j
         VEaOVeH9E4nmuut3GGvlM6Kb3N/t81+JP2gqZqsu/BH/ZSP3VctgAlXJrHUh/qBsI7Q/
         s00b1BqHRqs7QG/vzEhWzrdDzsXedL0wAMWXrDJakZ5LwhYV7mKXMa5hHPEcLMiWNr45
         AMo/18S4OtgEep9lj9GiL2U9rVpsAQ7izqRJOJOICA+xA5l0v/i3h5pozIcyxhMzUu+E
         2TO2Z/AcRm1BnhpFX3JUOG77omP24wQ2Nx3HWAbohGw9w0biHgRMWV4EUdV2pCT1eRIT
         REYA==
X-Gm-Message-State: AOAM531mcVlJuBJC4nkN3SGmaksM3Ne6vaEqDZlVWGZE8YztPVQ6UJBt
        sxFuFZtABLyfacsLNSgdawabhkV07d3A
X-Google-Smtp-Source: ABdhPJwMje5mNyQ5B2E+CKvcUA1n6pGO1/9kBtlDfk7PZHWFOPAa6JUGwrHd/tRYTsOcmJLVf4nO4PTNFxrm
X-Received: from nandos.syd.corp.google.com ([2401:fa00:9:14:30c1:7a5a:2ec9:29e5])
 (user=amistry job=sendgmr) by 2002:a05:6214:1d0c:: with SMTP id
 e12mr33333658qvd.0.1619676026057; Wed, 28 Apr 2021 23:00:26 -0700 (PDT)
Date:   Thu, 29 Apr 2021 16:00:17 +1000
Message-Id: <20210429155950.v2.1.I2392cf11fb353d10459958100b69d93346fa167c@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH v2] x86: Add a prompt for HPET_EMULATE_RTC
From:   Anand K Mistry <amistry@google.com>
To:     x86@kernel.org
Cc:     Anand K Mistry <amistry@google.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This does two things:
1. Makes the option visible in menuconfig, allowing the user to easily
   disable this option
2. Allows olddefconfig to respect the option if it is set in the old
   .config file

It's not clear exactly why the second consequence is true, but it
appears to be because when the conf tool reads the config file, it only
respects the existing setting if the option is "visible" (see
scripts/kconfig/symbol.c:381).

Signed-off-by: Anand K Mistry <amistry@google.com>
---
This patch was previously discussed at
https://lore.kernel.org/lkml/20210204132043.1.I2392cf11fb353d10459958100b69d93346fa167c@changeid/
Sending as a v2 because a merge conflict exists with commit
3228e1dc80983 ("x86/Kconfig: Remove HPET_EMULATE_RTC depends on RTC")

Changes in v2:
- Rebase
- Fix typo in commit message

 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0fc82237414d..55e652aa42d1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -896,6 +896,7 @@ config HPET_TIMER
 
 config HPET_EMULATE_RTC
 	def_bool y
+	prompt "HPET RTC emulation"
 	depends on HPET_TIMER && (RTC_DRV_CMOS=m || RTC_DRV_CMOS=y)
 
 # Mark as expert because too many people got it wrong.
-- 
2.31.1.498.g6c1eba8ee3d-goog

