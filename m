Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74FE3372476
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 04:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbhEDCda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 22:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhEDCd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 22:33:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3C8C061574
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 19:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=aJDaz9h61ALMY/jeCMMqJO35KTqiD4vZqxr3/+fQmDI=; b=dkodewbnM4OCf2HZEoNP80FOUj
        6CTIpNIyXfaN0yBJ7iJ34fRjPfCpcx64byL097owTnukLnkxMVa/1DIuA8160RyhiTyJTBqdSmMZe
        fTaCN9vKqm0fCl8IBq99YQhE06A4ZXLXS6P/LIxJejydULCpxuka9HXKogJ7DVEHS1topsOc618rr
        +l7qoNyOncQGAVsXFrl7vmhhYbs2RKIHjS2t65isG17smxxcor7IQqOvjIBMy6GtpMpmq7SH7wbxk
        XkRBp1a/KEAMf0s8XClu9uCNVZ3kUSZYfVWCpG20+G3Lo4wVdLkNsFoR38PiGMQX/cPZTqS1061ua
        IYx1VHeg==;
Received: from [2601:1c0:6280:3f0::df68] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ldkrH-00Fy2h-0w; Tue, 04 May 2021 02:32:26 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH] MFD: mp2629: select MFD_CORE to fix build error
Date:   Mon,  3 May 2021 19:32:18 -0700
Message-Id: <20210504023218.20553-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MFD_MP2629 should select MFD_CORE to a prevent build error:

ERROR: modpost: "devm_mfd_add_devices" [drivers/mfd/mp2629.ko] undefined!

Fixes: 06081646450e ("mfd: mp2629: Add support for mps battery charger")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Saravanan Sekar <sravanhome@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20210503.orig/drivers/mfd/Kconfig
+++ linux-next-20210503/drivers/mfd/Kconfig
@@ -465,6 +465,7 @@ config MFD_MP2629
 	tristate "Monolithic Power Systems MP2629 ADC and Battery charger"
 	depends on I2C
 	select REGMAP_I2C
+	select MFD_CORE
 	help
 	  Select this option to enable support for Monolithic Power Systems
 	  battery charger. This provides ADC, thermal and battery charger power
