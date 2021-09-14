Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F3540B0F5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbhINOgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:36:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233828AbhINOeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:34:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F62F61155;
        Tue, 14 Sep 2021 14:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631629970;
        bh=mQWncG+nkMNDW24ydsD02ptTFMcYE2iljRDwZ4M8aHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qy0ambJRj2x1Rf7a9772Ij8Y2BZT5Fz/m8uc274v6hh0HWzzATMbofzrrAtv2JU9y
         hesz2hF+aMfnEgxSpUKJ0zEOpQdp5Oq/TkRQsGOycRK3wlmD+jY3G63vl4NRvivIBW
         g6OvRsMz3Lwnq6Zx2gornoPS0w+10JDjvMAsP8ri9MjsasUGJoPoS++p7hASdlZ4wI
         HjZA3NgaRVFh/iEC6npjoHwKwt1hhe0lgIGuEhsQ19wwD237OIpmNq5SUyBNpSWGjB
         T7juPwGeRzw1vJpeTapRcZFMRZ6e9zqQ+RkkY/d0Wfzq3l036p62Rw0BIZAmr0Xt/B
         oMrP+PNpOL1Yw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQ9UO-000Km0-L7; Tue, 14 Sep 2021 16:32:48 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 28/29] ABI: sysfs-platform-sst-atom: use wildcards on What definitions
Date:   Tue, 14 Sep 2021 16:32:43 +0200
Message-Id: <2b3c1c7dfda4d921f7ca7a05ce534229a82fe84b.1631629496.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631629496.git.mchehab+huawei@kernel.org>
References: <cover.1631629496.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

%x is not a valid wildcard. Use <x> instead, as this allows
script/get_abi.pl to convert it into a regex.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/testing/sysfs-platform-sst-atom | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-sst-atom b/Documentation/ABI/testing/sysfs-platform-sst-atom
index d5f6e21f0e42..0154b0fba759 100644
--- a/Documentation/ABI/testing/sysfs-platform-sst-atom
+++ b/Documentation/ABI/testing/sysfs-platform-sst-atom
@@ -1,4 +1,4 @@
-What:		/sys/devices/platform/8086%x:00/firmware_version
+What:		/sys/devices/platform/8086<x>:00/firmware_version
 Date:		November 2016
 KernelVersion:	4.10
 Contact:	"Sebastien Guiriec" <sebastien.guiriec@intel.com>
-- 
2.31.1

