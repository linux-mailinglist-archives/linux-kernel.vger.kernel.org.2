Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685D83F757A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 14:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240915AbhHYM6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 08:58:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34755 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229547AbhHYM6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 08:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629896270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ofpBn7OPoa/qED0CwXqSoNO7Orrei4dP7CZWPoRhlw8=;
        b=gTFC/dJ66JaXCn38JXp9uJYzywwpBYajOTAETnepfKbMJuNxh13ZwwjTmPorPuGdGNm330
        3GPwnkwvznIGWO7Aix1GIin9rw+BvILtfhor+Y8x7sEDYTVlD4VW75DE9buX+Dv21mMZng
        pwL9lX2ULrZz/CfBPIDJVxLSabz7CCc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-rY4UtSuPO8qKfvIoxkOVZA-1; Wed, 25 Aug 2021 08:57:48 -0400
X-MC-Unique: rY4UtSuPO8qKfvIoxkOVZA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42E9E107ACF5;
        Wed, 25 Aug 2021 12:57:47 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.7a2m.lab.eng.bos.redhat.com [10.16.222.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C12486788B;
        Wed, 25 Aug 2021 12:57:46 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Prarit Bhargava <prarit@redhat.com>,
        Lee Jones <lee.jones@linaro.org>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] mfd: intel_pmt: Only compile on x86
Date:   Wed, 25 Aug 2021 08:57:35 -0400
Message-Id: <20210825125735.621799-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intel_pmt driver shows up as a compile option for all arches but is
32-bit and 64-bit x86 specific.

Add a CONFIG dependency on X86 for intel_pmt.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: David E. Box <david.e.box@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mfd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 6a3fd2d75f96..0f12b00955b4 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -676,7 +676,7 @@ config MFD_INTEL_PMC_BXT
 
 config MFD_INTEL_PMT
 	tristate "Intel Platform Monitoring Technology (PMT) support"
-	depends on PCI
+	depends on X86 && PCI
 	select MFD_CORE
 	help
 	  The Intel Platform Monitoring Technology (PMT) is an interface that
-- 
2.31.1

