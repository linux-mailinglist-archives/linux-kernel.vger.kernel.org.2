Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FE0341868
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 10:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhCSJcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 05:32:11 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:52573 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbhCSJbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 05:31:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1616146310; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=ICCo1NwFAZQWpVxqKXI+Vi5m//alNYpfO/J2NdJBdv8=; b=gZQsNu7vYv6+kavatRylFVG6iW0fgVmJT95Kb3jQeS6LhzJNcGj3OxZwmAmKdB3IKE0YDLd0
 TKRPZeHWkyYgmMdTz4lvqLv8mk1/Z3EEUlLdfhjMyD6uVfWZL/Jo1K40J1XjTl1/RYCzwULI
 IwTiY6C/uROQeIU+dsJ2k8t4wNg=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 60546f754db3bb6801025baf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 19 Mar 2021 09:31:33
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AAD94C4346B; Fri, 19 Mar 2021 09:31:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from wcheng-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 71FCEC43464;
        Fri, 19 Mar 2021 09:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 71FCEC43464
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
From:   Wesley Cheng <wcheng@codeaurora.org>
To:     balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Wesley Cheng <wcheng@codeaurora.org>
Subject: [PATCH 0/2] Fix allowing of ep queuing while stopping transfers
Date:   Fri, 19 Mar 2021 02:31:23 -0700
Message-Id: <1616146285-19149-1-git-send-email-wcheng@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit f09ddcfcb8c5 ("usb: dwc3: gadget: Prevent EP queuing while stopping
transfers") addressed an issue where the DWC3 gadget was still allowing EP
queuing to occur while the pullup disable routine was executing.  This led to
a situation where the controller prepares a TRB, which will be unmapped by the
stop active transfer call.

In addition to the above, there are a few other places in the DWC3 gadget where
we need to block preparing of TRBs:

 1. While the DWC3 gadget cleans up completed TRBs (during
    dwc3_gadget_endpoint_trbs_complete()), DWC3 gadget giveback is utilized and
    will release the dwc->lock.  If a pullup disable call occurs while the
    cleanup is happening, then there is a chance dwc3_gadget_ep_should_continue
    will prepare a TRB, which will later on be unmapped by the stop active
    transfer in the pullup disable path.

 2. If we are in the CONFIGURED state and the host issues a bus RESET.  In this
    situation, the connected flag is still set to true while we stop active
    transfers, which can lead to the same initial problem.  Ideally, function
    drivers would stop any pending usb requests through dwc3_reset_gadget()
    using the EP disable call, but for some function drivers, this does not
    occur synchronously in their disable() callback.  These functions would rely
    on the stop active transfers in the reset handler to issue the endxfer cmd.

Wesley Cheng (2):
  usb: dwc3: gadget: Avoid continuing preparing TRBs during teardown
  usb: dwc3: gadget: Ignore EP queue requests during bus reset

 drivers/usb/dwc3/gadget.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

