Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C18734395E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 07:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhCVGW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 02:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhCVGWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 02:22:53 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478DDC061574;
        Sun, 21 Mar 2021 23:22:53 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id v70so9511228qkb.8;
        Sun, 21 Mar 2021 23:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fWgRUYEuMUUVkXBcd2OYwANj6EMz7TTGepw25B/1h0c=;
        b=Tq3EIIttN+HTALS/Lx/GIwHllpnrxvs27w/1RaoEyxBrrkiIFNqAPzQodvY3zWnHXJ
         hSN16evPv0o8ANqEDnHeu43njqMf/ZKnFNcQshux7/Bdue3m4qUwZedQc1dEHdUUwwMn
         IOWLpbik2kPCe8KRTjHG2B+i6QJJu+bWTZINxKuKLAHIbm4JaalVgnSsqojT2b8T/T27
         mACmwyeBgVyT6d2BNn3feilfG/S2aDkWUNdMYpG3rCqofT4HDzxHVSOV4RIdZqeAHEOf
         h4Pbxrdt5YYZzNz2X+d2zR895ipdx9Io46hTH5oI5m/HUG/4ukozrxhrwaFPQI2EE9r+
         R49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fWgRUYEuMUUVkXBcd2OYwANj6EMz7TTGepw25B/1h0c=;
        b=bruvzWWPkoHhUi/yC+KXg9USzZb+VlJF1Rz23dS76EtyMtK1TunjHCl+YtHv6TRQw/
         mX+rsOrIKCLQESbXCv3CHcdPygl2mCZBcTsmzDhy5IWLdNa/HdelwBDFHK7xyKMb9gCQ
         tV5g1eF8CptEKliGe1mSuuOXUC2R6j7/IKcC4o1lhWy/ioQM0T9H6BwsacT6Bv7gJ4uX
         8qYSEoXevinhB4Z7AdhUBaPfFv5wjaCUXVFm3QVIyLSXG2odR6+11mYvFkXsaQTMyyNe
         yPacvZB9IGcgEUeVxpdMxIYDzHiacs1WWslMPQ2oJD/qtlZkw5AYU9yssW1FqqRPanRL
         AKJQ==
X-Gm-Message-State: AOAM530UF8NBrbNfMq3Xs9swIPP9amOenntJF98lw7knF+qPioQlAhpe
        ViPQImmn+oDEDT4OBKtZGV2X0SOLVElyaBFs
X-Google-Smtp-Source: ABdhPJx7XfGH8Jy1ODOOB9Mm1UUAZ5d4LPz7WKIupSLPG/SfdW8m7tZ2OZeqX0h0yGYuDu2WvlnVCg==
X-Received: by 2002:ae9:f80b:: with SMTP id x11mr9504441qkh.220.1616394172611;
        Sun, 21 Mar 2021 23:22:52 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.40])
        by smtp.gmail.com with ESMTPSA id i93sm8673119qtd.48.2021.03.21.23.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 23:22:51 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        corbet@lwn.net, linuxppc-dev@lists.ozlabs.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] docs: powerpc: Fix a typo
Date:   Mon, 22 Mar 2021 11:52:37 +0530
Message-Id: <20210322062237.2971314-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/struture/structure/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/powerpc/firmware-assisted-dump.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/powerpc/firmware-assisted-dump.rst b/Documentation/powerpc/firmware-assisted-dump.rst
index 20ea8cdee0aa..6c0ae070ba67 100644
--- a/Documentation/powerpc/firmware-assisted-dump.rst
+++ b/Documentation/powerpc/firmware-assisted-dump.rst
@@ -171,7 +171,7 @@ that were present in CMA region::
                                            (meta area)    |
                                                           |
                                                           |
-                      Metadata: This area holds a metadata struture whose
+                      Metadata: This area holds a metadata structure whose
                       address is registered with f/w and retrieved in the
                       second kernel after crash, on platforms that support
                       tags (OPAL). Having such structure with info needed
--
2.31.0

