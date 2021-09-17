Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5B840F4B3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 11:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240821AbhIQJZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 05:25:34 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:48506
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245621AbhIQJVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 05:21:07 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D01A440268
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 09:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631870373;
        bh=p6HUPon1kszCQMILCC0vROc00hQT65Msl8k6wuLckrA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=GJLHNoo16H1pz8qSSZ8MO6oJyBzBL8mVk0VsOub+cvLhyG54/9spN72a2gLmk5mFp
         +WT4mbbsP6KnsYgMXuZ5240H9dFUnxgJXNofoYV96lO0zSMhbQPgnaI/n6jq24GZIo
         s8lFhY0wzpQBpCISyzdPNjJc6jtbgQWlEZbOyNp94ig0yrKhM9+yow+bP4F3u0ST2L
         NGsn1THc38BeqUASL1PQjJVPMz7WomhF6ZTDkitle7DHOXUen0VNdqMivX2aPA+64O
         QZFGCv+HyFTNsbXAtyucAJpdq4gX18Def0Fd30/gUQiPDJZYw3n36TsFnHx95mBVb+
         5NUPwBXU24MNw==
Received: by mail-wm1-f70.google.com with SMTP id b139-20020a1c8091000000b002fb33c467c8so4357899wmd.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 02:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p6HUPon1kszCQMILCC0vROc00hQT65Msl8k6wuLckrA=;
        b=2JewFP2TSSVjFHZ+DeGdV5qytOGQy5/YovVWZDfxnQyPRbJBSq2PPRi1bR+0Mi2A7s
         W5/+88rWo4xtasSCj5pybHFtNwnsLsS5RMx6QAMarWLl0nFTUL7lrl07nTgOZLtuTuq6
         YkjdGiMLE8I2NODudA317PCwtc+CXGSsozdZ0pf0WIjS4mix3Y2gTipFVmLD25nxjdoD
         AFP3+CEa/GvQIA0g1TqADtMmzybWLc/wbX6WKH0YvdKlw0+8FDSQo53xtxscZdd/1C9f
         An1yz9Y2ZgpfeGGztcAH7yROgKEAydh/gDd215a/7lcezgvlRAI1ompVYQofjNaXoUNL
         Qf1Q==
X-Gm-Message-State: AOAM5320MdTYIqZbJmn6du6wyJAGb84940hI7nejkrnMTRNE0HVfnUX7
        JFpB2dburG++EKDoPpV1i/RBOEqz+gB4pZaNgZPrj81erMoA26flVS5FXvF2oFYjW5A1qefACto
        NGhtvzX/Rtk9moWNZsH3inVKeK3uctdaBvtF+rNY7WQ==
X-Received: by 2002:adf:fcca:: with SMTP id f10mr10954248wrs.304.1631870373494;
        Fri, 17 Sep 2021 02:19:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqXxbeZD6oTBDvipoUVLNYKgzKbf56C8E7jiR0bRAuCgNvovbTiVkTx/4l+xFvSd/2Nf6HLg==
X-Received: by 2002:adf:fcca:: with SMTP id f10mr10954236wrs.304.1631870373381;
        Fri, 17 Sep 2021 02:19:33 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id p1sm5678354wmi.30.2021.09.17.02.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 02:19:32 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 3/3] USB: cdc-acm: remove duplicate USB device ID
Date:   Fri, 17 Sep 2021 11:18:49 +0200
Message-Id: <20210917091849.18692-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210917091849.18692-1-krzysztof.kozlowski@canonical.com>
References: <20210917091849.18692-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device 0x00e9 (Nokia 5320 XpressMusic) is already on the list.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/usb/class/cdc-acm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 8bbd8e29e60d..d77e30625f4d 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1848,7 +1848,6 @@ static const struct usb_device_id acm_ids[] = {
 	{ NOKIA_PCSUITE_ACM_INFO(0x0071), }, /* Nokia N82 */
 	{ NOKIA_PCSUITE_ACM_INFO(0x04F0), }, /* Nokia N95 & N95-3 NAM */
 	{ NOKIA_PCSUITE_ACM_INFO(0x0070), }, /* Nokia N95 8GB  */
-	{ NOKIA_PCSUITE_ACM_INFO(0x00e9), }, /* Nokia 5320 XpressMusic */
 	{ NOKIA_PCSUITE_ACM_INFO(0x0099), }, /* Nokia 6210 Navigator, RM-367 */
 	{ NOKIA_PCSUITE_ACM_INFO(0x0128), }, /* Nokia 6210 Navigator, RM-419 */
 	{ NOKIA_PCSUITE_ACM_INFO(0x008f), }, /* Nokia 6220 Classic */
-- 
2.30.2

