Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FD34195B4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 16:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbhI0OBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 10:01:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234640AbhI0OBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 10:01:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4231E60F94;
        Mon, 27 Sep 2021 13:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632751197;
        bh=AcWq79anN2Ti5Sqe7EzkkB6TU7BL7No/sr9GYRjszlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=asY3pPbVp6DRWK7hF2Ozmu7Lb17nHzwcDTwfOUzL8AVznOuonHTHfxAUoy7FNmEPa
         wUxNI7eLLtTw8CTsl7HXPdB4KMd6ZyJXLZDV8OOT3Xv4WSdCB0Hb99PVFO6IY4U9Th
         mOKJUBwCcc3R7eSyRYamgBfr0VGPB0QCdZ/o57kOYaEjIQe7OVigM0pRDg30e7tNTA
         4YFCIgXuYuhD/KZTlQElyxlpM9QoZKwOgYnZMts94JTazKivXeyZygoDKCe3PBcMGX
         jPcQMk1q/YzrzQRpnQUkg/gKk3DE8BGC0fqGvSAg33IpCY1asZj3AqLeddxlVWHNKH
         55sNbLMNiLU2g==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mUrAh-000Ati-BO; Mon, 27 Sep 2021 15:59:55 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Oded Gabbay <oded.gabbay@gmail.com>, Tom Rix <trix@redhat.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/17] ABI: testing/sysfs-module: document initstate
Date:   Mon, 27 Sep 2021 15:59:36 +0200
Message-Id: <b9c72187abce2b0efd1c41646b1d0c66104d90e4.1632750608.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632750608.git.mchehab+huawei@kernel.org>
References: <cover.1632750608.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Despite being an old ABI, present on all modules, its documentation
is missing. Add it, based on the original commit.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH 00/17] at: https://lore.kernel.org/all/cover.1632750608.git.mchehab+huawei@kernel.org/

 Documentation/ABI/testing/sysfs-module | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-module b/Documentation/ABI/testing/sysfs-module
index 88bddf192ceb..08886367d047 100644
--- a/Documentation/ABI/testing/sysfs-module
+++ b/Documentation/ABI/testing/sysfs-module
@@ -41,6 +41,13 @@ KernelVersion:	3.3
 Contact:	Kay Sievers <kay.sievers@vrfy.org>
 Description:	Module size in bytes.
 
+What:		/sys/module/*/initstate
+Date:		Nov 2006
+KernelVersion:	2.6.19
+Contact:	Kay Sievers <kay.sievers@vrfy.org>
+Description:	Show the initialization state(live, coming, going) of
+		the module.
+
 What:		/sys/module/*/taint
 Date:		Jan 2012
 KernelVersion:	3.3
-- 
2.31.1

