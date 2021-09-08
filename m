Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96BC403C02
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 16:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351968AbhIHPAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 11:00:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233754AbhIHPAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 11:00:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CC5E6115C;
        Wed,  8 Sep 2021 14:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631113142;
        bh=hJAa8hcqeiDM+/Qqlnhml4tyTWniUKhXeti2Cw12wWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bxv+YLVsE/VLimRrKOF3A3mhABtKMOoRJHViJ1cAOCEJ3+dFsQZ8g76HckcjXuyQO
         WVgJBfobl125+5JML5VDaJhCHnf7JUbIcdKGmffXn0MJ2uH9ldm3eE7E2YeR96ECkX
         oHBzDkqXVwoaLWf8OpKuEk5JuFgg/EFUZmSA6KMOb1N1wHmenHqTT1KpxvrH1gW+mZ
         ++2EXRKCpfphiudKlf2lxopnCfRV6Uk4OVHkfwG74XJXVKJ//2h9z3hdxUjeEho6rD
         M9RbINGN3f1rJYnd3Z7oLmWKnxX108sBHutnC3lM1B/8SQgEmC+zYZFt7A6CoTGGdO
         AQdpT5BGv6Nkg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mNz2S-006r3t-RV; Wed, 08 Sep 2021 16:59:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] ABI: sysfs-module: better document module name parameter
Date:   Wed,  8 Sep 2021 16:58:52 +0200
Message-Id: <dc60b13a593ee3f95fa437da7a7f3d066b7b61d3.1631112725.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631112725.git.mchehab+huawei@kernel.org>
References: <cover.1631112725.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On almost all ABI documents, variable arguments are declared
as <foo_bar>. Change it here too, in order to allow replacing
such wildcards by regexes on a scriptable way.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/stable/sysfs-module | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-module b/Documentation/ABI/stable/sysfs-module
index 6272ae5fb366..c60c7a6f5aff 100644
--- a/Documentation/ABI/stable/sysfs-module
+++ b/Documentation/ABI/stable/sysfs-module
@@ -2,7 +2,7 @@ What:		/sys/module
 Description:
 	The /sys/module tree consists of the following structure:
 
-	/sys/module/MODULENAME
+	/sys/module/<MODULENAME>
 		The name of the module that is in the kernel.  This
 		module name will always show up if the module is loaded as a
 		dynamic module.  If it is built directly into the kernel, it
@@ -12,7 +12,7 @@ Description:
 		Note: The conditions of creation in the built-in case are not
 		by design and may be removed in the future.
 
-	/sys/module/MODULENAME/parameters
+	/sys/module/<MODULENAME>/parameters
 		This directory contains individual files that are each
 		individual parameters of the module that are able to be
 		changed at runtime.  See the individual module
@@ -25,10 +25,14 @@ Description:
 		individual driver documentation for details as to the
 		stability of the different parameters.
 
-	/sys/module/MODULENAME/refcnt
+	/sys/module/<MODULENAME>/refcnt
 		If the module is able to be unloaded from the kernel, this file
 		will contain the current reference count of the module.
 
 		Note: If the module is built into the kernel, or if the
 		CONFIG_MODULE_UNLOAD kernel configuration value is not enabled,
 		this file will not be present.
+
+	/sys/module/<MODULENAME>/srcversion
+		If the module source has MODULE_VERSION, this file will contain
+		the version of the source code.
-- 
2.31.1

