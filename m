Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D21F39FD06
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbhFHREs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:04:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52210 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbhFHREr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:04:47 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8A5CE1FD33;
        Tue,  8 Jun 2021 17:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623171773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=XE6BGDAlpoGT7vB16KKKSYud+7PMVavS6/QbZRzdDxs=;
        b=MV50QSfEK2ynwxGqYtXKmch4fg36xJzNnB8rvWddCqKd0xv/p3GxnAg805Tnhl2Tt0aFfG
        hk7tnD0pACjAyOfQExdShxTI2I4UKbXoucfEHqC56EmH1Uu7a1e20erV2yVJDvrjkGXnmv
        cyN2jmKRL0GdgAt7lbfH1fW0uPAnE1M=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 5C968118DD;
        Tue,  8 Jun 2021 17:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623171773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=XE6BGDAlpoGT7vB16KKKSYud+7PMVavS6/QbZRzdDxs=;
        b=MV50QSfEK2ynwxGqYtXKmch4fg36xJzNnB8rvWddCqKd0xv/p3GxnAg805Tnhl2Tt0aFfG
        hk7tnD0pACjAyOfQExdShxTI2I4UKbXoucfEHqC56EmH1Uu7a1e20erV2yVJDvrjkGXnmv
        cyN2jmKRL0GdgAt7lbfH1fW0uPAnE1M=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id voVoFb2iv2DsZQAALh3uQQ
        (envelope-from <jgross@suse.com>); Tue, 08 Jun 2021 17:02:53 +0000
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.13-rc6
Date:   Tue,  8 Jun 2021 19:02:53 +0200
Message-Id: <20210608170253.13602-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.13b-rc6-tag

xen: branch for v5.13-rc6

It contains a single patch fixing a Xen related security bug: a malicious
guest might be able to trigger a "use after free" issue in the xen-netback
driver.

Thanks.

Juergen

 drivers/net/xen-netback/interface.c | 6 ++++++
 1 file changed, 6 insertions(+)

Roger Pau Monne (1):
      xen-netback: take a reference to the RX task thread
