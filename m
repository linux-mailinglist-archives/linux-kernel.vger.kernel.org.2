Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8C940B237
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbhINO4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:56:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231816AbhINO4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:56:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B8A960FD7;
        Tue, 14 Sep 2021 14:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631631328;
        bh=xP0GIfd+EZ5UAddK+nHIS6wuNIEIjdABJRHeANPwTrw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eLtmU7RKiOMnKM7OQP9iGQJXQnd5aacbttEPuOuWHbgMm2Iw7Ar9GtS/tB+Ora1hD
         K2yki83IGy/TO4eboTmiFBax4uQk4+sbxgDuxR4krpr9oHfnuA0jUGhD4vSWPJezOJ
         QAXQ3mAnvCEErxsPmIhEH/N9kZ4sFdB7K6MQiUBnXnnALBVRU53+BaOmejWe+5hEY7
         AVnrr2uuCugyidORn81BJhOzEsY03bQ/E/gINNjqdrjHPxwM1YOejmu0sLWfon+Gxx
         86vhP6JYm67x44Qd271ak5CTayW/N+o7yoipsNq4pYw6AueGCeMUBAfCIEQIFm9onc
         mLyesLzjxpX1g==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQ9qI-000L6k-Hr; Tue, 14 Sep 2021 16:55:26 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] ABI: stable/sysfs-module: better document modules
Date:   Tue, 14 Sep 2021 16:55:14 +0200
Message-Id: <9875b31c9c45c0b66600cf929325697222993076.1631630792.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631630792.git.mchehab+huawei@kernel.org>
References: <cover.1631630792.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of placing almost everything there as a text, use
the proper What: for each component of the ABI.

This allows it to be better documented and parsed by
get_abi.pl.

While here, use wildcards for MODULENAME.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/stable/sysfs-module | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-module b/Documentation/ABI/stable/sysfs-module
index 6272ae5fb366..5c028af9921a 100644
--- a/Documentation/ABI/stable/sysfs-module
+++ b/Documentation/ABI/stable/sysfs-module
@@ -1,8 +1,7 @@
-What:		/sys/module
-Description:
-	The /sys/module tree consists of the following structure:
+The /sys/module tree consists of the following structure:
 
-	/sys/module/MODULENAME
+What:		/sys/module/<MODULENAME>
+Description:
 		The name of the module that is in the kernel.  This
 		module name will always show up if the module is loaded as a
 		dynamic module.  If it is built directly into the kernel, it
@@ -12,7 +11,8 @@ Description:
 		Note: The conditions of creation in the built-in case are not
 		by design and may be removed in the future.
 
-	/sys/module/MODULENAME/parameters
+What:		/sys/module/<MODULENAME>/parameters
+Description:
 		This directory contains individual files that are each
 		individual parameters of the module that are able to be
 		changed at runtime.  See the individual module
@@ -25,7 +25,8 @@ Description:
 		individual driver documentation for details as to the
 		stability of the different parameters.
 
-	/sys/module/MODULENAME/refcnt
+What:		/sys/module/<MODULENAME>/refcnt
+Description:
 		If the module is able to be unloaded from the kernel, this file
 		will contain the current reference count of the module.
 
-- 
2.31.1

