Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCDA341DBE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 14:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhCSNIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 09:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhCSNHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 09:07:46 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A7FC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 06:07:45 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id n16so20743069wro.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 06:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=N6ZyWsQjyYITH1DtAAAV8hrkc7rjv8eAm0Bac9Z5PT8=;
        b=TnqA//zK9gQJnaZHXinNxKGVoB7kl5o7IODNaQdi0CVH7hYbntG5Vn8XmGd4JRsa9P
         /yXBJ2WkZmZcLCipXy8bMFLcatVtT+HUXct5WzDq7XmimshmUCL3zMZoJK+2N1nykbgO
         RQBeKCBTYkbfi4ue8JmlN5NT5RuSiZIOVQ2iRN/7TTKM07brEQ6aOlwbntrgM1GNzq+Y
         C9Z+VumWlVuwBGiqSee3g8TOI1/jdLqYc6Q3HBG23h8heizrn98cjOwfp//4gqEsk1WN
         m63jJW437qM9jJbqU3Ikyl+IwWJSK78g7RQYguuPS0tZt5fuacxhZmmNAonr1zmIIMNt
         WcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=N6ZyWsQjyYITH1DtAAAV8hrkc7rjv8eAm0Bac9Z5PT8=;
        b=OsHA19YDiP4BIt6t7PCk6L1VJmA1GigKzVa77UNTKkjKRw1terFvGyyrLKxk7Tnkbi
         kqIKQ+zbMof3bNe/zm7TJ4wqCp5PGyFH+kBiB2e/wo4rH2+u26qjn/j4a2A6yHRH81iQ
         ZA1nQF8LFyvyp2nMHedx2N3cj417s+Qc6uAMxJbC2rifwc4EyXYbQkunOuX+qfWzZ77k
         g4InMOTKkCxEUcO0cp8oYaa39IecGot7dBAV4ZF8tx/W+7jwznjFdT04+CtqWRI3yOtF
         qMxO8A+SbJ+0jX7hsxZ6+8Dp0IQ9BCeG5D4cXzu78FEQz01ma50IjYN5a4lU9+IZ2jRh
         4h7w==
X-Gm-Message-State: AOAM532iWegTJZDrY9n6qvlcaIaBmeU6cSH1jWJh5Qge+//my0JXvkmJ
        gWvWl6gch62mt4xh6JmDQun1AWdslJ1aow==
X-Google-Smtp-Source: ABdhPJyJClpXKS3O6sZfHM4w9ZElo2Wjw0HdbpgytjhgjHiKAp5/jhaT4WQq+iLOSE/8Hzoo1OBaJIslaICOBA==
X-Received: from dbrazdil.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:7f9b])
 (user=dbrazdil job=sendgmr) by 2002:a1c:bc82:: with SMTP id
 m124mr3708352wmf.118.1616159264141; Fri, 19 Mar 2021 06:07:44 -0700 (PDT)
Date:   Fri, 19 Mar 2021 13:05:41 +0000
Message-Id: <20210319130541.2188184-1-dbrazdil@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v2] selinux: vsock: Set SID for socket returned by accept()
From:   David Brazdil <dbrazdil@google.com>
To:     selinux@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Alistair Delva <adelva@google.com>,
        David Brazdil <dbrazdil@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For AF_VSOCK, accept() currently returns sockets that are unlabelled.
Other socket families derive the child's SID from the SID of the parent
and the SID of the incoming packet. This is typically done as the
connected socket is placed in the queue that accept() removes from.

Reuse the existing 'security_sk_clone' hook to copy the SID from the
parent (server) socket to the child. There is no packet SID in this
case.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Signed-off-by: David Brazdil <dbrazdil@google.com>
---
Tested on Android AOSP and Fedora 33 with v5.12-rc3.
Unit test is available here:
  https://github.com/SELinuxProject/selinux-testsuite/pull/75

Changes since v1:
  * reuse security_sk_clone instead of adding a new hook

 net/vmw_vsock/af_vsock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 5546710d8ac1..bc7fb9bf3351 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -755,6 +755,7 @@ static struct sock *__vsock_create(struct net *net,
 		vsk->buffer_size = psk->buffer_size;
 		vsk->buffer_min_size = psk->buffer_min_size;
 		vsk->buffer_max_size = psk->buffer_max_size;
+		security_sk_clone(parent, sk);
 	} else {
 		vsk->trusted = ns_capable_noaudit(&init_user_ns, CAP_NET_ADMIN);
 		vsk->owner = get_current_cred();
-- 
2.31.0.rc2.261.g7f71774620-goog

