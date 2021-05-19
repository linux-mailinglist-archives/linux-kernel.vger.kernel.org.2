Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A773889D7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 10:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344155AbhESIxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 04:53:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:60246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239672AbhESIxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 04:53:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D33261355;
        Wed, 19 May 2021 08:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621414311;
        bh=mH1S3gR8mGlC4/9PyAMcx8kASGkIydEqBDRzbifZAAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HlCivzGNn7pQkgaOkpw6zvJYEx3mNvLP+q+rlZU5oY9DDqERVpyJ/9/XcSM/Oy92z
         1wa97jOULmvRU7naNPMifc1HVBhPhETMqSajPtpxM8rokukvHGvDaejXoHdmK3iIN8
         xc3Xs+7xd4dfFd/Ek8GbQfS7exvFlQDzxtONjt+uRTvMbN99jO7mzoB8ZYWucXg0EF
         Q3Voy6skOYF6Omb0iBw/DDncOX4k4lFKOA9XsJEbuTCWmNshTj5dN8+1jNBlMevwP3
         t2WhPFdk6Kxrcgc2/Ums0KscxJeSg/saS0OK9M7aHRlzM4uhsUiLB1MtUvPbpfuCrh
         dryIoAIe7KuRw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ljHvh-007gYA-GN; Wed, 19 May 2021 10:51:49 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Kir Kolyshkin <kolyshkin@gmail.com>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] docs: sched-bwc.rst: fix a typo on a doc name
Date:   Wed, 19 May 2021 10:51:41 +0200
Message-Id: <1dc0203bd7df375ef45832f0c88566e22c4138ff.1621413933.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1621413933.git.mchehab+huawei@kernel.org>
References: <cover.1621413933.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cgroupv2.rst -> cgroup-v2.rst

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/scheduler/sched-bwc.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/scheduler/sched-bwc.rst b/Documentation/scheduler/sched-bwc.rst
index 845eee659199..1fc73555f5c4 100644
--- a/Documentation/scheduler/sched-bwc.rst
+++ b/Documentation/scheduler/sched-bwc.rst
@@ -29,7 +29,7 @@ Quota and period are managed within the cpu subsystem via cgroupfs.
 .. note::
    The cgroupfs files described in this section are only applicable
    to cgroup v1. For cgroup v2, see
-   :ref:`Documentation/admin-guide/cgroupv2.rst <cgroup-v2-cpu>`.
+   :ref:`Documentation/admin-guide/cgroup-v2.rst <cgroup-v2-cpu>`.
 
 - cpu.cfs_quota_us: the total available run-time within a period (in
   microseconds)
-- 
2.31.1

