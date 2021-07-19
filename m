Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929C93CCD21
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 06:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhGSEjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 00:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhGSEjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 00:39:51 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A835C061765
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 21:36:52 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id v14so8928866plg.9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 21:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yYsZ+ikgce2hMzO++2AKM6wMqwMOnQFfBVChCh2032U=;
        b=DodU3mHKvLOBpExF7PmlfcpdF899zpLvyq1NBc3PDsH+WmLWbrrUVlQLfDQOZlnryI
         kBewVYDmDaiEGMJwtEraprQHnwuGObK7kOLPIz1cjRs4SJUEPJKcQ0Qa2invsB+sGB7r
         PnBSQhWNObuOmhDc4VFYNmcYbth/avXqQDooE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yYsZ+ikgce2hMzO++2AKM6wMqwMOnQFfBVChCh2032U=;
        b=rJDzM1m7y3jPcagXbI8eYLO8UwbTWIPj7UVietdgI+y/59br6Fo/ja2JKspgIs8QqD
         ePNZhJXXw1F3wWwcNTW3YHiZfJepTcEbqF3KeYI+zvLREfKBGbjRJHny35p/XB95Pf5G
         T7cRfkDRa8OEyuK8neSQ8B8fNx2JfBVGaM78Tn+5pg+fDOnkxjHEcBBCmqQDgL17MIpV
         xuFWcEaLg0xIjONZKM/ZDpWGHqrgKgQBWuleu6K4SilYCGl2diY1ciixZaIrPqLonGUw
         iBMBCS38hwrK7BQuHsu7Yzvom5YD8/5U5pOfZVbdlYenUzbPF6wajmxDO11E5uuGzNTA
         v14w==
X-Gm-Message-State: AOAM5305Uo9gzOXZBSu5cWzk1h75ELB1PIeiBeYfwhHAyfUIr7R7Vqh0
        BeHe4KnYVUf39bM5ngJo8C0XEUNW3g6rG7YL+5WiUg==
X-Google-Smtp-Source: ABdhPJwV7nrvm/yXIQakkxsQ8Bv8R9xP9VVdYwLwek+kQO+5++gcNiNUT+rgMISjBwsedhdcDcBUM8SPQz8/maUKTKA=
X-Received: by 2002:a17:902:8c83:b029:129:17e5:a1cc with SMTP id
 t3-20020a1709028c83b029012917e5a1ccmr17970476plo.49.1626669411408; Sun, 18
 Jul 2021 21:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210708164256.1.Ib344a977b52486ec81b60f9820338f1b43655f8d@changeid>
 <e13a1d38-cc0a-51b4-fe19-7a9145e75b1d@linux.intel.com>
In-Reply-To: <e13a1d38-cc0a-51b4-fe19-7a9145e75b1d@linux.intel.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Mon, 19 Jul 2021 12:36:40 +0800
Message-ID: <CAATdQgDEwOZaBeXrsocF-b5-wfXgNGNhfaEBPsmhf7nefo55KQ@mail.gmail.com>
Subject: Re: [PATCH] xhci: fix unmatched num_trbs_free
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathias,

On Fri, Jul 16, 2021 at 8:54 PM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
> On 8.7.2021 11.43, Ikjoon Jang wrote:
> > When unlinked urbs are queued to the cancelled td list, many tds
> > might be located after hw dequeue pointer and just marked as no-op
> > but not reclaimed to num_trbs_free. This bias can leads to unnecessary
> > ring expansions and leaks in atomic pool.
>
> Good point, in that case trbs turned no-op never get added to free trb count.
>
> >
> > To prevent this bias, this patch counts free TRBs every time xhci moves
> > dequeue pointer. This patch utilizes existing
> > update_ring_for_set_deq_completion() function, renamed it to move_deq().
> >
> > When it walks through to the new dequeue pointer, it also counts
> > free TRBs manually. This patch adds a fast path for the most cases
> > where the new dequeue pointer is still in the current segment.
> >
>
> This looks like an option.
>
> Another approach would be to keep the normal case fast, and the special case code simple.
> Something like:
>
> finish_td()
> ...
>         /* Update ring dequeue pointer */
>         if (ep_ring->dequeue == td->first_trb) {
>                 ep_ring->dequeue = td->last_trb;
>                 ep_ring->deq_seg = td->last_trb_seg;
>                 ep_ring->num_trbs_free += td->num_trbs - 1;
>                 inc_deq(xhci, ep_ring);
>         } else {
>                 move_deq(...);
>         }
>
> move_deq(...)
> {
>         while(ring->dequeue != new_dequeue)
>                 inc_deq(ring);
>         inc_deq(ring);
> }

Yes, I think most cases would be in (ep_ring->dequeue == td->first_trb)
so I think just repeating inc_deq() will be okay like the above example
cancelling urbs is an expensive and unusual operation.

But as you can see, I changed update_ring_for_set_deq_completion() to
move_deq(),
Do you think it's okay for that substitution In xhci_handle_cmd_set_deq()?
I'm worrying about some weird situation where the new dequeue ptr is
not in the ring.

>
> inc_deq() increases the num_trbs_free count.
>
> I haven't looked at the details of this yet, but I'm away for the next two weeks so
> I wanted to share this first anyway.
>

Thanks for reviewing, I hope to get some feedback when you come back.

> -Mathias

On Fri, Jul 16, 2021 at 8:54 PM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
> On 8.7.2021 11.43, Ikjoon Jang wrote:
> > When unlinked urbs are queued to the cancelled td list, many tds
> > might be located after hw dequeue pointer and just marked as no-op
> > but not reclaimed to num_trbs_free. This bias can leads to unnecessary
> > ring expansions and leaks in atomic pool.
>
> Good point, in that case trbs turned no-op never get added to free trb count.
>
> >
> > To prevent this bias, this patch counts free TRBs every time xhci moves
> > dequeue pointer. This patch utilizes existing
> > update_ring_for_set_deq_completion() function, renamed it to move_deq().
> >
> > When it walks through to the new dequeue pointer, it also counts
> > free TRBs manually. This patch adds a fast path for the most cases
> > where the new dequeue pointer is still in the current segment.
> >
>
> This looks like an option.
>
> Another approach would be to keep the normal case fast, and the special case code simple.
> Something like:
>
> finish_td()
> ...
>         /* Update ring dequeue pointer */
>         if (ep_ring->dequeue == td->first_trb) {
>                 ep_ring->dequeue = td->last_trb;
>                 ep_ring->deq_seg = td->last_trb_seg;
>                 ep_ring->num_trbs_free += td->num_trbs - 1;
>                 inc_deq(xhci, ep_ring);
>         } else {
>                 move_deq(...);
>         }
>
> move_deq(...)
> {
>         while(ring->dequeue != new_dequeue)
>                 inc_deq(ring);
>         inc_deq(ring);
> }
>
> inc_deq() increases the num_trbs_free count.
>
> I haven't looked at the details of this yet, but I'm away for the next two weeks so
> I wanted to share this first anyway.
>
> -Mathias
