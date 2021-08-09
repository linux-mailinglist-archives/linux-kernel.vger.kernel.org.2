Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9835C3E4E76
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 23:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236415AbhHIV12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 17:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235661AbhHIV12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 17:27:28 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A3CC0613D3;
        Mon,  9 Aug 2021 14:27:07 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id f11so29332374ioj.3;
        Mon, 09 Aug 2021 14:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bSVTGD0E1Co6L1LpjT4iW2VzE8/m5TIYK/SbNEx/88I=;
        b=hezSmvao6xgZ7pFyqkWA3CozDN7J4A7J56ZakXThQxlsI7y0q6TkrGo7p5+oKfrltg
         ZsYVMqPuUtcqiHrsp0E0pxYtd13CLZxwx7nBkx3QhokofSPWjxYXOPS+7cBUUMmGz1sm
         U8u9jkQuatzvCycUN9KIG4lxlH6vh48Mpl9HT4tMmv2K+Sfec+OJHkEprOIf24vRx877
         M3qWhi/pZc6qX0nwOiWqZO6DUHk/fhJ4wYTK23QiwGicG7c9bfvdfuCE+Iwzp2LsLq0J
         wcI8r71iJX+4iGOju4wvexxaffpPCXelSwsKYt2X3UtTvLBDh5+svHvxfvuT4xEkbgDT
         yVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bSVTGD0E1Co6L1LpjT4iW2VzE8/m5TIYK/SbNEx/88I=;
        b=rqJneG0VboLlXgCS4wYVGeFgPE/F/lcXWjXjVHIgZGVWdcfX4H/81v/ILrXX0TX0c1
         +SIl5hylihXxPdS3brfoB8hYjaaS7SpcX4mwMP2WwmeEvAEbyHRwxJgX0s169vVefyVc
         NP/bNWj3N/s9pcAMiIyhk2PkLr9Kl81Miqnc0GugH5Ybxfv5pX2w88pdCPhIwczc0lts
         gZUltP/tNws+mS3QrgLU37Jsp3RLs1BZDX+BFt9xjjCeeSMCWis379D8auyFwQfuLae0
         uD0rAg/zy7tQcMwGvH2g55fXrd5ZEya4kTv/XDqUcrb5aAfHu/yutvBRJk5C80KBBJkB
         t07g==
X-Gm-Message-State: AOAM531jOa5geUbKyZnbVSqMpx73Ugu/0IyvP9mKZjpSpD9FpYgJvvxl
        7OmhCwe/B6V+8S60nuLCchZsfb4zzB5q/zPPPWQ=
X-Google-Smtp-Source: ABdhPJwvzwkvGJ4iB8/yRiztHd5W8q/0TVae/w5CY/tDZ6cJ1Zgbyg1iAKUYQOISlSJKATmFCdrfD0SJBmC6RpSlDmI=
X-Received: by 2002:a6b:ea19:: with SMTP id m25mr24107ioc.182.1628544426511;
 Mon, 09 Aug 2021 14:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <1627543994-20327-1-git-send-email-wcheng@codeaurora.org>
In-Reply-To: <1627543994-20327-1-git-send-email-wcheng@codeaurora.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 9 Aug 2021 14:26:55 -0700
Message-ID: <CANcMJZCAVBnOv5bR_n4edZphrZQL76HtQBNXn_AvDSouk68Yww@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: gadget: Use list_replace_init() before
 traversing lists
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     balbi@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jackp@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 12:34 AM Wesley Cheng <wcheng@codeaurora.org> wrote:
>
> The list_for_each_entry_safe() macro saves the current item (n) and
> the item after (n+1), so that n can be safely removed without
> corrupting the list.  However, when traversing the list and removing
> items using gadget giveback, the DWC3 lock is briefly released,
> allowing other routines to execute.  There is a situation where, while
> items are being removed from the cancelled_list using
> dwc3_gadget_ep_cleanup_cancelled_requests(), the pullup disable
> routine is running in parallel (due to UDC unbind).  As the cleanup
> routine removes n, and the pullup disable removes n+1, once the
> cleanup retakes the DWC3 lock, it references a request who was already
> removed/handled.  With list debug enabled, this leads to a panic.
> Ensure all instances of the macro are replaced where gadget giveback
> is used.
>
> Example call stack:
>
> Thread#1:
> __dwc3_gadget_ep_set_halt() - CLEAR HALT
>   -> dwc3_gadget_ep_cleanup_cancelled_requests()
>     ->list_for_each_entry_safe()
>     ->dwc3_gadget_giveback(n)
>       ->dwc3_gadget_del_and_unmap_request()- n deleted[cancelled_list]
>       ->spin_unlock
>       ->Thread#2 executes
>       ...
>     ->dwc3_gadget_giveback(n+1)
>       ->Already removed!
>
> Thread#2:
> dwc3_gadget_pullup()
>   ->waiting for dwc3 spin_lock
>   ...
>   ->Thread#1 released lock
>   ->dwc3_stop_active_transfers()
>     ->dwc3_remove_requests()
>       ->fetches n+1 item from cancelled_list (n removed by Thread#1)
>       ->dwc3_gadget_giveback()
>         ->dwc3_gadget_del_and_unmap_request()- n+1
> deleted[cancelled_list]
>         ->spin_unlock
>
> Fix this condition by utilizing list_replace_init(), and traversing
> through a local copy of the current elements in the endpoint lists.
> This will also set the parent list as empty, so if another thread is
> also looping through the list, it will be empty on the next iteration.
>
> Fixes: d4f1afe5e896 ("usb: dwc3: gadget: move requests to cancelled_list")
> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
>
> ---
> Previous patchset:
> https://lore.kernel.org/linux-usb/1620716636-12422-1-git-send-email-wcheng@codeaurora.org/
> ---
>  drivers/usb/dwc3/gadget.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index a29a4ca..3ce6ed9 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -1926,9 +1926,13 @@ static void dwc3_gadget_ep_cleanup_cancelled_requests(struct dwc3_ep *dep)
>  {
>         struct dwc3_request             *req;
>         struct dwc3_request             *tmp;
> +       struct list_head                local;
>         struct dwc3                     *dwc = dep->dwc;
>
> -       list_for_each_entry_safe(req, tmp, &dep->cancelled_list, list) {
> +restart:
> +       list_replace_init(&dep->cancelled_list, &local);
> +
> +       list_for_each_entry_safe(req, tmp, &local, list) {
>                 dwc3_gadget_ep_skip_trbs(dep, req);
>                 switch (req->status) {
>                 case DWC3_REQUEST_STATUS_DISCONNECTED:
> @@ -1946,6 +1950,9 @@ static void dwc3_gadget_ep_cleanup_cancelled_requests(struct dwc3_ep *dep)
>                         break;
>                 }
>         }
> +
> +       if (!list_empty(&dep->cancelled_list))
> +               goto restart;
>  }

So, I'm not sure yet, but the "break" cases in the
list_for_each_entry_safe seem suspicious to me.

It seems we've move the list to the local listhead, then as we process
the local listhead, we may hit the "break" case, which will stop
processing the list, and then we end up returning, losing the
unprocessed items on the local listhead.

I suspect we need to move them back to the started/cancelled_list, or
rework things so we don't hit the "break" cases and fully process the
local list before returning.

thanks
-john
