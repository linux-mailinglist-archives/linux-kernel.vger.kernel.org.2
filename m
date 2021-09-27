Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C144195C7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 16:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbhI0OCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 10:02:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234716AbhI0OBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 10:01:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCC9F61266;
        Mon, 27 Sep 2021 13:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632751197;
        bh=pRwgBygJCF0uygrQacxkXypNnIIkSYPVhWcJIvDJP+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Afc7CKApuP93zxKkhdmMXgr1HeevKwd2lvd9mZA8UvYuYTgDl5vqqYZ9+kJHJnxB6
         nnuYUnvYX3lgCnZo3uddqmyuLzr3UNTeYdGQ+1wGOdoEScLOdjg2l8VpJ+d1OHzO/x
         RNMDwSb7y7+Zgb82dwv5XQtS5zREtXdRuxhOI1IpWxRX3MD479UtLdsKcXwKpR4Wrq
         6S2RRAy97VbTzBhB1M4Ofg4bUEEWZW3TtmQB+DUEDtWhfl9kH/KNUdZKzHXtZhMXz5
         I5ZIOK/2CZz4Q+ojwEbnUjlvoHljoXJoKDRPbL96AINszlO1gLZEkDBcn+S/Qvb/rN
         d3ESzHa7H7XEA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mUrAi-000Auc-2l; Mon, 27 Sep 2021 15:59:56 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/17] ABI: sysfs-bus-platform: add modalias description
Date:   Mon, 27 Sep 2021 15:59:50 +0200
Message-Id: <9cdebbad008886b1d09f5f3ac5d88bee19f08d97.1632750608.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632750608.git.mchehab+huawei@kernel.org>
References: <cover.1632750608.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the modalias parameter for platform devices, including
the ones exposed via devicetree.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH 00/17] at: https://lore.kernel.org/all/cover.1632750608.git.mchehab+huawei@kernel.org/

 Documentation/ABI/testing/sysfs-bus-platform | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-platform b/Documentation/ABI/testing/sysfs-bus-platform
index ff30728595ef..c4dfe7355c2d 100644
--- a/Documentation/ABI/testing/sysfs-bus-platform
+++ b/Documentation/ABI/testing/sysfs-bus-platform
@@ -42,3 +42,15 @@ Date:		August 2021
 Contact:	Barry Song <song.bao.hua@hisilicon.com>
 Description:
 		This attribute will show "msi" if <N> is a valid msi irq
+
+What:		/sys/bus/platform/devices/.../modalias
+Description:
+		Same as MODALIAS in the uevent at device creation.
+
+		A platform device that it is exposed via devicetree uses:
+
+			- of:N`of node name`T`type`
+
+		Other platform devices use, instead:
+
+			- platform:`driver name`
-- 
2.31.1

