Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E986355EB7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 00:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344072AbhDFWWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 18:22:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54919 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232505AbhDFWWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 18:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617747715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=s1hRxpt2ffdYHYrIGfbgGHgTPYMM56n8tQe3ShKBMhM=;
        b=AJ+AeVLoePuDTcePnkoTes1awG5sR1VHahTF89miIwWxkfw0p/BiT4DQlAP3/CkUs+2nR9
        bOuBv6RI4jy2lxWesW19eOavb3/dpfSiXxt35IpPYv6pFzX8j/VC6Bgn3AdE9298tOa1sE
        xmq3xturfgt9wo+3op44N7R58isDX/Q=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-hqFsYXnvOUaQ30QAbLTabA-1; Tue, 06 Apr 2021 18:21:47 -0400
X-MC-Unique: hqFsYXnvOUaQ30QAbLTabA-1
Received: by mail-oi1-f198.google.com with SMTP id t186so5832710oih.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 15:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s1hRxpt2ffdYHYrIGfbgGHgTPYMM56n8tQe3ShKBMhM=;
        b=gTnzQ9NP3f94kCAKIf+YYv2oly0yXzDvC/J3t/rqpHDP8761b2Q0uG8oOOYkzsA6ig
         aQkae1Ci/Oqf4C/61HJ+8LU8bHbqmLE9BoUDO2Msn0LJUIxDHm37BMCNnY1bu8nDrrkH
         ujNZG0PMoYtQlya8HITp4iPuYE2i0cIx/ICj59OE6k8vzxGOpi/nG/lX4kFVXIqA+Ovc
         XIOOzUxUkyDXepCl1b9CLBqk2v/+H7eWKwFwWKxtQR8auaqVQP5RAr2l/X9wr3YzwQQS
         qOmZxtzFZ2hOb5a0kcW+BkoCkUPKrqkalCNc6hnuexOZf+v6h69/TAQMfeb+D9+vn50a
         EJcA==
X-Gm-Message-State: AOAM531mYEziI5zOek0SMWwG8Xp08YQxAfbRYPY7orC26Kxoq199Eeli
        u6h+of3+ZPJANA33MrRYugtue3PiBa3KNAlP2ZRVAwxqk0CAykJCMxpleaSrHDBOmvE6HLz+Wk6
        cgkVUAdX6n+6ZsZuo3P7Ylf67
X-Received: by 2002:a9d:303:: with SMTP id 3mr256743otv.268.1617747706954;
        Tue, 06 Apr 2021 15:21:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVK/wKfco2rpUqiiNbYfzLUjvxyjVjuDGeQW5Ynxv/fOZ5VQFgqpDYynoPDmgw+xuTSyAjag==
X-Received: by 2002:a9d:303:: with SMTP id 3mr256729otv.268.1617747706791;
        Tue, 06 Apr 2021 15:21:46 -0700 (PDT)
Received: from halaneylaptop.redhat.com ([136.33.225.96])
        by smtp.gmail.com with ESMTPSA id y10sm4854599oto.18.2021.04.06.15.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 15:21:46 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     bigeasy@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Andrew Halaney <ahalaney@redhat.com>,
        Chunyu Hu <chuhu@redhat.com>
Subject: [RT PATCH] locking/rwsem-rt: Remove might_sleep() in __up_read()
Date:   Tue,  6 Apr 2021 17:19:52 -0500
Message-Id: <20210406221952.50399-1-ahalaney@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no chance of sleeping here, the reader is giving up the
lock and possibly waking up the writer who is waiting on it.

Reported-by: Chunyu Hu <chuhu@redhat.com>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
Hello,

I ran into a warning caused by this, and I think the warning is
incorrect. Please let me know if I'm wrong!
I'm working off of linux-5.12.y-rt, but this applies cleanly to older
stable branches as well.

Thanks,
Andrew

 kernel/locking/rwsem-rt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/locking/rwsem-rt.c b/kernel/locking/rwsem-rt.c
index 274172d5bb3a..b61edc4dcb73 100644
--- a/kernel/locking/rwsem-rt.c
+++ b/kernel/locking/rwsem-rt.c
@@ -198,7 +198,6 @@ void __up_read(struct rw_semaphore *sem)
 	if (!atomic_dec_and_test(&sem->readers))
 		return;
 
-	might_sleep();
 	raw_spin_lock_irq(&m->wait_lock);
 	/*
 	 * Wake the writer, i.e. the rtmutex owner. It might release the
-- 
2.30.2

