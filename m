Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3867941F02C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 17:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354730AbhJAPCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 11:02:36 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59984 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354686AbhJAPCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 11:02:31 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B77812005F;
        Fri,  1 Oct 2021 15:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633100446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oyuxf2Y1J+lyDb6SpUAj+J2Bo2Nkah6NWr6tdJdZLO8=;
        b=jo1x8PD9yL9dIXeua2bgw/yOpomsDEtePlNPQzVzLpCyps40A189+sdJu7dRFoPGe3NNmC
        Dt+fG2kheCL1JLztcphycrL3l5Jf45I29loB95W91kXj9XgsF4i1KreM0IDENfLhK1wBCn
        SSZX1BnAhZ0g19WVnsSczVhJ3wpvvZU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 801AE13C71;
        Fri,  1 Oct 2021 15:00:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YPkFHp4iV2G5OgAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 01 Oct 2021 15:00:46 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <Konrad.wilk@oracle.com>
Subject: [PATCH v5 3/3] xen: add Xen pvUSB maintainer
Date:   Fri,  1 Oct 2021 17:00:39 +0200
Message-Id: <20211001150039.15921-4-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211001150039.15921-1-jgross@suse.com>
References: <20211001150039.15921-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as maintainer for the Xen pvUSB stuff.

Signed-off-by: Juergen Gross <jgross@suse.com>
Acked-by: Konrad Rzeszutek Wilk <Konrad.wilk@oracle.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bc68a13a7655..069724ff5628 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20529,6 +20529,14 @@ F:	drivers/scsi/xen-scsifront.c
 F:	drivers/xen/xen-scsiback.c
 F:	include/xen/interface/io/vscsiif.h
 
+XEN PVUSB DRIVER
+M:	Juergen Gross <jgross@suse.com>
+L:	xen-devel@lists.xenproject.org (moderated for non-subscribers)
+L:	linux-usb@vger.kernel.org
+S:	Supported
+F:	divers/usb/host/xen*
+F:	include/xen/interface/io/usbif.h
+
 XEN SOUND FRONTEND DRIVER
 M:	Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
 L:	xen-devel@lists.xenproject.org (moderated for non-subscribers)
-- 
2.26.2

