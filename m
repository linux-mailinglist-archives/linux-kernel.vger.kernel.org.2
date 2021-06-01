Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465D5397983
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 19:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbhFARyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 13:54:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40695 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231918AbhFARyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 13:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622569991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pNOYNG97wxiKXrv1fY3MLdBLOgcafFxSlaK17pla1RE=;
        b=d9Ua7G7XmUeTTU+mO0Y0A+BzxR9qF76ZrkAIFcxo7jW5E5ytqdgaN5p83UMsiGjGvaXLnf
        Hj8znHSDdw5f1WuSLLymDu45wFEPHK1AqhZRp4VmzurkkoiJs5dpnHhbRiAoP4iL6sNBuN
        6D9Jpcf9LUpV9EupxXkRwzmk7pcvwpw=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-x6LcV1TgPD2GiYPEu8_Ffw-1; Tue, 01 Jun 2021 13:53:10 -0400
X-MC-Unique: x6LcV1TgPD2GiYPEu8_Ffw-1
Received: by mail-ot1-f72.google.com with SMTP id i25-20020a9d4a990000b0290304f00e3e3aso33629otf.15
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 10:53:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pNOYNG97wxiKXrv1fY3MLdBLOgcafFxSlaK17pla1RE=;
        b=APQZH+J4oeIFLaQjApMWVaM/bXIHObfHzYzmsA8JK3MIgdz5Z9Fz3jv80OLOzopQNI
         WQ7+Gg364xFtLu8/3gBuhotD6+nOLw5gNEA8e54JMaT97bH4tfDUyawKkfVDUKDBvX+/
         WpJD81nY76jc5JbrrmC5OGCE2x6l2XKnCZ5kSyxvCFs+LNGV0yC7rNSj2LGSJ/H1BR6o
         86Ij5NEBQgVLOxI/DvBb1nfG+3ejAnh/yc+p9zNtQkJ92YSb+/janJu0M3Zn6FlUtEN7
         Eu/2+AMwg9BoFggM7hMi06ci/Ow/dvs+05dZcp0z/BgAHQBpy7efSXb7vvl9mr2C7rCP
         OP2Q==
X-Gm-Message-State: AOAM530Lw7wtyEMR2VN6jadrVjHnuvA6II7iY9TS6OyWWyWjw/2izxL8
        QfoOsZDyk0MLKFuTCDNyxBpKqw3FqSj4Cb5YoXuU4qfS1QOPVamtdDjf8BApfmlQh0ccJ5ZXONc
        J+JOiQZ4fGqFmFss1UFtWGQF/
X-Received: by 2002:aca:b605:: with SMTP id g5mr19367060oif.127.1622569989157;
        Tue, 01 Jun 2021 10:53:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzDMtyES5IO0g4tKfr9KgONwWoEXJGguwbpp38uye5bNA0u9EOVxUefy/X5FiVfd7rwRnouw==
X-Received: by 2002:aca:b605:: with SMTP id g5mr19367027oif.127.1622569988610;
        Tue, 01 Jun 2021 10:53:08 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id e29sm3585403oiy.53.2021.06.01.10.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 10:53:08 -0700 (PDT)
From:   trix@redhat.com
To:     christophe.leroy@csgroup.eu, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] powerpc/8xx: select CPM1 for MPC8XXFADS
Date:   Tue,  1 Jun 2021 10:53:04 -0700
Message-Id: <20210601175304.2634549-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

With MPC8XXFADS, there is this linker error
ppc64-linux-ld: m8xx_setup.o: in function `cpm_cascade':
m8xx_setup.c: undefined reference to `cpm_get_irq'

cpm_get_irq() is conditionally complied by CPM1
So add a select, like the other plaforms

Signed-off-by: Tom Rix <trix@redhat.com>
---
 arch/powerpc/platforms/8xx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/8xx/Kconfig b/arch/powerpc/platforms/8xx/Kconfig
index 60cc5b537a98..919082cdb2f1 100644
--- a/arch/powerpc/platforms/8xx/Kconfig
+++ b/arch/powerpc/platforms/8xx/Kconfig
@@ -10,6 +10,7 @@ choice
 
 config MPC8XXFADS
 	bool "FADS"
+	select CPM1
 
 config MPC86XADS
 	bool "MPC86XADS"
-- 
2.26.3

