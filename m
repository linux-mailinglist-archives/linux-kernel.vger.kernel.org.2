Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CE433FD6D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 03:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhCRCxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 22:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbhCRCw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 22:52:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3505FC06174A;
        Wed, 17 Mar 2021 19:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=iROa4/51dcocn3mg/oC7kdQ9Jspi0mhZOUY4BfJk/IM=; b=uZqrAnUrs4YT/DVfl2THCkSx40
        kBpy0rRqhJcCIiJMg+oL1cK3Q1V3wMuvBVLk59mioumHoLthnBLd4w82nvkgnoo34b3IrOoXrBTp0
        cVqE+wvzmrxwgwYu+sYP48GkVKyP4KvKPDKvtH57B+jGOPNu//2OrpEmuW1RjZ0oAjrQ4rGM6e5Qf
        kOFqvl2iZ+ybZDTsc3KkyOx1cmjGF20pTKnea96tv0trJ3EhMs8VXxvx3enW8e26BukBUyayfMHal
        YXHN3No9IhAEWvvpMXIcWnZ79vQXgDjPOe1ZRfFy0EBzmg6p+X2wy3Hpxyp5gkxieidko9hRCVBTo
        5uYCIKVw==;
Received: from [2601:1c0:6280:3f0::9757] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMimC-002Rj4-BK; Thu, 18 Mar 2021 02:52:47 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 2/2] Documentation: filesystesm api-summary: add namespace.c
Date:   Wed, 17 Mar 2021 19:52:26 -0700
Message-Id: <20210318025227.4162-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210318025227.4162-1-rdunlap@infradead.org>
References: <20210318025227.4162-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fs/namespace.c to the filesystems api-summary docbook.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/filesystems/api-summary.rst |    3 +++
 1 file changed, 3 insertions(+)

--- linux-next-20210317.orig/Documentation/filesystems/api-summary.rst
+++ linux-next-20210317/Documentation/filesystems/api-summary.rst
@@ -101,6 +101,9 @@ Other Functions
 .. kernel-doc:: fs/xattr.c
    :export:
 
+.. kernel-doc:: fs/namespace.c
+   :export:
+
 The proc filesystem
 ===================
 
