Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10385378263
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhEJKfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:35:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231219AbhEJKbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:31:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10EAE61934;
        Mon, 10 May 2021 10:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620642444;
        bh=XV3BlLVsbLXy8P+v3fW8y64kD1zGLO02X8eZISsJWyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qDMIrvawz0L+ZZxAdOVIpuDu592EBudvr1R7jbb/Fcf4PisF9UwIfu+FnTlP1+j4O
         grtIFKw5HVuN5Yvg2yApfV4hnd70yUBg5hK104aFeyJQ06I0TSZ0iilKkgokTz2hG0
         027fJSalD9WNjE4/ZNmcM2RE0HG3p4qeYZc8LJnBW8fhMDov284fBQqLcoJSSiQTNG
         0as7Nvu+3wvkmbXFXzQcbbEisy3FtXZYbnujsl9vHewXrBxORJl46ODRganHqHeKOj
         33KdrDMGLdhz19OwgJpGvvow3v/FgsCd5gqceasSvACECPkVEnw4TYYHvk+d7WNsCp
         PZTxmzf3n7ReQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lg38E-000UQm-67; Mon, 10 May 2021 12:27:22 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 38/53] docs: scheduler: sched-deadline.rst: avoid using UTF-8 chars
Date:   Mon, 10 May 2021 12:26:50 +0200
Message-Id: <b61e003ec84ecc1ee3216e9bed2471d43dae05d0.1620641727.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620641727.git.mchehab+huawei@kernel.org>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While UTF-8 characters can be used at the Linux documentation,
the best is to use them only when ASCII doesn't offer a good replacement.
So, replace the occurences of the following UTF-8 characters:

	- U+2013 ('–'): EN DASH
	- U+2212 ('−'): MINUS SIGN

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/scheduler/sched-deadline.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/scheduler/sched-deadline.rst b/Documentation/scheduler/sched-deadline.rst
index 9d9be52f221a..0ff353ecf24e 100644
--- a/Documentation/scheduler/sched-deadline.rst
+++ b/Documentation/scheduler/sched-deadline.rst
@@ -359,7 +359,7 @@ Deadline Task Scheduling
  More precisely, it can be proven that using a global EDF scheduler the
  maximum tardiness of each task is smaller or equal than
 
-	((M − 1) · WCET_max − WCET_min)/(M − (M − 2) · U_max) + WCET_max
+	((M - 1) · WCET_max - WCET_min)/(M - (M - 2) · U_max) + WCET_max
 
  where WCET_max = max{WCET_i} is the maximum WCET, WCET_min=min{WCET_i}
  is the minimum WCET, and U_max = max{WCET_i/P_i} is the maximum
@@ -515,7 +515,7 @@ Deadline Task Scheduling
       pp 760-768, 2005.
   10 - J. Goossens, S. Funk and S. Baruah, Priority-Driven Scheduling of
        Periodic Task Systems on Multiprocessors. Real-Time Systems Journal,
-       vol. 25, no. 2–3, pp. 187–205, 2003.
+       vol. 25, no. 2-3, pp. 187-205, 2003.
   11 - R. Davis and A. Burns. A Survey of Hard Real-Time Scheduling for
        Multiprocessor Systems. ACM Computing Surveys, vol. 43, no. 4, 2011.
        http://www-users.cs.york.ac.uk/~robdavis/papers/MPSurveyv5.0.pdf
-- 
2.30.2

