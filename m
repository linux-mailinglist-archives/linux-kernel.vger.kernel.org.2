Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203A23BE359
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 09:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhGGHEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 03:04:22 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45426 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbhGGHEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 03:04:21 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8ED6D2001A;
        Wed,  7 Jul 2021 07:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625641300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Z/e1G+gloDaAJuCz1ic3rY8b4Q6mwDzhQzHZUcYRM20=;
        b=EDS83y1O8+1gXi+Y6G9NBCc00pHQ33+jQ/Yt+dj1A18BKAHI/ThqLjlCMlGeQocmRg+/5v
        +NgnPQSLq0Yo6nQ2aSEEaDwzhTj0ItTlAQQy0OIwKorBcpfgcrgiOA7mXY+35/TVU8GNmC
        ynosbRpR++FY2H6x3nHmn3WMH497pDk=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 619F013768;
        Wed,  7 Jul 2021 07:01:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id BjeeFlRR5WAkDwAAGKfGzw
        (envelope-from <jgross@suse.com>); Wed, 07 Jul 2021 07:01:40 +0000
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.14-rc1
Date:   Wed,  7 Jul 2021 09:01:39 +0200
Message-Id: <20210707070139.27901-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.14-rc1-tag

xen: branch for v5.14-rc1

It contains only two minor patches this time: one cleanup patch and
one patch refreshing a Xen header.

Thanks.

Juergen

 drivers/xen/pcpu.c                |   6 +-
 drivers/xen/xen-balloon.c         |  28 ++--
 drivers/xen/xenbus/xenbus_probe.c |  15 +-
 include/xen/interface/io/ring.h   | 278 +++++++++++++++++++++-----------------
 4 files changed, 177 insertions(+), 150 deletions(-)

Juergen Gross (1):
      xen: sync include/xen/interface/io/ring.h with Xen's newest version

YueHaibing (1):
      xen: Use DEVICE_ATTR_*() macro
