Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B904B41C371
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 13:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245356AbhI2Laq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 07:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhI2Lap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 07:30:45 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA688C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 04:29:04 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id v127so1540390wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 04:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=uFr7uJ6KTmQJHmnmWVFZMG4UoPxJgzcyn7oJlR9xeQQ=;
        b=Exknt2Km+rOM24URy9Y39g26h2kaTHwcxVisGHzVDjAJ7Vf8/upcldVViHRyeMClU2
         nmdmI39qk6t5WV3WNYa+uQnRDsywFT6jzgfMqpJrH3IsbhXRlabKklsYpVto/x48KdtY
         z8ZhbDHKXaHMhm4xC/I/6BU+RnZQjrIToyfumbUE03iIKKYYdTjKS3ZOWp2Ol//fO16Q
         nizCSIhcbvPcYzhhffyPZ9QMHJiA5kdWp9bPKPGgmZb4jpvATaG3uQd56mYL9u0IikEp
         sbfUWIeAuHRBjdnA3OWNAWVbJYH/CcUthyRvsqPlhFYAEJBl44zXbmqDiI2qsmbDmEzp
         8Deg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=uFr7uJ6KTmQJHmnmWVFZMG4UoPxJgzcyn7oJlR9xeQQ=;
        b=QSBBbDbWCp0nvB8x+XcPbyq5+fJ2riE/QfvdgVNWpFFSLtt6oxz+27Hu1/vDQwqfQT
         6Wp19pJTk/g+ZzgFl70J+ufdNvEqjYrztBQDsB4XQGurH/OBBN0cvc4bIgs3cu48D5Ui
         G47IFUMnkK/JE9IJka6zcXv8h0H7sHeqWlmWq3f8uUJMEng2R+1Wu0E+nYfC8vG4aLr3
         C1Ylz4O3uF+/gXFZvrroQjKakSAf/j9Md6XhpkOmc9VMcEXhVy+8n3GHm5beD7oIQeGY
         cZTU1XJ9AiijlcTT53e5IUKjlrig0A8nb19C+ARBcZKXMTN9kop6OsXe+TYrN5HCJb94
         5WzQ==
X-Gm-Message-State: AOAM531PHh4b3V1xRC1nVVN9xLvnjPK+obiSHvMirbztkA4jFvzuA+WJ
        2YD5sU7/Mcurj58VmPGbg52ZULSSCccgIalT
X-Google-Smtp-Source: ABdhPJywcrVgiD8Y+ZTWWUhoN9oSXmGDrjkJ9TwTYfQdV2oskhgQdVd4Q9KSswaIr3YzdnQO5grqqg==
X-Received: by 2002:a1c:1f10:: with SMTP id f16mr9837890wmf.179.1632914942977;
        Wed, 29 Sep 2021 04:29:02 -0700 (PDT)
Received: from ?IPv6:2a02:8084:20c7:8d80:b92e:b532:3d37:f10b? ([2a02:8084:20c7:8d80:b92e:b532:3d37:f10b])
        by smtp.gmail.com with ESMTPSA id j5sm2095159wrw.39.2021.09.29.04.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 04:29:02 -0700 (PDT)
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
From:   hallblazzar <hallblazzar@gmail.com>
Subject: [PATCH v2] staging: r8188eu: Fix misspelling in comment
Message-ID: <7bc392d5-11e4-7ad0-dab6-295ccadf63b9@gmail.com>
Date:   Wed, 29 Sep 2021 12:29:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As format check raised by scripts/checkpatch.pl, comment in the rtw_ap.c
looks misspelled by accident. Help fix it.

The original error is as below shows:

CHECK: 'followign' may be misspelled - perhaps 'following'?
+Set to 0 (HT pure) under the followign conditions

Signed-off-by: Siou-Jhih, Guo <hallblazzar@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index 94e02aad96b7..205168f960f6 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -744,7 +744,7 @@ void update_beacon(struct adapter *padapter, u8 ie_id, u8 *oui, u8 tx)
 
 /*
 op_mode
-Set to 0 (HT pure) under the followign conditions
+Set to 0 (HT pure) under the following conditions
     - all STAs in the BSS are 20/40 MHz HT in 20/40 MHz BSS or
     - all STAs in the BSS are 20 MHz HT in 20 MHz BSS
 Set to 1 (HT non-member protection) if there may be non-HT STAs
-- 
2.25.1

