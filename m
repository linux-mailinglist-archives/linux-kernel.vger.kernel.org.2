Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B124537825A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbhEJKej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:34:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231860AbhEJKap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:30:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EBC826192A;
        Mon, 10 May 2021 10:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620642444;
        bh=5XvKweeJlfByIWyqx5n3/rwhfkl4jZwsOIYU0G0wXTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gWr6lfrr/p7MFRe58W8gbMix0N4mF7ECGSjy8KP4cABfEVzYgtkVRDyxNxlx1+3aK
         4zMs5fevq+5DkA3QExPfJ1pqLhdBYHReJ3NLOEg4kHnTzh02JRTDO+Up6Sk8opb6EN
         uyonhAHoA0xPAMfluLddVCj2ItlkfZaiBUXGRPAbt02q+SDyJvV7UToj+aBvkir34v
         vhrH93d+KPGFDtqH98521/haSU/GPKPKBo9CYFzjPFzf/7+IN2ewGqFhMre3yCJtSH
         OpIvBG9kC5WMFLWvalnVDUD/mIpMaqFoFqGRylO5gqYBB4O9LH04Tl2kbqvm3uikxL
         H5K+PFJljUeOw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lg38D-000UQK-RE; Mon, 10 May 2021 12:27:21 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 31/53] docs: security: tpm: avoid using UTF-8 chars
Date:   Mon, 10 May 2021 12:26:43 +0200
Message-Id: <1e6958e5e5e65479da9fe5b53752b872cc252269.1620641727.git.mchehab+huawei@kernel.org>
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

	- U+2019 ('’'): RIGHT SINGLE QUOTATION MARK
	- U+feff ('﻿'): ZERO WIDTH NO-BREAK SPACE

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/security/tpm/tpm_event_log.rst | 2 +-
 Documentation/security/tpm/xen-tpmfront.rst  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/security/tpm/tpm_event_log.rst b/Documentation/security/tpm/tpm_event_log.rst
index f00f7a1d5e92..9f2716c170bb 100644
--- a/Documentation/security/tpm/tpm_event_log.rst
+++ b/Documentation/security/tpm/tpm_event_log.rst
@@ -20,7 +20,7 @@ process.
 The main application for this is remote attestation and the reason why
 it is useful is nicely put in the very first section of [1]:
 
-"Attestation is used to provide information about the platform’s state
+"Attestation is used to provide information about the platform's state
 to a challenger. However, PCR contents are difficult to interpret;
 therefore, attestation is typically more useful when the PCR contents
 are accompanied by a measurement log. While not trusted on their own,
diff --git a/Documentation/security/tpm/xen-tpmfront.rst b/Documentation/security/tpm/xen-tpmfront.rst
index 00d5b1db227d..31c67522f2ad 100644
--- a/Documentation/security/tpm/xen-tpmfront.rst
+++ b/Documentation/security/tpm/xen-tpmfront.rst
@@ -1,4 +1,4 @@
-﻿=============================
+=============================
 Virtual TPM interface for Xen
 =============================
 
-- 
2.30.2

