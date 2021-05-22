Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B4838D54B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 12:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhEVKtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 06:49:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:47842 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230232AbhEVKtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 06:49:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621680464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=YVW4fFsQp9kFBzeDykkxPl+Pl2140mXCCdzxA1+za9I=;
        b=AaNXEBTRFwWA9N+NX+QIk+DNpndes8olYZO18kkr8miV3r3jVORk8wYbrTesisIpL2xD3o
        4je9K3ghkEiqQ4R6WbzdLG2R9TWpv9/NC51+IQmojAOSMEqKqzU43YTlK1cW6Kl7+Ez8JV
        nfNUOrDoAqqIz4DkokjVNnB0N2aPppw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 62319ABB1;
        Sat, 22 May 2021 10:47:44 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.13-rc3
Date:   Sat, 22 May 2021 12:47:43 +0200
Message-Id: <20210522104743.10801-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.13b-rc3-tag

xen: branch for v5.13-rc3

It contains:
- a fix for a boot regression when running as PV guest on hardware without
  NX support
- a small series fixing a bug in the Xen pciback driver when configuring
  a PCI card with multiple virtual functions


Thanks.

Juergen

 arch/x86/xen/enlighten_pv.c      |  8 ++++----
 drivers/xen/xen-pciback/vpci.c   | 14 ++++++++------
 drivers/xen/xen-pciback/xenbus.c | 22 +++++++++++++++++-----
 3 files changed, 29 insertions(+), 15 deletions(-)

Jan Beulich (3):
      x86/Xen: swap NX determination and GDT setup on BSP
      xen-pciback: redo VF placement in the virtual topology
      xen-pciback: reconfigure also from backend watch handler
