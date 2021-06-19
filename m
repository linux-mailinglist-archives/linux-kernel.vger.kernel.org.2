Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144503AD9A4
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 12:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbhFSKvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 06:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbhFSKuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 06:50:00 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D839DC061574
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 03:47:48 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id n35-20020a05600c3ba3b02901cdecb6bda8so10283437wms.5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 03:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LTkyAehf8YDMFLVUk7PThGVVorkKOg4GbKlGuTWT6o8=;
        b=cmbaj81bapkWavHCB3MZVrkVnP/SZdNEKl67WB1irsh25jl7lvdLpz9waPXwilLIGl
         Jvc777Se48ju/+gjqm7sUKF+4Cnq5OzCjtPdGKVudIWptxQFYKC8zbDIfNq+xmAJHXrq
         GbumVzl7fK3+9jpHgLXnb+mB1gMC4QTWZpr6yPjakhbQQe0em8Bu/zd+FycUhymiXG6i
         HgFbOwJU2IcCAjoZI8rcLWW+8kxX33rJt3PyUmpDQnoIzWhMxnBymBnsDUjAaLFajXg3
         7whHdTQiw2xg/FeljOSIm5vhdzsONjt2vM/8bw3sTmmSyvmeI8k0Tejdg0jhZUzut2hu
         49sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LTkyAehf8YDMFLVUk7PThGVVorkKOg4GbKlGuTWT6o8=;
        b=okgSR3eNRE0KuebY4ThFZqwxxFZWUMRpvnPqTLNrxk3/5S1aAXaCHYItLIm/w8480m
         BAiE6hbYBP+eTse/hmBdwZYMPOzvOFInPuKV6UBc3bF2MbVI9KbUf0wtMwpEckFYO4S5
         jK92SBL4rXzObMUvqp/TBUoFOpOSvI+hAtaP1hKU8sXUi54WrVodPhnufxPZjwjFLjc/
         L7i2GgDNws/vZMMCnrBEld8H7J+eDxq3WKJG14723MRb6xcYcy3j9e0aXDetvnXybxn/
         uHBfunLI7UudwoaFIOckzWvFcmAlj+sj6HOZLaYm98t8os3lXpUHHavm5Zi5hYE4MpwI
         8qJA==
X-Gm-Message-State: AOAM530cGseQeK2Yn9LRIj5UUVcwjOwFmyeRAnN76oUmCrFqdnNyEDm4
        W9CbT8TSogC9t/F4TCvoEhcN+4zplRfuLA==
X-Google-Smtp-Source: ABdhPJwZX9Q4hG7OqQvle/LI4PetvpeUXzf5ZfrXzUvOBrPdIsGgKbmH0UnFzrb2Q0XwGCGWEsz70A==
X-Received: by 2002:a05:600c:190f:: with SMTP id j15mr15856276wmq.37.1624099667436;
        Sat, 19 Jun 2021 03:47:47 -0700 (PDT)
Received: from agape ([5.171.81.81])
        by smtp.gmail.com with ESMTPSA id f14sm11050322wri.16.2021.06.19.03.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 03:47:47 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 18/18] staging: rtl8723bs: remove item from TODO list
Date:   Sat, 19 Jun 2021 12:47:21 +0200
Message-Id: <f85985665cd3d1a6e7cf4e6c2d63e7dc920fafab.1624099126.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1624099125.git.fabioaiuto83@gmail.com>
References: <cover.1624099125.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove item related to 5Ghz code deletion from
driver's TODO list.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/TODO | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/TODO b/drivers/staging/rtl8723bs/TODO
index afa620ceb2d8..3d8f5a634a10 100644
--- a/drivers/staging/rtl8723bs/TODO
+++ b/drivers/staging/rtl8723bs/TODO
@@ -1,6 +1,4 @@
 TODO:
-- find and remove remaining code valid only for 5 GHz. Most of the obvious
-  ones have been removed, but things like channel > 14 still exist.
 - find and remove any code for other chips that is left over
 - convert any remaining unusual variable types
 - find codes that can use %pM and %Nph formatting
-- 
2.20.1

