Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE0C309F91
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 00:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbhAaXpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 18:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhAaXps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 18:45:48 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5CCC061573;
        Sun, 31 Jan 2021 15:45:08 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id h6so16949530oie.5;
        Sun, 31 Jan 2021 15:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=/MfklXb/fPreEZTP4a/+2979i0zJ9HYWRF0rUS01xT4=;
        b=Q7P9XwZrFaqX3BfRtb5F59wxFQFPracuGkwFgBC5GxyKvAuYFMbk9YovhUnLw2b5J0
         WeTAlgEi38LFVusmVYZSJ9WjNNvRGNckNn3GV6lpm3lo09Cb9aKfneru75uV0qRQfffd
         12Mf5/wZL1vEuCabdtEeZqC3JALYEBup2tqZCLr62ZTmip28TES3gfRuLFNxhRDjMdan
         ZLdvy16LsaBTrw2eobYJJpOXXBnrHsaKsiYciPo1bgqBBD23FWM/OPUpbmPYpvEjRWMF
         RgDksqEdw9xOOuTQHsWQbnSWD591BC9Ll+8Cfe8z3xWO5OoUhsaWAhO0uI7KAvjPGFdJ
         odZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=/MfklXb/fPreEZTP4a/+2979i0zJ9HYWRF0rUS01xT4=;
        b=p1cVl34Yno+6mqGbc3MKxEk5Rd7/VBpSNC4YYe1lHaMaZplsxxSjEhsC5q/4xkv4HN
         49iPxZqP95Dqhfa+KfHKAt7K0fNufX1lnsvps7A6BoE9eLyt6fQ8gf8niJ5d/P4/o53N
         NKE1P1NjIdrULc03HSvvhBkZk1gEq/oqn1QjtdAOuKkFve16NLnM3ScOBVkA+v4/6X43
         M7LGbi3De4qlTZ1u4yTFP9z0pTn+258XBlQ0wKmuto4pMrRJw3jeTCkQ1QKeWhSETmCv
         FeoECHkncG1pKHoLLOXaPKnU/kRWnFM3ttofZHlNYndOEpERSieRk3Il+Yw08VJxrHe+
         f2AA==
X-Gm-Message-State: AOAM530ACLMN17efTt0MIzMVxxV/ooGzPPUNEFDtKTucdxxVLpwKeNFV
        hAuzx9XWmB/GdLRZ9I2Ut9yNX7ZTyDKi6vipZ84=
X-Google-Smtp-Source: ABdhPJxzE/iWBwXGLvMTUc1b0SKuduY8Kx1fkFZPrhoYcU21x3VptgyFcRoMFIgK6brg1e0HsV7LWP1iUzwUMqYk6rI=
X-Received: by 2002:aca:d11:: with SMTP id 17mr9423685oin.6.1612136707670;
 Sun, 31 Jan 2021 15:45:07 -0800 (PST)
MIME-Version: 1.0
From:   Ruslan Bilovol <ruslan.bilovol@gmail.com>
Date:   Mon, 1 Feb 2021 01:44:56 +0200
Message-ID: <CAB=otbTVxa=nGWF4K1AYcYyPceYYRkC_1HYSb_Nhu6C9RMZEHA@mail.gmail.com>
Subject: RPi4 DWC2 gadget doesn't copy data to a buffer in ep0 SETUP + DATA
 OUT transaction
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Linux USB <linux-usb@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minas and other USB experts,

I'm currently developing new features for UAC1/UAC2 audio gadgets
like Volume/Mute controls which use Control SETUP + DATA OUT
transactions through ep0.

While it works fine on BeagleBone black board with MUSB UDC,
on Raspberry Pi 4 with DWC2 UDC there is an issue.

I found that when DWC2 receives ep0 SETUP + DATA OUT transaction,
it doesn't copy data transferred from the host to EP0 in DATA OUT stage
to the usb_request->buf buffer. This buffer contains unchanged data from
previous transactions.

However, when I disable DMA for DWC2 controller (see the patch below)
it starts to work as expected and correctly copies data transferred from
the host in the DATA OUT stage, to the usb_request->buf buffer.

So far I tested it on v5.9 kernel and v5.10.10 stable kernel both have
the same issue.

This issue is easily reproducible with RNDIS gadget which also
uses ep0 SETUP + DATA OUT transactions for transferring
RNDIS control messages.

During enumeration of RNDIS gadget attached to Linux host,
I see next messages for RPi4 DWC2 with DMA enabled:

| ## RPi4 DWC2 DMA
| [   91.029881] rndis_msg_parser: unknown RNDIS message 0x0052033A len 4456526
| [   91.029889] RNDIS command error -524, 24/24

In this case rndis_msg_parser can't parse messages from the host
because they are sent through SETUP + DATA OUT transaction and
DWC2 didn't copy that messages to the buffer, so buffer contains
some garbage from previous transactions which can't be parsed.

In case of BBB black or DWC2 with disabled DMA, it looks like:

| ## BBB black
| [   32.867751] rndis_msg_parser: RNDIS_MSG_INIT

| ## RPi4 DWC2 no DMA
| [  151.080724] rndis_msg_parser: RNDIS_MSG_INIT

I also did a quick googling and found that same issue was
recently reported for Raspberry pi OS:
https://github.com/raspberrypi/Raspberry-Pi-OS-64bit/issues/127

I spent some time on debugging this issue, but without having
DWC2 documentation and experience with DWC2 internals
that's all that I found so far.

Is this a known issue? Anybody debugging it? Any ideas?

Thanks,
Ruslan

-------------------------------------8<----------------------------------------
From ced7a3631d9800d04bcbcd756dac4583459fe48c Mon Sep 17 00:00:00 2001
From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Date: Wed, 20 Jan 2021 00:27:52 +0200
Subject: [PATCH] usb: dwc2: workaround: disable DMA for gadget

On Raspberry PI 4 it was observer that in case of control
transfers with DATA phase from a host, the driver for some
reason doesn't copy transferred data to the buffer, leaving
previous data in it.

With disabled DMA the issue isn't reproducible, thus
temporarily disable it

Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
---
 drivers/usb/dwc2/params.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index 267543c..46c18af 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -357,7 +357,11 @@ static void dwc2_set_default_params(struct
dwc2_hsotg *hsotg)
 {
  struct dwc2_hw_params *hw = &hsotg->hw_params;
  struct dwc2_core_params *p = &hsotg->params;
+#if 0
  bool dma_capable = !(hw->arch == GHWCFG2_SLAVE_ONLY_ARCH);
+#else
+ bool dma_capable = 0;
+#endif

  dwc2_set_param_otg_cap(hsotg);
  dwc2_set_param_phy_type(hsotg);
@@ -651,7 +655,11 @@ static void dwc2_check_params(struct dwc2_hsotg *hsotg)
 {
  struct dwc2_hw_params *hw = &hsotg->hw_params;
  struct dwc2_core_params *p = &hsotg->params;
+#if 0
  bool dma_capable = !(hw->arch == GHWCFG2_SLAVE_ONLY_ARCH);
+#else
+ bool dma_capable = 0;
+#endif

  dwc2_check_param_otg_cap(hsotg);
  dwc2_check_param_phy_type(hsotg);
-- 
1.9.1
