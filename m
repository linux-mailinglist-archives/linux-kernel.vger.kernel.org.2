Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F3031C41E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 23:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhBOWn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 17:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhBOWn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 17:43:56 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E49C061756
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 14:43:15 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id l13so6300620qvt.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 14:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=0wElvRgNTl0iDIYef+iukzJo48+l2BEb5QT2NVP8CrY=;
        b=R9JsApEa0SQDiBumN9hoKMpVMQaoyNOjHHcp1DZk4bsrhZ1emx9arNfVLpj8DhQrLM
         ek6kmHUUvj6vWQJv2Xk83fTgTDtQXSyxtLwzJmjrxZ21ZhUXN/k31o38BAc2aTHafvu8
         7DSy0xoFlkTDYm+TldQX2gjqKSE5PZ8CLsIuD9+1G8Zk7bi+fuf2cY3QToQZ/5+GT7Jj
         pw2xqvY9X7ukMUfdyqZVtuU2dVhRB55YnhPQqQWhrmTGyRZWWDe/RUeYWDQHSs8JDwON
         ZFqCrbEJ6m83B/Wu6rf2A5ltLj1bRSaCSmT6ke7sLDPokH4bkDNXOqd5oJUdvDbdKe8z
         ieOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=0wElvRgNTl0iDIYef+iukzJo48+l2BEb5QT2NVP8CrY=;
        b=Q8Ft51a5hDSO+cHu13QpdNdyUM8yVQE39rMmSVANpeam+GnimqYIS1bD10PV5nIC+D
         QZQVDgQ+xaLQUhiuPJVeSi6gND8/ltUB4BV6lLL5FdKJlfAVgvRQuseDf+QuaPNh1BGf
         45fEpJPzYXjfPvdjCaP1VJHuJsDEd2yLMyA5ljrCjMnKOeXJ+EvhBLPN5F2jRXVEORqO
         KRmfl+3SIpYB2ou7MlXknEwv35I/pg+BUgSlOCjMBDz0IO0VTJqkYYSxv1pcIPD8z9/I
         FwmV8wk1vDzfgiy8huJ5alB153D/k0B0o6ICRO8ea05hmU3mKFsfTcNBKgpz3TS8HDIB
         kx2Q==
X-Gm-Message-State: AOAM530RXoRehcUYKeGsOwpN+LjA4PpAdmQ3Ar+S3w23gEMp/Sx4xgGH
        w9/FVn/DZPlqoBgzrFn6QUTQTRndJsu+LtY=
X-Google-Smtp-Source: ABdhPJxXr8yZQALiMRqZkVXhcR2VUKse9BYWISgiYswf+oHn/FP2CkcZi7tYR2K7xI5bwKLb4KbW8tKfKTMmJ7c=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:909c:cac6:3bbe:67a9])
 (user=saravanak job=sendgmr) by 2002:a0c:b49f:: with SMTP id
 c31mr16885605qve.35.1613428993272; Mon, 15 Feb 2021 14:43:13 -0800 (PST)
Date:   Mon, 15 Feb 2021 14:42:58 -0800
Message-Id: <20210215224258.1231449-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH] of: property: fw_devlink: Ignore interrupts property for some configs
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <treding@nvidia.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, kernel-team@android.com,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_OF_IRQ is not defined, it doesn't make sense to parse
interrupts property.

Also, parsing and tracking interrupts property breaks some PPC
devices[1].  But none of the IRQ drivers in PPC seem ready to be
converted to a proper platform (or any bus) driver. So, there's not much
of a point in tracking the interrupts property for CONFIG_PPC. So, let's
stop parsing interrupts for CONFIG_PPC.

[1] - https://lore.kernel.org/lkml/20210213185422.GA195733@roeck-us.net/
Fixes: 4104ca776ba3 ("of: property: Add fw_devlink support for interrupts")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
Greg/Rob,

I believe this needs to land on driver-core-next.

-Saravana

 drivers/of/property.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 79b68519fe30..5036a362f52e 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1300,6 +1300,9 @@ static struct device_node *parse_interrupts(struct device_node *np,
 {
 	struct of_phandle_args sup_args;
 
+	if (!IS_ENABLED(CONFIG_OF_IRQ) || IS_ENABLED(CONFIG_PPC))
+		return NULL;
+
 	if (strcmp(prop_name, "interrupts") &&
 	    strcmp(prop_name, "interrupts-extended"))
 		return NULL;
-- 
2.30.0.478.g8a0d178c01-goog

