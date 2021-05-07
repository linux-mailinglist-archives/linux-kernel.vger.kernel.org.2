Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF89437602F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 08:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbhEGGYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 02:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbhEGGYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 02:24:11 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5594C061761
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 23:23:06 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id t3-20020a170902e843b02900eec200979aso3579667plg.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 23:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Rdh0vRzSHWi0umCQDgHyPw54MZmqXW1urreOABEWOo0=;
        b=s7OXqMysxV0wyGqiHPyAopSoFuw1ZvUiirjHDE8W3YBKQmrdXCngfhxd+vOgSpdzAH
         tuk8Ag7Of06D4jXZLzchte5WrLVCOgYd5sEbL3RM/CoJEFgLlWs7FOzQzvtODxVraBwx
         2OZ63utQ5CNxVVtj9nEDt+g5j4m2nAjEVuJNIw6U4SDlivu/bKj6iH6yA9LG7Pofz2q+
         /UHPS4UTpO2asuJbw7wLpnG2N8e9wrW/j6tDRg+OCYmjIZEhTm1/7byjz6JftmlFGAd0
         lkvWw/oA5w6OeiX6j7G6MSRiJRlr2SVfDMjDrgTi5UVLIZE3Oo9alR1JdPBuDfZ3Fpvf
         To7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Rdh0vRzSHWi0umCQDgHyPw54MZmqXW1urreOABEWOo0=;
        b=rtRM5lhp+tiihb6TOpd1Cq+DgslnUFnMGZkt6QLJfDl2UGyYVtxbTFBnoYU4UHo2jj
         awnSO2RLMumXEUWg//dcQdR7254le8Fz4ibXGQIcD+Ww/LYo3fpUL3omwDZHtPrQE+ho
         XmxkBCEKBwPoNkVPrFIKq5D+UjGlCCVe/Wa0YJRZtBCQM7tXYmY0VRMl818ZY+TwKh7b
         Sql7CYB5Mpy9B4EVTzGYtAet/5dbfi8fOqyZRwIOjYi7p8LRZ0Tee6UuQLM/VI9/VHhZ
         +oW8lqsUPGE/LCx5y7HuT7SPBckrLFxY8+yp6I8AHmHUfTE7ejo002X+pnxzo4OcDHog
         Jqyw==
X-Gm-Message-State: AOAM530U5MraYL8thUNLjApUbCR+PHBoPIpJgJnAlU0KVBgGu2biSHgs
        JjCBpSiHIKsLTunmjKMCqZydaYgCSKqf
X-Google-Smtp-Source: ABdhPJxwn6YciE5u4JFCfq3pvH6+NmzwfobwWNdT5QoOJQU3JbPCMO+80b2ndzXZQgld5pvoWuCX1TTYemBp
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:9a5c:8de0:4c79:ba52])
 (user=kyletso job=sendgmr) by 2002:a62:4e87:0:b029:29e:ea03:6343 with SMTP id
 c129-20020a624e870000b029029eea036343mr6065411pfb.2.1620368586270; Thu, 06
 May 2021 23:23:06 -0700 (PDT)
Date:   Fri,  7 May 2021 14:22:58 +0800
Message-Id: <20210507062300.1945009-1-kyletso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH v3 0/2] VDM management improvement and some bug fixes
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No changes since v2 except for "Reviewed-by:" and "Acked-by:"

--
v2 cover letter:

usb: typec: tcpm: Send DISCOVER_IDENTITY from dedicated work
- nothing changed since v1
- Hi, Greg, do I need to add "Reviewed-by:" and "Acked-by:" ?

usb: typec: tcpm: Fix wrong handling for Not_Supported in VDM AMS
- I stacked these two patches because they are somewhat relevant.
- This patch solved 3 bugs
  1. Not_Supported should be acceptable in VDM AMS. Previous design will
     send Soft_Reset after receiving Not_Supported
  2. vdm_sm_running flag should be cleared in some VDM states
  3. If port partner responds Busy, the VDM AMS should finish.

Kyle Tso (2):
  usb: typec: tcpm: Send DISCOVER_IDENTITY from dedicated work
  usb: typec: tcpm: Fix wrong handling for Not_Supported in VDM AMS

 drivers/usb/typec/tcpm/tcpm.c | 99 ++++++++++++++++++++++++++++++-----
 1 file changed, 87 insertions(+), 12 deletions(-)

-- 
2.31.1.527.g47e6f16901-goog

