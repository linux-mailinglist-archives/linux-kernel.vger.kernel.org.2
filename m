Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E563E515D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 05:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236548AbhHJDMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 23:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbhHJDMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 23:12:47 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2082EC061796
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 20:12:26 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id e3-20020ac80b030000b029028ac1c46c2aso9317240qti.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 20:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=c7H/3mXxDgSULKRoQknWPbfYgsJ3ssxvDOUhKVgnTAI=;
        b=XQ+qrLYHOPpmrlgq1I+3Qz70fRy13Axmk/pwCk3BMmOD/KFfLQ4geIoMSGxoP0rwV3
         Sj7rikQUxQDHyX03DjLDgqJPTmTZ/Ej3z60ArlS46gVnPN2Y7VBNF924PccLaz8oYR8N
         rQ9dG1IYgKnsLc+37TpvGVBII5W2lJ1TY11WWDL6ivBTvTgyBIDAB3iFv6HWZA+luwD2
         KGTYrx0UQATyLO3DclFGfSapOF5Ce8Qf7bkBO5rWYauwldQIlvwkt+jfwQgl7Us9z2ag
         yBEm456EmWHWo14yW+47Xqmix4majyeAikQOYecIxZAbjWxGraWDwYB+iwSCA3Mww3iZ
         ibTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=c7H/3mXxDgSULKRoQknWPbfYgsJ3ssxvDOUhKVgnTAI=;
        b=e0jxqana027zm/I1/ZYezPOufoV0WdO4InhojCfPc3WB6M2ohaHRg9J8ldWu3GqlXO
         VNQkYjdcrhplFpup74CWb9w5GzBDF9Uuv4bKDq+8Is1UdHBCpRlz97YY9LwmTno4hGCC
         3rHfQUDcXg2n8H1rcOusQkoJfpTNYpLo38D/+q7UIpIpdk6gtZJJXxsZAPRaw+woW2zf
         LrBpgY4c8tvF9qB7EWS1jiYrZ1/ddy2v7c8nQYZClSmIYc2dkKRDAVeYWEuU1FVrNadR
         ZQYORVq262NRH2VGvowrSmmc1bktHbWS0nzTSMl7SAoQiEIE9rawDRBmtPmNbURVvGA5
         lOlQ==
X-Gm-Message-State: AOAM531nNmD4G/TYyKwu+4NlclHkdGSTfXubzE0FM2bkHzt11ctjoPIa
        tOfUlNiweUq8pHjp1N889Wmy+BeA3ok=
X-Google-Smtp-Source: ABdhPJyXDUO9P4XvNP4XJFNuuGIV854lHWDCj65T5UsVBZxnb6jBEgVxt7/jICXtc8luwOj5D0BfGQx2kH8=
X-Received: from raychi.tao.corp.google.com ([2401:fa00:fc:202:30c0:e8c8:f8a1:8a43])
 (user=raychi job=sendgmr) by 2002:a0c:f703:: with SMTP id w3mr5707071qvn.53.1628565145292;
 Mon, 09 Aug 2021 20:12:25 -0700 (PDT)
Date:   Tue, 10 Aug 2021 11:12:16 +0800
In-Reply-To: <1627543994-20327-1-git-send-email-wcheng@codeaurora.org>
Message-Id: <22969fbd-c16b-9443-7673-1e0ae72c873f@synopsys.com> (raw)
Mime-Version: 1.0
References: <22969fbd-c16b-9443-7673-1e0ae72c873f@synopsys.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: Re: [PATCH] usb: dwc3: gadget: Use list_replace_init() before
 traversing lists
From:   Ray Chi <raychi@google.com>
To:     thinh.nguyen@synopsys.com, Wesley Cheng <wcheng@codeaurora.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>
Cc:     jackp@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, albertccwang@google.com,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

