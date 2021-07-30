Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2D33DB8D6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 14:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238895AbhG3Mql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 08:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238866AbhG3Moq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 08:44:46 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C65C061765
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 05:43:53 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id j12-20020a05620a146cb02903ad9c5e94baso5637939qkl.16
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 05:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=BUiqVnmCC5LvHUiB8iYWIOWbO4jO0OfShvOq4rUC/U0=;
        b=uot/DzFgmwjObSu3zktrMgJ2umnJ8lum8uAOrI27vCbViA92GIbqlHdxxDRPAtckTu
         pERv9asVh4OIsUjb+BUVGdepbl1ymy3BdWTldI52oht4Djvx8c1uLSPY415R6wMYVqfP
         gh2tWn1w+GJx/x5pJ64MIl5CVdTQ5d4MVpxZcq/C15WiF5kTACB9QcDW/Ru8dv3bKYO7
         1XCRNDQ1GfUcykDekKhqhlqii7cp89YBceib99SKdTvjEb4dOjmjNd2B7LZRDb5dXKUx
         a5PQTb0tC4XQwd4a3cymf2cMRcb8AR13tAzMA+varqD7Skn/iPnkXY10kLohLcJB0CWT
         oSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=BUiqVnmCC5LvHUiB8iYWIOWbO4jO0OfShvOq4rUC/U0=;
        b=P4rLGsqqvtvrJ/HRw5eTwSGy3GLyzyxVxUgCvIbh8iBMWalv/n8/wF7rtYAjvZCImP
         PijgY8xvCcDGBcZ9uP/UDZmcG9r6N9Zb6EPQhXF50UMEE8TKKMGguegCCvtMsNuEc9SE
         okG3bNEtYArR6hMURUqeYL2l8f+6XTG+dSOwxfVeT/uDisNIrmWwW/2QwrKc6jGB5kM3
         vyiN6JPZYm7ehU6AtKRjpOqV70QtVWPZExRpXAEvnO2cxIX8jNYAfo105CkBnyb+Y89P
         wSVJRjO+CFcFG8wsfLvr3LGgJkinB0rEcq+ljY5Vfmkw7A0Dxpq8NphffIu3HVoGKz7m
         U3eQ==
X-Gm-Message-State: AOAM531hnAlz+PC0vUJBa1eZKAaBeGEmV/VxWhZNCq22tnsmqUFoNU7s
        2Lf11GlGMkWWAf1JoIT1b4ca9iO2YzSM
X-Google-Smtp-Source: ABdhPJxzxMzASRvkFgqW+ytumwovki124B/n372u7N1TvgSmlRct/5OVggH9RDgimalWc+KEFLXb7Jn2Ascy
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:6892:a74:4970:a062])
 (user=kyletso job=sendgmr) by 2002:ad4:522c:: with SMTP id
 r12mr2460956qvq.17.1627649032859; Fri, 30 Jul 2021 05:43:52 -0700 (PDT)
Date:   Fri, 30 Jul 2021 20:43:46 +0800
Message-Id: <20210730124348.1986638-1-kyletso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH v5 0/2] TCPM non-PD mode
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

cover-letter is the same as that in v4

The reason for this patch is to let the device/system policy decide
whether PD is going to be supported using devicetree properties.

A new dt property "pd-unsupported" is introduced and TCPM uses this
property as a flag to decide whether PD is supported. If the flag is
false (the dt property is not present), the RX functionality of the
low-level driver will not be enabled. The power negotiation related
states will be skipped as well. If the flag is true, everything is a
what it was before.

If "pd-unsupported" is present, and the port is SRC or DRP, another
existing dt property "typec-power-opmode" needs to be specified to
indicate which Rp value should be used when the port is SRC.

changes since v4:
dt-bindings: connector: Add pd-unsupported property
- Corrected the subject

usb: typec: tcpm: Support non-PD mode
- Added Reviewed-by

Kyle Tso (2):
  dt-bindings: connector: Add pd-unsupported property
  usb: typec: tcpm: Support non-PD mode

 .../bindings/connector/usb-connector.yaml     |  4 +
 drivers/usb/typec/tcpm/tcpm.c                 | 87 +++++++++++++++----
 2 files changed, 72 insertions(+), 19 deletions(-)

-- 
2.32.0.554.ge1b32706d8-goog

