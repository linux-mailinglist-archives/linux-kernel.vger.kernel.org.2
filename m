Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81FD3199D3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 07:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbhBLGCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 01:02:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:47322 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhBLGB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 01:01:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613109672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=0v46qQRuE5c4pAwWDjq4Hvrs44PX0xNfVaw3r/wqYzE=;
        b=eyJWTr4jFEUfHoWMr1kClNLREwQz9QTj0mAfBKTo8FIZZwCqU7RRFsLTlmvASzRX3Paw0h
        a4H7RV8cAgE14HCpP3a8oNubwqP2Az+wuERcgt/e+EMvgPRPQwteKLgAiaXm2/wctYsEBe
        dRMiC+IL9Ye52glqAAjj9sGj4uSqSpA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 635A2B1E6;
        Fri, 12 Feb 2021 06:01:12 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.11-rc8
Date:   Fri, 12 Feb 2021 07:01:11 +0100
Message-Id: <20210212060111.22013-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.11-rc8-tag

xen: branch for v5.11-rc8

It contains a single fix for an issue introduced in 5.11: when running
as a Xen guest on Arm systems the kernel will hang during boot.

Thanks.

Juergen

 arch/arm/xen/enlighten.c          | 2 --
 drivers/xen/xenbus/xenbus.h       | 1 -
 drivers/xen/xenbus/xenbus_probe.c | 2 +-
 include/xen/xenbus.h              | 2 --
 4 files changed, 1 insertion(+), 6 deletions(-)

Julien Grall (1):
      arm/xen: Don't probe xenbus as part of an early initcall
