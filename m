Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8190140A581
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 06:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239296AbhINElE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 00:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239317AbhINElC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 00:41:02 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAC2C061764
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 21:39:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a23-20020a25ae17000000b005ad73346312so8388369ybj.18
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 21:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Rp+LGIcBfAr1NqwZ4X90eHlVDLVPm008k1HTK/JNgaY=;
        b=lyomEiUu5pTk9VDT6rlRRb8yxN7DuHUAEz5Xa3P7JZKtHIuK9esp0mnsweE/DfSWyR
         OwXI34s0+97D/QBOH16qAGUTmxJVoBXfMFZkd6zkqlj/5rJCsTfvD/RUcA3Cuaxi2FF/
         UM1QQqz16m6COTiydvvQPvKS9SJVE99fdlNf8HHV/3nxNHas2tqe7ucZSvqKHbRU8bie
         It7NQe1GTMZnsuRfeyzJl0HCjkRzHp7Y7wRo5kl3zh9qt8O4K2jn+S1p9vDTy99hznu+
         IXpEInvNwLpgwPxBv4sPNCkpPvLp9onalABkHoh/P3E6Hs9XGYPOcMmJX+ZsYz31I2iR
         3VRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Rp+LGIcBfAr1NqwZ4X90eHlVDLVPm008k1HTK/JNgaY=;
        b=MravrOKsA+C20Hmy2adBCNXgNYtjNDsQmgfHw/2f9NKU8bnGExrKOVQRToK+xkTaJ6
         LwEHaYHAWQM81AXH4DWSzLyEO6CZv/gMxD7XaJAjP308dWPfY16zKAKOwmSsGIFITIzQ
         ROE0mp44ZxLHYdfk+7lksrMryIxVwxd1Lo1e8bS71OboLdCxjsLmYnJkk0z2gS6rXmyr
         PerdzKPIGenvvNG+SbqgndPV0texk1w7mNcmnZSfuLeCuYBB4Jq9caTxiDJx4VMlgUZe
         ySDw7fGZHxSdYBEV1VkgeD4GcIXHexqby27nCqfTrqFZyCwUpVDECNkDgs0Bn0fbWRaU
         ZPwQ==
X-Gm-Message-State: AOAM53369D9n31QxuP+Gev3VgupPkJJ3oqcoQisXpjb1Rd1ZePcgvGFn
        3JxBEDgyHPHBrbhhwwdlDic9dPeqxlJebl0=
X-Google-Smtp-Source: ABdhPJwRuel8A6MSafUUKQCkz29xL6+l3DJ2NeaMnVWUSKxHlFD/IIKMguqXfZvRmJJwCmC7FEywbCXJ07bbHnk=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:48b:108c:f6a1:56f3])
 (user=saravanak job=sendgmr) by 2002:a25:3f03:: with SMTP id
 m3mr20648860yba.547.1631594385223; Mon, 13 Sep 2021 21:39:45 -0700 (PDT)
Date:   Mon, 13 Sep 2021 21:39:26 -0700
In-Reply-To: <20210914043928.4066136-1-saravanak@google.com>
Message-Id: <20210914043928.4066136-5-saravanak@google.com>
Mime-Version: 1.0
References: <20210914043928.4066136-1-saravanak@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v1 4/5] driver core: Add debug logs when fwnode links are added/deleted
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will help with debugging fw_devlink issues.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 516a5c498b88..b10c425f4b89 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -95,6 +95,8 @@ int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup)
 
 	list_add(&link->s_hook, &sup->consumers);
 	list_add(&link->c_hook, &con->suppliers);
+	pr_debug("%pfwP Linked as a fwnode consumer to %pfwP\n",
+		 con, sup);
 out:
 	mutex_unlock(&fwnode_link_lock);
 
@@ -109,6 +111,8 @@ int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup)
  */
 static void __fwnode_link_del(struct fwnode_link *link)
 {
+	pr_debug("%pfwP Dropping the fwnode link to %pfwP\n",
+		 link->consumer, link->supplier);
 	list_del(&link->s_hook);
 	list_del(&link->c_hook);
 	kfree(link);
-- 
2.33.0.309.g3052b89438-goog

