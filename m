Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 795C4421B39
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 02:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhJEAmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 20:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbhJEAmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 20:42:19 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A015C061749
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 17:40:30 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id v17-20020a4ae051000000b002b5a56e3da3so5912502oos.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 17:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UeYE606AtOaUbHnjJix1yj04uzh2BmvD/bVanv2Ttbg=;
        b=Cff0WKDiZ8yw+AKafR9Ct3x0bcOY9Nviv6v+Xm8rYfXtR1VEkStYe0IK9EwuDfiWcc
         wLNFm5dO52ABBcbLocK8UNOu3UYaCNRtkftm46wPSp04JKGI7ymYU76sYagzPNdd6pkd
         A+yf5EVSeKU60u2zeGK8dptE/tWYZ67ndKxdseRkVgMfG5YPQPf/+X97QqbqqgUW+baq
         eQJjAPtv9EeeQdBL91k2+VTK3UqcHzQ9ieUHMuMI20Mkv4SgJ2mY9Pu31DL+hSsqSX0H
         B+7jJCxruDTGYkyORCIIPXwxAfhw861jXovqBWa5nW8TXXuyW/mbsTd+QY6SA98xUbXj
         DS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=UeYE606AtOaUbHnjJix1yj04uzh2BmvD/bVanv2Ttbg=;
        b=y8uxe+g10+SRz9C80xJHSFcSQHAkKgtLYnHQ6EH0SR6rZ+A0v7SNdX9FyrMzphrUaM
         Ahw4z+7IMVpwbAiyl/WPGB/3gQqTTIUx6wIAUGz9dFW+Q8gOiaV64Y9DqPI33yzd2Hnk
         dsJjVrO4phsjNdTiMUfRVGjK7r6YhBNO2o/Sy2LikjtCdnTLe8BA4lACDcjZJr3jLuVa
         1oTmhaZORa6b5idk0bRYDtEzQWmB209t1LkWk9QQ0xJnP5RnYMvMwmtqG2d/BiySkLXL
         S7jZKFjtdyyrmJZSyhqQvYvsrr6fcdTy34xs3pDUxrc7/Fj7QUgpb3R3WL2x2V9rjd79
         Yh6A==
X-Gm-Message-State: AOAM533kLecFcnZ2/+q5/W0EOPRbufQLC1T6isusHp+Z4r66QVBVFEKL
        mB68/ksLY/e3kkh6cN7jTg==
X-Google-Smtp-Source: ABdhPJyTQvC7dXmTdY6LWviqi3pBypqXnLtELwE1A5hdLnkSLfmX44ujX4m/j2av3GJOeMj1SDbmaQ==
X-Received: by 2002:a4a:d185:: with SMTP id j5mr11384754oor.16.1633394429506;
        Mon, 04 Oct 2021 17:40:29 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id o8sm3097824oiw.39.2021.10.04.17.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 17:40:27 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from t560.minyard.net (unknown [IPv6:2001:470:b8f6:1b:1ce5:3fb4:8fe9:30d1])
        by serve.minyard.net (Postfix) with ESMTPA id 774071800F8;
        Tue,  5 Oct 2021 00:40:26 +0000 (UTC)
From:   minyard@acm.org
To:     openipmi-developer@lists.sourceforge.net
Cc:     Andrew Manley <andrew.manley@sealingtech.com>,
        linux-kernel@vger.kernel.org, Corey Minyard <cminyard@mvista.com>,
        Corey Minyard <minyard@acm.org>
Subject: [PATCH 4/5] ipmi: Add docs for IPMB direct addressing
Date:   Mon,  4 Oct 2021 19:40:18 -0500
Message-Id: <20211005004019.2670691-5-minyard@acm.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005004019.2670691-1-minyard@acm.org>
References: <20211005004019.2670691-1-minyard@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corey Minyard <cminyard@mvista.com>

Describe the addressing mechanism and how to use it.

Signed-off-by: Corey Minyard <minyard@acm.org>
Tested-by: Andrew Manley <andrew.manley@sealingtech.com>
Reviewed-by: Andrew Manley <andrew.manley@sealingtech.com>
---
 Documentation/driver-api/ipmi.rst | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/ipmi.rst b/Documentation/driver-api/ipmi.rst
index bc281f10ce4b..c9cb5669bc4c 100644
--- a/Documentation/driver-api/ipmi.rst
+++ b/Documentation/driver-api/ipmi.rst
@@ -166,8 +166,8 @@ and the type is IPMI_SYSTEM_INTERFACE_ADDR_TYPE.  This is used for talking
 straight to the BMC on the current card.  The channel must be
 IPMI_BMC_CHANNEL.
 
-Messages that are destined to go out on the IPMB bus use the
-IPMI_IPMB_ADDR_TYPE address type.  The format is::
+Messages that are destined to go out on the IPMB bus going through the
+BMC use the IPMI_IPMB_ADDR_TYPE address type.  The format is::
 
   struct ipmi_ipmb_addr
   {
@@ -181,6 +181,23 @@ The "channel" here is generally zero, but some devices support more
 than one channel, it corresponds to the channel as defined in the IPMI
 spec.
 
+There is also an IPMB direct address for a situation where the sender
+is directly on an IPMB bus and doesn't have to go through the BMC.
+You can send messages to a specific management controller (MC) on the
+IPMB using the IPMI_IPMB_DIRECT_ADDR_TYPE with the following format::
+
+  struct ipmi_ipmb_direct_addr
+  {
+	int           addr_type;
+	short         channel;
+	unsigned char slave_addr;
+	unsigned char rq_lun;
+	unsigned char rs_lun;
+  };
+
+The channel is always zero.  You can also receive commands from other
+MCs that you have registered to handle and respond to them, so you can
+use this to implement a management controller on a bus..
 
 Messages
 --------
@@ -348,6 +365,10 @@ user may be registered for each netfn/cmd/channel, but different users
 may register for different commands, or the same command if the
 channel bitmasks do not overlap.
 
+To respond to a received command, set the response bit in the returned
+netfn, use the address from the received message, and use the same
+msgid that you got in the receive message.
+
 From userland, equivalent IOCTLs are provided to do these functions.
 
 
-- 
2.25.1

