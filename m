Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C7A42967A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 20:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbhJKSI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 14:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234209AbhJKSIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 14:08:54 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE617C061745
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 11:06:54 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id a73so11598407pge.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 11:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AKSWyTyn9n+edaapvkC7vaBB8OJAUZwCu1IHle6rtDY=;
        b=OZ6zwhqaH/H2H183lbB3m07pe7Owz0pC8AvenQvQ+Mn7A7e2isEn/zdMrmsB6IrDZq
         AAUMKl/Jj2Xhj9Kd29IH7ShOGKx6qN4tPOO/IT/tu8yEFu6l+a31zjkCBX0KTB/OqgCF
         EmBdZMLvWwr1uiSAua9XKHwEUtHnOvskOcDe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AKSWyTyn9n+edaapvkC7vaBB8OJAUZwCu1IHle6rtDY=;
        b=x76uxsz82GkqEvVPR2WPL7tvk+BqWt9pnUZ9OOSCyU7OuwF4Aq051O6q5LqQ+OX8/R
         hj9Up383I8u9vxnSyOT2Zm7fEVp83sFpliKY/POOGFrC6pbSqVt5jO0KGFOzKT6XfBLU
         dccgtnLS0Z1rLrS+hSUHqSwY76i+Gis7sqR/LxKNC2DsEpJCn6ggzUO56oiJ+6nUew5e
         nRRcpQMu27eZ8+pqlv9cTaWUc8JXqR+20u3M0vD1G4RcW/An67vE9nbGWPoIAY2nc8jr
         60tNDwK8JMr64e8cTHOZZzwYUGyWRuukESwUkSmqdZRx3KYpsLaD9ebNDHBo32LKP4dW
         ab3Q==
X-Gm-Message-State: AOAM532Ic7BHD/K0q3ymG2a94bI9i/Rzjq1kTfGjFTEKTfGXEnjqrEAc
        lMwn60PtZLiQvsML2gMA00pQfbA+oMLfUw==
X-Google-Smtp-Source: ABdhPJwhEQTsN7pk9oYDwZpjal+msvahUmdOCitxu3gOsNA0gmUZ2ZejS3f5zhKnQFEn4YMoV1oAyQ==
X-Received: by 2002:a62:3893:0:b0:44b:9369:5de5 with SMTP id f141-20020a623893000000b0044b93695de5mr27094335pfa.40.1633975614215;
        Mon, 11 Oct 2021 11:06:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 11sm8321884pfl.41.2021.10.11.11.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 11:06:53 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] scripts: kernel-doc: Ignore __alloc_size() attribute
Date:   Mon, 11 Oct 2021 11:06:50 -0700
Message-Id: <20211011180650.3603988-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1303; h=from:subject; bh=zIZBSRypSkBFoFzJsCHrXCrcXGTdO+7AmKLnpzGsLwo=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhZH05wBi3hNvmq6CaS1nNLVd8y9+1L5HHQfD4QA7V WRP7xhKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYWR9OQAKCRCJcvTf3G3AJlAWD/ 9BitfK3CzitxKFMGBbWkij63jPaszUqC0D+tkQfJjMC/UBWFtjH9i9r/ZOzmRYKVw8KysNpEpD5Kni sPbnDdS+3xSm79wNOCzLRrdm2klzOGGtV1rytEcPytE/WH+7rmleedpZ5Uer701hfLkl/hzRdTJe0j gH2eJSFKceWqm8vvq03wU53IcXtzdh5lKoQ89PXQH/zQv24tv34HDh6WhXR1Qubnbk953G2MRNRW10 Z/lsIgFpSuXPT5BPkA2jmibWEl2Q1Uy6tBvIuBzfviW0hhZyGy/OTPh63d+KlV1IfLi/eBjASAF5/v 9wr8qmOH67CYWw8kQGqEfk/ha5HA+vn21EeUdfTjkOpgiq1uFg0obZBTOAEPBeFNKtGbob37jaR5V1 Lr/P9HMRAWcxWBKu56Qfoi9jldfmawjdD0vvakeLRB5AASNmG1fhuGBI3Xvw3bW7SZQCBWzedjpyrc 8x/aEUKkysBNf/oIC+iIDxLnc0so15uOfn6xrdA9dqkZCbYMRb9u/q24st3vaSYsq8Wp30Ftf3VCBX IaDx+NSKLfDdGNy4CnSBCJWhaZXnaLB1NdDKexMl1gyyS7CkYrCmrZhNDf4NAK2q6DZLmPw92VRZEi f/m3tBr1dCs2QeDu4pyHnQH9k61kgXKnK4ilL1uRhBd0mQpbEtlrXbNFAlrQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes "Compiler Attributes: add __alloc_size() for better bounds checking"
so that the __alloc_size() macro is ignored for function prototypes when
generating kerndoc. Avoids warnings like:

./include/linux/slab.h:662: warning: Function parameter or member '1' not described in '__alloc_size'
./include/linux/slab.h:662: warning: Function parameter or member '2' not described in '__alloc_size'
./include/linux/slab.h:662: warning: expecting prototype for kcalloc().  Prototype was for __alloc_size() instead

Suggested-by: Matthew Wilcox <willy@infradead.org>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/kernel-doc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index cfcb60737957..c123bac28f7a 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1789,6 +1789,7 @@ sub dump_function($$) {
     $prototype =~ s/__weak +//;
     $prototype =~ s/__sched +//;
     $prototype =~ s/__printf\s*\(\s*\d*\s*,\s*\d*\s*\) +//;
+    $prototype =~ s/__alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\) +//;
     my $define = $prototype =~ s/^#\s*define\s+//; #ak added
     $prototype =~ s/__attribute_const__ +//;
     $prototype =~ s/__attribute__\s*\(\(
-- 
2.30.2