> + John Stultz
>
> Wesley Cheng wrote:
> > The list_for_each_entry_safe() macro saves the current item (n) and
> > the item after (n+1), so that n can be safely removed without
> > corrupting the list.  However, when traversing the list and removing
> > items using gadget giveback, the DWC3 lock is briefly released,
> > allowing other routines to execute.  There is a situation where, while
> > items are being removed from the cancelled_list using
> > dwc3_gadget_ep_cleanup_cancelled_requests(), the pullup disable
> > routine is running in parallel (due to UDC unbind).  As the cleanup
> > routine removes n, and the pullup disable removes n+1, once the
> > cleanup retakes the DWC3 lock, it references a request who was already
> > removed/handled.  With list debug enabled, this leads to a panic.
> > Ensure all instances of the macro are replaced where gadget giveback
> > is used.
> > 
> > Example call stack:
> > 
> > Thread#1:
> > __dwc3_gadget_ep_set_halt() - CLEAR HALT
> >   -> dwc3_gadget_ep_cleanup_cancelled_requests()
> >     ->list_for_each_entry_safe()
> >     ->dwc3_gadget_giveback(n)
> >       ->dwc3_gadget_del_and_unmap_request()- n deleted[cancelled_list]
> >       ->spin_unlock
> >       ->Thread#2 executes
> >       ...
> >     ->dwc3_gadget_giveback(n+1)
> >       ->Already removed!
> > 
> > Thread#2:
> > dwc3_gadget_pullup()
> >   ->waiting for dwc3 spin_lock
> >   ...
> >   ->Thread#1 released lock
> >   ->dwc3_stop_active_transfers()
> >     ->dwc3_remove_requests()
> >       ->fetches n+1 item from cancelled_list (n removed by Thread#1)
> >       ->dwc3_gadget_giveback()
> >         ->dwc3_gadget_del_and_unmap_request()- n+1
> > deleted[cancelled_list]
> >         ->spin_unlock
> > 
> > Fix this condition by utilizing list_replace_init(), and traversing
> > through a local copy of the current elements in the endpoint lists.
> > This will also set the parent list as empty, so if another thread is
> > also looping through the list, it will be empty on the next iteration.
> > 
> > Fixes: d4f1afe5e896 ("usb: dwc3: gadget: move requests to cancelled_list")
> > Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
> > 
> > ---
> > Previous patchset:
> > https://urldefense.com/v3/__https://lore.kernel.org/linux-usb/1620716636-12422-1-git-send-email-wcheng@codeaurora.org/__;!!A4F2R9G_pg!Ngid3pREhM1FWiRmEnCGrN6FhBvSxDTkPbZ4RzAEO5Ubs0aGSxtikFT1APzTWhgw42As$ 
> > ---
> >  drivers/usb/dwc3/gadget.c | 18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> > index a29a4ca..3ce6ed9 100644
> > --- a/drivers/usb/dwc3/gadget.c
> > +++ b/drivers/usb/dwc3/gadget.c
> > @@ -1926,9 +1926,13 @@ static void dwc3_gadget_ep_cleanup_cancelled_requests(struct dwc3_ep *dep)
> >  {
> >  	struct dwc3_request		*req;
> >  	struct dwc3_request		*tmp;
> > +	struct list_head		local;
> >  	struct dwc3			*dwc = dep->dwc;
> >  
> > -	list_for_each_entry_safe(req, tmp, &dep->cancelled_list, list) {
> > +restart:
> > +	list_replace_init(&dep->cancelled_list, &local);
> > +
> > +	list_for_each_entry_safe(req, tmp, &local, list) {
> >  		dwc3_gadget_ep_skip_trbs(dep, req);
> >  		switch (req->status) {
> >  		case DWC3_REQUEST_STATUS_DISCONNECTED:
> > @@ -1946,6 +1950,9 @@ static void dwc3_gadget_ep_cleanup_cancelled_requests(struct dwc3_ep *dep)
> >  			break;
> >  		}
> >  	}
> > +
> > +	if (!list_empty(&dep->cancelled_list))
> > +		goto restart;
> >  }
> >  
> >  static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
> > @@ -3190,8 +3197,12 @@ static void dwc3_gadget_ep_cleanup_completed_requests(struct dwc3_ep *dep,
> >  {
> >  	struct dwc3_request	*req;
> >  	struct dwc3_request	*tmp;
> > +	struct list_head	local;
> >  
> > -	list_for_each_entry_safe(req, tmp, &dep->started_list, list) {
> > +restart:
> > +	list_replace_init(&dep->started_list, &local);
> > +
> > +	list_for_each_entry_safe(req, tmp, &local, list) {
> >  		int ret;
> >  
> >  		ret = dwc3_gadget_ep_cleanup_completed_request(dep, event,
> > @@ -3199,6 +3210,9 @@ static void dwc3_gadget_ep_cleanup_completed_requests(struct dwc3_ep *dep,
> >  		if (ret)
> >  			break;

I also met the connection issue. The problem is related that dwc3 requests
in local list are ignored due to loop break.

> >  	}
> > +
> > +	if (!list_empty(&dep->started_list))
> > +		goto restart;
>
> This is not right. We don't cleanup the entire started list here.
> Sometime we end early because some TRBs are completed but not all.

Yes, I also think it can be replaced with checking local list and
restoring unhandled requests directly.

> BR,
> Thinh
>

Best regards,
Ray
