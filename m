Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAF7314D20
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhBIKca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 05:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbhBIK05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:26:57 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB547C061786
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 02:26:16 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id q14so11883962ljp.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 02:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=otN+QQNUNIP047zDpB3/w5u9a7jvfkmpri8aI4VojBU=;
        b=mBRQcxrGN0CnbcLykibVwDL9XDmfZeIn5braZ9bj91r/UiGCkRCLP/QTFE8YR8sUYC
         +MS3kPk0dkLLqRX2x8Kwm8kp+uWVwikfExk8fx7ZHoN1jAQiFYqxsXBzupAXR/tWZLHc
         U124PpMsvDQnGdaHugIshSRl/1dI9TVhXyNmPyymtCr/3Ux1sE7jDxrWLPfXK7sQVZZK
         d8ODHgeV8s/CbCnrM4sDpsKRC5iuroOJqNVVwfqzVmi8acbvS8EIdIgZfmPXekxHavpw
         9JSAE2K0588AVayqbS7Ra80htqXRiQ1n7S2J68F23Ev0Olg4KKEO5N958nDKtWQGGRuT
         OOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=otN+QQNUNIP047zDpB3/w5u9a7jvfkmpri8aI4VojBU=;
        b=C+JzyLUK7XIlJpy3R5CXL0EC9WqesVzegfp8qOuvdivycBzHiHlFQ7PsOORmZePClw
         oY9D4dd/p28O8AAOimL+TYuo/AaT3COMFDtpM2+a/TsC6RVjmR4rSgfEUNMBgY50R1PJ
         iAaGDw+ksqh12R5XrR6KLSuQxL9mubVHhVQZFyPjPXElioRphiW6rjV6p4ktTMammDrE
         e6lxPvkbpEL/fr6IEj0d6wdrev0wUtFdxrk8ndHU+pRZ3/FVJys1YJIF/SPA41jjj6Db
         6nJpt71djRIdeC4R2JIAX3kln6FvgEe+0NCFF9EYAFxbD46trivCvzw+tA5j6/0JVeNe
         paEA==
X-Gm-Message-State: AOAM532KKWfKpAePycAQHSdpjk/Qh425R7TvXJZvGi/BQ8VCmOvZ2mdJ
        CMnWouTMlHM6UpjNlITqKKI=
X-Google-Smtp-Source: ABdhPJzxQ3F5f+EsjFgvMOE1AVjhzAS855UrSg/ZbbT1HAtvLCDOYSnyorf6jzlHDCmWbmuC17TKfA==
X-Received: by 2002:a2e:9710:: with SMTP id r16mr377109lji.358.1612866375446;
        Tue, 09 Feb 2021 02:26:15 -0800 (PST)
Received: from localhost.localdomain ([146.158.65.228])
        by smtp.googlemail.com with ESMTPSA id i25sm2403969ljj.100.2021.02.09.02.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 02:26:14 -0800 (PST)
From:   Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     alex.dewar90@gmail.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, snovitoll@gmail.com,
        syzbot+15ec7391f3d6a1a7cc7d@syzkaller.appspotmail.com
Subject: [PATCH v4] drivers/misc/vmw_vmci: restrict too big queue size in qp_host_alloc_queue
Date:   Tue,  9 Feb 2021 16:26:12 +0600
Message-Id: <20210209102612.2112247-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YCJb0Rc8ruCQIJMM@kroah.com>
References: <YCJb0Rc8ruCQIJMM@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot found WARNING in qp_broker_alloc[1] in qp_host_alloc_queue()
when num_pages is 0x100001, giving queue_size + queue_page_size
bigger than KMALLOC_MAX_SIZE for kzalloc(), resulting order >= MAX_ORDER
condition.

queue_size + queue_page_size=0x8000d8, where KMALLOC_MAX_SIZE=0x400000.

[1]
Call Trace:
 alloc_pages include/linux/gfp.h:547 [inline]
 kmalloc_order+0x40/0x130 mm/slab_common.c:837
 kmalloc_order_trace+0x15/0x70 mm/slab_common.c:853
 kmalloc_large include/linux/slab.h:481 [inline]
 __kmalloc+0x257/0x330 mm/slub.c:3959
 kmalloc include/linux/slab.h:557 [inline]
 kzalloc include/linux/slab.h:682 [inline]
 qp_host_alloc_queue drivers/misc/vmw_vmci/vmci_queue_pair.c:540 [inline]
 qp_broker_create drivers/misc/vmw_vmci/vmci_queue_pair.c:1351 [inline]
 qp_broker_alloc+0x936/0x2740 drivers/misc/vmw_vmci/vmci_queue_pair.c:1739

Reported-by: syzbot+15ec7391f3d6a1a7cc7d@syzkaller.appspotmail.com
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
> This patch does not apply to the tree...
Apologies, it was so stupid from my side.
Tested locally and via syzbot.

v4: made a patch based on commit 65f0d2414b("Merge tag 'sound-5.11-rc4'
of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound")
---
 drivers/misc/vmw_vmci/vmci_queue_pair.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vmci/vmci_queue_pair.c
index c49065887e8f..024dcdbd9d01 100644
--- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
+++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
@@ -537,6 +537,9 @@ static struct vmci_queue *qp_host_alloc_queue(u64 size)
 
 	queue_page_size = num_pages * sizeof(*queue->kernel_if->u.h.page);
 
+	if (queue_size + queue_page_size > KMALLOC_MAX_SIZE)
+		return NULL;
+
 	queue = kzalloc(queue_size + queue_page_size, GFP_KERNEL);
 	if (queue) {
 		queue->q_header = NULL;
-- 
2.25.1

