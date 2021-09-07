Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB28402454
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 09:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbhIGHax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 03:30:53 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:55908
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232056AbhIGHau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 03:30:50 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 440BA3F101;
        Tue,  7 Sep 2021 07:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1630999782;
        bh=CjLbqfN2yNEt3Pqk3AxMfUe2cR3Bz7R0AKeNAxMZH7A=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=QkMEZc8EUHRnRNRiU8nDWQT+444XlNfVh1HLMT95XSmUyVJT8YFE8WieWt7p0dMQj
         MHOT6F/xATR6AlRhhu92+fKS3DTu3AE0B4MOpI+/58tlBbKJMl/0N0jdZ90Pqfkpjt
         +HA66J7892yL+6LnGDmjZHakrJtX/KuYad2r3ocdpC5EGZngGoGI1u41Xl+9GZJ/5e
         c9EKo6rMwczHXkRET/l3mJUc+s3fnc0Nd3ujJbF2cjaDf8AysqQ7vrWjPaUisrcCP1
         4rcfgqT8QIDW27Msf+gJQPZaYgT09Xtsw4QOagibeTQ5vsDrJYVLLFFxnmmY12dBV2
         9OmL2mN8xO1DQ==
From:   Colin King <colin.king@canonical.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/spelling.txt: add more spellings to spelling.txt
Date:   Tue,  7 Sep 2021 08:29:41 +0100
Message-Id: <20210907072941.7033-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Some of the more common spelling mistakes and typos that I've found
while fixing up spelling mistakes in the kernel in the past few months.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 scripts/spelling.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index 17fdc620d548..fd8f07317b8e 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -178,6 +178,7 @@ assum||assume
 assumtpion||assumption
 asuming||assuming
 asycronous||asynchronous
+asychronous||asynchronous
 asynchnous||asynchronous
 asynchromous||asynchronous
 asymetric||asymmetric
@@ -241,6 +242,7 @@ beter||better
 betweeen||between
 bianries||binaries
 bitmast||bitmask
+bitwiedh||bitwidth
 boardcast||broadcast
 borad||board
 boundry||boundary
@@ -265,7 +267,10 @@ calucate||calculate
 calulate||calculate
 cancelation||cancellation
 cancle||cancel
+cant||can't
+cant'||can't
 canot||cannot
+cann't||can't
 capabilites||capabilities
 capabilties||capabilities
 capabilty||capability
@@ -501,6 +506,7 @@ disble||disable
 disgest||digest
 disired||desired
 dispalying||displaying
+dissable||disable
 diplay||display
 directon||direction
 direcly||directly
@@ -595,6 +601,7 @@ exceded||exceeded
 exceds||exceeds
 exceeed||exceed
 excellant||excellent
+exchnage||exchange
 execeeded||exceeded
 execeeds||exceeds
 exeed||exceed
@@ -938,6 +945,7 @@ migrateable||migratable
 milliseonds||milliseconds
 minium||minimum
 minimam||minimum
+minimun||minimum
 miniumum||minimum
 minumum||minimum
 misalinged||misaligned
@@ -956,6 +964,7 @@ mmnemonic||mnemonic
 mnay||many
 modfiy||modify
 modifer||modifier
+modul||module
 modulues||modules
 momery||memory
 memomry||memory
@@ -1154,6 +1163,7 @@ programable||programmable
 programers||programmers
 programm||program
 programms||programs
+progres||progress
 progresss||progress
 prohibitted||prohibited
 prohibitting||prohibiting
@@ -1328,6 +1338,7 @@ servive||service
 setts||sets
 settting||setting
 shapshot||snapshot
+shoft||shift
 shotdown||shutdown
 shoud||should
 shouldnt||shouldn't
@@ -1439,6 +1450,7 @@ syfs||sysfs
 symetric||symmetric
 synax||syntax
 synchonized||synchronized
+synchronization||synchronization
 synchronuously||synchronously
 syncronize||synchronize
 syncronized||synchronized
@@ -1521,6 +1533,7 @@ unexpexted||unexpected
 unfortunatelly||unfortunately
 unifiy||unify
 uniterrupted||uninterrupted
+uninterruptable||uninterruptible
 unintialized||uninitialized
 unitialized||uninitialized
 unkmown||unknown
@@ -1553,6 +1566,7 @@ unuseful||useless
 unvalid||invalid
 upate||update
 upsupported||unsupported
+useable||usable
 usefule||useful
 usefull||useful
 usege||usage
@@ -1574,6 +1588,7 @@ varient||variant
 vaule||value
 verbse||verbose
 veify||verify
+verfication||verification
 veriosn||version
 verisons||versions
 verison||version
@@ -1586,6 +1601,7 @@ visiters||visitors
 vitual||virtual
 vunerable||vulnerable
 wakeus||wakeups
+was't||wasn't
 wathdog||watchdog
 wating||waiting
 wiat||wait
-- 
2.32.0

