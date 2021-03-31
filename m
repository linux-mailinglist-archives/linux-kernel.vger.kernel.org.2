Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B2234C545
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 09:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhC2Hu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 03:50:59 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:40410 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbhC2HuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 03:50:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617004224; h=References: In-Reply-To: References:
 In-Reply-To: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=Cspt7L9RGwyPgT6OPwo/iaMk9p8/3cLm8IE+KVY7mek=; b=ACcfRMCWVRqRthLVu9qBMwXXLEl3HaeZFxu5JBSahW0g/c/emUIcR1ty9zFyfHcdlmGEvlsf
 cvY16u8r4T9WCz9aM7yzAc2vC9Nv37zVm7p66QAxVxCNI3H/l5K7trYL8pfAl/wyKjSB7w9I
 OXgFSX79HAtIzEl7VwHvSAM5zkM=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 606186bf3f0cbfdaf2358ca8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 29 Mar 2021 07:50:23
 GMT
Sender: schowdhu=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A7EDBC433CA; Mon, 29 Mar 2021 07:50:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-525.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: schowdhu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E6BFEC433C6;
        Mon, 29 Mar 2021 07:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E6BFEC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=schowdhu@codeaurora.org
From:   Souradeep Chowdhury <schowdhu@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, vkoul@kernel.org,
        Souradeep Chowdhury <schowdhu@codeaurora.org>
Subject: [Resend PATCH V3 3/5] DCC: Added the sysfs entries for DCC(Data Capture and Compare) driver
Date:   Mon, 29 Mar 2021 13:19:12 +0530
Message-Id: <a800c114f43b3884e2427fd1ba1c58ba848f4391.1617001132.git.schowdhu@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1616651305.git.schowdhu@codeaurora.org>
References: <cover.1616651305.git.schowdhu@codeaurora.org>
In-Reply-To: <cover.1617001131.git.schowdhu@codeaurora.org>
References: <cover.1617001131.git.schowdhu@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DCC is a DMA engine designed to store register values either in
case of a system crash or in case of software triggers manually done
by the user.Using DCC hardware and the sysfs interface of the driver
the user can exploit various functionalities of DCC.The user can specify
the register addresses,the values of which is stored by DCC in it's
dedicated SRAM.The register addresses can be used either to read from,
write to,first read and store value and then write or to loop.All these
options can be exploited using the sysfs interface given to the user.
Following are the sysfs interfaces exposed in DCC driver which are
documented
1)trigger
2)config
3)config_write
4)config_reset
5)enable
6)rd_mod_wr
7)loop

Signed-off-by: Souradeep Chowdhury <schowdhu@codeaurora.org>
---
 Documentation/ABI/testing/sysfs-driver-dcc | 114 +++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-dcc

diff --git a/Documentation/ABI/testing/sysfs-driver-dcc b/Documentation/ABI/testing/sysfs-driver-dcc
new file mode 100644
index 0000000..05d24f0
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-dcc
@@ -0,0 +1,114 @@
+What:           /sys/bus/platform/devices/.../trigger
+Date:           March 2021
+Contact:        Souradeep Chowdhury <schowdhu@codeaurora.org>
+Description:
+		This is the sysfs interface for manual software
+		triggers.The user can simply enter a 1 against
+		the sysfs file and enable a manual trigger.
+		Example:
+		echo  1 > /sys/bus/platform/devices/.../trigger
+
+What:           /sys/bus/platform/devices/.../enable
+Date:           March 2021
+Contact:        Souradeep Chowdhury <schowdhu@codeaurora.org>
+Description:
+		This sysfs interface is used for enabling the
+		the dcc hardware.Without this being set to 1,
+		the dcc hardware ceases to function.
+		Example:
+		echo  0 > /sys/bus/platform/devices/.../enable
+		(disable interface)
+		echo  1 > /sys/bus/platform/devices/.../enable
+		(enable interface)
+
+What:           /sys/bus/platform/devices/.../config
+Date:           March 2021
+Contact:        Souradeep Chowdhury <schowdhu@codeaurora.org>
+Description:
+		This is the most commonly used sysfs interface
+		file and this basically stores the addresses of
+		the registers which needs to be read in case of
+		a hardware crash or manual software triggers.
+		Example:
+		echo  0x80000010 10 > /sys/bus/platform/devices/../config
+		This specifies that 10 words starting from address
+		0x80000010 is to be read.In case there are no words to be
+		specified we can simply enter the address.
+
+What:           /sys/bus/platform/devices/.../config_write
+Date:           March 2021
+Contact:        Souradeep Chowdhury <schowdhu@codeaurora.org>
+Description:
+		This file allows user to write a value to the register
+		address given as argument.The values are entered in the
+		form of <register_address> <value>.The reason for this
+		feature of dcc is that for accessing certain registers
+		it is necessary to set some bits of soe other register.
+		That is achievable by giving DCC this privelege.
+		Example:
+		echo 0x80000000 0xFF > /sys/bus/platform/devices/.../config_write
+
+What:           /sys/bus/platform/devices/.../config_reset
+Date:           March 2021
+Contact:        Souradeep Chowdhury <schowdhu@codeaurora.org>
+Description:
+		This file is used to reset the configuration of
+		a dcc driver to the default configuration.
+		Example:
+		echo  1 > /sys/bus/platform/devices/.../config_reset
+
+What:           /sys/bus/platform/devices/.../loop
+Date:		March 2021
+Contact:        Souradeep Chowdhury <schowdhu@codeaurora.org>
+Description:
+		This file is used to enter the loop count as dcc
+		driver gives the option to loop multiple times on
+		the same register and store the values for each
+		loop.This is done to capture the changing values
+		of a register with time which comes handy for
+		debugging purposes.
+		Example:
+		echo 10 > /sys/bus/platform/devices/10a2000.dcc/loop
+		(Setting the loop count to 10)
+		echo  0x80000010 10 > /sys/bus/platform/devices/.../config
+                (Read 10 words starting from address 0x80000010O)
+		echo 1 > /sys/bus/platform/devices/.../loop
+		(Terminate the loop by writing a count of 1 to the loop sysfs node)
+
+What:           /sys/bus/platform/devices/.../rd_mod_wr
+Date:           March 2021
+Contact:        Souradeep Chowdhury <schowdhu@codeaurora.org>
+Description:
+		This file is used to read the value of the register
+		and then write the value given as an argument to the
+		register address in config.The address argument should
+		be given of the form <mask> <value>.For debugging
+		purposes sometimes we need to first read from a register
+		and then set some values to the register.
+		Example:
+		echo 0x80000000 > /sys/bus/platform/devices/.../config
+		(Set the address in config file)
+		echo 0xF 0xA > /sys/bus/platform/devices/.../rd_mod_wr
+		(Provide the mask and the value to write)
+
+What:           /sys/bus/platform/devices/.../ready
+Date:           March 2021
+Contact:        Souradeep Chowdhury <schowdhu@codeaurora.org>
+Description:
+		This file is used to check the status of the dcc
+		hardware if it's ready to take the inputs.
+		Example:
+		cat /sys/bus/platform/devices/.../ready
+
+What:		/sys/bus/platform/devices/.../curr_list
+Date:		February 2021
+Contact:	Souradeep Chowdhury <schowdhu@codeaurora.org>
+Description:
+		This attribute is used to enter the linklist to be
+		used while appending addresses.The range of values
+		for this can be from 0 to 3.This feature is given in
+		order to use certain linkedlist for certain debugging
+		purposes.
+		Example:
+		echo 0 > /sys/bus/platform/devices/10a2000.dcc/curr_list
+
--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

