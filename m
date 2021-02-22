Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18F9321B54
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 16:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbhBVPYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 10:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbhBVPPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 10:15:17 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9D6C061A30;
        Mon, 22 Feb 2021 07:13:05 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id l30so3772385wrb.12;
        Mon, 22 Feb 2021 07:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eE3vB1/Y8MdpJt97O9ILAeiKByH7vJluKckPn4DVjuc=;
        b=qRBLvooKzzptyg4Na1vV+Zw3xpJrgdbtv8oSWAD7uDzDOAIsoTtNtDBnRP9zRr6tkh
         9f6G6dKGjz9WqzquotrqA1GQ0V2DC9qo/WLqkVtNZzGlwHJ6egBZxwWujxTt/wYYKVgT
         N9EkVwdrFyjVzqlI1Q150Z6RFloU34+sttMm2VStZnXAzwYTBae87xniZ9tqaDV+5Rv7
         NlvoiH4/Btz0f3ojJebhRhpVbONzce8Rr1ksYkPxS50D3HLkxHENK/oyP9iYz9y4yD2S
         Hj9yfnfnfRQn6PdUvWIhTP9ZODAnNhPVrqhvbkfziR3sCGsXj4jq1O1wu9GUWbxu1vW7
         ylvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eE3vB1/Y8MdpJt97O9ILAeiKByH7vJluKckPn4DVjuc=;
        b=WBlUKL1tN8bZ6XztVQVBU8x6xuN3e5aYKOAqlDtULj0oEqGoYWNULqsNuwfTPm28aO
         i7axW9SQEpKxWRx+PzHXXB15BGpRQwLDiGMRADSAnp1kMvyvlbLo8XB2P5hzInipC9FR
         Df0up/4LHsA/cI278t5qOeyibraJKJgwbhL8rlARoYg1o01EZoQO6EfGhl2XtKMSwDkQ
         k+ckj+JRUrz1q5hc0/2eS5g+OaAHihUgZirG1h8gtIfRbLSsPcTO7JDMpPlffrISQjuh
         RB7MyfEnAZ4kA3j/s2DhZVUUhhflxIa0xkhwUozZfiI9Tt809kg9eLNoRaAmC8PqH8VQ
         rqTw==
X-Gm-Message-State: AOAM530Ip3E7rOhyuQp4fVfESHlICeoBHBsi2knhNHern1BEpOuQ3rxH
        SXT6yEpEBZRNorRTY7KAY7Ai93/QcFSHkLA8CgE=
X-Google-Smtp-Source: ABdhPJyfPGar/M7v1Lbgl1i6VGHfK9R+x8JNl1xnJQkxT/oA6TAsd7WzE2w4ZgIygKgSC/mrQJNzqg==
X-Received: by 2002:adf:f1c4:: with SMTP id z4mr4346920wro.52.1614006783582;
        Mon, 22 Feb 2021 07:13:03 -0800 (PST)
Received: from debby (176-141-241-253.abo.bbox.fr. [176.141.241.253])
        by smtp.gmail.com with ESMTPSA id y62sm30776774wmy.9.2021.02.22.07.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 07:13:03 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Romain Perier <romain.perier@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 18/20] usb: gadget: f_midi: Manual replacement of the deprecated strlcpy() with return values
Date:   Mon, 22 Feb 2021 16:12:29 +0100
Message-Id: <20210222151231.22572-19-romain.perier@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210222151231.22572-1-romain.perier@gmail.com>
References: <20210222151231.22572-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The strlcpy() reads the entire source buffer first, it is dangerous if
the source buffer lenght is unbounded or possibility non NULL-terminated.
It can lead to linear read overflows, crashes, etc...

As recommended in the deprecated interfaces [1], it should be replaced
by strscpy.

This commit replaces all calls to strlcpy that handle the return values
by the corresponding strscpy calls with new handling of the return
values (as it is quite different between the two functions).

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 drivers/usb/gadget/function/f_midi.c    |    4 ++--
 drivers/usb/gadget/function/f_printer.c |    8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
index 71a1a26e85c7..1f2b0d4309b4 100644
--- a/drivers/usb/gadget/function/f_midi.c
+++ b/drivers/usb/gadget/function/f_midi.c
@@ -1143,11 +1143,11 @@ F_MIDI_OPT(out_ports, true, MAX_PORTS);
 static ssize_t f_midi_opts_id_show(struct config_item *item, char *page)
 {
 	struct f_midi_opts *opts = to_f_midi_opts(item);
-	int result;
+	ssize_t result;
 
 	mutex_lock(&opts->lock);
 	if (opts->id) {
-		result = strlcpy(page, opts->id, PAGE_SIZE);
+		result = strscpy(page, opts->id, PAGE_SIZE);
 	} else {
 		page[0] = 0;
 		result = 0;
diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
index 61ce8e68f7a3..af83953e6770 100644
--- a/drivers/usb/gadget/function/f_printer.c
+++ b/drivers/usb/gadget/function/f_printer.c
@@ -1212,15 +1212,15 @@ static ssize_t f_printer_opts_pnp_string_show(struct config_item *item,
 					      char *page)
 {
 	struct f_printer_opts *opts = to_f_printer_opts(item);
-	int result = 0;
+	ssize_t result = 0;
 
 	mutex_lock(&opts->lock);
 	if (!opts->pnp_string)
 		goto unlock;
 
-	result = strlcpy(page, opts->pnp_string, PAGE_SIZE);
-	if (result >= PAGE_SIZE) {
-		result = PAGE_SIZE;
+	result = strscpy(page, opts->pnp_string, PAGE_SIZE);
+	if (result == -E2BIG) {
+		goto unlock;
 	} else if (page[result - 1] != '\n' && result + 1 < PAGE_SIZE) {
 		page[result++] = '\n';
 		page[result] = '\0';

