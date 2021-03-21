Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B94343200
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 11:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhCUKri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 06:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhCUKra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 06:47:30 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E9BC061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 03:47:29 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a7so16576048ejs.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 03:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=GtG4fafcFT8vFQnxdOYJcbp+otAWq3Vk5HwAWjktepk=;
        b=pgwAmTK7I4+WTQMJXVtnchxKDW0l9SEEqGP3YMj/XrtfNDDgxOvbCfe6r3S5whvDpd
         OAuFqcBPP95ujl8SxdT8kjP+5NrIvu5YTqQK+gL8bjYIXw+Wx/coifYeocAPyN0MOVhF
         yCJgfHfPyH+zf+7uubuZBzowGKPXVLN0H/bsbEEVzMKkKc3uTNR6N7cvrzbWnKV+EGXW
         9O//duji2Z5jR7j53Awqkvf5jQkhaM3jUM3AfRsZVI8Y3WakyneCmMYCws8KeFCPjlCF
         /FsxX8TPY5pLnKdydQhSO4SqDSVBkEnUqNF0d8sotejCUNUqtm3tpAYlOqLeY0ubeH3r
         fCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=GtG4fafcFT8vFQnxdOYJcbp+otAWq3Vk5HwAWjktepk=;
        b=twnCU+pTRQgwjAYFbV7PuteAmVMhoAxMYzdpLxqAFWex05tlObaO55umWiE7auymAV
         PUkFAICV6+RHSAP+xKer9w15FgH/AZ5C0Twk959mxkzW8pvzkIUhRMH2a1FCBbKl/0Ec
         8UR8VFPcFSNh7VrfG/pkxcnMcvrU94r6JpAwZihYf3c7qrq3uBG5ZVvYS1PkyGK3mmRo
         I7zrG04cFKTnLV/cEnkHBfHSebznbJ2Hem6/NpPVHwhVqxCYRcOO7gEQxEQKzGkF+9wH
         LHQ0lE6lga0dE5p2mOz049fxGjpSwDSkYje8owgqXGxBNZKBcX8afARK3fdVyEAND7el
         /dqQ==
X-Gm-Message-State: AOAM530qFyh6n+APuNT2sA1teVdzO/UWquE6yOlVcQ1GUUc9HVKVu4HT
        Rfc75k0A4s1xLlFkiKzXivbqDmYXIB8=
X-Google-Smtp-Source: ABdhPJwh6Bza2/jQnVPL2dFO9K2ZLhEWz+991dcvjAFUc63OuvJ924Ss/YrJmckcjDE0D3hy4UXOww==
X-Received: by 2002:a17:906:6817:: with SMTP id k23mr13660995ejr.6.1616323647164;
        Sun, 21 Mar 2021 03:47:27 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id e4sm6870821ejz.4.2021.03.21.03.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 03:47:26 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 21 Mar 2021 11:47:24 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] EFI fixes
Message-ID: <20210321104724.GA3399@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest efi/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-2021-03-21

   # HEAD: 429257a430a0e81e9979256e0db718e35e7d9cee Merge tag 'efi-urgent-for-v5.12-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi into efi/urgent

EFI fixes:

 - another missing RT_PROP table related fix, to ensure that the efivarfs
   pseudo filesystem fails gracefully if variable services are unsupported,
 - use the correct alignment for literal EFI GUIDs,
 - fix a use after unmap issue in the memreserve code

 Thanks,

	Ingo

------------------>
Ard Biesheuvel (1):
      efi: use 32-bit alignment for efi_guid_t literals

Lv Yunlong (1):
      firmware/efi: Fix a use after bug in efi_mem_reserve_persistent

Shawn Guo (1):
      efivars: respect EFI_UNSUPPORTED return from firmware


 drivers/firmware/efi/efi.c  | 3 ++-
 drivers/firmware/efi/vars.c | 4 ++++
 include/linux/efi.h         | 6 ++++--
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index df3f9bcab581..4b7ee3fa9224 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -927,7 +927,7 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 	}
 
 	/* first try to find a slot in an existing linked list entry */
-	for (prsv = efi_memreserve_root->next; prsv; prsv = rsv->next) {
+	for (prsv = efi_memreserve_root->next; prsv; ) {
 		rsv = memremap(prsv, sizeof(*rsv), MEMREMAP_WB);
 		index = atomic_fetch_add_unless(&rsv->count, 1, rsv->size);
 		if (index < rsv->size) {
@@ -937,6 +937,7 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 			memunmap(rsv);
 			return efi_mem_reserve_iomem(addr, size);
 		}
+		prsv = rsv->next;
 		memunmap(rsv);
 	}
 
diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index 41c1d00bf933..abdc8a6a3963 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -484,6 +484,10 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
 				}
 			}
 
+			break;
+		case EFI_UNSUPPORTED:
+			err = -EOPNOTSUPP;
+			status = EFI_NOT_FOUND;
 			break;
 		case EFI_NOT_FOUND:
 			break;
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 8710f5710c1d..6b5d36babfcc 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -72,8 +72,10 @@ typedef void *efi_handle_t;
  */
 typedef guid_t efi_guid_t __aligned(__alignof__(u32));
 
-#define EFI_GUID(a,b,c,d0,d1,d2,d3,d4,d5,d6,d7) \
-	GUID_INIT(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)
+#define EFI_GUID(a, b, c, d...) (efi_guid_t){ {					\
+	(a) & 0xff, ((a) >> 8) & 0xff, ((a) >> 16) & 0xff, ((a) >> 24) & 0xff,	\
+	(b) & 0xff, ((b) >> 8) & 0xff,						\
+	(c) & 0xff, ((c) >> 8) & 0xff, d } }
 
 /*
  * Generic EFI table header
