Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45DA640B0FA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbhINOhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:37:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233880AbhINOeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:34:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA8A26124E;
        Tue, 14 Sep 2021 14:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631629970;
        bh=VU1FdXfqgwu2xC6IKLl/1hUB4FG2TU42WbTm0oHgE54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oVKpZ4fjo8hcvP7tIFxs8z4c5s6sgCi18/TvwAWZPGxfBgZ+qVw+ifJuff3j6dL5z
         aP23M0ONHkO3unD9yG+qj8ULCdB/9IzZRBqcces5ZMMd6DqZ4r0GfahGW7JjMMQ+2R
         f7TspFKzQOIHhEbyxBPT4aHjoVo5xnuQkP8SPGC06mCFJTHsINjXtGkUIYqjn46OMo
         2UYpDFu+CZ+d2RDPQIUKcWmoGHRJJl5nxwdqAi4BTLdjiSCMwQRoTCutGhJTKr7Vcw
         uJmnzotQ9QiguEe9zbrIp8/p9jfj7+dnU/4cPg4Ek/FEMpbjj047PsQmHViU+iwMbJ
         NFcD8LWoXqNYA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQ9UO-000KlI-48; Tue, 14 Sep 2021 16:32:48 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/29] ABI: sysfs-class-gnss: use wildcards on What definitions
Date:   Tue, 14 Sep 2021 16:32:32 +0200
Message-Id: <96f8a52482a789931820d197f3a288556c47e46d.1631629496.git.mchehab+huawei@kernel.org>
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
 Documentation/ABI/testing/sysfs-class-gnss | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-gnss b/Documentation/ABI/testing/sysfs-class-gnss
index c8553d972edd..9650f3a7fc03 100644
--- a/Documentation/ABI/testing/sysfs-class-gnss
+++ b/Documentation/ABI/testing/sysfs-class-gnss
@@ -1,4 +1,4 @@
-What:		/sys/class/gnss/gnssN/type
+What:		/sys/class/gnss/gnss<N>/type
 Date:		May 2018
 KernelVersion:	4.18
 Contact:	Johan Hovold <johan@kernel.org>
-- 
2.31.1

