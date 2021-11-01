Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F62E441A73
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 12:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhKALM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 07:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhKALMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 07:12:24 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B775C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 04:09:51 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n18so11328200plc.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 04:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bg/Nxjcg97SdYrwitZ6E3dM7TX0/NVlamOqK7QpXn2s=;
        b=P8mA3v684ZZqdOvmfJAzL7ik8DyaXlmJ/IN8KbNAMZ3U0fB+LV10ELlMGaP9NKrAeC
         LZw/NWsunO7Z6aQUEX8K2OMiVE7nNiG827i/F7eHwTVPBXmIDPf2aDA0GBB5w/wDO6of
         euDJ652uTTxVrXJ5sTE0R1q81fhp1KJ8BcD/Hqlld1AbMeSLndAu1ogEED/d3MEiUwPm
         p3/x3AvfjJu1soBYUB/0JIIKsnFRCuAa0EUMIV6y2BbXTIdtm0I3ykKsuzLX6sOfVtw8
         nlqqpZergypdtBMABQbDPnJ5mOigaQ6fnQgyaDNV4A2PG5F0CG+xThJsFqbKX5eqh+15
         XuVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bg/Nxjcg97SdYrwitZ6E3dM7TX0/NVlamOqK7QpXn2s=;
        b=rYnVfVi4ufOsQ46oMN2j9RPos6Ozh0KZ6a6A2a3Bah8KP+GGeDK4253rBMiG+36876
         8hGDj05shIqmCBkco5AEv6sBFwzE7h49cWVsPQvtB7Ho5bq/VSo52DKwajBjh2bcH9Kn
         xce0WldiWCvZ29qrTCAkuTRy4aRdDe1xmY/IO8zE8jY2OQPIAqGaY8bQNCjE9TH8O16h
         xlEE1Bkb7y0DTHAqErgfH/UCw14hwZamGiOGp4bT2GExRkhQbhYDCN4T015hTbd/FYgy
         Sie4CIoCMilnO2rYh1t6QuTIwPQIt39ohXP22XkxizogsrNq8r+4ZCWYgJ/wAQRVQH3k
         7gxw==
X-Gm-Message-State: AOAM5336XgbPC/QLLaeMTF1GoEvAqBSoTsAUxK0iPlhh9wZkkDblIw56
        jHMcLAsqSV+64EJ4FjVhc6c=
X-Google-Smtp-Source: ABdhPJx0ejstOE33zO5V4OZmYXEExElg2v6a+UrWXmQ8Y/LdyxCuw3a6N7HNCc0yuwYpPYo9wPDlwA==
X-Received: by 2002:a17:902:6b86:b0:13f:8d7a:397c with SMTP id p6-20020a1709026b8600b0013f8d7a397cmr24828182plk.50.1635764990928;
        Mon, 01 Nov 2021 04:09:50 -0700 (PDT)
Received: from localhost.localdomain ([122.161.50.72])
        by smtp.googlemail.com with ESMTPSA id m15sm13355451pjf.49.2021.11.01.04.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 04:09:50 -0700 (PDT)
From:   Ojaswin Mujoo <ojaswin98@gmail.com>
To:     nsaenz@kernel.org, gregkh@linuxfoundation.org,
        stefan.wahren@i2se.com
Cc:     dan.carpenter@oracle.com, phil@raspberrypi.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] vchiq: Replacing global structs with per device
Date:   Mon,  1 Nov 2021 16:39:20 +0530
Message-Id: <cover.1635764115.git.ojaswin98@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Sorry for being so late on this patch, I recently found some time to
make progress on this hence sending this here for review and suggestions

This patch is the first draft to address the following task in the vchiq TODO
(staging/vc04_services/interface/TODO):

	13) Get rid of all non essential global structures and create a proper per
	device structure
  
	The first thing one generally sees in a probe function is a memory allocation
	for all the device specific data. This structure is then passed all over the
	driver. This is good practice since it makes the driver work regardless of
	the number of devices probed.

The patch is NOT complete yet but I thought it is a good time for a review so
that I can confirm if I'm approaching this correctly and not missing anything.

To start with, I have focused on making the state (g_state) as per-device instead of
global as it is one of the most frequently used global varibale in the driver
code right now. 

To achive this, I have modified the code to define a new data structure
"vchiq_device" which is initialised/allocated during probing and holds the state
as well as some other things like the miscdevice object that is needed to create
the misc device driver for vchiq.  Embedding the miscdevice structure in it
helps us retrieve vchiq_device struct when the misc_device open() is called and
then use it to retrieve the state. 

For all the ioctl and miscdevice fops, the filp->private_data stores the
vchiq_instance struct which embeds the vchiq state in it. I have modified the
code to fetch the state from here instead of using the global state or the
vchiq_get_state() function. 

This patch has been tested using vchiq_test utility and seems to be working
functional so far.

------- Changes ---------

* A short summary of the changes:

  *  Define per device structure vchiq_device 
	*  Use instance->state (per device state) instead of using the global state 
	   in the code
	*  Split vchiq_get_state() into vchiq_get_state() and vchiq_validate_state().
	   The validation function is used to validate the per device state. 
	*  Modify vchiq_dump_platform_instances(...) to pass in an extra vchiq_state
	   argument.

------- Some questions -------

**HOWEVER**, the patch is still not complete as there are some areas that still
need some work to ensure our driver is able to support multiple devices. I will
be listing them out below, would love to have some suggestions around it.

1. There is one specific function where I have not been able to replace the use
	 of global state, ie vchiq_initialise() function in vchiq_arm.c. The root
	 issue here is that vchiq_initialise is called from either the IOCTL
	 functions of the cdev or from other kernel modules directly. (Example, in
	 bcm2835_new_vchi_ctx() in bcm2835-audio)

	 When called from ioctl we have a reference to our per device state and we
	 can pass it in, but this is not possible when calling it from a different
	 kernel module.  This forces us to use a global state in the driver. 

	 I'm not sure how we can approach this in such a way that our driver is able
	 to support multiple devices. I would love to have some suggestions and
	 throughts around this.

2. In vchiq_deregister_chrdev() in vchiq_dev.c, I need the reference to the
	 miscdevice to call deregister on it. To get this reference, I use a global
	 variable but again, this wont work when we are trying to support multiple
	 devices. In this case, how do we handle registering and deregistering
	 multiple cdevs which might be created when we try to support multiple
	 VideoCore VPUs in the same driver.
	
--------------------------

Please let me know if you have any other suggestions or questions around the
patch and we can discuss the further. 

Thank you in advance!

Regards,
Ojaswin

Ojaswin Mujoo (1):
  staging: vchiq: Replace global state with per device state

 .../interface/vchiq_arm/vchiq_arm.c           | 100 ++++++++++++++----
 .../interface/vchiq_arm/vchiq_arm.h           |  12 ++-
 .../interface/vchiq_arm/vchiq_core.c          |   2 +-
 .../interface/vchiq_arm/vchiq_core.h          |   3 +-
 .../interface/vchiq_arm/vchiq_dev.c           |  64 +++++++----
 5 files changed, 138 insertions(+), 43 deletions(-)

-- 
2.25.1

