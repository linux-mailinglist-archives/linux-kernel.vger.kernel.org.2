Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B0941968C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 16:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbhI0OnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 10:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbhI0OnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 10:43:05 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2EAC061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 07:41:27 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id j14so11943821plx.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 07:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p23ioMFXihNK5fPV90Emqpr9ocsUo09yX0SkSX5EZh8=;
        b=do+Z2yHgUPjsMWkdY3uOKLHEUNljWuRXFI8u6ktF++PhoL9Y0xWy5NBUOScNZzesjy
         2k++B4bzJSSfGM+b1OKO4FqdcrbQ9uvSOv8duc45g/dfKQBBPvPg6+FUNlXF0W2mFV2t
         mbMXV0Rs+HmCzL8HFUIQJby2F8ZUqEdSL38/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p23ioMFXihNK5fPV90Emqpr9ocsUo09yX0SkSX5EZh8=;
        b=lNdNnLG3GDJm9JLHXi6yFBx5QpBwLFTtsC8sqoizg4dlR4QY7niIYvEhxJXYFpeATl
         hdgwo3jzbFmlRyuiCl0h7DzrLTeaHPrn/eJSSUEvzvldPbGV881N0VnqHr+sQfaYJrT4
         QAaRBjCmTvLu6wNqageDWaQgUg83x5OEBNLWiD+3pMm0LaUmevWlarXKwfzYOxt9Kppn
         S4Ox0aGHb5upckhX8rFJK1FQv8UPv21o/AME4+3egGDLWhiNNXHPjEz76znO/AiIUCiC
         KCu38UnB1XwWkuFeAAUdN4K14VbD/8WVJp3Vc3XJYnTkHj6nDTApZTxQks27m0/tUIJd
         l29Q==
X-Gm-Message-State: AOAM532kZ3rtW0Eto1h9wMShw0BqUJJtFSkczoB91z1Hlu+GWyS+Sjs1
        DnMcOw3pg21ZtuDVjjh87x0UuQ==
X-Google-Smtp-Source: ABdhPJxXgPlT3xU0KLmn3J4lvA5hVI2OazHf3+1yesYWmi17QgeBQYoQg0g7i6t92Z7blpfoqnGHPw==
X-Received: by 2002:a17:90a:1d0:: with SMTP id 16mr356012pjd.60.1632753687547;
        Mon, 27 Sep 2021 07:41:27 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:aa10:bd89:ed05:6646])
        by smtp.gmail.com with ESMTPSA id p48sm17443377pfw.160.2021.09.27.07.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 07:41:27 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/edid: Fix drm_edid_encode_panel_id() kerneldoc warning
Date:   Mon, 27 Sep 2021 07:41:22 -0700
Message-Id: <20210927074104.1.Ibf22f2a0b75287a5d636c0570c11498648bf61c6@changeid>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to a simple typo (apparently I can't count. It goes 0, 1, 2 and
not 0, 2, 3) we were getting a kernel doc warning that looked like
this:

include/drm/drm_edid.h:530: warning:
  Function parameter or member 'vend_chr_1' not described in 'drm_edid_encode_panel_id'
include/drm/drm_edid.h:530: warning:
  Excess function parameter 'vend_chr_3' description in 'drm_edid_encode_panel_id'

Fix it.

Fixes: 7d1be0a09fa6 ("drm/edid: Fix EDID quirk compile error on older compilers")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 include/drm/drm_edid.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index 4d17cd04fff7..18f6c700f6d0 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -511,8 +511,8 @@ static inline u8 drm_eld_get_conn_type(const uint8_t *eld)
 /**
  * drm_edid_encode_panel_id - Encode an ID for matching against drm_edid_get_panel_id()
  * @vend_chr_0: First character of the vendor string.
- * @vend_chr_2: Second character of the vendor string.
- * @vend_chr_3: Third character of the vendor string.
+ * @vend_chr_1: Second character of the vendor string.
+ * @vend_chr_2: Third character of the vendor string.
  * @product_id: The 16-bit product ID.
  *
  * This is a macro so that it can be calculated at compile time and used
-- 
2.33.0.685.g46640cef36-goog

