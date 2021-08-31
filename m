Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2747E3FC2E7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 08:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236732AbhHaGkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 02:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbhHaGkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 02:40:18 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE7BC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 23:39:23 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so1222806pjc.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 23:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NTCDFRak7iBO7zSAEx1oNf4Ml2aUyPgE0FxiqkjCLnw=;
        b=ea0cyM6OhCVeGG5usZ0KxNHxuYsmmrHVTB/I0bTGwh+BYHl4HXTqySRz2JObBQ5eb9
         g0HmHkQ1s0wX9/HzIvkxUGZT9rCe7WYKXVKbpjJGlS6uHCmfwSXgsg7fP9KMI8svvy+P
         B5iih6MzjvTdzL9aIaUBOPVpE9YT7D+6MkVGB2ARB8wodEFoouVyRZN9Lf7UdDfPrHpk
         dAdq+Og5Nn1szM1iIG5p3/ldeifZO/p74iKLP3uz5D1DeuVF4hEqwoSnvDJVYoBX9lUi
         P2KxxiVYUIQwOYy9MX/j5u15XaXVzqGK7FPEjNWDD/6GUsWWKiu1P+mxWuZKmHfD8rZS
         QnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NTCDFRak7iBO7zSAEx1oNf4Ml2aUyPgE0FxiqkjCLnw=;
        b=e120yXBi18OsdfL/Z7x2PdbkztF1w+Bve8vi0Wo53wJTamgC9LAbRFDL9OTFX+kqHB
         xI4qCktbZG6A4z0Lt+XlzywcyJffjd2vOmltUOohvUZLZwNgjEjW1zJZ8TEFuyFnO4Io
         5om7oQ2JT4iZN1jNdN74NSmZwbRGOLc911oja0EjxaLsYF6I7Iw1FZnOq9SJT2+sz8PU
         Jwba5F0FOsFWsaLC8QjgYB1PfuOveY+e+fw/ULdFWz+3a+B0D83MtHZ17XJrrLVShHMp
         gFQWoFAuDZb7GccjGvOD+e1eUflaR98Oc53sBWfcT0+tlrYvILdeOUfoEjo4MubfZ0cb
         zxIQ==
X-Gm-Message-State: AOAM533GfXWeUxq/SrrYYcrewcBcn+zAG3r6TX9UNtOECFDtoQnoz1kz
        yWRTWSi45nccEVXIbp2sf5Fl3w==
X-Google-Smtp-Source: ABdhPJxBHVEMsZU9CGeogp8ZvKAVf1sD+YoYtF3kIkhRZTAMZ5NJtLosRxW0uUePoJRVQ3c2ER8/zg==
X-Received: by 2002:a17:90a:680c:: with SMTP id p12mr3619960pjj.33.1630391963054;
        Mon, 30 Aug 2021 23:39:23 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id y3sm19954621pgc.67.2021.08.30.23.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 23:39:22 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: virtio: Add missing mailings lists in MAINTAINERS entry
Date:   Tue, 31 Aug 2021 12:09:17 +0530
Message-Id: <76305b7e89006437b2a3ecf97f857231b2d4ae2a.1630391782.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gpio and virtualization lists in the MAINTAINERS entry for Virtio
gpio driver.

Reported-by: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f632acd7d98c..da58964935d4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19650,6 +19650,8 @@ F:	include/uapi/linux/virtio_fs.h
 VIRTIO GPIO DRIVER
 M:	Enrico Weigelt, metux IT consult <info@metux.net>
 M:	Viresh Kumar <vireshk@kernel.org>
+L:	linux-gpio@vger.kernel.org
+L:	virtualization@lists.linux-foundation.org
 S:	Maintained
 F:	drivers/gpio/gpio-virtio.c
 F:	include/uapi/linux/virtio_gpio.h
-- 
2.31.1.272.g89b43f80a514

