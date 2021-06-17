Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9DD3AAF55
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 11:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhFQJMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 05:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhFQJMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 05:12:09 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930FBC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 02:10:01 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id y7so5845001wrh.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 02:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LddN6VdqgEQMBDMe5FR55fpFlxE7qF0s8cEeKWSAjEI=;
        b=KZpHq/WPIKCp1FfdmUAv30N4kxlka+BYdq8VCOr44rPGmtN7nA81Ky30TdKCsWiaLH
         WfeW6XrSTyoae7fp2LbfK5so5gWjrQJba25FfRA/ZDltyzU1h6uaCPi6VVeFBTtuaOVN
         YvwjKpmnRcBZ+vr5GfuKOuzlgz9AxJX3Dk8M/icA84TW4K9SaB3v19hBxBQipD5i7XLy
         t1Z6Zjmx+vys6N2FZm2y1cR8tUA1E8fWzqtTxw10nx9ufCPJ8HpaCypgTpde0BjzyrIY
         IHccjezjR6A5ECS4ddSOZeuMVW9YMeNDOFUkbqS+8SkqDxFhsOUKyAURr3mr6WARAhfR
         ypWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LddN6VdqgEQMBDMe5FR55fpFlxE7qF0s8cEeKWSAjEI=;
        b=Fl+auoN5kz1moviTowNV7eRvuF85EV6+Qjvq2wHLc8O6/VspYA2H54RMK4DBZyxBaG
         IBdkYwssO6aEFL+nYyOM6TYoyCMQR1Z001hjcOfxLRd+pJ7DkuPVfpAFtMOTaNXvVlj9
         d/FwQiMXxvvGFC+j55MQ4LmNNRp958C/weIFC+tEzhRmqWOSPVXRmDdtcdGZnh0eBTj/
         PcACZeTPEyvWDTX8G4Nb0HsmZFGb+Y0FRN8ZX/k/8pbbavQxF0pKf9kkWocwVfdCtrdF
         sKWN8dm2hd+4ah4dk0ivXih603qVO/TVO0/Nujagnx6jsFqTm6H1LXhnAowoS2/oKLPL
         vv3Q==
X-Gm-Message-State: AOAM530jw8A4fC0LMQ9RV56VS/Ts0SOqn5dQqIErN8+kP5g3prL+Da3F
        fDnx+PNW+6TczdE5vaw2YWE5JQ==
X-Google-Smtp-Source: ABdhPJzmiMDIHpo1Gi9jB6ZSpBA3YLu1mMpg3dE7vWL9Cqi1rMgj4OtezJDP0Pl3q0d2h4hM+mKjjg==
X-Received: by 2002:a5d:4dd0:: with SMTP id f16mr4444000wru.192.1623921000089;
        Thu, 17 Jun 2021 02:10:00 -0700 (PDT)
Received: from dell.default ([91.110.221.170])
        by smtp.gmail.com with ESMTPSA id m7sm5179719wrv.35.2021.06.17.02.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 02:09:59 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: [PATCH 1/1] cgroup-v1: Grant CAP_SYS_NICE holders permission to move tasks between cgroups
Date:   Thu, 17 Jun 2021 10:09:41 +0100
Message-Id: <20210617090941.340135-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It should be possible for processes with CAP_SYS_NICE capabilities
(privileges) to move lower priority tasks within the same namespace to
different cgroups.

One extremely common example of this is Android's 'system_server',
which moves processes around to different cgroups/cpusets, but should
not require any other root privileges.

Cc: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: cgroups@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 kernel/cgroup/cgroup-v1.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 1f274d7fc934e..56d0d91951f02 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -510,7 +510,8 @@ static ssize_t __cgroup1_procs_write(struct kernfs_open_file *of,
 	tcred = get_task_cred(task);
 	if (!uid_eq(cred->euid, GLOBAL_ROOT_UID) &&
 	    !uid_eq(cred->euid, tcred->uid) &&
-	    !uid_eq(cred->euid, tcred->suid))
+	    !uid_eq(cred->euid, tcred->suid) &&
+	    !ns_capable(tcred->user_ns, CAP_SYS_NICE))
 		ret = -EACCES;
 	put_cred(tcred);
 	if (ret)
-- 
2.32.0

