Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDBC306B0D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 03:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhA1CWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 21:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbhA1CVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 21:21:10 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F893C061756
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 18:20:30 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id s2so3804347otp.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 18:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WaWfUsxlwLjtJJJs7BCjaV3recgbn4DsBXlNrfMz+oo=;
        b=saVXRoDxBhtwjjEtBk2HabAxNFKMEVhPljlcyyH0GwrH+q8TICzDWdY3SaYxc38oH9
         Pv1Fw9vG0xUXjxezCkklUNGxZ7Gm5ExDHgbB+GHD3MQZaLwt/XZbx8IJjOdl8T8NrArm
         nDB6kSOaONxbI3tAboDMfz7RGL+tk46gIncXAJDcGiuoWsn7qC3G+yqIrj5TO2qYq1EE
         yf2gMyivcRViM57zTQ04U6OsGxhoXsdIp/yNn+6Qwfis5YZErsV5IQ1vhKxSuh3Ztr3p
         4Ph6WA4XvPV4fCWUP0WxFkZ0w9lPyPs1Lvs2S8UqsFflgTWvUOFunDseoEdKCuwF1dy7
         Jmag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WaWfUsxlwLjtJJJs7BCjaV3recgbn4DsBXlNrfMz+oo=;
        b=hdZo8u81VuKDr5E7umChz+L6wRsy/eb+p2ixDOspIQNkE/hgylMxQ2XKimXMyxsZXv
         VwyyZY/HlcAKy4zoOmryCOvhDoB+06Xt4+KUKKiEDGJIk7GZ+IYL/FHOoV2rd0tGycSr
         ImimGhBubqL3TyTiQUNYs73+q1CdyEOhLMDcXzpC2QLVKw9S/olpwi0G0bVntJBRrbLg
         F1W1ZaEAha2k+wO/e/sUwf371LbMrgAPEIYYESPS7DB1q8ulOF3CKV6v/IaDRKaBoP/e
         bzjBYx2tFPStY2iio2SVb3I4WY5gcv8ysv6TfD73kE5pxfTjz0jAVW/sHKJv6ua9I/47
         RZxQ==
X-Gm-Message-State: AOAM533P0hbsXgWrbJVwv28Uyk9RR3AHhrXTbrwM1nE0+uQurK1DQwgR
        X4rbSeu/b1jO4624Qbab+JA=
X-Google-Smtp-Source: ABdhPJz8AWLveugxt8Vw+jfjDoAFWZOcLN/f5niUp0wrxR0UbOYISJvgKpGp5cnvecembCJTwQdczA==
X-Received: by 2002:a05:6830:2f3:: with SMTP id r19mr9873087ote.299.1611800429873;
        Wed, 27 Jan 2021 18:20:29 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id m10sm731246otp.19.2021.01.27.18.20.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 18:20:29 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     david@redhat.com, vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 3/3] printk: dump full information of page flags in pGp
Date:   Thu, 28 Jan 2021 10:19:47 +0800
Message-Id: <20210128021947.22877-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210128021947.22877-1-laoar.shao@gmail.com>
References: <20210128021947.22877-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the pGp only shows the names of page flags, rather than
the full information including section, node, zone, last cpupid and
kasan tag. While it is not easy to parse these information manually
because there're so many flavors. Let's interpret them in pGp as well.

- Before the patch,
[ 6312.639698] ERR: Slab 0x000000006d1133b9 objects=33 used=3 fp=0x000000006d0779d1 flags=0x17ffffc0010200(slab|head)

- After the patch,
[ 6315.235783] ERR: Slab 0x000000006d1133b9 objects=33 used=3 fp=0x000000006d0779d1 flags=0x17ffffc0010200(Node 0x0,Zone 0x2,Lastcpupid 0x1fffff,slab|head)

Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 lib/vsprintf.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 3b53c73580c5..bd809f4f1b82 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1916,6 +1916,46 @@ char *format_flags(char *buf, char *end, unsigned long flags,
 	return buf;
 }
 
+struct page_flags_layout {
+	int width;
+	int shift;
+	int mask;
+	char *name;
+};
+
+struct page_flags_layout pfl[] = {
+	{SECTIONS_WIDTH, SECTIONS_PGSHIFT, SECTIONS_MASK, "Section "},
+	{NODES_WIDTH, NODES_PGSHIFT, NODES_MASK, "Node "},
+	{ZONES_WIDTH, ZONES_PGSHIFT, ZONES_MASK, "Zone "},
+	{LAST_CPUPID_WIDTH, LAST_CPUPID_PGSHIFT, LAST_CPUPID_MASK, "Lastcpupid "},
+	{KASAN_TAG_WIDTH, KASAN_TAG_PGSHIFT, KASAN_TAG_MASK, "Kasantag "},
+};
+
+static
+char *format_layout(char *buf, char *end, unsigned long flags)
+{
+	int i;
+
+	for (i = 0; i < sizeof(pfl) / sizeof(struct page_flags_layout) && buf < end; i++) {
+		if (pfl[i].width == 0)
+			continue;
+
+		buf = string(buf, end, pfl[i].name, default_str_spec);
+
+		if (buf >= end)
+			break;
+		buf = number(buf, end, (flags >> pfl[i].shift) & pfl[i].mask,
+			     default_flag_spec);
+
+		if (buf >= end)
+			break;
+		*buf = ',';
+		buf++;
+	}
+
+	return buf;
+}
+
 static noinline_for_stack
 char *flags_string(char *buf, char *end, void *flags_ptr,
 		   struct printf_spec spec, const char *fmt)
@@ -1929,7 +1969,7 @@ char *flags_string(char *buf, char *end, void *flags_ptr,
 	switch (fmt[1]) {
 	case 'p':
 		flags = *(unsigned long *)flags_ptr;
-		/* Remove zone id */
+		buf = format_layout(buf, end, flags & ~((1UL << NR_PAGEFLAGS) - 1));
 		flags &= (1UL << NR_PAGEFLAGS) - 1;
 		names = pageflag_names;
 		break;
-- 
2.17.1

