Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488513EC174
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 10:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237613AbhHNIox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 04:44:53 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55050 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237587AbhHNIot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 04:44:49 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 886D82226B;
        Sat, 14 Aug 2021 08:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628930654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=DAVLXJ0IXAU+QKBWPzDuqylSvV4KktT+rntSNNfQix8=;
        b=rzhbBDyrjPOoX6CN8W3ohduzsy4YgQucxquaCeO6AM5nDMhzZo1sRWLUYhvtPWWR0Jtayw
        G7s+oVT63M++To0bNMmlxDf7JxcmssSr2tHw/R4YwA4G6DTycrslS2rq4Wdnfi2tsd/yA/
        8m2EKOZEzKUVNBUP3sKSnXXOPyzBxe8=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 4E2C91374B;
        Sat, 14 Aug 2021 08:44:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id vqbyEF6CF2GlIAAAGKfGzw
        (envelope-from <jgross@suse.com>); Sat, 14 Aug 2021 08:44:14 +0000
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.14-rc6
Date:   Sat, 14 Aug 2021 10:44:13 +0200
Message-Id: <20210814084413.12168-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.14-rc6-tag

xen: branch for v5.14-rc6

It contains a small cleanup patch and a fix of a rare race in the Xen
evtchn driver.

Thanks.

Juergen

 drivers/xen/events/events_base.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

Colin Ian King (1):
      xen/events: remove redundant initialization of variable irq

Maximilian Heyne (1):
      xen/events: Fix race in set_evtchn_to_irq
