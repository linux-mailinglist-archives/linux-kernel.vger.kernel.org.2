Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB523ADAAA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 17:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbhFSPqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 11:46:18 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:54176 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbhFSPqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 11:46:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624117446; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=Ri5cchpabYVpYyuRXmLtfl/9pxuvePUUyJsuIYB0DU0=; b=QHPdME1eLJsoWqxAQEmLQDxnT/2/NLf9NBG4Ey9JtNZ4oCAdaCXuPLn0bqIJX911WPcPqwKg
 Z+o0ys2G+KJL8cKvMVJUNM+LU/uibA3DGeDdQDg5TkrYl9GU750uIscY2IWhYA7Hw5/rNJha
 tossF0By1PC3lCr2mBGrvOqDdz0=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60ce10aeea2aacd729bd9af3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 19 Jun 2021 15:43:42
 GMT
Sender: linyyuan=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 98FC1C4338A; Sat, 19 Jun 2021 15:43:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from localhost.localdomain (unknown [101.87.142.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: linyyuan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1EA1FC433F1;
        Sat, 19 Jun 2021 15:43:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1EA1FC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=linyyuan@codeaurora.org
From:   Linyu Yuan <linyyuan@codeaurora.org>
To:     Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jack Pham <jackp@codeaurora.org>
Subject: [PATCH v3 0/2] usb: udc: indroduce more api for lower gadget driver
Date:   Sat, 19 Jun 2021 23:43:07 +0800
Message-Id: <20210619154309.52127-1-linyyuan@codeaurora.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

void usb_gadget_udc_disconnect(struct usb_gadget *);
void usb_gadget_udc_suspend(struct usb_gadget *);
void usb_gadget_udc_resume(struct usb_gadget *);
int usb_gadget_udc_setup(struct usb_gadget *,
			const struct usb_ctrlrequest *);

dwc3 is first driver to use these apis.

v3: fix mail format
v3: fix mail format

Linyu Yuan (2):
  usb: udc: core: hide struct usb_gadget_driver to gadget driver
  usb: dwc3: fix race of usb_gadget_driver operation

 drivers/usb/dwc3/core.h       |  2 --
 drivers/usb/dwc3/ep0.c        |  6 +---
 drivers/usb/dwc3/gadget.c     | 53 +++++++++--------------------------
 drivers/usb/gadget/udc/core.c | 47 ++++++++++++++++++++++++++++++-
 include/linux/usb/gadget.h    |  6 ++++
 5 files changed, 66 insertions(+), 48 deletions(-)

-- 
2.25.1

