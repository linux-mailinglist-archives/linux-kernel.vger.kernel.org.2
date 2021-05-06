Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A0F3758F7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 19:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236190AbhEFRLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 13:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236042AbhEFRLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 13:11:38 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AF5C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 10:10:39 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id t9-20020a0cde090000b02901c4c7ae0cceso4630032qvk.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 10:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=i5hbcI2b08ctJKsV+uyax41mbRV5yx+2PLw98oS0cyA=;
        b=cYpbRdAInq0ahsOxhhQDHOVzl2EHq7QVAlu3VoOnoHoPM6dHTEedg7JrMLWcyLuzPm
         zlccXnYyNnRJdTCctN9qIPMqNiLY6fAJ+nUlTZ0lebyuD/vF+pYur5RTcesMRk9OLfsM
         /3IrgJOi6R99I3LwrJ78YHoLKGs6fdUDCNdsDW3a4VyrASvdCsTrz1wTxbFbL5tWB4Tm
         INrtE2x+683XsreqXP5EE9uEaPq/d/8mxRHZqgX/AQrWb9UxCjYOmCw3Ez4JpoFbXKTj
         RPUOEUX1mgCDthTtab3HNoMvl8x2eFfFt0s/ZWLVRl/vbPbfzRAqfK4MV6WH8DqGnYLm
         +OtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=i5hbcI2b08ctJKsV+uyax41mbRV5yx+2PLw98oS0cyA=;
        b=CaVX55IUFcD2Z9j9JtsqSflT3rx7Kb2XpAsPNI/pfW7VmsrUzegScoHrfU+MWO8HL/
         saM0PY4CJ88pmRJo7GixF9zClJp2/8HdYvmWM+3873JKsxeQBh7/d3YCjsGyl5nDTxfn
         amqkNBj2JrDUvacuTDJQ1qEFwptgtWqgJe0gZ+A6s/wuB8FRdtW52FV0lt8X7Z74tLFs
         1ECJ2rm0mT+rpE3dAY1h2NH7QCT5xdf+YprM1AcW1oUf0hNegQmaRh3xO/sgrwlitj1I
         l5ilAieklInIwvsgogH+bOaZIJfe/Xp7emktxV0txTkzSh555dNruMSgSRNwXDIRq6Pt
         Du8w==
X-Gm-Message-State: AOAM532Muh/VLT3ohanrT3gfSYHOeXGE0WZqj2Q30W2/xiHLkjcqPOTa
        gNM2rWiOEL0TJBtZVZhjyN4B0g06R3wS
X-Google-Smtp-Source: ABdhPJx1Qh9ZnnpOXcw0rDlmx7IiVVSYANT+aJil6BYGXaRj01+yFGWnYY3Ec6O2jMqPdCop9rpd19kEvrlY
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:9a5c:8de0:4c79:ba52])
 (user=kyletso job=sendgmr) by 2002:a0c:e6c5:: with SMTP id
 l5mr5829060qvn.2.1620321038643; Thu, 06 May 2021 10:10:38 -0700 (PDT)
Date:   Fri,  7 May 2021 01:10:24 +0800
Message-Id: <20210506171026.1736828-1-kyletso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH v2 0/2] VDM management improvement and some bug fixes
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

