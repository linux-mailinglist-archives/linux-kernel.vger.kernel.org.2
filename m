Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0483DFCA6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 10:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbhHDITj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 04:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236179AbhHDITh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 04:19:37 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02C5C061799
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 01:19:23 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id p14-20020a05620a22eeb02903b94aaa0909so1617556qki.15
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 01:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JaeVOCD1xjiNZOo9WK4DguArWkRWfpfwXcJD2bxAZ2E=;
        b=RUoMD6rTY3IJ5/5+6xzAN02NV3WPmsnxPG+M6fxPeTNjvM/X4YQhwIGP2Rup96mqcI
         BhViJzXZSQHeOTbN/UGP3oFMatd7QM8PuTjGcMQb6P+BUarMrSAj517wqzBc6UXudTGK
         k3bubRgnXNyS+LnPV+vAuaWqRXr4bELD8I4x98i4v27VZYNpbblHw6B61CBOQnVXwQ10
         CDP/9NmBDASfZkv6UeCrimgSd1Zoji+aEytv2Cu6cxJf1s4k/kG/r/5p0vPrCqPP/BG8
         iWS0q32Muevk+q1Z2hFn+AfPpvNH/D/XyaN/8Hh6JMPPkwdclpQaDQRl2Zg6SNW+dFwG
         CouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JaeVOCD1xjiNZOo9WK4DguArWkRWfpfwXcJD2bxAZ2E=;
        b=auNY24Fv+9wrGGudJPYTTyYUdW12YvY1z6zaWfZi/cwWd5eVOclb/ZskI5FGHeqvZz
         xrhMkhk34bMynltSoVHPHm0pLys54Swgj8c2sygYShmsDRAcGfI3zPzssAIsV/0EsYn5
         Vu0vlkVMABG/eTG55Q481BvjTN37qQbkgnJRVVpFz6LALSRmznJzD+B5+2eWQIevstmA
         eTd2ujm9T8vsGThH2nd4egNd127hI7UD5FGLkbhOrBU6d8ZwTHJnpre41LZzbN966i+R
         hm3hotn17ZmIeKjmUOEvab1XZyHdzSRluBo8XoV0s6oKYTu7Ky85kaPGBcmzXcyTdVNb
         GvFQ==
X-Gm-Message-State: AOAM530435SNz2+4M1HiQguXttjYFtqajv+wb0olTd6iYTiRA1ECXykM
        BlKvpw1Eism1rbH2bZqgXXZKbIJUg/co
X-Google-Smtp-Source: ABdhPJz/Ubuo6nOoq/2uOV+UPUW4YrwJ1FpKt6WTzRBYNSlxeSoAHZr/LPGvs7Jk8Fk/VC6Wf5zixktUKiHw
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:7eb8:c2f5:2e08:d4bc])
 (user=kyletso job=sendgmr) by 2002:a05:6214:1021:: with SMTP id
 k1mr25874996qvr.4.1628065162885; Wed, 04 Aug 2021 01:19:22 -0700 (PDT)
Date:   Wed,  4 Aug 2021 16:19:15 +0800
Message-Id: <20210804081917.3390341-1-kyletso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH v6 0/2] TCPM non-PD mode
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(changed the property name only)

The reason for this patch is to let the device/system policy decide
whether PD is going to be supported using devicetree properties.

A new dt property "pd-disable" is introduced and TCPM uses this
property as a flag to decide whether PD is supported. If the flag is
false (the dt property is not present), the RX functionality of the
low-level driver will not be enabled. The power negotiation related
states will be skipped as well. If the flag is true, everything is a
what it was before.

If "pd-disable" is present, and the port is SRC or DRP, another
existing dt property "typec-power-opmode" needs to be specified to
indicate which Rp value should be used when the port is SRC.

changes since v5:
dt-bindings: connector: Add pd-disable property
- Changed the property name to "pd-disable"

usb: typec: tcpm: Support non-PD mode
- Changed the property name to "pd-disable"
- Added Acked-by tag

Kyle Tso (2):
  dt-bindings: connector: Add pd-disable property
  usb: typec: tcpm: Support non-PD mode

 .../bindings/connector/usb-connector.yaml     |  4 +
 drivers/usb/typec/tcpm/tcpm.c                 | 87 +++++++++++++++----
 2 files changed, 72 insertions(+), 19 deletions(-)

-- 
2.32.0.554.ge1b32706d8-goog

