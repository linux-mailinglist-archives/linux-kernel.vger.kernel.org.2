Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B774382920
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbhEQKAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:00:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34566 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236492AbhEQJ7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:59:48 -0400
Received: from mail-ej1-f71.google.com ([209.85.218.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1lia19-0002RA-9j
        for linux-kernel@vger.kernel.org; Mon, 17 May 2021 09:58:31 +0000
Received: by mail-ej1-f71.google.com with SMTP id k9-20020a17090646c9b029039d323bd239so817830ejs.16
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eNm8R5g6wjNdRLhL7auat+eVwlX93f6wEYA2jUJMKRQ=;
        b=Idj4vN3x4kJe+qEz+LH+UG7+aUnFB1ctJ8MdY59F3eLrv/FcGHEUgs0hFRrM9YIgQq
         rTcT3lN5B2AR1jtj5Jyu4/hYICohcBSg/RzEAb9tsmzd5SU0VBE67Oyla22OQkTZqkp4
         kw4VBFp00MAkAuPawEk+AB6RIknXz2J84BnSI0wUtR/OTpZwmv0jDRnTBDiEHoTBFQl/
         ED0q66qDqLwteE6AuVb7YKAXkn0b0s1ce1f5svMfOpel+5QFFwLFza0WzCnJFnHiV7/R
         Ewin2GzDcafYPhU1t9mwePZ8a05ayI1xu+02p1R70OMaQ3HHbIrHCnoGwJsFpVHtjZfK
         iR4Q==
X-Gm-Message-State: AOAM531HPwXngkwkjfy0vR6yx/zNNR8BBlt3ynRrflgo7N2sg1/NNJpj
        m8Wwm1pgZOG9r4Jl6FeGop0zWyE+NbCbw/tGyjkFkISrTnlReLI4PhDU68nCrV1TixY2yhWOK4u
        hNv/LHOe4d3dSjzhR+86nnl9uZ7VqE8JdHjNR3oB2uQ==
X-Received: by 2002:a17:907:94c3:: with SMTP id dn3mr16169003ejc.26.1621245511075;
        Mon, 17 May 2021 02:58:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnBIKcyXNLW4zb+KVyZ7wdrQ3YX+RT9BN/cK8fL8JRWHG+BnwyH0DjVHFe6XBpfP/cwI3tZQ==
X-Received: by 2002:a17:907:94c3:: with SMTP id dn3mr16168985ejc.26.1621245510883;
        Mon, 17 May 2021 02:58:30 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id m9sm8857521ejj.53.2021.05.17.02.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:58:30 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     linux@armlinux.org.uk, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, juergh@canonical.com
Subject: [PATCH] ARM: mm: Remove leading spaces in Kconfig
Date:   Mon, 17 May 2021 11:58:28 +0200
Message-Id: <20210517095828.81581-1-juergh@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove leading spaces before tabs in Kconfig file(s) by running the
following command:

  $ find arch/arm/mm -name 'Kconfig*' | \
    xargs sed -r -i 's/^[ ]+\t/\t/'

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 arch/arm/mm/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 35f43d0aa056..7a4a04bafa92 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -123,13 +123,13 @@ config CPU_ARM925T
 	select CPU_PABRT_LEGACY
 	select CPU_THUMB_CAPABLE
 	select CPU_TLB_V4WBI if MMU
- 	help
- 	  The ARM925T is a mix between the ARM920T and ARM926T, but with
+	help
+	  The ARM925T is a mix between the ARM920T and ARM926T, but with
 	  different instruction and data caches. It is used in TI's OMAP
- 	  device family.
+	  device family.
 
- 	  Say Y if you want support for the ARM925T processor.
- 	  Otherwise, say N.
+	  Say Y if you want support for the ARM925T processor.
+	  Otherwise, say N.
 
 # ARM926T
 config CPU_ARM926T
-- 
2.27.0

