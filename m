Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9EED3F12D7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 07:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhHSFmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 01:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhHSFl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 01:41:59 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F653C0613D9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 22:41:24 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id f3so3274549plg.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 22:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X40twNuUzE3XmXzdn7oC63jTsAYe8TLwgZJqPK62/Bw=;
        b=PpGbgxwRwy9qvrBfzI5BPxYXv+Me68BOJn/inChLaH5pJiGm3ZH3LTsTqN7I5qMCjb
         U1sQl8iUXqJsenXuolEo0eLTYm0xosg3mxOQNDMgo7zh+2h2ajeS84kNDMta/3jM64J7
         Ba3NwwTlOG5N1OlKGzNN1UM8Wc2CGNqhb/B9v0S7NHv8qHMxADsGxFBPAN29Yehdxb6i
         Uhdbcu0wUPmzzj10NPK25q9KKs7diD0jDoVFKjNsumplzyiqmXkxhF8Z/9DnDv56FiKc
         ckKbBvW+yZjP9qp0iaDEQH/p5p11czoQx72KR0U9NQr31iy5X5tbeunFATtQDlKZNPuT
         iXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X40twNuUzE3XmXzdn7oC63jTsAYe8TLwgZJqPK62/Bw=;
        b=LckOkv0P1zgyYnTn4JJILDcDss40GdxXyHAK1In6izkApv/Wy6P3Ws7svx4EpOhKk3
         2ftiM67CAIXtAxFXYck1al5IQQ1nCsABBauUbykjXk3cl6pog8cR7BVqnxooxU88vdzu
         Z5fI88TpWoNmm1klQtPXRA4X9raLK7a3RWXazRQCmRYvepfb6KS1ch9BUSEB1sHwIoGP
         CuzXQt7TqePcj0sFyYlv1LlRtdxlL+2uTH9xnnF8ZE4rrp33zMrEI+2aZmvu0XDoQiyI
         BF2XdmbyRDTrhqhgfrD0hNXLA0G5nMYQpGWDOuhgniGMh+crWXcV5G0In1XnaLy3onLa
         BkMA==
X-Gm-Message-State: AOAM532CDB4uaiupxKi5YY5oKzThvMMVk58Qyw+bIx6bZZgPFKz4nfmj
        Kr6pe/8QHkdlzqCYGPAaSh0=
X-Google-Smtp-Source: ABdhPJzSc2ESnEMB8pnICcxfybX3I1DbquopD7QOl27N2POjjalvV22HoQM/H18rVmTmceMyCTSf8A==
X-Received: by 2002:a17:902:8f8b:b029:12c:d085:7918 with SMTP id z11-20020a1709028f8bb029012cd0857918mr10423716plo.10.1629351683886;
        Wed, 18 Aug 2021 22:41:23 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id s188sm1708312pfb.4.2021.08.18.22.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 22:41:22 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     naoya.horiguchi@nec.com, osalvador@suse.de, tdmackey@twitter.com,
        david@redhat.com, willy@infradead.org, akpm@linux-foundation.org,
        corbet@lwn.net
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH 3/3] mm: hwpoison: dump page for unhandlable page
Date:   Wed, 18 Aug 2021 22:41:16 -0700
Message-Id: <20210819054116.266126-3-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210819054116.266126-1-shy828301@gmail.com>
References: <20210819054116.266126-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently just very simple message is shown for unhandlable page, e.g.
non-LRU page, like:
soft_offline: 0x1469f2: unknown non LRU page type 5ffff0000000000 ()

It is not very helpful for further debug, calling dump_page() could show
more useful information.

Calling dump_page() in get_any_page() in order to not duplicate the call
in a couple of different places.  It may be called with pcp disabled and
holding memory hotplug lock, it should be not a big deal since hwpoison
handler is not called very often.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/memory-failure.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 7cfa134b1370..60df8fcd0444 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1228,6 +1228,9 @@ static int get_any_page(struct page *p, unsigned long flags)
 		ret = -EIO;
 	}
 out:
+	if (ret == -EIO)
+		dump_page(p, "hwpoison: unhandlable page");
+
 	return ret;
 }
 
-- 
2.26.2

