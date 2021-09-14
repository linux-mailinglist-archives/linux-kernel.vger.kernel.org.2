Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC82440B0B4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbhINOeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:34:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233790AbhINOeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:34:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BC77610D1;
        Tue, 14 Sep 2021 14:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631629970;
        bh=I9nRCiQVEaw8EMBn5XYRpxUoWQZ4SY7CJXtl/LWJAoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lPFHw2F9rFHUWYDqiM5Ev1vqDWBDtyKouT1lzVL7Hp+rRYDBzPYUuVLXs/IVSdF3K
         6ffpNsPv0BfAqbA9Zw4BucKrZMSR/j8u8WV64zDTSP8kkwTVymBWtbW9A8vUfNMkET
         Y2oiH/KqJJ6MEuPpOKzwgvbgJlmmDjUoX6eHMTK0tt/ThYfqndifkkd6uETB2F6R03
         A8GYRT9jSBxPZnWS35+o+j0TxiSoRj6rZYfVpkxQX/RPlnvyMmkzP6PbQqJgS1mbkd
         jrjZg2fIXKefmy7AtQCkbeQpaJrRq/BtdmuebAO5pgqFabaAJAiftFfAL3wO9/9Jmm
         5N4xwu0d03anw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQ9UN-000KkS-G3; Tue, 14 Sep 2021 16:32:47 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Raphael Gianotti <raphgi@linux.microsoft.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        THOBY Simon <Simon.THOBY@viveris.fr>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/29] ABI: security: fix location for evm and ima_policy
Date:   Tue, 14 Sep 2021 16:32:19 +0200
Message-Id: <d81b75a86e927ed33cb2b7df12965e832f968f72.1631629496.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631629496.git.mchehab+huawei@kernel.org>
References: <cover.1631629496.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The What: definitions there are wrong, pointing to different
locations than what's expected.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/testing/evm        | 4 ++--
 Documentation/ABI/testing/ima_policy | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/evm b/Documentation/ABI/testing/evm
index 553fd8a33e56..4b76a19b7bb4 100644
--- a/Documentation/ABI/testing/evm
+++ b/Documentation/ABI/testing/evm
@@ -1,4 +1,4 @@
-What:		security/evm
+What:		/sys/kernel/security/evm /sys/kernel/security/*/evm
 Date:		March 2011
 Contact:	Mimi Zohar <zohar@us.ibm.com>
 Description:
@@ -93,7 +93,7 @@ Description:
 		core/ima-setup) have support for loading keys at boot
 		time.
 
-What:		security/integrity/evm/evm_xattrs
+What:		/sys/kernel/security/*/evm/evm_xattrs
 Date:		April 2018
 Contact:	Matthew Garrett <mjg59@google.com>
 Description:
diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 5c2798534950..2d84063d196f 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -1,4 +1,4 @@
-What:		security/ima/policy
+What:		/sys/kernel/security/*/ima/policy
 Date:		May 2008
 Contact:	Mimi Zohar <zohar@us.ibm.com>
 Description:
-- 
2.31.1

