Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8D040B0DF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbhINOgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:36:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233858AbhINOeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:34:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0AE46121F;
        Tue, 14 Sep 2021 14:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631629970;
        bh=223jFRZJMMHbkDrjPCo1stNDFp9oupnGkKgVhQoSgTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iWi5ce2ENkIx6IkcoCtiSBiCY6slQSMjqTDUTdzChM9ELxZ0OhZ1Vi2pPm7hnbOyR
         IITyJO+Y6dWmw3sM2P2aHtIaAvLuujpBNyqGXI37qOYo6eW0aoZKQEyOHWMhBVYbrk
         vvwlNi5e+xODaokNKTRJuyCpDNI0CeFIJWRX1Vqf/jOtZrHArftuGXvHb1m5eQlTdr
         AFx54DNLSmF4In/L0y0rcgNyV1Q4sjoxAATEAobH5wF4LWMXysSidCmH2a4+ZW4yXm
         JKRnAfLCzgshVH7X4OV2+kIaQTqm/fE5kHy4c5SpvqaeLxJptvC1Vem+8n4xwf8lu8
         oKQO9PJSb4uSg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQ9UO-000KlA-1B; Tue, 14 Sep 2021 16:32:48 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/29] ABI: sysfs-bus-soundwire-master: use wildcards on What definitions
Date:   Tue, 14 Sep 2021 16:32:30 +0200
Message-Id: <b666b3ae34ca8228332767616954ca35afba323b.1631629496.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631629496.git.mchehab+huawei@kernel.org>
References: <cover.1631629496.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An "N" upper letter is not a wildcard, nor can easily be identified
by script, specially since the USB sysfs define things like.
bNumInterfaces. Use, instead, <N>, in order to let script/get_abi.pl
to convert it into a Regex.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/testing/sysfs-bus-soundwire-master | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-soundwire-master b/Documentation/ABI/testing/sysfs-bus-soundwire-master
index 46ef038d8722..f63db707ee7a 100644
--- a/Documentation/ABI/testing/sysfs-bus-soundwire-master
+++ b/Documentation/ABI/testing/sysfs-bus-soundwire-master
@@ -1,4 +1,4 @@
-What:		/sys/bus/soundwire/devices/sdw-master-N/revision
+What:		/sys/bus/soundwire/devices/sdw-master-<N>/revision
 		/sys/bus/soundwire/devices/sdw-master-N/clk_stop_modes
 		/sys/bus/soundwire/devices/sdw-master-N/clk_freq
 		/sys/bus/soundwire/devices/sdw-master-N/clk_gears
-- 
2.31.1

