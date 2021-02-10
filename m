Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7FE3174CA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 00:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbhBJXyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 18:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbhBJXyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 18:54:13 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAECC061756
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 15:53:33 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id e12so2161948pls.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 15:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zj5l2TaWH01pVxKiROmW9tqp3Gf3tRU4tqswJVkyijs=;
        b=LUu2Ql3S3LZ6KRQdIRM44fZdlo9FETEcPbpWfwzfWP/OwB2kfGhk0NBQZ444Y6gS84
         cqqRyzWrA01gsetE2YnXTYM25dF340zx9L4r0rMEqS6FXzVh7ZPSlX9j3AdbC/MEDIai
         +6zU4S0K5cbNDo9xidyAHRDKZc7J+1uFcCg8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zj5l2TaWH01pVxKiROmW9tqp3Gf3tRU4tqswJVkyijs=;
        b=F9Qx78corzJdFCBcbAMZfzAh+quZDKk3cGWCZecAgYDyFBLq1d6p+1DXkHJCnhlF5X
         XNR2EyAk7GczFaAxcb58WL8ApE0K26LS0dBuQ+xSsHxFV6gAWZPMWEU0OtBuvUmtKAmq
         PBu5WeVfjytJONasg7/w9LHZVsUWfqrwyQaagKoVeBrQtwNvmoINcIkMsDaZ6caZYqMH
         nvXtJScxa8T49+O0nnxUvWgjvz74hwjKpzztp4j8zPqL7fzfNcPfv8K2UakhINiL4D4B
         JOhrMSgzYOdheKtTGiagVdaDQcyD4j+eRZmKy2fM75FV3hHn/9Qh07cIEXEoO1rEVbLm
         xb9Q==
X-Gm-Message-State: AOAM530sBBAifCt7VHb22VQNVCF72GiVgtMBCzteK8rQMttPn5vY3eQ5
        SDZGjVvSBjo3umhHQOzprV8Vfw==
X-Google-Smtp-Source: ABdhPJxn6d4HljoUCZrvAdpCoL1DwQblJ3hzAj4YtXGibEqSQ9vSwDUtsmWUD2TANhfUPPfmDuB62A==
X-Received: by 2002:a17:90a:80c5:: with SMTP id k5mr1260909pjw.217.1613001213199;
        Wed, 10 Feb 2021 15:53:33 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 9sm3463308pgw.61.2021.02.10.15.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 15:53:32 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Joe Perches <joe@perches.com>,
        Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH] usb: Replace lkml.org links with lore
Date:   Wed, 10 Feb 2021 15:53:30 -0800
Message-Id: <20210210235330.3292719-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=d9c7823dad2ef78111b271ca0324a207be917bb3; i=D9zEhuNzLfa2liVytchUXDtYkln8bkxLBm379ZBYaEE=; m=kc8NgBcNkR1FdAUFoBcecPqIFWVDlhJwDI99K+gzg58=; p=UFVmbKtTxGlQA7W+7EMSXF0tvEoDMPhJZjpruI0gZTk=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmAkcfkACgkQiXL039xtwCYb+Q//Z9j +9FVgqmMRXE4nuTCPZfOr+xm1NHy0g6uanlaeK6qSazb/6IlwHZJEyBqFa9QEJTiCnqCbroi8hZuM hUHjYDbLzVynrDOVtIbWtWBaAEzZg/bMnwVDgz/PTTPrXRQUgqgDF21GHB+UCq6DM8UhOXwicSCQq GoawUmcNITtl5UDK8yEni6DLOgazLzoMH7/kecxCBFpKsJqNXzxb9a70GD8o8Q1QxWk1Co8bZlMss x2oCqS83UfLDe19pJGkfXyVT9auobZmfKss4THh9Qh2Fh+4zLjU/646T75LnxbloVSSEaPuMdtMxJ QGM4XX7cnXjO6umi/g+spE7/9mnJpuhDoBI977KfkTNHy8eEqUy5WPBfgtPdo8aBJh0WnJX/4niDe h+hjwzF56BibI2XW3fh2nDPX9r9KJN4/1QL00m18wxAue2W1DK4EVHpnWvN/EhRCvP2UPdCHjlwvD dSZmFFWa2fleEjwefhAstayJygRdE+BJeC7EgrZ1MTvD0O4Zt/jcbscDn6TYwkd4IpPZrqiFlfdVH MXRFJbd4ojlnfB6Y7NRI/h8nl8E+cgsJmodAcJ09kAvOcAXwu+TyAYFvso8czBnwxrzaVIENaHYbO bRZsiLjgoAS8tP+pUfKAqbX7oyYbRSpTWxcZavfd+jmdzuF/O9MpUh71azfOUOXY=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As started by commit 05a5f51ca566 ("Documentation: Replace lkml.org
links with lore"), replace lkml.org links with lore to better use a
single source that's more likely to stay available long-term.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/usb/serial/ark3116.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/serial/ark3116.c b/drivers/usb/serial/ark3116.c
index f0ac7bb07ac1..b9bedfe9bd09 100644
--- a/drivers/usb/serial/ark3116.c
+++ b/drivers/usb/serial/ark3116.c
@@ -717,9 +717,10 @@ MODULE_DESCRIPTION(DRIVER_DESC);
  * hardware bug or something.
  *
  * According to a patch provided here
- * (http://lkml.org/lkml/2009/7/26/56), the ARK3116 can also be used
- * as an IrDA dongle. Since I do not have such a thing, I could not
- * investigate that aspect. However, I can speculate ;-).
+ * https://lore.kernel.org/lkml/200907261419.50702.linux@rainbow-software.org
+ * the ARK3116 can also be used as an IrDA dongle. Since I do not have
+ * such a thing, I could not investigate that aspect. However, I can
+ * speculate ;-).
  *
  * - IrDA encodes data differently than RS232. Most likely, one of
  *   the bits in registers 9..E enables the IR ENDEC (encoder/decoder).
-- 
2.25.1

