Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F2B40B0F9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbhINOhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:37:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233814AbhINOeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:34:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91A2A6112E;
        Tue, 14 Sep 2021 14:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631629970;
        bh=nNaeUlSwEFv+VPUbG93T21G4eNhmdRttUilMQiNdyfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AwBU3EYmGKo5uSDYtswcYuA4YltpIhFnuzCZ9z7zR4+9dpd0rigwChonx2FSQwueR
         XhQLEhDsIoHX24W2kXtPeEqwAz2M5a0ctEXMepUEsuO3iW6gJGWKsRndIvTfCdJFai
         ku+e6QLs7M4BXihsjkZtbhEX+Mk2+3WwJtFPVg+RJ2Vx28HLEvf8pQuDL+cDSl2Ui0
         VbFo3jcpFJCYinAGbsSd6BuyZ4dQ8DZZ2bamFnwVnEcY5iVr8S3sj9/NBalK4+5MoM
         h3YpFi7OO3jggjGCglCzfjKh8Cg3QTh2Y3LlMzigzfaYjA0X3xE2BsiBwAsHZldO+M
         oDGlktXof1s+w==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQ9UN-000KkW-HT; Tue, 14 Sep 2021 16:32:47 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/29] ABI: sysfs-class-tpm: use wildcards for pcr-* nodes
Date:   Tue, 14 Sep 2021 16:32:20 +0200
Message-Id: <bbbe6dd50569c126d7d0c8431e208be88792c303.1631629496.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631629496.git.mchehab+huawei@kernel.org>
References: <cover.1631629496.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change how this expression is defined:

	/sys/class/tpm/tpmX/pcr-H/N

in order to allow get_abi.pl to convert it into this regex:

	/sys/class/tpm/tpmX/pcr-.*/.*

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/stable/sysfs-class-tpm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/stable/sysfs-class-tpm b/Documentation/ABI/stable/sysfs-class-tpm
index d897ecb9615f..411d5895bed4 100644
--- a/Documentation/ABI/stable/sysfs-class-tpm
+++ b/Documentation/ABI/stable/sysfs-class-tpm
@@ -195,7 +195,7 @@ Description:	The "tpm_version_major" property shows the TCG spec major version
 
 		  2
 
-What:		/sys/class/tpm/tpmX/pcr-H/N
+What:		/sys/class/tpm/tpmX/pcr-<H>/<N>
 Date:		March 2021
 KernelVersion:	5.12
 Contact:	linux-integrity@vger.kernel.org
-- 
2.31.1

