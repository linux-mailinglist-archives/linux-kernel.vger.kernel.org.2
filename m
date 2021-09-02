Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C0E3FF4E2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 22:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346400AbhIBU1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 16:27:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:53938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346294AbhIBU1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 16:27:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 575E06056B;
        Thu,  2 Sep 2021 20:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630614396;
        bh=4Mzm0ZnE9uA7xCnmfbYNt3yjRLo8E84ptUXOhxGYFKA=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=iVTBMv1kDM0KvZ0p4lmNpIJjfmlICLE66FRMUBuxhRFgRs03Sr6SrrzLKEtE9187J
         O8Zc20pDbsOSw6ZVUaDgY2Zpf1nQLIeCi082lpPSnZkfg8gipVaiC+IuuicvcokN+I
         AMzjIrV35VxaZJAmA6aMgk1OY2JyBW2ibmJin1xEhmdsxflOWWlXxffoPxz/lXOaMd
         F8DHTALoWy/UK5w9qMBKvi9K4pRRlhkI0JRBLV1B1zRTmNMd54ayOtmf3rU3nxaLOr
         +288W65c9wKHJWFmsq8/WHPicMnXAtIi6NteAv/FaiEZfCGnPADL++3TsGPHQx4FaO
         TGZxfuYKZcLZw==
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 2/2] Linux 5.4.143-rt64-rc1
Date:   Thu,  2 Sep 2021 15:26:31 -0500
Message-Id: <bbc4e4f132b2674a0f26c1860da184785e8cb72f.1630614380.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1630614380.git.zanussi@kernel.org>
References: <cover.1630614380.git.zanussi@kernel.org>
In-Reply-To: <cover.1630614380.git.zanussi@kernel.org>
References: <cover.1630614380.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

v5.4.143-rt64-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index b0e8dd7bd707..c64934cc5dfa 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt63
+-rt64-rc1
-- 
2.17.1

