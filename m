Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427743E4E3C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 23:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbhHIVEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 17:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbhHIVEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 17:04:45 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2D6C0613D3;
        Mon,  9 Aug 2021 14:04:24 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id f8so12996577ilr.4;
        Mon, 09 Aug 2021 14:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OphbEaCkTCP++YvIIxjHhNa/W+Fs8RM+j2tETgiMwd8=;
        b=qUZFjIiRgOxCltQUJjn3kci9TdnbD4WxOv5bsRdi1z4OCZzMIlkkNt3kPXdOs1NQ9u
         ErJMqOL+zHofJQXGnDlPEbvtvly6MQ2bNpP/FF+49us7hZYEK/PXtHQvD31HgSFkUqHy
         DfQ3QYXqqMggu/HUBlzMZWtMQCHnwQOwplL7e7DtWZvBl7gVxDCKQGGK6+9vAIZ9rhWw
         JF4WdBwv3Fwpvyzi+eVH96j+mokyAiTQuFt78ICCvuMCZBlqa+wMwtW841BSF9TRrqu/
         YSLQzMTTJ8AQ8I5bGDgocGlBGR92SerAErnSNO93M+fzaRzWMjvmYMNBan5k4oZq4gKM
         Oz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OphbEaCkTCP++YvIIxjHhNa/W+Fs8RM+j2tETgiMwd8=;
        b=G/krHwvE3rAk5tH9Do+6vpXJuH9/xOXkrHxMPfobn00H2CCuIDn0eWxxSwd/WZrbvx
         zJ1qdH0zxpK0sSrSmxGBc5LXfCmsPokt2VbiF98fsjrDD7X+gx1XBz8UrjzvfiCYlMVZ
         fqjRNDxSVg9Q9y5Gum35tdf/vEbNn5uKv56hcrpB15K/F55w/NkxYWRAQa12NXrrtkfo
         jTY6lRQvVA7X2e6ZVW1UlNZn3j+LSCuKPnYp0tVVb9JyS7N0z5nWAluCEdfOYrkKLROB
         q1j4pUVnZuO5QyOsiC6+who39hCt7Es1HklEnSn2YJlmLgiGzLpzsqaJjcaS6HjgZpNQ
         fgQw==
X-Gm-Message-State: AOAM533pRp0UqmKaP4m+zNCmhgzwWBDrwoyOTtFkn3Hyk4s93YHktXMp
        q3YQjXKYfOIuARah/BzlkVTCM5H8AP6tZ1bnZVU=
X-Google-Smtp-Source: ABdhPJyPjRi0TpbIvWrtOAjJBhKdTvpWOShQZhnEudrRZq+XBMLCtiZtSpEzucksDsj9DxVpYIlAYLR6KJRxuTObg0I=
X-Received: by 2002:a92:1942:: with SMTP id e2mr201900ilm.4.1628543063659;
 Mon, 09 Aug 2021 14:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <1627543994-20327-1-git-send-email-wcheng@codeaurora.org>
In-Reply-To: <1627543994-20327-1-git-send-email-wcheng@codeaurora.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 9 Aug 2021 14:04:13 -0700
Message-ID: <CANcMJZCEVxVLyFgLwK98hqBEdc0_n4P0x_K6Gih8zNH3ouzbJQ@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: gadget: Use list_replace_init() before
 traversing lists
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     balbi@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jackp@codeaurora.org, Amit Pundir <amit.pundir@linaro.org>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Todd Kjos <tkjos@google.com>
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

Hey Wesley,
  Just as a heads up, since this patch just landed upstream, I've
bisected it down as causing a regression on the db845c/RB3 board.

After booting with mainline, I'm seeing attempts to connect via adb fail with:
  error: device offline

Running "adb devices" provides:
  List of devices attached
  c4e1189c        offline

After reverting this patch, I can properly connect via adb again, and
"adb devices" shows the expected output:
  List of devices attached
  c4e1189c        device


I've not been able to isolate what might be going on, as there's no
obvious errors in dmesg. Any suggestions to further debug this?

thanks
-john
