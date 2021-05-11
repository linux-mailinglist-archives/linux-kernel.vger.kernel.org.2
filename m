Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E507037A860
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 16:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbhEKOEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 10:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhEKOE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 10:04:28 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6F1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 07:03:20 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id y32so15800325pga.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 07:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NYeYRlFwmTYVFPnZBE9jpbdODk2yUDxPpa+xXSIkfPc=;
        b=MDItPMggyNPiTzCTeqYZh+smEAMfEyd8bBUatCmnAqdhsAkM74TXs/kghQyPrzrN8a
         GoX+9sPokk68wWNGLREdCgKRVoCPb6fbYWz9oK2ZHvWo+/Qmo6bWPZeeFmfx4GXlQplq
         vasEutO84yhF89Q6WwE2q/TQ2JIJ0xViIiIRX1dZjqWpkYhRI+Nl3yS/JkAqSPvQS0mH
         LaCqeNHygkLu78svzYzclH9N29Erd025N31O4oycfj8IvbI9+NizpEYqCkqzeZS/Wxyt
         pw9xro4xhxiVJc84sNyavd4MS9Djj51+DCpYlNOK+RkDt+rkMeehNUP4t0CsXfKpkkhe
         DQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NYeYRlFwmTYVFPnZBE9jpbdODk2yUDxPpa+xXSIkfPc=;
        b=AfMP0lMl/SaEivTI+hufFkWb5BIyoAEGbLEfleNTBIsrfhE27Mi9YFm1E6qeHHhdqr
         TTHC2UFGCKb+URTpT+8G2gdtjKvnG0bY0eVu/vb5y4kzFXdwt0xqU2tpqEmq3WhV7uT0
         jP70j3MlubOVJiHCTW4qY/lSMMCStKwYdtc51KDD6XMLlhaLAR8aLAS7i6wRSsJKGjU5
         HLcUGjQnHtMHk2jyJfCk3/TwyLInpGbacK5cOeJMhhuHGmUxOk5d7pvsarMavFqOY9sE
         cxd08VCLiWWlO9pG8QDNkoPjYK7Dehz5zXBMDjcYTBMxiIYbViCVYwBaKOzlpxVXffV0
         jUng==
X-Gm-Message-State: AOAM532G4G6mPuRXI6YfQkB9O7TOPgsm9G40QqrAf2w5y/BQLCRnw/sA
        P4HADsPTu7RTBwMWApZx27CPs5dJ6RDBkQQmflE=
X-Google-Smtp-Source: ABdhPJwJ39vg4/1YIapYwBd47WFIahO9IJ3J6MtlLxcPrxWalR0lTVKG0H8fFfWetESGxt8TyLkutA==
X-Received: by 2002:aa7:9f4c:0:b029:27a:150e:abd8 with SMTP id h12-20020aa79f4c0000b029027a150eabd8mr31125918pfr.46.1620741800200;
        Tue, 11 May 2021 07:03:20 -0700 (PDT)
Received: from localhost.localdomain (host-219-71-67-82.dynamic.kbtelecom.net. [219.71.67.82])
        by smtp.gmail.com with ESMTPSA id z23sm13772947pjh.44.2021.05.11.07.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 07:03:19 -0700 (PDT)
From:   Wei Ming Chen <jj251510319013@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mingo@redhat.com,
        Wei Ming Chen <jj251510319013@gmail.com>
Subject: [PATCH] ring-buffer: Use fallthrough pseudo-keyword
Date:   Tue, 11 May 2021 22:02:46 +0800
Message-Id: <20210511140246.18868-1-jj251510319013@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace /* fall through */ comment with pseudo-keyword macro fallthrough[1]

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
---
 kernel/trace/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 2c0ee6484990..d1463eac11a3 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3391,7 +3391,7 @@ static void check_buffer(struct ring_buffer_per_cpu *cpu_buffer,
 		case RINGBUF_TYPE_PADDING:
 			if (event->time_delta == 1)
 				break;
-			/* fall through */
+			fallthrough;
 		case RINGBUF_TYPE_DATA:
 			ts += event->time_delta;
 			break;
-- 
2.25.1

