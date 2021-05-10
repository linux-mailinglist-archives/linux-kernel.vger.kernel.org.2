Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F60378236
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbhEJKdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:33:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231186AbhEJK3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:29:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA65A616E9;
        Mon, 10 May 2021 10:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620642443;
        bh=ql3fH9YF+Tp5Cdc+ks9xGMNWAcomJ3IyUAsw5MhHPbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=frxEZ0X2fnSoTgU9+JLGE5I7t/YU/G9oiXxRS1X0xW2Rv+v8hoiKZPVF6zZK6gmuK
         YWraBoSxpZGipN4NdE4hqBK52JTen8IA1LsfqLifc5tF7W8C+WUVaqz8X5FZ39OZBs
         VeQ1meZ6FZVB53BiRJuawwZv49MOAYRIh/piw8Dxtp5IfRCR3wlzFrc8s9+xD7ISX5
         2tVOlYb5BhDw77vso25ycg41imjrpl1aK40Ev8uKhIz/hqvflrvPJHmSsiA+ZSdZxE
         2mIYEZVS/u4bXDyph0ZTenGw+N40Gpjcgkr5xTN0nTAo8go9WORp7Sicj56oXYjY+N
         8m+X5ej6mV+Cg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lg38C-000UOW-E6; Mon, 10 May 2021 12:27:20 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/53] docs: ABI: remove some spurious characters
Date:   Mon, 10 May 2021 12:26:15 +0200
Message-Id: <6d774ad6cb3795a177309503a39f8f1b5e309d64.1620641727.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620641727.git.mchehab+huawei@kernel.org>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KernelVersion tag contains some spurious UTF-8 characters
for no reason. Drop them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/testing/sysfs-module | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-module b/Documentation/ABI/testing/sysfs-module
index a485434d2a0f..88bddf192ceb 100644
--- a/Documentation/ABI/testing/sysfs-module
+++ b/Documentation/ABI/testing/sysfs-module
@@ -37,13 +37,13 @@ Description:	Maximum time allowed for periodic transfers per microframe (μs)
 
 What:		/sys/module/*/{coresize,initsize}
 Date:		Jan 2012
-KernelVersion:»·3.3
+KernelVersion:	3.3
 Contact:	Kay Sievers <kay.sievers@vrfy.org>
 Description:	Module size in bytes.
 
 What:		/sys/module/*/taint
 Date:		Jan 2012
-KernelVersion:»·3.3
+KernelVersion:	3.3
 Contact:	Kay Sievers <kay.sievers@vrfy.org>
 Description:	Module taint flags:
 			==  =====================
-- 
2.30.2

