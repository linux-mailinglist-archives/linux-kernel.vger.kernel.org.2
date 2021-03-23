Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116A43454FC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 02:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhCWB1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 21:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbhCWB1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 21:27:09 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4E5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 18:27:08 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id q26so7561793qkm.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 18:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JYxYqwBBeANyqWyQGmvwdqYnwLRNZNV58JDTVavfLTc=;
        b=a6JdwhHNlMdGaVeyHRZVJp6OtC/hlOt2kSI6OhN2ddlOaHVxVeZeQ8HV+E3FTvmvQI
         pH1SrynTesuBahTBNhFHiYEUSrRpIW+SEGg/Om+b8Jo2ibJxfOS4B1Nd+F1pWFpuNAjM
         1XKffvMC9iWDlAG/WJRZCqZ15ztaMjjuJsuMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JYxYqwBBeANyqWyQGmvwdqYnwLRNZNV58JDTVavfLTc=;
        b=EfqqnvWO0dBYoZrUZB1xzIEGiY775McO6clh0DonKgd8jSzMwBHbALJl9PUnqUxhui
         FlpmeEbfSgK41DgD5Bv2ddesyS/Qh4/ULdNagHkT54b0Uwc7Ko0UJPOydpgnLQajdban
         6c7K+zo5U/Ogk0X81jwgB+GE9hOtnL31YcNpmkgaYybcIYTDMqiUq7Js1F/i1AOQRd23
         TDH/crI8gIgWKSN3veXTadQudOaVXeHQeQqpKq/uhkBs/B9bWdLgMQ+cDB04qu/0GV42
         wqhmiULSjk7YqJeO00v+pHjom1R1jID5zUcotyUx0eerArfZ9LgrboJIYePo37r4Grcz
         Dzbg==
X-Gm-Message-State: AOAM530fmnM5WMndQK/RGk3qCPPzjfbXoZCI39REO9pkD2inIUREzZqh
        42pcHnsUNzNk7buh6qVImvYcdCeNS+HbwQ==
X-Google-Smtp-Source: ABdhPJwh+P0iyg1kHJCigcgE/wguIazGGzk46ACl1MMgwlRR7F6zmG+P2FdGrpKl3ps9WogmDqHDUg==
X-Received: by 2002:a37:5687:: with SMTP id k129mr3154988qkb.488.1616462827644;
        Mon, 22 Mar 2021 18:27:07 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id l9sm10076124qtv.65.2021.03.22.18.27.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 18:27:07 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id z1so8643405ybf.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 18:27:07 -0700 (PDT)
X-Received: by 2002:a9d:1b70:: with SMTP id l103mr2239864otl.203.1616462470404;
 Mon, 22 Mar 2021 18:21:10 -0700 (PDT)
MIME-Version: 1.0
References: <1595351666-28193-1-git-send-email-pillair@codeaurora.org>
 <1595351666-28193-3-git-send-email-pillair@codeaurora.org>
 <13573549c277b34d4c87c471ff1a7060@codeaurora.org> <d79ae05e-e75a-de2f-f2e3-bc73637e1501@nbd.name>
 <04d7301d5ad7555a0377c7df530ad8522fc00f77.camel@sipsolutions.net>
 <1f2726ff-8ba9-5278-0ec6-b80be475ea98@nbd.name> <06a4f84b-a0d4-3f90-40bb-f02f365460ec@candelatech.com>
In-Reply-To: <06a4f84b-a0d4-3f90-40bb-f02f365460ec@candelatech.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 22 Mar 2021 18:20:58 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOotYHmtqOvSwBES6_95bnbAbEu6F7gQ5TjacJWUKdaPw@mail.gmail.com>
Message-ID: <CA+ASDXOotYHmtqOvSwBES6_95bnbAbEu6F7gQ5TjacJWUKdaPw@mail.gmail.com>
Subject: Re: [RFC 2/7] ath10k: Add support to process rx packet in thread
To:     Ben Greear <greearb@candelatech.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes@sipsolutions.net>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Rakesh Pillai <pillair@codeaurora.org>,
        ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 4:58 PM Ben Greear <greearb@candelatech.com> wrote:
> On 7/22/20 6:00 AM, Felix Fietkau wrote:
> > On 2020-07-22 14:55, Johannes Berg wrote:
> >> On Wed, 2020-07-22 at 14:27 +0200, Felix Fietkau wrote:
> >>
> >>> I'm considering testing a different approach (with mt76 initially):
> >>> - Add a mac80211 rx function that puts processed skbs into a list
> >>> instead of handing them to the network stack directly.
> >>
> >> Would this be *after* all the mac80211 processing, i.e. in place of the
> >> rx-up-to-stack?
> > Yes, it would run all the rx handlers normally and then put the
> > resulting skbs into a list instead of calling netif_receive_skb or
> > napi_gro_frags.
>
> Whatever came of this?  I realized I'm running Felix's patch since his mt76
> driver needs it.  Any chance it will go upstream?

If you're asking about $subject (moving NAPI/RX to a thread), this
landed upstream recently:
http://git.kernel.org/linus/adbb4fb028452b1b0488a1a7b66ab856cdf20715

It needs a bit of coaxing to work on a WiFi driver (including: WiFi
drivers tend to have a different netdev for NAPI than they expose to
/sys/class/net/), but it's there.

I'm not sure if people had something else in mind in the stuff you're
quoting though.

Brian
