Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F6A458B01
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 10:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238964AbhKVJHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 04:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhKVJHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 04:07:44 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43062C061574;
        Mon, 22 Nov 2021 01:04:38 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id x15so73664749edv.1;
        Mon, 22 Nov 2021 01:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/n2Vm5z8nFGK+sbMSre7nkEQgLie2yLLJputlZIF0rw=;
        b=MGM9gXKyZV26D2lbgtxuuQwoJ9UQxDrIdr1g22N9dWWKStYfmVIfWgKcAeTAU2qFoh
         lkDXU/77a7NYdBZLLfansRByZ6LiJkpl+E6fasDgmtEYZjVwEL8PNuaAZQTBnzXsQxqR
         LnOX4xT/gYYayGwbXFAQyJoJszrL0txDfx6Xa+XZ0MSlsTYCzt/XHRBckPtKyA24sWCd
         90UPzxQx/YgyPDPoN5OzKUB5pbkHDVxtTBc6IDV6g/oYocP7F7j3vWm/D0/a9opZnnR6
         2NfLOThgtZslMgvYFBJEW53hlyu4OC6pDPXaeyA/fghOpmyvsMZ0ofu2q4FDbIqjZWAv
         PhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/n2Vm5z8nFGK+sbMSre7nkEQgLie2yLLJputlZIF0rw=;
        b=ISKbu8c9wTw+f5L0v0DqgHVOzY+RNRKX5m7BrsrxAJCbjL6ZyFDk0jYk2hymZI+8Iu
         VYleXKMGKOIPxgkza2RaajKKn09X1TebFWr4hGGSG7lLlc8Et++6fPjuw9etbnBwtKH3
         SFDRGweuYm1U7rzyiPnTDgcbCOe75RklKCQGkB0S9cZiI1cu4H+SGk5uJUympUagKliq
         A5jQsP/nEzoxLogHE54IVnq/UGTbYuZXbyQVDbYMGKtHRUPMdHxMbDiLWOZLrVdt9iDR
         kjD5TzgpnxaA4ua4bfefLBZcx+DxDzBoSWKE8UT00aNmnnDMl9GRL/s+/7M41xpK4YM7
         uxrQ==
X-Gm-Message-State: AOAM531lTn1csqbf3PJOD7+ViGGU8uVS/LQBbl6f7RIYbOeQ7NUbeUWW
        n/jDCqsNqkToGANMbqu8ZGAwaSc7Eg9Ob2kZKOA=
X-Google-Smtp-Source: ABdhPJw1Y/E8hlBCt4M0ZxIE/6dl4jAqFgcMD+6FREtOB29ObDhN9iSjRxOlsQ2zIkKb4HicLv91Qy5jg7lWpWCJE4U=
X-Received: by 2002:aa7:dbc1:: with SMTP id v1mr62739440edt.49.1637571876741;
 Mon, 22 Nov 2021 01:04:36 -0800 (PST)
MIME-Version: 1.0
References: <20211112162827.128319-1-aouledameur@baylibre.com>
 <20211112162827.128319-3-aouledameur@baylibre.com> <CAFBinCDNMCT4KZjw8HnYer9NJBx09yF=KpguGm8Q4vKw8eBr9A@mail.gmail.com>
In-Reply-To: <CAFBinCDNMCT4KZjw8HnYer9NJBx09yF=KpguGm8Q4vKw8eBr9A@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 22 Nov 2021 14:34:26 +0530
Message-ID: <CANAwSgRoBCao2fh1jgBwb-7r+ng3LabNbH8i4G=kn668uhCasg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] usb: dwc3: meson-g12a: fix shared reset control use
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Felipe Balbi <balbi@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amjad

On Sun, 21 Nov 2021 at 05:21, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Amjad,
>
> +Cc Anand who was also investigating the original issue one year ago
>
Thanks.
> On Fri, Nov 12, 2021 at 5:33 PM Amjad Ouled-Ameur
> <aouledameur@baylibre.com> wrote:
> >
> >
> it seems that there's an extraneous blank line here
>
> > reset_control_(de)assert() calls are called on a shared reset line when
> > reset_control_reset has been used. This is not allowed by the reset
> > framework.
> >
> > Use reset_control_rearm() call in suspend() and remove() as a way to state
> > that the resource is no longer used, hence the shared reset line
> > may be triggered again by other devices. Use reset_control_rearm() also in
> > case probe fails after reset() has been called.
> >
> > reset_control_rearm() keeps use of triggered_count sane in the reset
> > framework, use of reset_control_reset() on shared reset line should be
> > balanced with reset_control_rearm().
> >
> > Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> > Reported-by: Jerome Brunet <jbrunet@baylibre.com>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Changes fix the warning messages on my odroid n2 during suspend / resume.
Please add my
Tested-by: Anand Moon <linux.amoon@gmail.com>
