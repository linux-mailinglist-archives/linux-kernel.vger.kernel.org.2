Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B8E40D578
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235738AbhIPJDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:03:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235423AbhIPJBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:01:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A803861283;
        Thu, 16 Sep 2021 09:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631782802;
        bh=xXwjqTWtRJtJwiUp53Gn44fMKhY9RahEOID2kDbDrnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lz16r8AseUh8i9/xxTc//g+ChTgHp4kq4Lgd33/nxPhvf+cEpW0S4nbiWFiFOoKWI
         eB0Icrerpb+eyLLBmKO61cxbfnttRMkOprEM70L3Mr+q2JRzIiTS7BD0j1K6BrCH0/
         yw9qAmHAB/RCq9TduCC01JmjiC05UV63O0jF+ZKgYN663sUFFRSFoMJ2DQW5fWq9lq
         VwKaBHhbLJyusRqW9O1lzNgmyaafyJbZ2ltJPt7P0NH3+CCOaxRJC/+PdMHQNSSdx0
         WYF6GJtW3UAzVP/eGzfvu9MRLjX7wCYmtlEEdEvQ667mJaSp9Fi/3UcVhV+d8c0bVQ
         rAuRLmO9C2CiQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQnFQ-001qkS-Tv; Thu, 16 Sep 2021 11:00:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Carlos Bilbao <bilbao@vt.edu>,
        Leon Romanovsky <leon@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Narendra K <narendra_k@dell.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 14/30] ABI: sysfs-bus-pci: use wildcards on What definitions
Date:   Thu, 16 Sep 2021 10:59:41 +0200
Message-Id: <4ede4ec98e295f054f3e5a6f3f9393b5e3d5d2a7.1631782432.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631782432.git.mchehab+huawei@kernel.org>
References: <cover.1631782432.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An "N" upper letter is not a wildcard, nor can easily be identified
by script, specially since the USB sysfs define things like
bNumInterfaces. Use, instead, <N>, in order to let script/get_abi.pl
to convert it into a Regex.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/testing/sysfs-bus-pci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index d4ae03296861..191cbe9ae5ed 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -160,7 +160,7 @@ Description:
 		If the underlying VPD has a writable section then the
 		corresponding section of this file will be writable.
 
-What:		/sys/bus/pci/devices/.../virtfnN
+What:		/sys/bus/pci/devices/.../virtfn<N>
 Date:		March 2009
 Contact:	Yu Zhao <yu.zhao@intel.com>
 Description:
-- 
2.31.1

