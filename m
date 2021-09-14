Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4655140B0EB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbhINOg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:36:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233855AbhINOeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:34:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB5D661213;
        Tue, 14 Sep 2021 14:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631629970;
        bh=DBa6ZFMIA9te52fBlowrmL1vEcBXgwvULizWaYDAF9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qdt4Uq1+Edbhv1nbxcyCSU26rRAIQqkcFeLm5GyAtRm97VCJBy1CcqLaQjYGqrbno
         tSYME2pHdZQhcG0BgVjhAI0LPmNKj2lno2vri+ce5X0sON6O8R0CCqheZdSYGtYOx6
         zfThAiA0OgAcUlDSSGh3L6H+pqbywJlQiA9qnWZh9tA1SntIHumunAMa71hcv7PUXT
         mkw+MGRKwEpVSriYRt8qOSMZ5KbomqaWNUK+kcnofJN/cexbrtMArV8E/1tQb4BUwv
         rwoiUFh3xWVv7fWBmpWYQwpH31RHrDGwOymi1K6xJE3puOJchr4Im2Qfo7QT7SIbzX
         DRIT7sS5OsfAg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQ9UO-000Klc-BU; Tue, 14 Sep 2021 16:32:48 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 22/29] ABI: sysfs-class-rc-nuvoton: use wildcards on What definitions
Date:   Tue, 14 Sep 2021 16:32:37 +0200
Message-Id: <bdd6f32ebf675cd612a8dec726b6dad1515b7d30.1631629496.git.mchehab+huawei@kernel.org>
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
 Documentation/ABI/testing/sysfs-class-rc-nuvoton | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-rc-nuvoton b/Documentation/ABI/testing/sysfs-class-rc-nuvoton
index d3abe45f8690..f7bad8ecd08f 100644
--- a/Documentation/ABI/testing/sysfs-class-rc-nuvoton
+++ b/Documentation/ABI/testing/sysfs-class-rc-nuvoton
@@ -1,4 +1,4 @@
-What:		/sys/class/rc/rcN/wakeup_data
+What:		/sys/class/rc/rc<N>/wakeup_data
 Date:		Mar 2016
 KernelVersion:	4.6
 Contact:	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
-- 
2.31.1

