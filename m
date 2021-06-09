Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6BD3A19DE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 17:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237542AbhFIPgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 11:36:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35814 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234693AbhFIPgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 11:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623252892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KfiuaUysjjm6b29OnnGvmDGDVpILaJ6Wzkg1WhNxQTY=;
        b=V2q87J4VrGkNuz2jsF3MQlQl45x+pRbbo6lBthUg9dwGwkDX6U4A6nM1DYJXmRLTlmuvjU
        djLFgaoYQYlow7cbEGv2lwTNo5oelzzLt1fV6OSCfBeWAHRgSV7c9+W4U0rkEpz3SISulT
        sIMBXIgWs3wK6wU9WsECHE4aBkThKM8=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-bMNbvMJgMjmaLcde37rldA-1; Wed, 09 Jun 2021 11:34:51 -0400
X-MC-Unique: bMNbvMJgMjmaLcde37rldA-1
Received: by mail-ot1-f71.google.com with SMTP id o26-20020a9d6d1a0000b02903e61e3de711so8935456otp.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 08:34:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KfiuaUysjjm6b29OnnGvmDGDVpILaJ6Wzkg1WhNxQTY=;
        b=FWDJWhYkdL9PWfHQQfuhmkJzEyDcEie3jYgd3/pAkcQTfzHYQ5RBCye9WxR8YebI6M
         7RI7ptkgdy2v7H8cAnWcZnjAsGBcatHTnjsfO599/IlGFpDT2IYVt9ZG5Qk/AUa0X87u
         +9kJMApqaoyAD/+b9+PEXaNc99XlyegrdQ6ssItONYFYXqX0fgx8qUlZrLbhYnOlcDo5
         jyCAS3gxo1JuUKI6/9tqMNw7dHl/PMh9JaKhTv6ornGtuRSgps60j8TbA8OodFLRHmPL
         TGWzDcC9btQHzPWiH3t0ah7INRzdGIqUenvzXs+3EUMkUZrQbHbUj7VGoCxg5TwOoeuY
         nSJg==
X-Gm-Message-State: AOAM531nDroD7gPJWqFGt7k0Fv6R3SsKsuxwmtdjamYXuCmkZJcIBizr
        k0unEvkzAvFWlW3L+/l3YiGBZroDDtV8d3biP/3upmOITD0pwTGzgk1nj0agtCMWH09pRQi/Ktj
        O6GPbpOVGybtUEjCrsGcHsnc4
X-Received: by 2002:a4a:3796:: with SMTP id r144mr381797oor.79.1623252890233;
        Wed, 09 Jun 2021 08:34:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKQsKCwsCUaNvi8dryoQlutWe8ew4Y6pgm9Uel7fwtQLSf0heqhCjC/gTWWNM6m8SCKRkUug==
X-Received: by 2002:a4a:3796:: with SMTP id r144mr381786oor.79.1623252890053;
        Wed, 09 Jun 2021 08:34:50 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j24sm12190oou.8.2021.06.09.08.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 08:34:49 -0700 (PDT)
From:   trix@redhat.com
To:     divya.bharathi@dell.com, prasanth.ksr@dell.com,
        hdegoede@redhat.com, mgross@linux.intel.com
Cc:     Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] platform/x86: dell-wmi-sysman: set fw_attr_class storage-class to static
Date:   Wed,  9 Jun 2021 08:34:45 -0700
Message-Id: <20210609153445.3090046-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

An allyesconfig has this linking error
drivers/platform/x86/think-lmi.o:
  multiple definition of `fw_attr_class'
drivers/platform/x86/dell/dell-wmi-sysman/sysman.o:
  first defined here

fw_attr_class is only used locally, so change to static

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
index 1378c18786582..636bdfa83284d 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
@@ -25,7 +25,7 @@ struct wmi_sysman_priv wmi_priv = {
 /* reset bios to defaults */
 static const char * const reset_types[] = {"builtinsafe", "lastknowngood", "factory", "custom"};
 static int reset_option = -1;
-struct class *fw_attr_class;
+static struct class *fw_attr_class;
 
 
 /**
-- 
2.26.3

