Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17CE732BE02
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445360AbhCCQu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 11:50:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:47158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350209AbhCCMWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 07:22:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A2A164DF2;
        Wed,  3 Mar 2021 08:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614760942;
        bh=FRgMk+OAmFAEpU9UR2Llp/Xzz5XikkDKRFOVhCQLfOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=piRHX4X9mqP8OhBnzoEcWJnGVjmsF3VKwjWy/H6p/jP0BVsAXbbR+a8JrSQsB5OVe
         EYSHmrQtZ6KgHH4dbID61DeG9ubb1A1+O1urXd8g2oLusGHgpoDL+OyA/ZMs86WdIs
         wvZktXeijQSTqiKjim7b/fBIJDjHt5Qx3xoK7MdhFD8rYqG6KQQ8DqF8xazonPnHgQ
         +8WjH4TFmho3rfHZWvXyV5ieOnLoglKsXCJt4kwg+wleoXTF3Il7hLH8KNUdCdI+rQ
         +B2GY8XDkoiu0TYaeV9/N6AOKvDLIrpOdvxlh96FLs32atLdLs6HQTkHTTI+l/jCrt
         TBVQQTOJBv3vg==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lHN5I-000rIv-2x; Wed, 03 Mar 2021 09:42:20 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Andy Shevchenko" <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/kernel-doc: ignore identifier on anonymous enums
Date:   Wed,  3 Mar 2021 09:42:14 +0100
Message-Id: <055ad57879f1b9381b90879e00f72fde1c3a5647.1614760910.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <CAHp75VcG544HZ1j_6jvZoba6kEjKXXfZ8deJWmwNQ08mC35NrA@mail.gmail.com>
References: <CAHp75VcG544HZ1j_6jvZoba6kEjKXXfZ8deJWmwNQ08mC35NrA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When anonymous enums are used, the identifier is empty.

While, IMO, it should be avoided the usage of such enums,
adding support for it is not hard.

So, postpone the check for empty identifiers to happen
only at the dump phase.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 68df17877384..f8ebbf5e9f12 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1412,9 +1412,14 @@ sub dump_enum($$) {
 
     if ($members) {
 	if ($identifier ne $declaration_name) {
-	    print STDERR "${file}:$.: warning: expecting prototype for enum $identifier. Prototype was for enum $declaration_name instead\n";
+	    if ($identifier eq "") {
+		print STDERR "${file}:$.: warning: wrong kernel-doc identifier on line:\n";
+	    } else {
+		print STDERR "${file}:$.: warning: expecting prototype for enum $identifier. Prototype was for enum $declaration_name instead\n";
+	    }
 	    return;
 	}
+	$declaration_name = "(anonymous)" if ($declaration_name eq "");
 
 	my %_members;
 
@@ -2132,7 +2137,7 @@ sub process_name($$) {
 	    ++$warnings;
 	}
 
-	if ($identifier eq "") {
+	if ($identifier eq "" && $decl_type ne "enum") {
 	    print STDERR "${file}:$.: warning: wrong kernel-doc identifier on line:\n";
 	    print STDERR $_;
 	    ++$warnings;
-- 
2.29.2

