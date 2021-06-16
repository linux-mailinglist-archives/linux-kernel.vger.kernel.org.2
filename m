Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36123A9291
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 08:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhFPGbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 02:31:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231684AbhFPG34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 02:29:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF82061425;
        Wed, 16 Jun 2021 06:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623824868;
        bh=GdHij+4MhRdAQ3UxmWv39I/XErTMzkdqM/g/Ig89fRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oE2L7YyI3YvPvfCBtWXbxedAURxyAqJy2BVk5TGKKWbqgDDOklYEuAjxzL1I3qW/k
         ob9vIyoa3S1OFB7DBnGkw9Zq89WZEP5E8LLPh97uBXwF810IHwKKCVhIfjb7Ni7UFd
         KfulY8CUtrnprhDqhuIr2uqIU24MltIfaYzDlPXPyPKttB+YmlvIGF2Pm3U0m0LRTs
         1GNbiVHLnrNvnCcMU0JS5tzYxmoAcHS54XevQWHK+LObGy2QEGCdxWZef3n7fyW7BC
         6mKh1DrboqE70EU92VUI+NbZYaEC2yP4nUPv3X6LsoN9jRtM6OKSI9k2TLjRTuBvVq
         9yCOjEB9exg4g==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ltP1f-004kJu-4Y; Wed, 16 Jun 2021 08:27:47 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 25/29] docs: trace: coresight: coresight.rst: avoid using ReST :doc:`foo` markup
Date:   Wed, 16 Jun 2021 08:27:40 +0200
Message-Id: <c79be625f7c90468e13d5380f0e4e1c1ccfa2fc8.1623824363.git.mchehab+huawei@kernel.org>
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
 Documentation/trace/coresight/coresight.rst | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/trace/coresight/coresight.rst b/Documentation/trace/coresight/coresight.rst
index 169749efd8d1..1ec8dc35b1d8 100644
--- a/Documentation/trace/coresight/coresight.rst
+++ b/Documentation/trace/coresight/coresight.rst
@@ -315,7 +315,8 @@ intermediate links as required.
 
 Note: ``cti_sys0`` appears in two of the connections lists above.
 CTIs can connect to multiple devices and are arranged in a star topology
-via the CTM. See (:doc:`coresight-ect`) [#fourth]_ for further details.
+via the CTM. See (Documentation/trace/coresight/coresight-ect.rst)
+[#fourth]_ for further details.
 Looking at this device we see 4 connections::
 
   linaro-developer:~# ls -l /sys/bus/coresight/devices/cti_sys0/connections
@@ -606,7 +607,8 @@ interface provided for that purpose by the generic STM API::
     crw-------    1 root     root       10,  61 Jan  3 18:11 /dev/stm0
     root@genericarmv8:~#
 
-Details on how to use the generic STM API can be found here:- :doc:`../stm` [#second]_.
+Details on how to use the generic STM API can be found here:
+- Documentation/trace/stm.rst [#second]_.
 
 The CTI & CTM Modules
 ---------------------
@@ -616,7 +618,7 @@ individual CTIs and components, and can propagate these between all CTIs via
 channels on the CTM (Cross Trigger Matrix).
 
 A separate documentation file is provided to explain the use of these devices.
-(:doc:`coresight-ect`) [#fourth]_.
+(Documentation/trace/coresight/coresight-ect.rst) [#fourth]_.
 
 
 .. [#first] Documentation/ABI/testing/sysfs-bus-coresight-devices-stm
-- 
2.31.1

