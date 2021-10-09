Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5E6427783
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 07:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbhJIFWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 01:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhJIFWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 01:22:07 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C48C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 22:20:11 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id e7so5137805pgk.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 22:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=TRbs+RpG/bJ1OltPUfWK5TostibOXaRSuhgVNbapoY0=;
        b=k2sTWanTnqYrUy3IFvhH2mcqNs0p6jkdCzVjoX3pUr+nhG7rfe2Icp1WyDLVzt4wPh
         muMQDYq/Jj26sKlKVcQmfksaiUOq5eUOwUmNOJbGxOfl0Bl3ZMLcXBs58f7KamMBATKz
         PJWMdM3P4udczCZgRHDD5+xM2RlqjbwbU7o+PgOXHoF4qN2VrXgAvwG9XDwCclb69hd1
         /9W3piqQ9qUbfGA6IIT0aBi4xm6cmvNiL1KRW5Y+j9xkRkbkNmzvR6ul0ed2UyjcSWWN
         q5k5DLAFU5UF9xSlSAc5GSFPcoeo32mFIvMY4ZdSVMril9VGpGoX8EpoQFi7lhA4lAYV
         GXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=TRbs+RpG/bJ1OltPUfWK5TostibOXaRSuhgVNbapoY0=;
        b=KMC8rzFPXomgyaIwsKUFBnh9rHD6Na2YPSnWtNs/J4MjiRfP7yi4RGVaRtRhjkNOi3
         xs3PIZIzQyCHRvO+qvafLXmMxk0oXYLQ5pLrx0XgC1/6YjX9Eeb2Xjjw6rDi10rCFWCj
         HWiZAGizygIHz3HZTAyseVWNV1ilkh71/ffQkfDEEIe7GCgXQEbruqxeKA5EEH4kXOGm
         ihtPfE/kj0ercy6+KAEQmgkZ7OaIyUAxmlh6Bca4cJctpar9Er+tH8/JsxAwT+xaeAfD
         5j7gTj+VegLEGvrMvH3+nh16QV3zVSIjPcn9OXIuHsASGz7+dHjpjNjg32cJqJK2LCtO
         phbA==
X-Gm-Message-State: AOAM530f0P+rzxnyVubzezXvxT5GqMwrORqm93x0a4r1XPW5rcpeIrF8
        MPu0+6ziLyTLbl+f3Que0k4=
X-Google-Smtp-Source: ABdhPJyCoL6N6rUUeGy4eq3W5yFHSPGpFuBIfsgzXN2zEsBpdEUCitL7AZgcrL4LpmkXBCGNCzkJdg==
X-Received: by 2002:a63:79c7:: with SMTP id u190mr8202981pgc.378.1633756810547;
        Fri, 08 Oct 2021 22:20:10 -0700 (PDT)
Received: from user ([223.230.43.197])
        by smtp.gmail.com with ESMTPSA id k17sm881666pff.214.2021.10.08.22.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 22:20:10 -0700 (PDT)
Date:   Sat, 9 Oct 2021 10:50:04 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, hdegoede@redhat.com,
        deborahbrouwer3563@gmail.com, marcocesati@gmail.com,
        linux@roeck-us.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: rtl8723bs: core: remove empty else section
Message-ID: <YWEmhBt3e0dNKl1G@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the empty else section in rtw_make_wlanhdr().

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_xmit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 46054d6a1fb5..34505b35a7f3 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -977,7 +977,6 @@ s32 rtw_make_wlanhdr(struct adapter *padapter, u8 *hdr, struct pkt_attrib *pattr
 				}
 			}
 		}
-	} else {
 	}

 exit:
--
2.32.0

