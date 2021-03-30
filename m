Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB1D34E704
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 14:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhC3MEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 08:04:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:38164 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229633AbhC3MDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 08:03:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617105817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=RgYXG8R4K7D3UYQ2peCbRMFBTS3NparOU1uQzH1eEOI=;
        b=ns/hsvRw67g4WN7NB4Qvd0CALMQ4QpTQHVNRooYdY+fHsNNOiiUfaBMJnAz8vF9Ybmma+1
        AeI29Mw0/1zf+nR8xZ1UENKzb2CiWlMqAE3XxNoTBgrbjFCKjwQP48GdWGT7y3gz4w4esz
        2psMmjkMokKaqDya48A9LeZjxtRS01E=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CF7EFB2E7;
        Tue, 30 Mar 2021 12:03:37 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.12-rc6
Date:   Tue, 30 Mar 2021 14:03:37 +0200
Message-Id: <20210330120337.4404-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.12b-rc6-tag

xen: branch for v5.12-rc6

It contains one Xen related security fix (XSA-371).

Thanks.

Juergen

 drivers/block/xen-blkback/blkback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Jan Beulich (1):
      xen-blkback: don't leak persistent grants from xen_blkbk_map()
