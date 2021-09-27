Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4924195C5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 16:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbhI0OCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 10:02:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234714AbhI0OBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 10:01:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CC786120A;
        Mon, 27 Sep 2021 13:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632751197;
        bh=89936j+tZ0jYDs1o/lOShxHhs+4GBHhMGHQyHIhavdo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NaNX8jYrbd6tyWzzCr3/mgaEm3wRqrnuQEyusSLuFW3aKY+3krAmDfmm0rqDkzZYh
         wEQupFMGtBbbvdgvxRRqnK3i2+MWHwi2D8uoqDPFdaDSmPbQn6JNsucPxtqOeV1Ebb
         SMYlkjFiMr2GIREYNLF9x5Mj5ciZLVaxUjKPnQzazQRQdL4bjUC2OR+yrldF3VFRqx
         OzjAMTPC9E7WTddHCnhdKWqRsRKg9RO6DmM/qzSX6A/s7b+RK1W63Mu5y7Pl/TgG2C
         7NRJfPbjT8wXgwGY0zF9vmc4mEnoTyuBU2W3VzKIzuoXSE/8YnI10KrBkKk7AgNH10
         ljECWsl+5MKag==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mUrAh-000AuM-Qu; Mon, 27 Sep 2021 15:59:55 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Rajat Jain <rajatja@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 13/17] ABI: sysfs-bus-usb: use a wildcard for interface name on What
Date:   Mon, 27 Sep 2021 15:59:46 +0200
Message-Id: <cec7048385b6a4779894e19af681226e60f4d8b9.1632750608.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632750608.git.mchehab+huawei@kernel.org>
References: <cover.1632750608.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use <INTERFACE> instead of INTERFACE, in order for the get_abi.pl
script to be able to identify this as a wildcard.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH 00/17] at: https://lore.kernel.org/all/cover.1632750608.git.mchehab+huawei@kernel.org/

 Documentation/ABI/testing/sysfs-bus-usb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
index 42103f0f54d6..7269077ce505 100644
--- a/Documentation/ABI/testing/sysfs-bus-usb
+++ b/Documentation/ABI/testing/sysfs-bus-usb
@@ -1,4 +1,4 @@
-What:		/sys/bus/usb/devices/INTERFACE/authorized
+What:		/sys/bus/usb/devices/<INTERFACE>/authorized
 Date:		August 2015
 Description:
 		This allows to authorize (1) or deauthorize (0)
-- 
2.31.1

