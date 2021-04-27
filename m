Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED87B36C96A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237584AbhD0Q1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237865AbhD0Q01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:26:27 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB58C061366
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:24:44 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 130so26259050ybd.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vag7K7RcXCDVoliJxHFlFU/qfrKDbAVCUT+KhdPEhgY=;
        b=Zsb/h0B7wwoThvNYvVqFZ8sKM509IEayCR8JxlvUdJPcPnqZ/jdNk4Ydx+Xp8cWc6s
         3xlEOXU+uNcnGsgZLAdnXgkn+S6Nn15jfrNpCr+trDLcvEBwlpuryQncmVy4OvC2J+MW
         kD6kJCreVRgAIYFwq9aidF4Ar9R4oDpEyIb7/02uzjaDDAltgWPve/d9Ay72444GCWKG
         QD2K4Wkhr5FQGf0x2PH6jknODUavGK76S2kqYMCVVkNsxxXzzjFn3ENPZAaVwkPzdIgx
         VMl/d+Vw9RkEPG6gBYpOo/k7E1+1o3GCXW+E8CBJ4eF58d0yDUJF3iiP/uFLJRcAKVga
         RM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vag7K7RcXCDVoliJxHFlFU/qfrKDbAVCUT+KhdPEhgY=;
        b=cyqYqZXHdo/FBEnVW8sK5IskaWE4ifGkmGmJmFwBm4AnHuUmEWP6crcbsECY+SzlmE
         BzPuugPr1n/MGB9LWMRUgqdTDzNgheyrUPviVSNUlsbSVsjNe1lw1mHU60h2+WEoZmhI
         3IMPPSa4DoprA6I4ldkOv88b2tb+TT97286ZzYmduIwY0v1VMLwiYi8pKvrYFcQi79NR
         U+R8L3XmatmuhcZvOPe3WmM+k8lihBZQceg7cCpEt/Ii54ueVR/+K6TrZtlEYhAyy+i4
         eoBGrIsVtIO6p1/wmclB0fnUllwZbup/YtAYLGIp5NjoriZRPdovOxWqsQnSTRzpCBEK
         y/xA==
X-Gm-Message-State: AOAM5329tbGtI1LPEEnGv+vHhdqpJ6+goFgmCEQWiq6RMUhYg8P0WH2p
        q8DjCsYaIgrgTCEczEqKvpLVEn9/3OMbeREne4jImg==
X-Google-Smtp-Source: ABdhPJxp60Ijg6VNCWKfeee5Tj0r0MHrtsquFE/HUKAFRvCeRC1iGddWrG3PmXltFhK2cUffmoSvIZFYg+KM9Svgt+g=
X-Received: by 2002:a25:9188:: with SMTP id w8mr30985173ybl.346.1619540682964;
 Tue, 27 Apr 2021 09:24:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210302211133.2244281-1-saravanak@google.com>
 <20210302211133.2244281-4-saravanak@google.com> <60989b90-7f8a-5306-e7d7-c5461bc9ac68@gmail.com>
 <CAGETcx_ayXd1uDR6WHWxLmskYwOSjyynNi3Rt8irRUrfnr266w@mail.gmail.com>
 <23ab7a11-330c-4d3d-00c1-984c5248464e@gmail.com> <20210427074807.GI43717@e120937-lin>
 <CA+-6iNz_kL0DnbRb0A=WSSLK0mnqw35S47TDXq5rhwXL_VWdPg@mail.gmail.com>
 <20210427141116.GJ43717@e120937-lin> <20210427151042.j7hku7pxqz56uyt6@bogus>
