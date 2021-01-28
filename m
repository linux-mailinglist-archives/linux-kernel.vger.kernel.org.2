Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7775307DF5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbhA1S2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbhA1S0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:26:12 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F562C061354
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:24:54 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id k24so2402214qtc.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:cc;
        bh=WO1Ps+Nvd/JhtfCCjwBjp1ZIkFI1epnqyV7iKoI3o6M=;
        b=kRyxNq1z6aP1oLR+T1rDCvOOEGgGBd0NT0WYQCd9JMMaGJ9KZ64ABn23wgetcIYIqk
         UgxIRZh2IxqO8TLPZAYS8UscufK7YBfdmAnzf6Thg7OwTRAEIGh+lDriUPVXWyxVBiTP
         vSV+VOHOKLatUnPHfVn57s9k68KhZe3ouL0kZrzVPeKvib0crdbJF5QcUQ1R/vr/lvxZ
         5FoHOJuQQruMx2fhUaWETT1ilWgTRt+Oqxwg68GfvRRZWi93epDFMlQxz0rY8QA5fdyj
         Y+WmVV46ZuoEnJrUkdOejUENnnnRes25LJGmKOMoa3ThqhEgE87zWQ8qkxgyvDzhhRdC
         5vGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=WO1Ps+Nvd/JhtfCCjwBjp1ZIkFI1epnqyV7iKoI3o6M=;
        b=CPeusdhGGB10dGbbR9QECToG6RIdLWhgjg82N02/IA9kKUK+p96hSY8PvtzYoGYyVG
         +WlYuk/6sLIjK4LH+8Hv+3RU1yP1pTW2TEaP5asryVcMhyEdIaBpcBClr3Vuv1K6+qLJ
         ZS4jfYCul/oHMSjjVh9ZiZJ2S1AxibGN+ATPX3ZW6WCHBqSfvZ0rMYxCCYO0nMGs3yHM
         OLEhkLwItPreindPGNrECOETbTMqBq2BbhOuhTuo1VT1WOElhGbwJO8hcVBdL6q3D4Cf
         4VRkTOtmt0gz+JPD42ZFFkxRbdnD9xPP6KGOSmnK9zUtvayz4IYwUtTPCDe2XEq+ZG/6
         4/fg==
X-Gm-Message-State: AOAM532dVG3ufwxGt+fpIkUCsmEMc1LjNJ+OUITr06l2dwXqD/7LO4HI
        jaj5FkIUiS3ZwnShMNds2jYqBqTekUdYnJSiMQ==
X-Google-Smtp-Source: ABdhPJxHCqtX2ZHgnqn1x3DYKD86aE5WR934LTPVMRYPiTVg9KKNFMi3ScBW4vQ0zl65Lu8rIgzHGPhMjlBRyKwGrA==
Sender: "kaleshsingh via sendgmr" <kaleshsingh@kaleshsingh.c.googlers.com>
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:10:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:ad4:4b6d:: with SMTP id
 m13mr614841qvx.56.1611858293408; Thu, 28 Jan 2021 10:24:53 -0800 (PST)
Date:   Thu, 28 Jan 2021 18:24:31 +0000
In-Reply-To: <20210128182432.2216573-1-kaleshsingh@google.com>
Message-Id: <20210128182432.2216573-3-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20210128182432.2216573-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH 2/2] dmabuf: Add dmabuf inode no to fdinfo
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     jannh@google.com, jeffv@google.com, keescook@chromium.org,
        surenb@google.com, minchan@kernel.org, hridya@google.com,
        kernel-team@android.com, Kalesh Singh <kaleshsingh@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dmabuf inode number allows userspace to uniquely identify the buffer
and avoids a dependency on /proc/<pid>/fd/* when accounting per-process
DMA buffer sizes.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 drivers/dma-buf/dma-buf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 9ad6397aaa97..d869099ede83 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -414,6 +414,7 @@ static void dma_buf_show_fdinfo(struct seq_file *m, struct file *file)
 {
 	struct dma_buf *dmabuf = file->private_data;
 
+	seq_printf(m, "dmabuf_inode_no:\t%lu\n", file_inode(file)->i_ino);
 	seq_printf(m, "size:\t%zu\n", dmabuf->size);
 	/* Don't count the temporary reference taken inside procfs seq_show */
 	seq_printf(m, "count:\t%ld\n", file_count(dmabuf->file) - 1);
-- 
2.30.0.365.g02bc693789-goog

