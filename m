Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B7F42E4FD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 02:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbhJOAEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 20:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhJOAEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 20:04:42 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CB3C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 17:02:36 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t2so23261722wrb.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 17:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NJ9h42EZq8V8uTouqjvpCukohjQ9nZfHHgB0TycmMIw=;
        b=R0zAUSmojL5KI/7M53aTElLzbIT3uHUA22GUriEBCrFpOfsheRN0osk804I/tADXz5
         2VZrqgitHi8VxW+iPFwo4Aikx7BpA57/BcnNNaaXtWo3RmxMCGQxZaHgamkVX9YzJmHZ
         Pvg0iTpIx4pg/sFrrbRa9k07pcBrkF0BAeBt3ADjVhW2992+px1ht2ZER/3n5dG+EDff
         IJvjV/djYlunF46NjPu1L+IGD/eHEfqZSQ5qHCkLblB4kKMNZrodmSg91UQwcNPfGzZm
         zlWDaPQThPQgTe7dfnbO+h+GhOEduzBBRCsBWYozfpm8xG121Bxz3gr/G5l3EKNHDmBa
         sN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NJ9h42EZq8V8uTouqjvpCukohjQ9nZfHHgB0TycmMIw=;
        b=KMORd5e7ObtCHVW6v4NPtuH+rhaIFHwxdbocvqjlJYxwatioiUIBxSX5cV9o0qe+oB
         SAXycxgx84m1JMwX+Wo9caU6evP+qWAGiRgVQh87m4rsJHnNdMjanf3FKqR9xrVJSgxF
         Rz63Tao3y2AMnCsMTvZvtcUneT01GvHGNW8RgETZxLUNBiwI7F/sYDG16Nep+VMmby9j
         j5sEo3y5cRFQz/xmqmcPXdnbx1teNIXH/wHU17YWJ2AXdyjn4BDH4anYPXhHeNBEbNUl
         E6cxu+h8wQCLQhMUoLWJ8g4DfIY1nFK8IU18z/MSQyIeJwhpTJy0mC6e+KyfXRZcqXjE
         hqww==
X-Gm-Message-State: AOAM533eQl3/TAatVkh6eaG4rqtlIAWVDxHpZ8eSaN7VMd4E31TEQuoa
        PQ/g84zo7m+JjUdeWCyZRremfA==
X-Google-Smtp-Source: ABdhPJy6u3Pn1Ya+r5+UZe7oicb5emKBZw0WhCRDptFGPB4wevvGZLR6bbEUcnppFwAmSgSaYp19og==
X-Received: by 2002:adf:de0e:: with SMTP id b14mr10451098wrm.271.1634256155106;
        Thu, 14 Oct 2021 17:02:35 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id l16sm3534684wmj.33.2021.10.14.17.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 17:02:34 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: remove MSG_88E calls from hal/usb_halinit.c
Date:   Fri, 15 Oct 2021 01:02:33 +0100
Message-Id: <20211015000233.842-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove both MSG_88E calls from hal/usb_halinit.c, as these calls serve
no purpose other than to print the name of the function they are in
(_ReadAdapterInfo8188EU) on entry and on exit, with a timing of the
function, which is better accomplished by other means. Also remove
the jiffies assignment at the start of the function, as it is no
longer used.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/hal/usb_halinit.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index f6db5b05e6e7..abbd107ad3c1 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1073,15 +1073,9 @@ static void _ReadRFType(struct adapter *Adapter)
 
 static int _ReadAdapterInfo8188EU(struct adapter *Adapter)
 {
-	u32 start = jiffies;
-
-	MSG_88E("====> %s\n", __func__);
-
 	_ReadRFType(Adapter);/* rf_chip -> _InitRFType() */
 	_ReadPROMContent(Adapter);
 
-	MSG_88E("<==== %s in %d ms\n", __func__, rtw_get_passing_time_ms(start));
-
 	return _SUCCESS;
 }
 
-- 
2.31.1

