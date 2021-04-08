Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6CC358EAA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 22:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbhDHUpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 16:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhDHUpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 16:45:17 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CFEC061760;
        Thu,  8 Apr 2021 13:45:04 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j5so2511204wrn.4;
        Thu, 08 Apr 2021 13:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=I2uf88F1MX0D+/ieSTh4Dwgs5iH5yDVfXlgdaFvgyLY=;
        b=iLQaYA9ii9lu78nfawnJ1j3EnThTkKbwXfmYWnlD+/U7jNg54IkiZ2oafwoqsiPQmB
         bXDztdUBIbPdz5o99zGzRw2KZg9vbtjRnPgftRp7TxyTz68PKMUmaVXcESMvNVgZ3ZmZ
         HG8DIPq7a0/4u8whVHwTVPV9uWHiPbjXlVwmhL73FaQrNIl/ewoMrsl97+Whcye4jTHt
         VN0tFRDETneCHToNWF+aw74HYgtgTuVOTcnkgetKzSSygR8nGdp19G2somF84BBIG8/I
         wgv8MqKba/7QQcLvTD2aPcE9UkePb1cmOJ/E/qdNatzSXo01WtcE2A2O4nUHAXSRNUZW
         3odg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=I2uf88F1MX0D+/ieSTh4Dwgs5iH5yDVfXlgdaFvgyLY=;
        b=XRir7RsbFkk4bAG4SgSvDLV1U0FDvcTVbt9CFsQDqxXiwL//zM+U3aOr4A06VW/YFC
         inPBIpobjrWVnINlq20YR3ZkuyUIynLUPf/H3mLRgtSBxCbuvzLFgRK+AlEBXRWnD+Je
         YHEl24xOIW9rFyxzNcHf5yu4JewC+qy36OzN94wyUrbH+j+OzLtmC7UeUfh7LRauoNwZ
         yP/C6jzKlUN8S4y/6fgAEiSpDIspRaF3LIDG7HVcDYAKWJ3OE0B7r9fPDeRF+4z/X9Fm
         ZIwWjAhsjV6i8Zh7SgKou+if/l83Xry/9F5/vi2i/MQJlUekmGhYkrXkFd4FMyn7a/RT
         a86g==
X-Gm-Message-State: AOAM531ZFd37M1UbL+huc4K01UQvjXVTbBH48pX64IWAWzTQnUgaNwqQ
        ntJecKjGAzyrxlu+YaX020c=
X-Google-Smtp-Source: ABdhPJz9eH5hl3abnAet2ReLpQ9AF0Zt0z0vKdm5nhpwAuyLX7xec5aYXlictvG+iAmXJIvosyDaWg==
X-Received: by 2002:a5d:4686:: with SMTP id u6mr14043266wrq.60.1617914703550;
        Thu, 08 Apr 2021 13:45:03 -0700 (PDT)
Received: from LEGION ([39.46.7.73])
        by smtp.gmail.com with ESMTPSA id w9sm519597wmg.21.2021.04.08.13.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 13:45:03 -0700 (PDT)
Date:   Fri, 9 Apr 2021 01:44:57 +0500
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>
Cc:     musamaanjum@gmail.com, kernel-janitors@vger.kernel.org,
        colin.king@canonical.com, dan.carpenter@oracle.com
Subject: [PATCH] staging: rtl8723bs: Remove unnecessary code
Message-ID: <20210408204457.GA3079308@LEGION>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same code is executed when the condition "!show_errors" is true or
false. Remove the if condition from here. The original intension of this
condition was to not to report any error logs if condition was true. But
this driver doesn't has those logs added. So this if condition can be
removed.

Addresses-Coverity: ("Same code execution")
Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 1b60252545b3..2af66a18200d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -1000,8 +1000,6 @@ enum ParseRes rtw_ieee802_11_parse_elems(u8 *start, uint len,
 			break;
 		default:
 			unknown++;
-			if (!show_errors)
-				break;
 			break;
 		}
 
-- 
2.25.1

