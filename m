Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1443D35A345
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 18:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbhDIQ1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 12:27:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:47092 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234071AbhDIQ1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:27:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617985625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=fhUPXYAbVhvraSv5r/RZz5v2Ni5ifrFujAGOxwr66WE=;
        b=juGDQ4WZ4Ko+BG6+oZPCXrgp95TotOf5V39FseY8r2yi6IyjkSchaPWeor2DPo4bUDORsZ
        DGX1VygdB9PVkicLSraGhQOEzyzIRvG6IZeHBFKqnCvB1UuRXl3MkO9tmySSuEvPSu9gmP
        YAKVpDGjQnVbxhNeu8a0fONUIRfKn1s=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 59CD9B02B;
        Fri,  9 Apr 2021 16:27:05 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.12-rc7
Date:   Fri,  9 Apr 2021 18:27:04 +0200
Message-Id: <20210409162704.27220-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.12b-rc7-tag

xen: branch for v5.12-rc7

It contains a single fix of a 5.12 patch for the rather uncommon problem of
running as a Xen guest with a real time kernel config.


Thanks.

Juergen

 drivers/xen/events/events_base.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Luca Fancellu (1):
      xen/evtchn: Change irq_info lock to raw_spinlock_t
