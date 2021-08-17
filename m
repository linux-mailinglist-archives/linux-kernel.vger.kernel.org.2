Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0823EE45D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 04:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236550AbhHQC1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 22:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbhHQC1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 22:27:13 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0C2C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 19:26:41 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so2274723pjn.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 19:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=FWNnDIf7lR/tz2VZKV6IB/1yvEwFpEjUtpbKurshWbk=;
        b=ASqMWxEKgXs1bymmIIZU51IAFsCKQaUQRblmjypHS3OWUnJb6FBLFQbAHMQ0ERCei3
         SQRCkIbVH2H526xT+bV27fciVbykdeliBporLf9DiVCTCwzX2zO5k33oWviHxeAS5ED5
         ulWpP20UPmlUd2cibBn6yqi5Fp+8vgfZP7wQlR6snfurHqgFCDMN5v12LKlzxZNn6Nra
         29Q652TgfYkCXVJ2aIYMvwQVxHkgiweARBoWbt0T7exeZqBXOmWZCbAPJ/fR2MPHLBFC
         pJa1WzYXZ8ee6dTGqjfcF2CM6Qp1ounbybw30loPmnjL0RE/EFLyW7LxMPMOeIVxYSL3
         0IQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FWNnDIf7lR/tz2VZKV6IB/1yvEwFpEjUtpbKurshWbk=;
        b=KgH/jwb6ObzPVapVnj0rxeKh9UkF9yqs1I0LPE2GEEb9O7tGYsfIe1qD2qDco6Sg44
         LbrBI6t2kZ+flWolaoejvSqRf9O2R+gJgciwTVv9dYnsec+zjsK8Bf1SfZtiTV9Bl5xU
         TePZ8QL518tdVLCmOQcgoO9yG4SI9BB0C0QFsarQAeDBxzG6Xazpy3vVnDUx2u2Ukgey
         brYMIQlQGr+k2vVnGN/GTbdu2UC/7ckz4cFHFtGqh70iWWgF77CLWgvb0XjbWMiRJ/Gv
         OgqBtiWHfOaZkTEmwMVfIv0IW0CN2MXm04FHvueCLdR1rNnzJWdMmIOiOZU/kTRha6dM
         oTeA==
X-Gm-Message-State: AOAM5337JZdmpUVhQ9I0Fw9AnmrOYdGZYaS1LU5Nq/yl36d1S0DDQ6GK
        usdjvIZB17FatiK/TjOFUYU=
X-Google-Smtp-Source: ABdhPJxmu+4ykKpn6leZGqXVL7tzI6yNh973tz7VdUisKjXeWR6Gj1z8Zd7fL4/WHtiHTJTbCY2fkg==
X-Received: by 2002:a17:90a:1616:: with SMTP id n22mr1111887pja.141.1629167200979;
        Mon, 16 Aug 2021 19:26:40 -0700 (PDT)
Received: from abhishek-Lenovo-ideapad-110-15AST ([103.58.155.246])
        by smtp.gmail.com with ESMTPSA id q13sm391431pjq.10.2021.08.16.19.26.40
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 16 Aug 2021 19:26:40 -0700 (PDT)
From:   Abhishek Anand Kulkarni <kulkarniabhishekanand@gmail.com>
X-Google-Original-From: Abhishek Anand Kulkarni <kulkaraniabhishekanand@gmail.com>
Date:   Tue, 17 Aug 2021 07:56:38 +0530
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kulkarniabhishekanand@gmail.com
Subject: [PATCH] staging: r8188eu: Add spaces before and after logical '&'
Message-ID: <20210817022628.GA6595@abhishek-Lenovo-ideapad-110-15AST>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix Checkpatch.pl warning to add space before and after logical '&'
operator

Signed-off-by: Abhishek Anand Kulkarni <kulkaraniabhishekanand@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ioctl_set.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
index a7f966a..570f25f 100644
--- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
@@ -630,7 +630,7 @@ u8 rtw_set_802_11_add_key(struct adapter *padapter, struct ndis_802_11_key *key)
 		struct ndis_802_11_wep *wep = &padapter->securitypriv.ndiswep;
 
 		wep->Length = len;
-		keyindex = key->KeyIndex&0x7fffffff;
+		keyindex = key->KeyIndex & 0x7fffffff;
 		wep->KeyIndex = keyindex ;
 		wep->KeyLength = key->KeyLength;
 
-- 
2.7.4

