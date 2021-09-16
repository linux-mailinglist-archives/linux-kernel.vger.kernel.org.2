Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A89F40D579
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237250AbhIPJDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:03:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235453AbhIPJBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:01:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1CCB61350;
        Thu, 16 Sep 2021 09:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631782802;
        bh=8X6iKZKbq4im/83b/dKnmIbN89ytuKdprO9tSswagyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WYMBrPDPCcvja0Yc3J1jiuq/AmXN0UaZ9stSHBsmrwgDjaluzcISXENaSciODSmMZ
         +OE37P0PvRuocXJ90CokLvSOsc0qz2CnG5ec2eT0nHOzieMPRFVXxcZkvdVogVEixB
         4KU2bnyPjxk7yuwvUysIFS0KPjzeF8IIOJI/Qjy18WzuCpNjBI3DFGzzPe+BSOMYeA
         LD2B59woMwbQMhFMbCMhs8trGhrwmj6tXLa6Cz35vtkG/0rakEySwB5XsG1JC+aqZL
         Z4viRAd0vOiNIMLIKAJ9ikuXPKPgFZGMgnWNYXyDF3wrIt6f12y+dVtA5zstHoMa5R
         xlZaFcz6w1bXw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQnFR-001qka-0J; Thu, 16 Sep 2021 11:00:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 16/30] ABI: sysfs-bus-soundwire-slave: use wildcards on What definitions
Date:   Thu, 16 Sep 2021 10:59:43 +0200
Message-Id: <416f4a746c116147abb08fb0155a6a4ed065dfd7.1631782432.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631782432.git.mchehab+huawei@kernel.org>
References: <cover.1631782432.git.mchehab+huawei@kernel.org>
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
 .../ABI/testing/sysfs-bus-soundwire-slave     | 60 +++++++++----------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-soundwire-slave b/Documentation/ABI/testing/sysfs-bus-soundwire-slave
index d324aa0b678f..fbf55834dfee 100644
--- a/Documentation/ABI/testing/sysfs-bus-soundwire-slave
+++ b/Documentation/ABI/testing/sysfs-bus-soundwire-slave
@@ -64,37 +64,37 @@ Description:	SoundWire Slave Data Port-0 DisCo properties.
 		Data port 0 are used by the bus to configure the Data Port 0.
 
 
-What:		/sys/bus/soundwire/devices/sdw:.../dpN_src/max_word
-		/sys/bus/soundwire/devices/sdw:.../dpN_src/min_word
-		/sys/bus/soundwire/devices/sdw:.../dpN_src/words
-		/sys/bus/soundwire/devices/sdw:.../dpN_src/type
-		/sys/bus/soundwire/devices/sdw:.../dpN_src/max_grouping
-		/sys/bus/soundwire/devices/sdw:.../dpN_src/simple_ch_prep_sm
-		/sys/bus/soundwire/devices/sdw:.../dpN_src/ch_prep_timeout
-		/sys/bus/soundwire/devices/sdw:.../dpN_src/imp_def_interrupts
-		/sys/bus/soundwire/devices/sdw:.../dpN_src/min_ch
-		/sys/bus/soundwire/devices/sdw:.../dpN_src/max_ch
-		/sys/bus/soundwire/devices/sdw:.../dpN_src/channels
-		/sys/bus/soundwire/devices/sdw:.../dpN_src/ch_combinations
-		/sys/bus/soundwire/devices/sdw:.../dpN_src/max_async_buffer
-		/sys/bus/soundwire/devices/sdw:.../dpN_src/block_pack_mode
-		/sys/bus/soundwire/devices/sdw:.../dpN_src/port_encoding
+What:		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/max_word
+		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/min_word
+		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/words
+		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/type
+		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/max_grouping
+		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/simple_ch_prep_sm
+		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/ch_prep_timeout
+		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/imp_def_interrupts
+		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/min_ch
+		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/max_ch
+		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/channels
+		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/ch_combinations
+		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/max_async_buffer
+		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/block_pack_mode
+		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/port_encoding
 
-		/sys/bus/soundwire/devices/sdw:.../dpN_sink/max_word
-		/sys/bus/soundwire/devices/sdw:.../dpN_sink/min_word
-		/sys/bus/soundwire/devices/sdw:.../dpN_sink/words
-		/sys/bus/soundwire/devices/sdw:.../dpN_sink/type
-		/sys/bus/soundwire/devices/sdw:.../dpN_sink/max_grouping
-		/sys/bus/soundwire/devices/sdw:.../dpN_sink/simple_ch_prep_sm
-		/sys/bus/soundwire/devices/sdw:.../dpN_sink/ch_prep_timeout
-		/sys/bus/soundwire/devices/sdw:.../dpN_sink/imp_def_interrupts
-		/sys/bus/soundwire/devices/sdw:.../dpN_sink/min_ch
-		/sys/bus/soundwire/devices/sdw:.../dpN_sink/max_ch
-		/sys/bus/soundwire/devices/sdw:.../dpN_sink/channels
-		/sys/bus/soundwire/devices/sdw:.../dpN_sink/ch_combinations
-		/sys/bus/soundwire/devices/sdw:.../dpN_sink/max_async_buffer
-		/sys/bus/soundwire/devices/sdw:.../dpN_sink/block_pack_mode
-		/sys/bus/soundwire/devices/sdw:.../dpN_sink/port_encoding
+		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/max_word
+		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/min_word
+		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/words
+		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/type
+		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/max_grouping
+		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/simple_ch_prep_sm
+		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/ch_prep_timeout
+		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/imp_def_interrupts
+		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/min_ch
+		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/max_ch
+		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/channels
+		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/ch_combinations
+		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/max_async_buffer
+		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/block_pack_mode
+		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/port_encoding
 
 Date:		May 2020
 
-- 
2.31.1

