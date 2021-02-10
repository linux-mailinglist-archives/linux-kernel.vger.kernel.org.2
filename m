Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E114E3174A7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 00:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbhBJXrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 18:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhBJXrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 18:47:13 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116AEC061793
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 15:46:22 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id o7so2362736pgl.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 15:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GxK3PI7vDPZB0gE5y+t0L6ekPC7epRKuLKN0gHcGI0k=;
        b=d3G7HKaV8TmLFxjZgmM1jOP6UW61nVg63mfethWVl7OVzgYXa4v/IGP6MBs7csssdM
         FzxOodhdMQjKziKVV5tXS3iah1TBI8bkHNvTqVAvxSVSAO9MlvRZ1ecRZNnnZjC+Ts+I
         Wn3ra5BRnmBNAwHijpb1eHcIh9e9+dERbWg+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GxK3PI7vDPZB0gE5y+t0L6ekPC7epRKuLKN0gHcGI0k=;
        b=GjlQyYXlyhJT4Ayy3JpAdffPkckPy9WlzM4c7wsHXVOxhHxxtxm45Ou21XbddsuvI4
         7jNvqzT/fFeqY9OVCzC51/HLwjhjyrdVSCLXIJwgY+XQ+koJgSThw2LTw2Nveqjqa7oa
         sOvb+Z4KDjZiTwwXsGOPCzv5RpqIFjmJLUr7+ohG91zavnlRunm76v3ur4k+rHdCTx9R
         hoYWnBRue55VY4mCocFmSe5g44QUnPSCI/OiBpvHEXFs4u7G17iPM5M/GZYZBcCICh8B
         9Wno5bXaLR6Vu7e6nbRuwWnhHfM0EQP0mn8vdMB4FqferKYHp01qYW2xfXRCBr4CdJuu
         TFTg==
X-Gm-Message-State: AOAM530Feqvwv1fdswGQCWXAU3EeTI1+n6xpTeM20/gkzG4YbzV35hTs
        SSHs81OzqVdxMlCUa9MQs1pbSA==
X-Google-Smtp-Source: ABdhPJwqbO8wVuYN5ck6GRwRGKKtKGHav/dWOVfnnFJrcGzMbAZZSGMs7fiQXdjdff7l8sTmz1+MAw==
X-Received: by 2002:a62:5b87:0:b029:1d8:90df:a54b with SMTP id p129-20020a625b870000b02901d890dfa54bmr5460354pfb.79.1613000781625;
        Wed, 10 Feb 2021 15:46:21 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o4sm3039796pjs.57.2021.02.10.15.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 15:46:21 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Kees Cook <keescook@chromium.org>, Joe Perches <joe@perches.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
Subject: [PATCH] xen: Replace lkml.org links with lore
Date:   Wed, 10 Feb 2021 15:46:18 -0800
Message-Id: <20210210234618.2734785-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=dbcf4ca7bce2f2f2a80590b480a2765db93127bd; i=YSscTzp3lVgXfFntf8Kb5E2vpf2VUCH6pRlxS8sELt4=; m=kc8NgBcNkR1FdAUFoBcecPqIFWVDlhJwDI99K+gzg58=; p=VSpsoEkhhoc0b4MXqeePgJxef7V8SVFc1j/JqX3Kem4=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmAkcEkACgkQiXL039xtwCbScw//f9b +LBIxQ3WQurWK0tZaB0GyM/Kpvjk0b47840okM1XwHAppPCijhOa3epm/1lpm/4c1mYH/aJdtmXM9 sy9eS2iLx+g/NFl3GZOqY+8tcMiIn7JFANfcHkw0YZfO4/9XuikNVkIsOmAdSIEHSoP0Uj32ZQs0Y yev7conmkSmWwsoT5pA8JRArJnXRqUqGp9CnJzFe951BtAiEhwxIljBmDYzEKr8GRerUZpFeJlhuz 13EuG6ZOM0TMYXmMHUQlgSKrXAJjnf7ZolvmpyLs9EfW/6Pi1jgCUxaTwEQrk1cnte++qGi5V5Xs7 rBkpzZ0dJahji64MOHxmUjd9duXSFIJZT2In3v3S+6b8364b2tfiOgMN4M3659LQkBEocxWpr+VRW Qn3qz5ni2MVf5bqfEi7Z0y6EQN4Mmol72DqYNcH61h6ZFzEhg4l5w9p7m7s5Bo7v6qZNDfZT45HsP 8ewiaKJoagZsZDdAaF1uQsoHMhlwaPzfPrwRhhtgLdyc7FdPYuUpqwyZpRwNKwkVkHaIPRKSw23TC kFvjFQJcqF3tgjxX6pMhCRO7Qq3bNsSKNgU27m14Lj1ZZKgPN4ByDIRl79Bd1OI4cg5iVZM83bh6m aFsn9Ua0YayuhndsTYVtLaFARcW9FmMHBNJI/6NL75LYmuGsUrx2cP6cfkvIdxtI=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As started by commit 05a5f51ca566 ("Documentation: Replace lkml.org
links with lore"), replace lkml.org links with lore to better use a
single source that's more likely to stay available long-term.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/xen/xen-acpi-processor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/xen-acpi-processor.c b/drivers/xen/xen-acpi-processor.c
index ce8ffb595a46..df7cab870be5 100644
--- a/drivers/xen/xen-acpi-processor.c
+++ b/drivers/xen/xen-acpi-processor.c
@@ -3,7 +3,8 @@
  * Copyright 2012 by Oracle Inc
  * Author: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
  *
- * This code borrows ideas from https://lkml.org/lkml/2011/11/30/249
+ * This code borrows ideas from
+ * https://lore.kernel.org/lkml/1322673664-14642-6-git-send-email-konrad.wilk@oracle.com
  * so many thanks go to Kevin Tian <kevin.tian@intel.com>
  * and Yu Ke <ke.yu@intel.com>.
  */
-- 
2.25.1

