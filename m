Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA799402B84
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 17:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345010AbhIGPQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 11:16:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:43010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345080AbhIGPQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 11:16:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B14AD61139;
        Tue,  7 Sep 2021 15:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631027734;
        bh=U4qqO1PZZrbT1eql/pf4N2aOQvD+klKbLPwvP0QYdds=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=pkWWaaky0cPfjCGhwNxL8GPi6820f2GFBZ+kAbMmtF462NFVLZ+VJ/MDJ7mYN5SeQ
         FJ4pUAnnrjvAFXK3CSwFenH6Ngs6pzsmrpND5OLdvVVy0QPZJ2bgz88FvD+M1uUSvg
         UFsr6iuDQkOz1u/PMTZYvR4Ri3GpVlN3+DGon4tnLabh9/KyrnvTSJO62wOY5tHrp4
         DS2FYzUA56J4DpPJuHHGS15S+bMsAXzpgE+oL38wKIT9dyVAQT7oNKqo/L+SaeWluv
         CxirCJc+fGKsVRmFwV7OlAl4dUrL8wohRAE7XFPDqTyI4PdArH8IDZIBoDubKCRyws
         2KorADZSENJfQ==
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
Subject: [PATCH RT 3/3] Linux 5.4.143-rt64-rc2
Date:   Tue,  7 Sep 2021 10:15:29 -0500
Message-Id: <ed47e9385a02199907eb30efe0799efe47813650.1631027711.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1631027711.git.zanussi@kernel.org>
References: <cover.1631027711.git.zanussi@kernel.org>
In-Reply-To: <cover.1631027711.git.zanussi@kernel.org>
References: <cover.1631027711.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

v5.4.143-rt64-rc2 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index b0e8dd7bd707..cc5ec6b9aa59 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt63
+-rt64-rc2
-- 
2.17.1

