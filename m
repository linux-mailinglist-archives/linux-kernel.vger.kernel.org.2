Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07213EFE8C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 10:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239449AbhHRIE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 04:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239262AbhHRIDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 04:03:16 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631D6C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 01:02:41 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id h29so1344798ila.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 01:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dUiC54xyp77ZqTLVrL1seoO6HZNPy9RfQND7sKSb1ZY=;
        b=NW3h32unzYNVpVfPFQ+MXD1ecjWX22E9d3sgk8jEgssFC+EUGte9LzopMdZt0fiF9L
         4XoGgVP/vaAdY1nzhBySbw7I1NdchUL5QfbRBVbXxGoQxOyXHQM+YrbgY6awT/JWI+/G
         3YniK2VoUDa7LmFhNW62FGd70ZADoJlt2vXGtWQ+ug70HNLF4T8gRF+HP81++IqbC4Bh
         R6U0PLFUH5b1FxLir1EgMO85spZNUz93V/OY4HOvoWPx+Uh4IVKzy341ohqP7bD4FAmb
         XHj4vXeZOG4fqHBb/ar7l+r88QIECw2BiIiS5j7bNNJJUc0OJ35BdQQKwo4adBXSG0E1
         GBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dUiC54xyp77ZqTLVrL1seoO6HZNPy9RfQND7sKSb1ZY=;
        b=bTOsH348GHQuDlSgojUyzdEWX2aXHFQqMLCIhOX7FmrleJ2tu9rqVPUHTh4FJFieK/
         N06vr2urPKW0sulUwkOcGt2mkP9jgBoKA+Kds0bOPM1u4Jtxy6d1OM8m3NxVtUQ0M/xm
         AgXTpL/LsK4hbnP5cJuqbs14j1Wbxuhc8L4RYcAmK518Imb2QBWn1/yUweM//mHcwW0t
         Ahgev0mj0gx9lagCe6cmJcXsXCnhet5tYVhqEb7dNfH8blSnRt5Z2lrGoW7feRTYzypL
         jotWiZEzI88ApwCypK7Rg5EjgQ8PUdXG/rMogmTBNGX4PHLoPEZrazeHg/L8CeNIUWt0
         7vCA==
X-Gm-Message-State: AOAM531smG5WOFXjJLYpBvke227J5EdiDtjhQPdHlS4EhOEQu+leY9gA
        xcpFD9EcztsM/Wj90mLlvgXTvG9J4hhE02UkEVjL/FptK3v6wQ==
X-Google-Smtp-Source: ABdhPJxYm2rzoSVaXH9oUjj6P7/25mAdgOc8oLPmxW+rh/RGl6k+2MutdZNxsIKVgc0tSBxNcYYETFXuNfigPMarL3U=
X-Received: by 2002:a92:9409:: with SMTP id c9mr5192801ili.135.1629273760464;
 Wed, 18 Aug 2021 01:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210813043131.833006-1-icenowy@aosc.io> <YRuDG78N2mB5w37p@kuha.fi.intel.com>
 <58034df4-f18c-ab3e-1fcc-dc85fc35320f@roeck-us.net>
In-Reply-To: <58034df4-f18c-ab3e-1fcc-dc85fc35320f@roeck-us.net>
From:   Kyle Tso <kyletso@google.com>
Date:   Wed, 18 Aug 2021 16:02:24 +0800
Message-ID: <CAGZ6i=1s9X58tOwoiGAxMkMVBTyGTjysOSe9bP8Q4WosmCtymw@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: tcpm: always rediscover when swapping DR
To:     Guenter Roeck <linux@roeck-us.net>, Icenowy Zheng <icenowy@aosc.io>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 11:13 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 8/17/21 2:36 AM, Heikki Krogerus wrote:
> > On Fri, Aug 13, 2021 at 12:31:31PM +0800, Icenowy Zheng wrote:
> >> Currently, TCPM code omits discover when swapping to gadget, and assume
> >> that no altmodes are available when swapping from gadget. However, we do
> >> send discover when we get attached as gadget -- this leads to modes to be
> >> discovered twice when attached as gadget and then swap to host.
> >>
> >> Always re-send discover when swapping DR, regardless of what change is
> >> being made; and because of this, the assumption that no altmodes are
> >> registered with gadget role is broken, and altmodes de-registeration is
> >> always needed now.
> >>
> >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >> ---
> >>   drivers/usb/typec/tcpm/tcpm.c | 9 ++++-----
> >>   1 file changed, 4 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> >> index b9bb63d749ec..ab6d0d51ee1c 100644
> >> --- a/drivers/usb/typec/tcpm/tcpm.c
> >> +++ b/drivers/usb/typec/tcpm/tcpm.c
> >> @@ -4495,15 +4495,14 @@ static void run_state_machine(struct tcpm_port *port)
> >>              tcpm_set_state(port, ready_state(port), 0);
> >>              break;
> >>      case DR_SWAP_CHANGE_DR:
> >> -            if (port->data_role == TYPEC_HOST) {
> >> -                    tcpm_unregister_altmodes(port);
> >> +            tcpm_unregister_altmodes(port);
> >> +            if (port->data_role == TYPEC_HOST)
> >>                      tcpm_set_roles(port, true, port->pwr_role,
> >>                                     TYPEC_DEVICE);
> >> -            } else {
> >> +            else
> >>                      tcpm_set_roles(port, true, port->pwr_role,
> >>                                     TYPEC_HOST);
> >> -                    port->send_discover = true;
> >> -            }
> >> +            port->send_discover = true;
> >>              tcpm_ams_finish(port);
> >>              tcpm_set_state(port, ready_state(port), 0);
> >>              break;
> >
> > Why is it necessary to do discovery with data role swap in general?
> >
> > thanks,
> >
>
> Additional question: There are two patches pending related to DR_SWAP
> and discovery. Are they both needed, or do they both solve the same
> problem ?
>
> Thanks,
> Guenter

Hi, I just noticed this patch.

Part of this patch and part of my patch
https://lore.kernel.org/r/20210816075449.2236547-1-kyletso@google.com
are to solve the same problem that Discover_Identity is not sent in a
case where the port becomes UFP after DR_SWAP while in PD3.

The difference (for the DR_SWAP part) is that my patch does not set
the flag "send_discover" if the port becomes UFP after PD2 DR_SWAP.
That is because in PD2 Spec, UFP is not allowed to be the SVDM
Initiator.

This patch indeed solves another problem where
tcpm_unregister_altmodes should be called during PD3 DR_SWAP because
the port partner may return mode data in the latest Discover_Mode. For
the PD2 case, I don't think it needs to be called because PD2 DFP will
always return NAK for Discover_Mode. However it is fine because it is
safe to call tcpm_unregister_altmodes even if there is no mode data.

In fact, when I was tracing the code I found another bug. PD2 UFP is
not allowed to send Discover_Identity and Discover_Mode. I can send
another patch to address this problem.

thanks,
Kyle
