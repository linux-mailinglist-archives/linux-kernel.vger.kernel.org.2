Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C93362DF5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 08:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhDQGNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 02:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhDQGNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 02:13:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA66C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 23:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
        :Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Cj+1iV0XSuIXr8xaN2YVnsr6m7GqUNPFBVu8lfJZWnE=; b=IQW9cY+c3GgmxAdaHeuI+cr/zj
        6Ks59+pPRfeBiDChdErv/yYelV2OiG6OLeb0wofQShD/J5tu1KcQolJRHJFdMW6wW57IxQs98Exdg
        lk80lY0ZETRte1iCh3gpJkQDMGI4fT86SuTKB5bHuVRFnfmCpY+i+S06J5KlDpSskzLJcO4QuyFid
        ml7houhKGGgfdOjpkysEANCDxXxGdtWcr1LLgc+uU+tOeH7CDOIeBr8nIZvpPX5spXTqGx8KU9Zel
        ULbQb0ctF+jRLWLxF2c5hg7EF7DZDmfE1KF0zaVjfxutJrq2AJz2JrGjLVniOoD4zlxp54EYe6ufK
        25pN97GA==;
Received: from [2601:1c0:6280:3f0::df68] (helo=smtpauth.infradead.org)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lXeCF-004VFL-AJ; Sat, 17 Apr 2021 06:12:47 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] of: linux/of.h: fix kernel-doc warnings
Date:   Fri, 16 Apr 2021 23:12:44 -0700
Message-Id: <20210417061244.2262-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct kernel-doc notation warnings:

../include/linux/of.h:1211: warning: Function parameter or member 'output' not described in 'of_property_read_string_index'
../include/linux/of.h:1211: warning: Excess function parameter 'out_string' description in 'of_property_read_string_index'
../include/linux/of.h:1477: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Overlay support

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/of.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20210416.orig/include/linux/of.h
+++ linux-next-20210416/include/linux/of.h
@@ -1192,7 +1192,7 @@ static inline int of_property_count_stri
  * @np:		device node from which the property value is to be read.
  * @propname:	name of the property to be searched.
  * @index:	index of the string in the list of strings
- * @out_string:	pointer to null terminated return string, modified only if
+ * @output:	pointer to null terminated return string, modified only if
  *		return value is 0.
  *
  * Search for a property in a device tree node and retrieve a null
@@ -1473,7 +1473,7 @@ static inline bool of_device_is_system_p
 	return of_property_read_bool(np, "system-power-controller");
 }
 
-/**
+/*
  * Overlay support
  */
 