In-Reply-To: <20210427151042.j7hku7pxqz56uyt6@bogus>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 27 Apr 2021 09:24:06 -0700
Message-ID: <CAGETcx8Xt3SNoWS68+DjmAero1kuu8qsg=A9Yt2coXuKSqHMuw@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] Revert "Revert "driver core: Set fw_devlink=on by default""
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Al Cooper <alcooperx@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 8:10 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Tue, Apr 27, 2021 at 03:11:16PM +0100, Cristian Marussi wrote:
> > On Tue, Apr 27, 2021 at 09:33:31AM -0400, Jim Quinlan wrote:
> [...]
> > > >
> > > I believe that the brcmstb-mbox node is in our DT for backwards
> > > compatibility with our older Linux only.   Note that  we use the compatible
> > > string '"arm,scmi-smc", "arm,scmi"'; the former chooses SMC transport and
> > > ignores custom  mailboxes such as brcmstb-mbox.
> > >
> >
> > Right..so it is even more wrong that it is waiting for the mailboxes...but
> > looking at the DT:
> >
> > brcm_scmi_mailbox@0 {
> >                 #mbox-cells = <0x01>;
> >                 compatible = "brcm,brcmstb-mbox";
> >                 status = "disabled";
> >                 linux,phandle = <0x04>;
> >                 phandle = <0x04>;
> >         };
> >
> > brcm_scmi@0 {
> >                 compatible = "arm,scmi-smc\0arm,scmi";
> >                 mboxes = <0x04 0x00 0x04 0x01>;
> >                 mbox-names = "tx\0rx";
> >                 shmem = <0x05>;
> >                 status = "disabled";
> >                 arm,smc-id = <0x83000400>;
> >                 interrupt-names = "a2p";
> >                 #address-cells = <0x01>;
> >                 #size-cells = <0x00>;
> >
> > it seems to me that even though you declare an SMC based transport (and in fact
> > you define the smc-id too) you also still define mboxes (as a fallback I suppose)
> > referring to the brcm_scmi_mailbox phandle, and while this is ignored by the SCMI
> > driver (because you have selected a compatible SMC transport) I imagine this dep
> > is picked up by fw_devlink which in fact says:
> >
> > > [    0.300086] platform brcm_scmi@0: Linked as a consumer to brcm_scmi_mailbox@0
> >
> > and stalls waiting for it. (but I'm not really familiar on how fw_devlink
> > internals works really...so I maybe off in these regards)

Cristian,

Great debugging work for not having worked on this before! Your
comments about the dependencies are right. If you grep the logs for
"probe deferral", you'll see these lines and more:

[    0.942998] platform brcm_scmi@0: probe deferral - supplier
brcm_scmi_mailbox@0 not ready
[    3.622741] platform 8b20000.pcie: probe deferral - supplier
brcm_scmi@0 not ready
[    5.695929] platform 840c000.serial: probe deferral - supplier
brcm_scmi@0 not ready

Florian,

Sorry I wasn't clear in my earlier email. I was asking for the path to
the board file DT in upstream so I could look at it and the files it
references. I didn't mean to ask for an "decompiled" DTS attachment.
The decompiled ones make it a pain to track the phandles.

The part that's confusing to me is that the mbox node is disabled in
the DT you attached. fw_devlink is smart enough to ignore disabled
nodes. Is it getting enabled by the bootloader? Can you please try
deleting the reference to the brcm_scmi_mailbox from the scmi node and
see if it helps? Or leave it really disabled?

Also, as a separate test of workarounds, can you please add
deferred_probe_timeout=1 to your commandline and see if it helps? I'm
assuming you have modules enabled? Otherwise, the existing smarts in
fw_devlink to ignore devices with no drivers would have kicked in too.

> I was about to mention/ask the same when I saw Jim's reply. I see you have
> already asked that. Couple of my opinions based on my very limited knowledge
> on fw_devlink and how it works.
>
> 1. Since we have different compatible for SMC and mailbox, I am not sure
>    if it correct to leave mailbox information in scmi node. Once we have
>    proper yaml scheme, we must flag that error IMO.
>
> 2. IIUC, the fw_devlink might use information from DT to establish the
>    dependency and having mailbox information in this context may be
>    considered wrong as there is no dependency if it is using SMC.

If this mbox reference from scmi is wrong for the current kernel and
never used, then I'd recommend deleting that.

-Saravana
