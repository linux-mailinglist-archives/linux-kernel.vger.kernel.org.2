Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7547C374E2C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 06:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhEFECH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 00:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhEFEBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 00:01:41 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F43C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 21:00:32 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id a11so3697944ioo.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 21:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uh1AtRtp6NOPeGjcwZWLLakxdcwpKC4mmrUPJ7q7F+8=;
        b=QclCYGRRpzC41jhjqlUyf9OSwpXo/RXDMQTPWUyoD0UxmavDFoAHzrT/FQOnWP6iEd
         3nq9YRrkOXoouKSawy41pjjY/BfdN1FZRKNp6+Ykf2erO65c/X7xEnqhutjJvfIfHyAJ
         LC5Iki3v2DVT21l+e3SeAiJqaYP0mmH+mRG5Kp00OZHrrH7njBgtC0qscVrT7r0fh0x+
         25qRryWwrhD/erZGFpxDnB8sWyJXIc1j6lNtqs/4i/LzAl7hCBxc+CGapM2kLuFx875I
         Akej5QSjpkWqfxi9l7TFBDZXaei+SFpu7HonepMFN48fIiHY94GRUtfnogLifZLQ9Nxl
         5B4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uh1AtRtp6NOPeGjcwZWLLakxdcwpKC4mmrUPJ7q7F+8=;
        b=mSJGtVKPJcE7r/ZQtEGPtmPiLH1xGm/2mgzJnivHwwdcsWS9vx/wCRyUjekTKhHbyf
         QP1bF1heQcapOdGza/gby6nuxoTPjvm6B3xCjYt/2lq+j8zlcP1btsujmdyDl7vTp4QR
         klN//Ow/ZrYRqyiuxroZpmwtC7+5P+7ggi0dsbI7Uql9CBVL00mn7pW0BMKjGjxu0vhE
         RupQuf72rZS+HRaN+evxHkGV9oRjHgnr1sAKviGNRT4nUvBTjLOb9YbNpUgifApq0gR3
         L8zitmU3IeVgkjARJYMPrzKgm5/8CVPYBd8qrJ9/kzeZ8soKwzndesca6gEtoba7PV6L
         nvlQ==
X-Gm-Message-State: AOAM53335NSPm5vTlXU4/65UOvfqxu3HVFEgDKgBzWzvAfw1uhJaUoM3
        aYxNEniMlk2XLQkCzJaOEOBs8FDsipTI1g==
X-Google-Smtp-Source: ABdhPJwA5QmdvdG4gnbjAvmCZXU+MZoy8wV6Okxu9k95b7pj03piByxvj0Wr4Ji29hONo4R5sjzBiA==
X-Received: by 2002:a6b:b7c3:: with SMTP id h186mr1576298iof.14.1620273631926;
        Wed, 05 May 2021 21:00:31 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id v2sm536918ioe.22.2021.05.05.21.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 21:00:31 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 2/4] module: add symbol-name to pr_debug Absolute symbol
Date:   Wed,  5 May 2021 22:00:17 -0600
Message-Id: <20210506040019.1322778-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210506040019.1322778-1-jim.cromie@gmail.com>
References: <20210506040019.1322778-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Symbol name is likely to be at least as useful as the value (which is
written, and is usually 0), if one is looking at these messages.

no functional changes

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 kernel/module.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index af2641b28d73..ab16b8da2555 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2300,8 +2300,8 @@ static int simplify_symbols(struct module *mod, const struct load_info *info)
 
 		case SHN_ABS:
 			/* Don't need to do anything */
-			pr_debug("Absolute symbol: 0x%08lx\n",
-			       (long)sym[i].st_value);
+			pr_debug("Absolute symbol: 0x%08lx %s\n",
+				 (long)sym[i].st_value, name);
 			break;
 
 		case SHN_LIVEPATCH:
-- 
2.30.2

