Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C35236653F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 08:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbhDUGOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 02:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235530AbhDUGOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 02:14:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F934C06174A;
        Tue, 20 Apr 2021 23:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
        :Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=/XEuHM9LCAA/ybLdTU4Am5aL3JBSDVFKYObgKXbEK4o=; b=pF/2a9IwQHXhDK23QbwsgImXsO
        BxoUBIQGjR4Cyy7sO3x23SmfYX8mnYM7kGAX8ZvpZd2+Wl3zKQlRi/f4AJc7EuJGJG+exnksm6jM3
        Mq558U6zpBl5wrQ/7+g2mRUNPMk909CYU99UL29p4Qw3KVL820RXJq4+9NUiFPGwSPbjUMXJKF7Vf
        2TDxplRNKLBMK9HluDzX1q9W3oBeg9zT/MJzdV/cfGbsnXB8riHAwld+PgoL4aAQCvaEfjkkA3JOc
        nQty3lIh7fMETySCnQl9jkJ0ohmKnZtg5jZ+OwLFENsWGD7vwJarQF1sRamGjrWJ1G3sx26poa84n
        qH3W/CDA==;
Received: from [2601:1c0:6280:3f0::df68] (helo=smtpauth.infradead.org)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZ66u-00Dls4-0I; Wed, 21 Apr 2021 06:14:10 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] alpha: eliminate old-style function definitions
Date:   Tue, 20 Apr 2021 23:13:12 -0700
Message-Id: <20210421061312.30097-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'make ARCH=alpha W=1' reports a couple of old-style function
definitions with missing parameter list, so fix those.

../arch/alpha/kernel/pc873xx.c: In function 'pc873xx_get_base':
../arch/alpha/kernel/pc873xx.c:16:21: warning: old-style function definition [-Wold-style-definition]
   16 | unsigned int __init pc873xx_get_base()

../arch/alpha/kernel/pc873xx.c: In function 'pc873xx_get_model':
../arch/alpha/kernel/pc873xx.c:21:14: warning: old-style function definition [-Wold-style-definition]
   21 | char *__init pc873xx_get_model()

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 arch/alpha/kernel/pc873xx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20210420.orig/arch/alpha/kernel/pc873xx.c
+++ linux-next-20210420/arch/alpha/kernel/pc873xx.c
@@ -13,12 +13,12 @@ static char *pc873xx_names[] = {
 static unsigned int base, model;
 
 
-unsigned int __init pc873xx_get_base()
+unsigned int __init pc873xx_get_base(void)
 {
 	return base;
 }
 
-char *__init pc873xx_get_model()
+char *__init pc873xx_get_model(void)
 {
 	return pc873xx_names[model];
 }
