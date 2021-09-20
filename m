Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9142F412792
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 22:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236549AbhITU6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 16:58:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32550 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232115AbhITU4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 16:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632171326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dScrSejYpC7A0l/RrxdfxG8Nv7jY0AjrBGwaqxIgiZU=;
        b=RiMjzpzfZvotKxJ/eRme1+P9XdiZe/oEnjM86tnZFfnm6/sN+tO+21QoMZVKC9dEeOLckt
        HOHx+g1QfTZDa2nIFna8nw5N5RtYtxgdiGMmT5jwgqprLcCUYBoApQo2DMtmN88oqTA+Ig
        dtn7TUtbTkEoO1wfO1w80Q723BdQMJg=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-AIMNQvDlMEiu4x5MUzMDVQ-1; Mon, 20 Sep 2021 16:55:24 -0400
X-MC-Unique: AIMNQvDlMEiu4x5MUzMDVQ-1
Received: by mail-io1-f69.google.com with SMTP id n6-20020a056602340600b005d56a34dea8so24921956ioz.19
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 13:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dScrSejYpC7A0l/RrxdfxG8Nv7jY0AjrBGwaqxIgiZU=;
        b=ArhM04Lz5RLiPlU/zoLSRhkMg0+Ou+IyS4PaYU/Uumk1ScpWVaLjLo60sexl9lcz05
         5oDmYeG4+iL18Svqjj43HNlEKbSoT8nRymaSBmIOq4uWMPgjhjVDQy0TooJ8sfhvwSEf
         zDaMSpEdaMh539PKYf+y4UxNvVrqe/Sh7SOzYp0d7hcUfnTM7Tk5dbeikJxNDfDzBYcQ
         h1aoY5et7c8Av8K7TT+WTWEnxwkmQYgJgu1Wr4MQSldFC+THYWhJZy/dO88DI+5lTdDH
         /5NximR1rpbPzfRLQ4Nooq9RTYyA4FxPWHXkVuhbZVqrwUa3UpNjFF0gOM/z0+jW76eS
         omuQ==
X-Gm-Message-State: AOAM5307wPy83lHsMSOYrsqi63QOZoA8Ko97hHeSGVIOKmYbxROQFj6U
        jc4HeEvFrYyXpWlZeS6VNaagULeooaj+yvrMzrIG4HOobFxFCWgMzdcAI3rh3aa3xjQycqmuxri
        h72k5pZq8AmZfVFu/EcBsBSq9
X-Received: by 2002:a6b:7c45:: with SMTP id b5mr5449608ioq.191.1632171324155;
        Mon, 20 Sep 2021 13:55:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUdnMDkoTsoD9pz69KpsVh0TPgycFO4BU8Ekit0tVzg+SQDrSqvNjirBIU7akE6Szm866M5Q==
X-Received: by 2002:a6b:7c45:: with SMTP id b5mr5449600ioq.191.1632171324014;
        Mon, 20 Sep 2021 13:55:24 -0700 (PDT)
Received: from halaneylaptop.redhat.com (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id v9sm9268905ilc.16.2021.09.20.13.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 13:55:23 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>
Cc:     Andrew Halaney <ahalaney@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] dyndbg: make dyndbg a known cli param
Date:   Mon, 20 Sep 2021 15:54:42 -0500
Message-Id: <20210920205444.20068-2-ahalaney@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210920205444.20068-1-ahalaney@redhat.com>
References: <20210920205444.20068-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now dyndbg shows up as an unknown parameter if used on boot:

    Unknown command line parameters: dyndbg=+p

That's because it is unknown, it doesn't sit in the __param
section, so the processing done to warn users supplying an unknown
parameter doesn't think it is legitimate.

Install a dummy handler to register it. dynamic debug needs to search
the whole command line for modules listed that are currently builtin,
so there's no real work to be done in this callback.

Fixes: 86d1919a4fb0 ("init: print out unknown kernel parameters")
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 lib/dynamic_debug.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index cb5abb42c16a..84c16309cc63 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -761,6 +761,18 @@ static __init int ddebug_setup_query(char *str)
 
 __setup("ddebug_query=", ddebug_setup_query);
 
+/*
+ * Install a noop handler to make dyndbg look like a normal kernel cli param.
+ * This avoids warnings about dyndbg being an unknown cli param when supplied
+ * by a user.
+ */
+static __init int dyndbg_setup(char *str)
+{
+	return 1;
+}
+
+__setup("dyndbg=", dyndbg_setup);
+
 /*
  * File_ops->write method for <debugfs>/dynamic_debug/control.  Gathers the
  * command text from userspace, parses and executes it.
-- 
2.31.1

