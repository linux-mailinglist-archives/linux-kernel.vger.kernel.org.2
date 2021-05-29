Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96AA7394E16
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 22:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhE2UFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 16:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhE2UET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 16:04:19 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED92C0613ED
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:41 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so7005543otg.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yqwu612kTu5Af3QIKB6umBBpyq371/vnuyT/AM/LZqI=;
        b=MGUEbQrqu6ahrGE+/bWJcjcLTGhKPWYZP/wuLvkOM3pUMG6MGsCqwwoOIJ34Dnj/7h
         G7I5jQnT/CQ8KkOqwZVEAwmBG2G2G2xXvAVKmWJ2+V7rroVrE8nkUABvmaFYpl5NxGTU
         MHWNl4SZtwXcPgtV2LbfzEuJ3fhUQ91ZrbtL58EBpFszI7aHbNWZPQkrZj5X0HlZcfU2
         iWM87NmxpNCMYrUVe4omt2ioL9QNaL/tJH+H2iDURHaQLvtgCzB9bVjeXJrkH3h6SfR5
         VjuEGOvvpNwF5TS30Z48NZBE9CyRNv7VFZ+m7NMhyOd3mA+Yf89+M6EcAYhFOWyEzX2E
         T/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yqwu612kTu5Af3QIKB6umBBpyq371/vnuyT/AM/LZqI=;
        b=XIYNDP/WOKs/GTrAVU9C4nLimpgIkd+oCHBRxkI3dgv1nqCKNnlpFJy628jXRup2C+
         OvwaRZUnKD42bxr7T9p0kMq/mOe9HzPXLU+d4Z609RF3SNKCBH44tdl9bn/JvZJjXT+K
         XweWRA86ocV4SFTEAJzdqUCpAKlAbRfPTHbvqmM55NCYg4l155c8LxA0L7X68QUGRXOp
         Co3DxCzfYCA9YttnbKOqR3uPSuWomR/rUqVa8eudPgeh6PpLv5hoRT+bP7llUMma+787
         6H0OM9y/OFGWFQqrbuMUAuS4+oB7Ie9oXFcu7OqzxvjIFDOnummk7Ld9MP4mqJ2uKVad
         XyFg==
X-Gm-Message-State: AOAM530aPz1aGISUHBnXjlRHCcwJEaM9KjZf1TaLTJYKFsW2E3VH82w8
        D9P/sSH3SSXy4Rr/vpSO9o4=
X-Google-Smtp-Source: ABdhPJy4HlLamE7GUBVK3Q1wgjn/tTsPAU976l0LRDULqZl921tkMsVD6Scv94nWCBikgPj2J9gULg==
X-Received: by 2002:a9d:12ee:: with SMTP id g101mr11977217otg.84.1622318561336;
        Sat, 29 May 2021 13:02:41 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t39sm1868064ooi.42.2021.05.29.13.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 13:02:40 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v6 27/34] dyndbg: fixup protect header when deleting site
Date:   Sat, 29 May 2021 14:00:22 -0600
Message-Id: <20210529200029.205306-28-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210529200029.205306-1-jim.cromie@gmail.com>
References: <20210529200029.205306-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix a null-ptr-deref when .site info is deleted.

  $> echo +D > /proc/dynamic_debug/control

This protects the header.site pointer from zeroing; we need it for all
the SITE_CHK sanity checking.  Probably should protect against
toggling the static_key too (in the same function), but this smaller
change fixes the crash.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 659e864837ad..f2f6f2b20d01 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -247,7 +247,7 @@ static void ddebug_alter_site(struct _ddebug *dp,
 #ifdef SITE_CHK
 	/* delete site info for this callsite */
 	if (modifiers->flags & _DPRINTK_FLAGS_DELETE_SITE) {
-		if (dp->site) {
+		if (dp->site && !is_dyndbg_header_pair(dp, dp->site)) {
 			vpr_info("dropping site info %s.%s.%d\n", dp->site->filename,
 				dp->site->function, dp->lineno);
 			dp->site = NULL;
-- 
2.31.1

