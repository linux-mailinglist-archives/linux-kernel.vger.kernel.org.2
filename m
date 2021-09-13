Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7100B409FA3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 00:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243526AbhIMW20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 18:28:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31868 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237393AbhIMW2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 18:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631572026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dScrSejYpC7A0l/RrxdfxG8Nv7jY0AjrBGwaqxIgiZU=;
        b=dLAGbgqM8h6eNAQLIEtSIopivE2hyb9Ml9jtNZGpPI64GBxg1xQ9SzSvV4B+oGW2cRyG3Y
        KrpJ7Lo1pqytwkGQ2AsnCoK7VsIKOJFb4xJK8qLffD9vF8jDHA2rrS6FeSeh0nZ9HYaTNw
        r7TbF+BX4naMqK5Hfx/QA1AeBqEi1VI=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-vF9qHCl3Pja1KVJqe5pXAQ-1; Mon, 13 Sep 2021 18:27:05 -0400
X-MC-Unique: vF9qHCl3Pja1KVJqe5pXAQ-1
Received: by mail-il1-f197.google.com with SMTP id o12-20020a92dacc000000b00224baf7b16fso16919052ilq.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 15:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dScrSejYpC7A0l/RrxdfxG8Nv7jY0AjrBGwaqxIgiZU=;
        b=shsDzqJq9M5gD0O74KcsBPHSGTUtVqdIyfvS5UY1sled8YPkhCMeksloNw2RIji+1y
         FpgtoIVxseGQd9qn0zzW/iGlIp8x6ETm12DAwk2t8yA0pCE4Fe+CO41MaxY46qm1rPvu
         CiCD9Zv87l36Ky6W4C0ZHTdxyiwssQB3HBvRZPBoL52wG5PyotlY/lDM11MyCV4e0IYe
         +cWgocnx5eeRF6lYeB36gkSVb/RREuCA70+5ctwoquL32ncKnQC4LmpSIvm4AD1Y2SKc
         jHRs80UJ7YDsGFVblLkC8tY5QaDZ8yLlgfMpxAd20nRi+VbsE6tPoSYCaR1ClijxUO6h
         PNQg==
X-Gm-Message-State: AOAM531Eu5sNV+d18fjOna9/fa/Os2NYdA9EE3RKRrqZKMrNEXgqEB95
        oUz9VyhJXdBCPJ7lm1OFsqHFfHDOnqCj2KrXkast1PP+kU4BWi2ISW3D2RoUcDsu+ayos13CVsx
        Ry80OYQJWNeUeRBaR7OdPtGJD
X-Received: by 2002:a92:6a05:: with SMTP id f5mr9352258ilc.140.1631572024573;
        Mon, 13 Sep 2021 15:27:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6h2gtOtrwgG40UaXqv0HofwAsV2NLYvLVNfQKicDx00O7l3jiNrYvHg8s7aEmkmqqXw4J2Q==
X-Received: by 2002:a92:6a05:: with SMTP id f5mr9352248ilc.140.1631572024416;
        Mon, 13 Sep 2021 15:27:04 -0700 (PDT)
Received: from halaneylaptop.redhat.com (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id d10sm5809457ilu.54.2021.09.13.15.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 15:27:04 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>
Cc:     Andrew Halaney <ahalaney@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dyndbg: make dyndbg a known cli param
Date:   Mon, 13 Sep 2021 17:24:38 -0500
Message-Id: <20210913222440.731329-2-ahalaney@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210913222440.731329-1-ahalaney@redhat.com>
References: <20210913222440.731329-1-ahalaney@redhat.com>
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

