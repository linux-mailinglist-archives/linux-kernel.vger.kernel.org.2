Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1715044E857
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 15:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbhKLOT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 09:19:29 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:49414 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbhKLOTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 09:19:22 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 34C2321991;
        Fri, 12 Nov 2021 14:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1636726591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YWNWU2gKDjDAJanqTwG6fTzE5N0yd0qPKZFUnVjdViI=;
        b=miVRPVce6tHxDAvdA0CCKQox1u+EjWgEanWk7lwgawzyE23tbLGG2DZpiOye9+zcxlEzBY
        jrPHc9YpE2RbnUX8IUznC3ijRcpFwtWHQbgOiEvPiF1QjJF8CgIwN4LJCVv6BW2d0LCU+r
        Pvve1Zq0Z3x63QvZSROe49igg5sKPq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1636726591;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YWNWU2gKDjDAJanqTwG6fTzE5N0yd0qPKZFUnVjdViI=;
        b=PXpN1H6IlLi38sSiB8pZlgOZlf2lhRqPFwKju2JvwVIoEbZSg3vdeIvfN0wo2BnGPjImhU
        xLsqAWMYr0mr3QAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0181113DB2;
        Fri, 12 Nov 2021 14:16:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oDXlOj53jmHhPAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 12 Nov 2021 14:16:30 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     airlied@linux.ie, daniel.vetter@ffwll.ch, arnd@arndb.de,
        gregkh@linuxfoundation.org, James.Bottomley@HansenPartnership.com,
        deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 3/7] agp: Documentation fixes
Date:   Fri, 12 Nov 2021 15:16:24 +0100
Message-Id: <20211112141628.12904-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211112141628.12904-1-tzimmermann@suse.de>
References: <20211112141628.12904-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix compiler warnings

  drivers/char/agp/backend.c:68: warning: Function parameter or member 'pdev' not described in 'agp_backend_acquire'
  drivers/char/agp/backend.c:93: warning: Function parameter or member 'bridge' not described in 'agp_backend_release'

by adding the necessary documentation.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/char/agp/backend.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/agp/backend.c b/drivers/char/agp/backend.c
index 004a3ce8ba72..0e19c600db53 100644
--- a/drivers/char/agp/backend.c
+++ b/drivers/char/agp/backend.c
@@ -62,6 +62,7 @@ EXPORT_SYMBOL(agp_find_bridge);
 
 /**
  *	agp_backend_acquire  -  attempt to acquire an agp backend.
+ *	@pdev: the PCI device
  *
  */
 struct agp_bridge_data *agp_backend_acquire(struct pci_dev *pdev)
@@ -83,6 +84,7 @@ EXPORT_SYMBOL(agp_backend_acquire);
 
 /**
  *	agp_backend_release  -  release the lock on the agp backend.
+ *	@bridge: the AGP backend to release
  *
  *	The caller must insure that the graphics aperture translation table
  *	is read for use by another entity.
-- 
2.33.1

