Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595B03A9251
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 08:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhFPG35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 02:29:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231396AbhFPG3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 02:29:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0561613D3;
        Wed, 16 Jun 2021 06:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623824867;
        bh=xcfRrSbIcqTm3T+UKP24MyVZeyMtewq5A8yaR3rp+m8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HQJ8xsneA5NWCf3fhuVeNnJO8Zk1CQD/9kn7tI8l05XakoiLE8phX7V3juiyI5t5X
         BPQI0qjdGNRveq2kwm1VdwfIKE/fscT3j2j5FWNad5GjBQK2tILsX9stssSIaNzeWD
         TbhdqG4VsQd+YpCPJ+PUSE+oaCCcOM6KKSWP45Tn6n7brLE3BhjmkH7eBKzKRHrtdQ
         CAJcRFOW6wldFbdPVkFtfYgenTxdodxLkHfQA+RgUqJg9YBnNwx6HOxMCe764AfVmd
         6Mw8H3U1dmjiyciOXdz1nq8xZZYK/dbDjMRmWp6eRJ+CFW7+HGdWcr/q9Guzj+fEGO
         eKCtPVy9ekdXQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ltP1e-004kIY-1P; Wed, 16 Jun 2021 08:27:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Mark Gross <mgross@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/29] docs: admin-guide: hw-vuln: avoid using ReST :doc:`foo` markup
Date:   Wed, 16 Jun 2021 08:27:19 +0200
Message-Id: <4e378517761f3df07165d5ecdac5a0a81577e68f.1623824363.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623824363.git.mchehab+huawei@kernel.org>
References: <cover.1623824363.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The :doc:`foo` tag is auto-generated via automarkup.py.
So, use the filename at the sources, instead of :doc:`foo`.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../hw-vuln/special-register-buffer-data-sampling.rst          | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst b/Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst
index 3b1ce68d2456..966c9b3296ea 100644
--- a/Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst
+++ b/Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst
@@ -3,7 +3,8 @@
 SRBDS - Special Register Buffer Data Sampling
 =============================================
 
-SRBDS is a hardware vulnerability that allows MDS :doc:`mds` techniques to
+SRBDS is a hardware vulnerability that allows MDS
+Documentation/admin-guide/hw-vuln/mds.rst techniques to
 infer values returned from special register accesses.  Special register
 accesses are accesses to off core registers.  According to Intel's evaluation,
 the special register reads that have a security expectation of privacy are
-- 
2.31.1

