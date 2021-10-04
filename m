Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD448421A88
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 01:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbhJDXWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 19:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbhJDXWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 19:22:54 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E7EC061749;
        Mon,  4 Oct 2021 16:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=lB9klwC6rOjyM0N8bWwN1xpjBQyssT4L9VIpQtP7fP8=; b=t8Nl04LLGQN7l/8hLjSQbU9tx5
        wTCzED2f1xX8RisVP2fIokIbHQaVyBpSU+uB2U+zRgngCoNPg6CWHgnLZpkilY/cxCQxPfwykKWrp
        2Saypf/97tvJkRSn4jZSmUcFbuezIePgX3C+nF+LCoVGHIZfdT9CtYfQ4vzzCYX2wHIBUpl+6wr8W
        i260b28NLvdlRmMNaBnmoPn6JRrngwYbi/yqE9N3D1Q2BQX6cPriVTjmJTto3aZNP47dFHPl4KcfY
        xIet0Abmv8DT4kvS46IxieH0c1nhY02UFoOlFLL8T07x7QNub45XA7ekQEufYcssUm87OYHLhOIDN
        T86zC31A==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXXGa-008O7O-0r; Mon, 04 Oct 2021 23:21:04 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH] usb: typec: STUSB160X should select REGMAP_I2C
Date:   Mon,  4 Oct 2021 16:21:03 -0700
Message-Id: <20211004232103.23893-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

REGMAP_I2C is not a user visible kconfig symbol so driver configs
should not "depend on" it. They should depend on I2C and then
select REGMAP_I2C.

If this worked, it was only because some other driver had set/enabled
REGMAP_I2C.

Fixes: da0cb6310094 ("usb: typec: add support for STUSB160x Type-C controller family")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Amelie Delaunay <amelie.delaunay@st.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
---
 drivers/usb/typec/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- lnx-515-rc4.orig/drivers/usb/typec/Kconfig
+++ lnx-515-rc4/drivers/usb/typec/Kconfig
@@ -65,9 +65,9 @@ config TYPEC_HD3SS3220
 
 config TYPEC_STUSB160X
 	tristate "STMicroelectronics STUSB160x Type-C controller driver"
-	depends on I2C
-	depends on REGMAP_I2C
 	depends on USB_ROLE_SWITCH || !USB_ROLE_SWITCH
+	depends on I2C
+	select REGMAP_I2C
 	help
 	  Say Y or M here if your system has STMicroelectronics STUSB160x
 	  Type-C port controller.
