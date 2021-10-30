Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DD94406E1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 04:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhJ3CKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 22:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhJ3CKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 22:10:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6B3C061570;
        Fri, 29 Oct 2021 19:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=nrEW7kuECysc7G8mItdbNyq/4urjerjQyoisk20/bT0=; b=iADe1WDRPoJUq7ZNlMhrY4Df8F
        wG+rrC1nGgufZ8KKfDCajpkSE4Kab+a4DrU7bQwx3ijereQSov2/thKJ9zojMLhxQM77Wz3YglBH7
        7ooO6apQal0ymUdgHpXluIV0qllEwOI01KQGjegJ5pdYyIJH7gjnEMf8L39bjj1eqStBI3z9ZmPwZ
        Zy8DQ6HjoNZni+tWdCtKBGvoiVxt98NqtyKdTr26ha87hGyUXEGH1YsksrcN48A/8ptkm/pWjwF86
        B4Fwb4L3Yf8Mkw+R32SCpqrGXhACF3cCGEsU+crL1x5qwl9aEdaQXOwcwzLeujM64N/+AGQeQJ34K
        NYNSVKew==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mgdn4-00CdTw-Uq; Sat, 30 Oct 2021 02:08:15 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Russell King <linux@armlinux.org.uk>, linux-doc@vger.kernel.org
Subject: [PATCH] kernel-doc: support DECLARE_PHY_INTERFACE_MASK()
Date:   Fri, 29 Oct 2021 19:08:13 -0700
Message-Id: <20211030020813.32654-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support the DECLARE_PHY_INTERFACE_MASK() macro that is used to declare
a bitmap by converting the macro to DECLARE_BITMAP(), as has been done
for the __ETHTOOL_DECLARE_LINK_MODE_MASK() macro.

This fixes a 'make htmldocs' warning:

include/linux/phylink.h:82: warning: Function parameter or member 'DECLARE_PHY_INTERFACE_MASK(supported_interfaces' not described in 'phylink_config'

that was introduced by commit
  38c310eb46f5 ("net: phylink: add MAC phy_interface_t bitmap")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: linux-doc@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
---
 scripts/kernel-doc |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20211029.orig/scripts/kernel-doc
+++ linux-next-20211029/scripts/kernel-doc
@@ -1256,6 +1256,7 @@ sub dump_struct($$) {
 	my $args = qr{([^,)]+)};
 	# replace DECLARE_BITMAP
 	$members =~ s/__ETHTOOL_DECLARE_LINK_MODE_MASK\s*\(([^\)]+)\)/DECLARE_BITMAP($1, __ETHTOOL_LINK_MODE_MASK_NBITS)/gos;
+	$members =~ s/DECLARE_PHY_INTERFACE_MASK\s*\(([^\)]+)\)/DECLARE_BITMAP($1, PHY_INTERFACE_MODE_MAX)/gos;
 	$members =~ s/DECLARE_BITMAP\s*\($args,\s*$args\)/unsigned long $1\[BITS_TO_LONGS($2)\]/gos;
 	# replace DECLARE_HASHTABLE
 	$members =~ s/DECLARE_HASHTABLE\s*\($args,\s*$args\)/unsigned long $1\[1 << (($2) - 1)\]/gos;
