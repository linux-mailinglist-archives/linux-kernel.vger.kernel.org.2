Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739F233CD72
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbhCPFnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbhCPFmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:42:53 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF6AC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:42:52 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id b130so34114439qkc.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s2AHE5KgfzAAH5zNcxRm5sRC9qXtoJfIPDTFtxRJkJE=;
        b=esS4i4m1rhO168bdtswjnV/uzO052YVQobGAuT2vWpni3+nQMUszsZmHVoRdYJoXQp
         FDlgdRN53cgQ7N9JIOsrh8G+V5Jdje5WrpvB0VqeMNrj/ms0shlBB8r6mfGzVnvScYow
         RX+ximTF+5FE6foFRqE4ZbCgptwoVCXAfZhvwKZTCps5/PYpqSOQov6BcnwOgq3tw0yV
         w5VBzdd7X5O9hVAUOfVV0hZdj+fzCFh/4Wm9Yti3yQTIFLIrr2pCzSCfxhMLtwMuoqHl
         MKFnHu2eKtxB2snnKeHCLZkHTg//YIGAWVfkImGbI4crBQ665ojjCzRYJRHlOvhQMOXW
         JXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s2AHE5KgfzAAH5zNcxRm5sRC9qXtoJfIPDTFtxRJkJE=;
        b=mjVr+bC66t0axiM8zE+umAGCdlHaKq5M9PShjofXxe9jFJeq/6+l2SZw1KX+lsh6Cf
         CNVviXHe4JznPh0SzzpZZSAW8PX1L3qRXmI4ZM552O6dlLpFtWs3quMkYpjO518T0TsD
         I9sSvgZoDNcwRrfZBhkVBFdTU40mcaKUoKoeELGuWcfDm4ib5VsPJBufW7uorOdyc8eA
         xchVNb9i1LS72ibH3qq+HSiBQ4RRSv4UuYBapnLpolwGKwVXEw5uREnwy4leGyebdNYl
         OQBm4bO4GjLn3EKc15RUadWDxKxHN/GfIcfQBt8OgJN9C5MnLmOsoyEaoIw5qwNq80Dh
         7ong==
X-Gm-Message-State: AOAM533Dux4P/cNzZHDaf8Ceh+tmyFuijfQLyb/nibs9Zosr0P/hskBj
        iZTOO9MhUiQyfzpGNJNkfJk=
X-Google-Smtp-Source: ABdhPJx7XQaXT/cOV1M2T6jFOxT9aF024CC6BjRNi0MHm09e9sJ0oWhWwbUrmvJRKF69bBpsEFmA2w==
X-Received: by 2002:a05:620a:84a:: with SMTP id u10mr29335842qku.389.1615873372092;
        Mon, 15 Mar 2021 22:42:52 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.45])
        by smtp.gmail.com with ESMTPSA id c19sm14196680qkl.78.2021.03.15.22.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 22:42:51 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH V2] x86: events: intel: A letter change in a word to make it sound right,in the file bts.c
Date:   Tue, 16 Mar 2021 11:12:27 +0530
Message-Id: <20210316054227.962533-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/kernal/kernel/

 A punctuation added too.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Changes from V1:
 Punctuation missed, added as per Randy's finding

 arch/x86/events/intel/bts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 731dd8d0dbb1..1ba93c40fc54 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -594,7 +594,7 @@ static __init int bts_init(void)
 		 * we cannot use the user mapping since it will not be available
 		 * if we're not running the owning process.
 		 *
-		 * With PTI we can't use the kernal map either, because its not
+		 * With PTI we can't use the kernel map either, because it's not
 		 * there when we run userspace.
 		 *
 		 * For now, disable this driver when using PTI.
--
2.30.2

