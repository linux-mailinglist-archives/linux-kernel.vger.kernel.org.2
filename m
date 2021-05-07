Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D5337652B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 14:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236890AbhEGMcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 08:32:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:46848 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236688AbhEGMcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 08:32:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6E24DB181;
        Fri,  7 May 2021 12:31:04 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-scsi@vger.kernel.org
Cc:     GR-QLogic-Storage-Upstream@marvell.com,
        linux-kernel@vger.kernel.org, Nilesh Javali <njavali@marvell.com>,
        Arun Easi <aeasi@marvell.com>, Daniel Wagner <dwagner@suse.de>
Subject: [RFC 0/2] Serialize timeout handling and done callback.
Date:   Fri,  7 May 2021 14:31:01 +0200
Message-Id: <20210507123103.10265-2-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210507123103.10265-1-dwagner@suse.de>
References: <20210507123103.10265-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We got a customer report where qla2xxx was crashing only if the kernel
was booting and ql2xextended_error_logging was set. Loading the module
with the log option didn't trigger the crash.

After starring for a long time at the crash report I figured the
problem might be a race between the timeout handler and done callback.
I've come up with these patches here but unfortunatly, our customer is
not able to reproduce the problem in the lab anymore (it was caused by
a hardware issue which got fixed). So for these patches I don't have
any feedback.

Maybe they make sense to add the driver even if I don't have prove it
really address the mentioned bug hence this is marked as RFC.

Thanks,
Daniel

Daniel Wagner (2):
  qla2xxx: Refactor asynchronous command initialization
  qla2xxx: Do not free resource to early in qla24xx_async_gpsc_sp_done()

 drivers/scsi/qla2xxx/qla_def.h    |  5 ++
 drivers/scsi/qla2xxx/qla_gbl.h    |  4 +-
 drivers/scsi/qla2xxx/qla_gs.c     | 86 ++++++++++-------------------
 drivers/scsi/qla2xxx/qla_init.c   | 91 +++++++++++++------------------
 drivers/scsi/qla2xxx/qla_iocb.c   | 54 +++++++++++++-----
 drivers/scsi/qla2xxx/qla_mbx.c    | 11 ++--
 drivers/scsi/qla2xxx/qla_mid.c    |  5 +-
 drivers/scsi/qla2xxx/qla_mr.c     |  7 +--
 drivers/scsi/qla2xxx/qla_target.c |  6 +-
 9 files changed, 127 insertions(+), 142 deletions(-)

-- 
2.29.2

