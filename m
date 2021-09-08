Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F6B403C11
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 16:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352001AbhIHPAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 11:00:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351929AbhIHPAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 11:00:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 946FB61176;
        Wed,  8 Sep 2021 14:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631113142;
        bh=I9nRCiQVEaw8EMBn5XYRpxUoWQZ4SY7CJXtl/LWJAoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s6LAHJt5xWJXpN07aWvZO3sjC9t8KEqalsjJyNJ8VVUDLuzqaibDLwkIcbhXc9UMT
         TF4mLT0q2e6KySMk8Zo+/HYNbf2KZwwnOWlN3AaE8UOIMZUEgXT952ws/TsOxJcbJE
         aIIHxb8Glx1PTcJk9lvbGbF08JcBPuwMrL8b8cVq/56RScimnA/uwzMPjttm0DEmYb
         NQLiGFl+5CDhvhKegBNwAZK1UuD0lUp0CAeGD12ZCbgP2JaHaAkGh3MleLU6YJcsY/
         bpkFdvDzHU2aHe5Q7Hivc/IKFArBmfYLI2kTN+FfvTixJc5I4X9oKdhxsu7IafXfzE
         HbtZ/drai+QEA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mNz2S-006r45-VW; Wed, 08 Sep 2021 16:59:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Raphael Gianotti <raphgi@linux.microsoft.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        THOBY Simon <Simon.THOBY@viveris.fr>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] ABI: security: fix location for evm and ima_policy
Date:   Wed,  8 Sep 2021 16:58:55 +0200
Message-Id: <27f568bf8973afb9c7aa023e96dcd4f50b07a188.1631112725.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631112725.git.mchehab+huawei@kernel.org>
References: <cover.1631112725.git.mchehab+huawei@kernel.org>
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

