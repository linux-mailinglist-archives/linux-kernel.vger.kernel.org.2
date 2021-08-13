Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B613EB15C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 09:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239384AbhHMHZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 03:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239363AbhHMHZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 03:25:49 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81730C0617AE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 00:25:23 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so19427832pjn.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 00:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f67Cc/0HAQ3ot5nygT81kjkHc1cXy+FLW6ZJm2gJlPw=;
        b=GMStW9dn9UpUUOe7rsrdfZDHhrwoEebi5lPXiiNoenRXxinSxO2F60Hze9FT4mGdoF
         drK6ijRnmIsbqm2mxgKfHAcXQ5Pg6gpbur8y6RBSzurfxo+J60LKH+v6Y+ilGiN5ihFe
         lJFr71K3bfQMBnGBQBll2mRMMoqCxV00HHfOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f67Cc/0HAQ3ot5nygT81kjkHc1cXy+FLW6ZJm2gJlPw=;
        b=IceU2OIGJdZYFaE4GAF1lvHzNSIGwnLl5uhu+4NXZXu7jM7oPdjL9lyBaLmrf6PHcZ
         34NHwF9CyTh06MtnuoB2aLe7raksNqWjgi5m7CZGBzUUbenE6Owd89gw9RSLSl1tD56B
         Fpc71KZYE5ZM/hrb703HTaFBtGYIaJh3mxx8S1D5/4Ia2BURBWm96Xe+X5W2M3dSf59D
         QpoGOxFyOw73h5ZR1yWFQOUPnfveWgIOwW4pVd5Avi4S/mdoeeiMjqUogdD9TaIlffuk
         qLzdZkmd8J8NDLbDBseFFoX7Q7Fa+aEAmBdeLuox0e75TA73rNlgjDhUw6giGNkPiLgo
         ICtA==
X-Gm-Message-State: AOAM530/nTp0ZdcwbK3ORsYZXOA+KGwExkdecAJM0wsqtjLhTWHLzkkr
        WF8Ca2FPwDkxJjy6NvqwSFLHAuh6WJeHHTZieqRvgw==
X-Google-Smtp-Source: ABdhPJw1XrFSqEXdJkJQQ83TbBHn6iaHIjxt522gcRMX0/uF4UyWgvwk7Bt5U8GXO1x6NcldvVMPVddPsZua+2NpD3Y=
X-Received: by 2002:a17:90b:102:: with SMTP id p2mr1348410pjz.126.1628839522940;
 Fri, 13 Aug 2021 00:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <1628822604-29239-1-git-send-email-wat@codeaurora.org>
In-Reply-To: <1628822604-29239-1-git-send-email-wat@codeaurora.org>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Fri, 13 Aug 2021 15:25:12 +0800
Message-ID: <CAATdQgDWPqoSyPxQpvdhupjWVKHDy6SqBy2kgitNLjaioPRviQ@mail.gmail.com>
Subject: Re: [PATCH] usb: xhci-ring: set all cancelled_td's cancel_status to TD_CLEARING_CACHE
To:     Tao Wang <wat@codeaurora.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 13, 2021 at 10:44 AM Tao Wang <wat@codeaurora.org> wrote:
>
> USB SSD may fail to unmount if disconnect during data transferring.
>
> it stuck in usb_kill_urb() due to urb use_count will not become zero,
> this means urb giveback is not happen.
> in xhci_handle_cmd_set_deq() will giveback urb if td's cancel_status
> equal to TD_CLEARING_CACHE,
> but in xhci_invalidate_cancelled_tds(), only last canceled td's
> cancel_status change to TD_CLEARING_CACHE,
> thus giveback only happen to last urb.
>
> this change set all cancelled_td's cancel_status to TD_CLEARING_CACHE
> rather than the last one, so all urb can giveback.
>
> Signed-off-by: Tao Wang <wat@codeaurora.org>
> ---
>  drivers/usb/host/xhci-ring.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index 8fea44b..c7dd7c0 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -960,19 +960,19 @@ static int xhci_invalidate_cancelled_tds(struct xhci_virt_ep *ep)
>                         td_to_noop(xhci, ring, td, false);
>                         td->cancel_status = TD_CLEARED;
>                 }
> -       }
> -       if (cached_td) {
> -               cached_td->cancel_status = TD_CLEARING_CACHE;
> -
> -               err = xhci_move_dequeue_past_td(xhci, slot_id, ep->ep_index,
> -                                               cached_td->urb->stream_id,
> -                                               cached_td);
> -               /* Failed to move past cached td, try just setting it noop */
> -               if (err) {
> -                       td_to_noop(xhci, ring, cached_td, false);
> -                       cached_td->cancel_status = TD_CLEARED;
> +               if (cached_td) {
> +                       cached_td->cancel_status = TD_CLEARING_CACHE;
> +
> +                       err = xhci_move_dequeue_past_td(xhci, slot_id, ep->ep_index,
> +                                                       cached_td->urb->stream_id,
> +                                                       cached_td);
> +                       /* Failed to move past cached td, try just setting it noop */
> +                       if (err) {
> +                               td_to_noop(xhci, ring, cached_td, false);
> +                               cached_td->cancel_status = TD_CLEARED;
> +                       }
> +                       cached_td = NULL;
>                 }
> -               cached_td = NULL;

I think we can call xhci_move_dequeue_past_td() just once to
the last halted && cancelled TD in a ring.

But that might need to compare two TDs to see which one is
the latter, I'm not sure how to do this well. :-/

if (!cached_td || cached_td < td)
  cached_td = td;

>         }
>         return 0;
>  }
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
