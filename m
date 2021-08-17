Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2193EF2B5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 21:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbhHQTiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 15:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhHQTiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 15:38:18 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FDFC061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 12:37:45 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id u7so23452804ilk.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 12:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tF0/t6UJlg1X0aiRKm2jEmga3jwWr3uOEX8C/+XWZ6k=;
        b=TsHR5msfMvRoVhrJOk1YsYCS1sbRimlK4IvSSRrj5ML3qOrhetQPz9laRhnOC9f7w6
         iCn62H7ZjUkz8vg90vRJGT63C1BHtr79rD84pKDYgQ9tg3BS+uS4egEEqIkVTC3qtfGs
         NM9yuNvUqbfoBfE41xGfgyROZbkeAdF9J8JiVQgtTFu8h7MJvKRLSrT94Ffxr7rGoLT1
         cgYCQ2itwlQbWSlEYzbE1R4ynYi/EmmkhoYa52OmEegIEbaB3ssKcw7/MxM17euGCtTF
         KKRpgouYgzKbH6zfvZbkPB+uem9un3rtVoGLphVMlDtV8Cg76FhwWi2FjoYWDB4DPYoA
         CmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tF0/t6UJlg1X0aiRKm2jEmga3jwWr3uOEX8C/+XWZ6k=;
        b=U9qvPuSJnoAjZdy+MjJX+PcgD6X+A1f0digAbB11hsQwwuDqbUE1PrP7YldXVGG9je
         wZvpG0xha48lsV2ewnnQ3BVlkX4lAXfkFBLu6g3IWhGZbDXrUbA+x2mxOh6yhVJSmFC1
         dOHYoSngRzcPaDHGZ6egR1/bmG6v1xGacXuqIbbMsf5i3QIx5yizlz2KnJijJWHJnzH9
         fQgB1aAYY4H/+++6KIzVVwhQYKKxClRIYaEHR+3sIwj2n7J4D6Qef7pnLzT91yP2fpka
         fwpd3+iq2p8FN8vezt+24FauI+LAZPLBpc+oNTs2q3hL8DEBT3niepZOZR/hBrWSusS9
         QjYQ==
X-Gm-Message-State: AOAM533w0W5kUKrvpPF82T1wAttWSAQAN8BfXmeUjAToxwHPQSGnoXpK
        6NtOImhhwANTwBFnuIGz+VI=
X-Google-Smtp-Source: ABdhPJzGnPgKJk0e3Wqyd8YWylIfOE1tWTpMFPdmVINHJ8/NM48TyurfJsZptw+HlNcvawAaG5iTnA==
X-Received: by 2002:a92:4a0d:: with SMTP id m13mr3585255ilf.129.1629229064277;
        Tue, 17 Aug 2021 12:37:44 -0700 (PDT)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id z22sm1657212ioe.52.2021.08.17.12.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 12:37:43 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH] lib/vsprintf: don't increment buf in bitmap_list_string
Date:   Tue, 17 Aug 2021 12:37:35 -0700
Message-Id: <20210817193735.269942-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increment is confusing as the buf is overritten at the same line.

Fixes: b1c4af4d3d6b (vsprintf: rework bitmap_list_string) (next-20210817)
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/vsprintf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 29a384eee286..919b70d00855 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1261,7 +1261,7 @@ char *bitmap_list_string(char *buf, char *end, unsigned long *bitmap,
 
 		if (buf < end)
 			*buf = '-';
-		buf = number(++buf, end, rtop - 1, default_dec_spec);
+		buf = number(buf + 1, end, rtop - 1, default_dec_spec);
 	}
 	return buf;
 }
-- 
2.30.2

