Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F7E40B0CF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbhINOgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:36:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233803AbhINOeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:34:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8EA0561107;
        Tue, 14 Sep 2021 14:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631629970;
        bh=JHQNNdD39Wp5Jh4navc1VgZuL/mfT3JryOKHMWmLhw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YDyQ9vMGIefCORpBdZTVVbiW6BfkcQ+z9QAAmbTrWlzF0rtPpVuc81kkTMaumtNjY
         TmuXJRJk6QawG0Hdl4HvnW+vR6p95+h3QQ/4+maYQ62FEStR9NlkU5dWF19r3XjFMb
         zDM8Q8xEBiOb5GTWS7D2ph23DoOCy9HXe/3SbxwG06KVaH0myHKRGLyaf29CUKe8T3
         4nRZdCuFuG1znxXEl+UEOC2rj+i9jnVpDp91TCSo8+ugYBZb4SVzm3b/TcWJi222I+
         Wgzb/xY8EFJFHMpf+tC/OGyfS0ZBQoVoqxCU4WvM8blCfJGrTb5A5vijJWNyg+yO7c
         2V90rNy0DuPUQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQ9UO-000Kl6-04; Tue, 14 Sep 2021 16:32:48 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Carlos Bilbao <bilbao@vt.edu>,
        Leon Romanovsky <leon@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/29] ABI: sysfs-bus-pci: use wildcards on What definitions
Date:   Tue, 14 Sep 2021 16:32:29 +0200
Message-Id: <86b40be1fde43adf059797e112b8aafd70e554b9.1631629496.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631629496.git.mchehab+huawei@kernel.org>
References: <cover.1631629496.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An "N" upper letter is not a wildcard, nor can easily be identified
by script, specially since the USB sysfs define things like.
bNumInterfaces. Use, instead, <N>, in order to let script/get_abi.pl
to convert it into a Regex.

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

