Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2363528C1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 11:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbhDBJ3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 05:29:40 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:18471 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234433AbhDBJ3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 05:29:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UUEdtug_1617355776;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UUEdtug_1617355776)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 02 Apr 2021 17:29:37 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     jaharkes@cs.cmu.edu
Cc:     coda@cs.cmu.edu, codalist@coda.cs.cmu.edu,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] coda: Remove various instances of an unused variable 'outp'
Date:   Fri,  2 Apr 2021 17:29:35 +0800
Message-Id: <1617355775-68715-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):
fs/coda/upcall.c:112:20: warning: variable ‘outp’ set but not used
fs/coda/upcall.c:161:20: warning: variable ‘outp’ set but not used
fs/coda/upcall.c:235:20: warning: variable ‘outp’ set but not used
fs/coda/upcall.c:303:20: warning: variable ‘outp’ set but not used
fs/coda/upcall.c:326:20: warning: variable ‘outp’ set but not used
fs/coda/upcall.c:380:20: warning: variable ‘outp’ set but not used
fs/coda/upcall.c:407:20: warning: variable ‘outp’ set but not used
fs/coda/upcall.c:440:20: warning: variable ‘outp’ set but not used
fs/coda/upcall.c:456:20: warning: variable ‘outp’ set but not used
fs/coda/upcall.c:574:20: warning: variable ‘outp’ set but not used

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/coda/upcall.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/fs/coda/upcall.c b/fs/coda/upcall.c
index eb3b189..e8db310 100644
--- a/fs/coda/upcall.c
+++ b/fs/coda/upcall.c
@@ -112,7 +112,6 @@ int venus_setattr(struct super_block *sb, struct CodaFid *fid,
 		  struct coda_vattr *vattr)
 {
         union inputArgs *inp;
-        union outputArgs *outp;
         int insize, outsize, error;
 	
 	insize = SIZE(setattr);
@@ -161,7 +160,6 @@ int venus_close(struct super_block *sb, struct CodaFid *fid, int flags,
 		kuid_t uid)
 {
 	union inputArgs *inp;
-	union outputArgs *outp;
 	int insize, outsize, error;
 	
 	insize = SIZE(release);
@@ -235,7 +233,6 @@ int venus_rename(struct super_block *sb, struct CodaFid *old_fid,
 		 const char *new_name)
 {
 	union inputArgs *inp;
-        union outputArgs *outp;
         int insize, outsize, error; 
 	int offset, s;
 	
@@ -303,7 +300,6 @@ int venus_rmdir(struct super_block *sb, struct CodaFid *dirfid,
 		    const char *name, int length)
 {
         union inputArgs *inp;
-        union outputArgs *outp;
         int insize, outsize, error;
         int offset;
 
@@ -326,7 +322,6 @@ int venus_remove(struct super_block *sb, struct CodaFid *dirfid,
 		    const char *name, int length)
 {
         union inputArgs *inp;
-        union outputArgs *outp;
         int error=0, insize, outsize, offset;
 
         offset = INSIZE(remove);
@@ -380,7 +375,6 @@ int venus_link(struct super_block *sb, struct CodaFid *fid,
 		  struct CodaFid *dirfid, const char *name, int len )
 {
         union inputArgs *inp;
-        union outputArgs *outp;
         int insize, outsize, error;
         int offset;
 
@@ -407,7 +401,6 @@ int venus_symlink(struct super_block *sb, struct CodaFid *fid,
 		     const char *symname, int symlen)
 {
         union inputArgs *inp;
-        union outputArgs *outp;
         int insize, outsize, error;
         int offset, s;
 
@@ -440,7 +433,6 @@ int venus_symlink(struct super_block *sb, struct CodaFid *fid,
 int venus_fsync(struct super_block *sb, struct CodaFid *fid)
 {
         union inputArgs *inp;
-        union outputArgs *outp; 
 	int insize, outsize, error;
 	
 	insize=SIZE(fsync);
@@ -456,7 +448,6 @@ int venus_fsync(struct super_block *sb, struct CodaFid *fid)
 int venus_access(struct super_block *sb, struct CodaFid *fid, int mask)
 {
         union inputArgs *inp;
-        union outputArgs *outp; 
 	int insize, outsize, error;
 
 	insize = SIZE(access);
@@ -574,7 +565,6 @@ int venus_access_intent(struct super_block *sb, struct CodaFid *fid,
 			size_t count, loff_t ppos, int type)
 {
 	union inputArgs *inp;
-	union outputArgs *outp;
 	int insize, outsize, error;
 	bool finalizer =
 		type == CODA_ACCESS_TYPE_READ_FINISH ||
-- 
1.8.3.1

