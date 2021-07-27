Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70DB3D6B0A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 02:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbhGZXtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 19:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbhGZXtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 19:49:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8162EC061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 17:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=6/7oKEVA4rxlQh0qVL5S1Rb1EZhJFDFyuVZPPnpRFwo=; b=xi6o0OraLioiJI1KLH+Hek9JFa
        EzaOwOd1Dx7NIcnoB9ogazIjnonOzp/m2VfvzJtsz6ElGkCk557BKQB53Nigjh/1vmsn56hf4nVmd
        PIGi8AtEd4bQea02Q5e73K35RxETXd+8dz8h0cRtlYBU+c6Jdr+f0PoEBV0uYN56X5VpQkpR4rOj/
        4RECyjY40zFFys6BvReOTg04T0yLlhUTL+Z+WiENpNsrDOF3sw6DETQJQHmsMBflkolLfUaZp+qY0
        Bsx+DeLLAXFgWbCm66uHkKuYFsiwKFGO7brbkYKHhCP241MBMXDG9HPzoZMq/JtO9z3tciSIbmAlx
        /8/B1Fbg==;
Received: from [2601:1c0:6280:3f0::aefb] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8Aye-00ChiZ-S6; Tue, 27 Jul 2021 00:29:44 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] scripts: check_extable: fix typo in user error message
Date:   Mon, 26 Jul 2021 17:29:43 -0700
Message-Id: <20210727002943.29774-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo ("and" should be "an") in an error message.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Quentin Casasnovas <quentin.casasnovas@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 scripts/check_extable.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20210723.orig/scripts/check_extable.sh
+++ linux-next-20210723/scripts/check_extable.sh
@@ -4,7 +4,7 @@
 
 obj=$1
 
-file ${obj} | grep -q ELF || (echo "${obj} is not and ELF file." 1>&2 ; exit 0)
+file ${obj} | grep -q ELF || (echo "${obj} is not an ELF file." 1>&2 ; exit 0)
 
 # Bail out early if there isn't an __ex_table section in this object file.
 objdump -hj __ex_table ${obj} 2> /dev/null > /dev/null
