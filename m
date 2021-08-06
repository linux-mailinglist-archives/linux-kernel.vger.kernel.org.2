Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53813E3030
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 22:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244803AbhHFUOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 16:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbhHFUOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 16:14:42 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EC9C061798
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 13:14:25 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so24391521pjr.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 13:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gPJ8NsKS+3Jw4kxc6WCHLzF/A70YlZNDecLhVvyEwVw=;
        b=NdOURHyDJZvSh8If1c7MyBRCht7XlsW8r2HtcVAVLUUWoZmmb6rVJdGcw9CANoRI6J
         tN4WH3v3iQv+ngKFN+eTeHi5IwsFf7MdKjVxLsRHC2An9rllNl6suYGF+oUWh3d4wM+4
         vNb9dykCBuSZqDfOuwvYjxHcnqP+Y7CAXB+WA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gPJ8NsKS+3Jw4kxc6WCHLzF/A70YlZNDecLhVvyEwVw=;
        b=PcrwO/mJODGXjkoN/9jBnlmUMXplblGm/VRG/IEyWmt72y+Kn54ELzooM1AtAbOfl0
         udJaaKQKXe1hjbYoSJ6hN8kMTacsv1Ey0r+GLmi/JlpRmPLVWgCTOCPWhyjcy707S1Zh
         rG9PFhaaaNXfosUdDzm3Wdk/HRDhhvJixEv+exyu3DiyvA0JxZT3AzTGlK5isiBM0Kwp
         SLSxSIKpgfkfRoUS/NeD/PHiYlq8ArStbxFl6ZxjFdnTv3gsYMggyqwpy/DKZnqTIRX1
         CiNGwzy5xqC6HV5/5Mn77zVwlp5Kn0HZ65y6TZbCHH7Z4g7P8Ax4dtJ/hLAQ+IcS8YQI
         HMiw==
X-Gm-Message-State: AOAM531D8cfMipgLMLc5lOIWWHFMKho+3NZoTUMR4/2D4kQ/fYc4iJhr
        gePStUJXS3fOOQVjRzss67bi9g==
X-Google-Smtp-Source: ABdhPJxxlITo6nirtimXf9fsmMsyNhsNe6iZOd6Asay/tIW2ItUL1ICQexCsZ8sZV+5aL8qA97a+yg==
X-Received: by 2002:aa7:8246:0:b029:39a:1e0a:cd48 with SMTP id e6-20020aa782460000b029039a1e0acd48mr12338144pfn.14.1628280864501;
        Fri, 06 Aug 2021 13:14:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a35sm12580854pgm.66.2021.08.06.13.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 13:14:23 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Ross Schmidt <ross.schm.dev@gmail.com>,
        Joe Perches <joe@perches.com>, devel@driverdev.osuosl.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: Avoid field-overflowing memcpy()
Date:   Fri,  6 Aug 2021 13:14:22 -0700
Message-Id: <20210806201422.2871679-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1599; h=from:subject; bh=N0zJZJw4fEfLxgkALcFP9+bOoMIMACrM/hpsApeDvnI=; b=owEBbAKT/ZANAwAKAYly9N/cbcAmAcsmYgBhDZgdacn85cUJLT9+vjP4fZ1DEL36WLydwIVHYdNs rrmiePqJAjIEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYQ2YHQAKCRCJcvTf3G3AJkCGD/ iUCT4C9PmKd9Cp68qNLOPT9cs4Sq4vUB0OAch0yQGtn/cHWpgjrSWVikOFA30ueW1pejMqIGHjwEfe uv0f5pcGAL6VB4sQ9zJP71HbfTsFPcTfJexGZMln9z98VlYwY1kN3wvOacp8fENVdE+EBx8sX3RJrW 4cGwdNARI8qGoFxO3xVkM1Ct3zVLgv0jBwXLIh+aQqPZ/htj0Nsz6QPnnFrgSt+oI6cihyNMjONwFQ E0/NDE4V0ZlqJHDgZp1KgM/PJr+BokVI7vYwCSP1Y28WRcck6NGIhOBl0ICAfkz/q26rzf+/3JsC9P Moth1SRuh89E7iz3gk1sV3upvmmGIVKGajM7Cuput472O/SQ7GH3KSFSkmNB5SbpHm+CFl6gEfaKLq LwufREyQVcs4/k2tKjVu/ua9p3TpoUon2rhZxbX7t3Rwmxc4arveTZeifdY4T5xl089sRHM9Hs/0GN EpMxrG9f9mEdw2ieFjyXSghZcoZFHNhoz0YdrQgao+JN7LyLbABYxKvlxr0XorXGkbn6GCOzBVuP2Y EJgmlcjiE0iVIcAgfpgE7niA44YNoBeCjxutXzAbhWSucrlud9JXoqYXlK9VlA6679p9TBjkNyObC8 dCZQw/U/n7z64h/+6pKRjssEYzakpEDkEV9MaNOySixUsyHxruB4HHhK6V
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring fields.

Adjust memcpy() destination to be the named structure itself, rather than
the first member, allowing memcpy() to correctly reason about the size.

"objdump -d" shows no object code changes.

Cc: Ross Schmidt <ross.schm.dev@gmail.com>
Cc: Joe Perches <joe@perches.com>
Cc: devel@driverdev.osuosl.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Hi Greg, since I've split out some other patches from my series, it made
sense to send this one directly too. You originally Acked it here:
https://lore.kernel.org/lkml/YQDvM4r2KomO9p+J@kroah.com
But since it has no dependencies on my tree, you can take it directly. :)
Thanks!
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 5ed13bf765d2..e0cee51224ff 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2389,7 +2389,7 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 	}
 
 	/* fill default supported_mcs_set */
-	memcpy(ht_capie.mcs.rx_mask, pmlmeext->default_supported_mcs_set, 16);
+	memcpy(&ht_capie.mcs, pmlmeext->default_supported_mcs_set, 16);
 
 	/* update default supported_mcs_set */
 	rtw_hal_get_hwreg(padapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
-- 
2.30.2

