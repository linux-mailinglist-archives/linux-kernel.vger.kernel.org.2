Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7800F3A5DD0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 09:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbhFNHmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 03:42:08 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:11733 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbhFNHmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 03:42:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623656404; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=d98WEJQYbmSI8pIjO0mRBl0EjEkT413AeWk1pMXSvV8=; b=WUKficYNOPtNM5HBDh9etySKUmOfrOqdUL5Eaq8oGXXu/Oy4PUhYFodj1N/bwSnmV6T9JD0F
 ZkpW1ZrMHIz1XZNpDINJ1guMhUvrnNT8apCRCASjJg25WNLN8xEi6tEwHwpYyAm/oML1Hwpk
 w46NDL8BFwza4D9HcWqn2tE3Jx8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60c707c4ed59bf69cc6992c0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 14 Jun 2021 07:39:48
 GMT
Sender: jackp=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 60694C433F1; Mon, 14 Jun 2021 07:39:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jackp-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: jackp)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 95FAEC433D3;
        Mon, 14 Jun 2021 07:39:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 95FAEC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jackp@codeaurora.org
Date:   Mon, 14 Jun 2021 00:39:42 -0700
From:   Jack Pham <jackp@codeaurora.org>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Wesley Cheng <wcheng@codeaurora.org>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: gadget: Disable gadget IRQ during pullup
 disable
Message-ID: <20210614073942.GB25299@jackp-linux.qualcomm.com>
References: <1621571037-1424-1-git-send-email-wcheng@codeaurora.org>
 <87h7i60ye8.fsf@kernel.org>
 <724ba69a-8c67-4b4b-3e6a-a5834b09e6e1@codeaurora.org>
 <a59a81c1-367f-b4b0-b6bf-dbe91ab3613d@codeaurora.org>
 <87wnr0zwxs.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wnr0zwxs.fsf@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 10:23:43AM +0300, Felipe Balbi wrote:
> Wesley Cheng <wcheng@codeaurora.org> writes:

<snip>

> > Hi Felipe,
> >
> > Let me share the ftrace snippets as well:
> >
> > USB FTRACE:
> >
> > <idle>-0    [002]   304.567900:  dwc3_gadget_ep_cmd name=ep0out cmd=1030  param0=0  param1=4026523648  param2=0  cmd_status=0
> > <idle>-0    [004]   304.583225:  dwc3_gadget_ep_cmd name=ep1out cmd=134152  param0=0  param1=0  param2=0  cmd_status=0
> >
> > //We don't have any logging in pullup disable, but this is when that
> > occurs, as we start to see -ESHUTDOWN statuses due to stop active
> > transfer.
> 
> argh, maybe we should add :-)
> 
> I noticed that the logs here look different. Did you modify dwc3 trace
> events or is it a special tracer (just curious)? Anyway...

These logs come from an internal tool that extracts the traces from a
complete RAM dump from a crashed device. One of the limitations is that
the script doesn't (yet) understand the event printk-formats so we're
left with just the raw field contents of the TP_STRUCT__entry. Not
pretty at all but it's *lot* better than nothing especially for
post-mortem analysis.

Yes there is crash-utility [1] which does all of this already but
logistically our internal tooling is not very well equipped (i.e. is
Windows-based) to make use of this, not without going through some
hoops. Been meaning to play around with it some more though to reduce
the need for our home-rolled solution.

[1] https://github.com/crash-utility

> > <idle>-0    [004]   304.583237:  dwc3_gadget_giveback name=ep1out req=1243650560  actual=0  length=16384  status=4294967188  zero=0 short_not_ok=0  no_interrupt=0
> > <idle>-0    [004]   304.583275:  dwc3_gadget_giveback name=ep1out req=1243645440  actual=0  length=16384  status=4294967188  zero=0 short_not_ok=0  no_interrupt=0
> > <idle>-0    [004]   304.583282:  dwc3_gadget_giveback name=ep1out req=1243648256  actual=0  length=16384  status=4294967188  zero=0 short_not_ok=0  no_interrupt=0
> > <idle>-0    [004]   304.583312:  dwc3_gadget_giveback name=ep1out req=4075146240  actual=0  length=16384  status=4294967188  zero=0 short_not_ok=0  no_interrupt=0
> > ...
> > //USB gadget disconnect is printed AFTER the pullup(0) routine is complete.
> > <idle>-0    [004]   304.584240:  usb_gadget_disconnect   speed=3 max_speed=6  state=7  mA=500  sg_supported=1  is_otg=0 is_a_peripheral=0  b_hnp_enable=0  a_hnp_support=0 hnp_polling_support=0  host_request_flag=0  quirk_ep_out_aligned_size=0 quirk_altset_not_supp=0  quirk_stall_not_supp=0  quirk_zlp_not_supp=0 is_selfpowered=0  deactivated=0  connected=1  ret=4294967186
> >
> > ---------------------------------------------------------
> > CPU2 SCHED FTRACE:
> >
> > kworker/u16:5-192    [002]   304.583354:  irq_handler_entry   irq=343 name=dwc3-msm
> > kworker/u16:5-192    [002]   304.583356:  irq_handler_exit   irq=343 ret=0
> > kworker/u16:5-192    [002]   304.583358:  irq_handler_entry   irq=343 name=dwc3
> > kworker/u16:5-192    [002]   304.583366:  irq_handler_exit   irq=343 ret=2
> > kworker/u16:5-192    [002]   304.583377:  sched_wakeup comm=irq/343-dwc3  pid=20174  prio=100  success=1  target_cpu=2
> > kworker/u16:5-192   [002]  304.583411: sched_switch: prev_comm=kworker/u16:5 prev_pid=192 prev_prio=120 prev_state=R ==> next_comm=irq/343-dwc3 next_pid=20174 next_prio=100
> > irq/343-dwc3-20174    [002]   304.583454:  irq_handler_entry   irq=343 name=dwc3-msm
> > irq/343-dwc3-20174    [002]   304.583455:  irq_handler_exit   irq=343 ret=0
> > irq/343-dwc3-20174    [002]   304.583458:  irq_handler_entry   irq=343 name=dwc3
> > irq/343-dwc3-20174    [002]   304.583465:  irq_handler_exit   irq=343 ret=2

Jack
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
