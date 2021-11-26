Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F6F45E6DB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 05:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358274AbhKZEds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 23:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358191AbhKZEbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 23:31:44 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A17C061D5E;
        Thu, 25 Nov 2021 20:11:22 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id o14so5850536plg.5;
        Thu, 25 Nov 2021 20:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=dH9vX4Nxo9Cf82Buyn6+6qDtIVOrljk6cIN+0S0PjHs=;
        b=HbHq0wwCD1GH7D8cUEtRKWcCkTQqozKYYsynYy25fWygDqSRTz3FPmEP+NxIizXPOe
         tr969p9H75hsqO//dwSSsLaZ07J4xUZ5aFbFpgLypd6O6j+Qs6/vgsGytEoupQEM5mTR
         YThY7x0YXRMHiLHXuOMRNp1FsoF1KRMvzqTxSR87llD+wNQqkztdierHuKtcJvdzvIDV
         K3eW+0BNfnvv7xTJJBOm3Z5JfC5z29EMfkr90WdGfWNA3wliv5pR04vFepydkTlnZon/
         82hgOvYldMJ/kN+o2Kigw+fXJOzLWRHLOpLfSl5uksjnXUpeA0XX98ZAvQqPjwtYS5Z/
         bEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=dH9vX4Nxo9Cf82Buyn6+6qDtIVOrljk6cIN+0S0PjHs=;
        b=x/VELMe1Ufzdr1frnfN3EGr5gh/q/4NBDuWkKLIvB1Qukn8CqA+vdtlRlPEI7jyh5s
         FUZsxeZ2en01LgXfLFPIsNskKMksdoyDnIDg9zzRGtC0AiNMbDrJ03nwa6cCecBNJqZI
         yvzZ6EAhRjULgwr12G+1F87I3ejdNb0gjmrqZJrTP23ITbM8m0sUgWEkbughqnCwoTb8
         jDiws/sHRFFLmKoDHNa/a+OCL1DH0Xr43z6iUCJO3HYrc82VprmOFFM4eHCX35inhPm7
         mvG+1e9Kg4bqS7CV3c9xj4jv0kvvfVUoCLIx4LbwABiYxfAIHwWbXCSNA+en1yCw/X1e
         cDkg==
X-Gm-Message-State: AOAM530hG+PlDVUELWmoIAUYLRqAHPxjGPWLvNptz4v0pmcdxaTgz20a
        651wc46XfKW81hrH8kqrIfKXkLbs+U4=
X-Google-Smtp-Source: ABdhPJxX6TxNi81h9TI69Ag/+v1fY9/EoFdHMQp+hJyloAWvDJ/Ty2yTyQo4nTEba2VqXTUtNW++RQ==
X-Received: by 2002:a17:90b:1c81:: with SMTP id oo1mr12767578pjb.5.1637899881675;
        Thu, 25 Nov 2021 20:11:21 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id m12sm5421704pfk.27.2021.11.25.20.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Nov 2021 20:11:21 -0800 (PST)
To:     Jonathan Corbet <corbet@lwn.net>,
        Joel Colledge <joel.colledge@linbit.com>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        drbd-dev@lists.linbit.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH v2] docs: admin-guide/blockdev: Remove digraph of node-states
Message-ID: <7df04f45-8746-e666-1a9d-a998f1ab1f91@gmail.com>
Date:   Fri, 26 Nov 2021 13:11:17 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While node-states-8.dot has two digraphs, the dot(1) command can
not properly handle multiple graphs in a DOT file and the
kernel-doc page at

    https://www.kernel.org/doc/html/latest/admin-guide/blockdev/drbd/figures.html

fails to render the graphs.

It turned out that the digraph of node_states can be removed.

Quote from Joel's reflection:

    On reflection, the digraph node_states can be removed entirely.
    It is too basic to contain any useful information. In addition
    it references "ioctl_set_state". The ioctl configuration
    interface for DRBD has long been removed. In fact, it was never
    in the upstream version of DRBD.

Remove node_states and rename the DOT file peer_states-8.dot.

Suggested-by: Joel Colledge <joel.colledge@linbit.com>
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
---
Changes in v1 [1] -> v2

 - As suggested by Joel, remove the digraph of node_states.
 - Rename the DOT file peers-states-8.dot.
 - Update the change log and the patch title.
 - Add Joel's Suggested-by.

[1]: https://lkml.kernel.org/r/3cbff170-582b-b6cf-0988-e0d0c9b47505@gmail.com

Joel, are you OK with this change going through the -doc tree?

        Thanks, Akira
--
 Documentation/admin-guide/blockdev/drbd/figures.rst          | 4 ++--
 .../blockdev/drbd/{node-states-8.dot => peer-states-8.dot}   | 5 -----
 2 files changed, 2 insertions(+), 7 deletions(-)
 rename Documentation/admin-guide/blockdev/drbd/{node-states-8.dot => peer-states-8.dot} (71%)

diff --git a/Documentation/admin-guide/blockdev/drbd/figures.rst b/Documentation/admin-guide/blockdev/drbd/figures.rst
index bd9a4901fe46..9f73253ea353 100644
--- a/Documentation/admin-guide/blockdev/drbd/figures.rst
+++ b/Documentation/admin-guide/blockdev/drbd/figures.rst
@@ -25,6 +25,6 @@ Sub graphs of DRBD's state transitions
     :alt:   disk-states-8.dot
     :align: center
 
-.. kernel-figure:: node-states-8.dot
-    :alt:   node-states-8.dot
+.. kernel-figure:: peer-states-8.dot
+    :alt:   peer-states-8.dot
     :align: center
diff --git a/Documentation/admin-guide/blockdev/drbd/node-states-8.dot b/Documentation/admin-guide/blockdev/drbd/peer-states-8.dot
similarity index 71%
rename from Documentation/admin-guide/blockdev/drbd/node-states-8.dot
rename to Documentation/admin-guide/blockdev/drbd/peer-states-8.dot
index bfa54e1f8016..6dc3954954d6 100644
--- a/Documentation/admin-guide/blockdev/drbd/node-states-8.dot
+++ b/Documentation/admin-guide/blockdev/drbd/peer-states-8.dot
@@ -1,8 +1,3 @@
-digraph node_states {
-	Secondary -> Primary           [ label = "ioctl_set_state()" ]
-	Primary   -> Secondary 	       [ label = "ioctl_set_state()" ]
-}
-
 digraph peer_states {
 	Secondary -> Primary           [ label = "recv state packet" ]
 	Primary   -> Secondary 	       [ label = "recv state packet" ]

base-commit: b96ff02ab2be1791248237b1bf318aaf62e8b701
-- 
2.17.1

