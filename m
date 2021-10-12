Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA4F42AF11
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 23:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbhJLViY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 17:38:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50945 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233650AbhJLViW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 17:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634074580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SkoPLiocY49c2kTh11FieWxtqcanklmJP04+gg+k/yY=;
        b=ZF7eVBA/34oIxSckjDw1qXwcwbA5dQDtNsAvk9v3hMj7GMqFPdVSEfphrLbkrxHimMpkDk
        bxp3jP/cnXbrZzjE9R3TuGP2AgqqGFPmlzgqsPOxOSdMebE9IxzmcZHunCmHEXLDiTecMK
        FsSapoaO/oPRftMDx0EPyxMc4KfQGBc=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-Ys3UAjR4Nuqs3OVf8bOJVg-1; Tue, 12 Oct 2021 17:36:19 -0400
X-MC-Unique: Ys3UAjR4Nuqs3OVf8bOJVg-1
Received: by mail-io1-f72.google.com with SMTP id f19-20020a6b6213000000b005ddc4ce4deeso370908iog.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 14:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SkoPLiocY49c2kTh11FieWxtqcanklmJP04+gg+k/yY=;
        b=Z+xiVYk7c/LeaT/BYykWhA5C2Apwj3i/7ILDCL/cHiZZFZyIQgc7cGoAoflihHgxzR
         LR8scqlDZDtZdRfVkMWtPImhnXJr41zuZczh6kod/yNgpWGcfwuOezhjYNZH0NI/T65c
         O9Tzu4a4D7rmaLxFy++OJ0rBVn2HPwTGwI046U/spDhIsOaa01OHjeAHvaqKftiYBWNG
         MQdy/ryDNX0TBjK0cv7+ciM5Zq9r6Xx74iWn4Sv1Fd4EUVpLNnjfxDbl66Creq7Qx5UY
         /EOowXGa/sevxU5GJeDgRNVrJPOZJPTQjQ+dQiaDLs6Bodo28TQLQQmOwIoyULPoi5Ef
         eB3g==
X-Gm-Message-State: AOAM531SlyHZ9mUFrOylzubOJkwa1NbEFlttPO7OX2umftTS4CSReNz9
        as3M00m9Py/WApY71ib03FAhiztb7hQFPrZuf1CAz+igTGSQFbeOknOOMuo6S9HeKGnmRIwscvj
        Oiixl2HwE7tS01+T569bAdgPc
X-Received: by 2002:a5d:8493:: with SMTP id t19mr25985186iom.79.1634074578242;
        Tue, 12 Oct 2021 14:36:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqSO9DQt2/fx702JX9z+lwh40nsa24oTQQ1NwsHPMUJjjQGB7uMFBe+alpQM1Omaa3stnHuQ==
X-Received: by 2002:a5d:8493:: with SMTP id t19mr25985171iom.79.1634074578030;
        Tue, 12 Oct 2021 14:36:18 -0700 (PDT)
Received: from halaneylaptop.redhat.com (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id f3sm5847104ilq.62.2021.10.12.14.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 14:36:11 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     akpm@linux-foundation.org
Cc:     rostedt@goodmis.org, bp@suse.de, linux-kernel@vger.kernel.org,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH] init: Make unknown command line param message clearer
Date:   Tue, 12 Oct 2021 16:35:23 -0500
Message-Id: <20211012213523.39801-1-ahalaney@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The prior message is confusing users, which is the exact opposite of the
goal. Try and make it clear (without needing to look at the kernel
source) that the message is indicating one of the following
situations:

 1. the param is misspelled
 2. the param is not valid due to the kernel configuration
 3. the param is intended for init but isn't after the '--'
    delineator on the command line

On that same topic, also make it clear that these params are passed to
init still despite not being after the delineator.

Fixes: 86d1919a4fb0 ("init: print out unknown kernel parameters")
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---

I'm not a huge fan of the wall of text this adds, but at the same time
I've had a few people come to me with confusion about the message and
concern that userspace isn't getting the params (not the case here, it's
just a cosmetic message). I'm open to better ideas on how to express
what I describe in the commit message, or if people think the message is
more confusing than useful a full revert would be ok with me too
(although I do think it is useful personally).

Thanks,
Andrew

 init/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/init/main.c b/init/main.c
index ee4d3e1b3eb9..8dc88c2386ee 100644
--- a/init/main.c
+++ b/init/main.c
@@ -925,6 +925,10 @@ static void __init print_unknown_bootoptions(void)
 	for (p = &envp_init[2]; *p; p++)
 		end += sprintf(end, " %s", *p);
 
+	pr_notice("The kernel command line has unknown parameters. They are either\n");
+	pr_notice("misspelled, not valid for the current kernel configuration,\n");
+	pr_notice("or are meant for init but are not after the '--' delineator. They will\n");
+	pr_notice("be passed to init along with those after '--' on the command line.\n");
 	pr_notice("Unknown command line parameters:%s\n", unknown_options);
 	memblock_free(unknown_options, len);
 }
-- 
2.31.1

