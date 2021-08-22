Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DC43F3E6F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 09:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbhHVHwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 03:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbhHVHwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 03:52:13 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F303C0613D9
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 00:51:32 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id t1so13646530pgv.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 00:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RZ8BEPPVll/zwqS70BZ2JYx9ju7xEKmdm5VlWqz/VdI=;
        b=iQnoPnJ40Ay8cygJzetIn2Rk/uaznhqz/TpzugtPRKTM7BbVoNVwvEf+wJCa4DEmXh
         4wH1AAcWnqHVFfOGO+JkZswqsbAccGr97mNT71/Z3PxMlywTWT98WKcQJHVYWiACaxgS
         5vvdl0SljDtHKljG6xpzUcVEIts0sPoq5se+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RZ8BEPPVll/zwqS70BZ2JYx9ju7xEKmdm5VlWqz/VdI=;
        b=d3Hxk2BrFkabLaePhxQR4UbqD8NpV9/UiryU8zwk9/UlSusTfDhVwNtNMpxpJL1pBk
         o3holsR3ek+RJvpuNLpLQE6zoBbjDog+z46W5wre9pxpdObcQcWRniQjmCnNtNg2qZ42
         rgnRe8CTVT/toZEbmeuKzJFnhUUQ4YS+BCMzh7SraS+xuHKOfneww+j6HHa/sa2oS4Im
         091bGZclGjOlTNvNWoekb9BfQspaWeuYiNExpixtC7ikc91Zw+u/s+VyFLdvxc8m5o9N
         twJ3nnKe5pH2fpJhuMl30BDiADnznoITKTGspWsoql3OYDtLJObOKhj5pHV+nV2zBFeH
         HOsQ==
X-Gm-Message-State: AOAM531cIx4mnFXpW5Pnoc7JbO83QIkCpej19z5pfJBAGmaJCWYHXOwO
        uLziQCny0+gI/5MTuyWpOcRckg==
X-Google-Smtp-Source: ABdhPJxj+QAwGyr993juNCJvBFdb0ObGsAlJilnIWnp/UGZWNjCNte2p8yIY9KOhLNxBVgJ4H3e48g==
X-Received: by 2002:a63:cc0e:: with SMTP id x14mr26811805pgf.352.1629618692173;
        Sun, 22 Aug 2021 00:51:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v25sm11904465pfm.202.2021.08.22.00.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 00:51:29 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Jiri Kosina <jikos@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Gow <davidgow@google.com>, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: [PATCH for-next 10/25] HID: roccat: Use struct_group() to zero kone_mouse_event
Date:   Sun, 22 Aug 2021 00:51:07 -0700
Message-Id: <20210822075122.864511-11-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210822075122.864511-1-keescook@chromium.org>
References: <20210822075122.864511-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1858; h=from:subject; bh=9rnBN9pp25qHZzpmSwKIY2SR98/yWw6L4NOQkzURsmI=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhIgH2LkwWtaOSS7Sx/Asb2SpLbNNFUNs3zGDDazyV HncbtwyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYSIB9gAKCRCJcvTf3G3AJsM2EA CR/tG8xuXRd6A9sHvtzfnyuKbJ8og8+11J/eZ1XFtBWxwj1ZWtRFM7SK4UsGVDCKbkgmTaWm9L42nz Ykh//OfkNzR8v8LgCX5I4afgYhpr+W2+jd7Vs8OSwt5KL+rh73sPUpznE5xXdoCNQh00RnLs0mgovr ym+zLbmN8A0XXaBmNhADwbonxzCDX3ketGY2WDLcLouoaX60Y2NxAlldabWUypxRLYLHxtOjZ19vR9 IOkqfSzRFVJwesNmzkbstIoEBECpzir6s6uUooa4uvcxTxzqhBDtSI8OkYLHr1mvKeo8cAl9m01ml9 r1hJVcdDio1h1TrNn901c8D1YDuau3G4qKcC3bNRryV/AZppmp9yBYHyXNChFegB12MgSw9yfNrvM1 acs0b5CLpypzUdeByvNdm94UY+Q+2rQ4Mi2imV+7l0rAGdcC+LmY0+zyGGmeYt1cjLP6yDrXqsPCbK TPOzODY5r8mgP7t1mgRy/lpSgH7iLKnv1HelL7GrG4tS/NZSPo2XGfxUF4xR1C13X3s/AImf+Uplnh r8cuoliRDvEXGm0Ly7BS/++cBqIK3M7u1iKh/JS3cPKtsuckyYRiAEQBHUsS+I/Atut8nieCNykJVN PnmWbeC/TjpL+BUjubxZwshG+kHeCYpFTMGXL6y/5csfEcVQbYsml1uPEOGw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Add struct_group() to mark region of struct kone_mouse_event that should
be initialized to zero.

Acked-by: Jiri Kosina <jikos@kernel.org>
Link: https://lore.kernel.org/lkml/nycvar.YFH.7.76.2108201810560.15313@cbobk.fhfr.pm
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/hid/hid-roccat-kone.c |  2 +-
 drivers/hid/hid-roccat-kone.h | 12 +++++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-kone.c
index 1ca64481145e..ea17abc7ad52 100644
--- a/drivers/hid/hid-roccat-kone.c
+++ b/drivers/hid/hid-roccat-kone.c
@@ -857,7 +857,7 @@ static int kone_raw_event(struct hid_device *hdev, struct hid_report *report,
 		memcpy(&kone->last_mouse_event, event,
 				sizeof(struct kone_mouse_event));
 	else
-		memset(&event->tilt, 0, 5);
+		memset(&event->wipe, 0, sizeof(event->wipe));
 
 	kone_keep_values_up_to_date(kone, event);
 
diff --git a/drivers/hid/hid-roccat-kone.h b/drivers/hid/hid-roccat-kone.h
index 4a1a9cb76b08..65c800e3addc 100644
--- a/drivers/hid/hid-roccat-kone.h
+++ b/drivers/hid/hid-roccat-kone.h
@@ -152,11 +152,13 @@ struct kone_mouse_event {
 	uint16_t x;
 	uint16_t y;
 	uint8_t wheel; /* up = 1, down = -1 */
-	uint8_t tilt; /* right = 1, left = -1 */
-	uint8_t unknown;
-	uint8_t event;
-	uint8_t value; /* press = 0, release = 1 */
-	uint8_t macro_key; /* 0 to 8 */
+	struct_group(wipe,
+		uint8_t tilt; /* right = 1, left = -1 */
+		uint8_t unknown;
+		uint8_t event;
+		uint8_t value; /* press = 0, release = 1 */
+		uint8_t macro_key; /* 0 to 8 */
+	);
 } __attribute__ ((__packed__));
 
 enum kone_mouse_events {
-- 
2.30.2

