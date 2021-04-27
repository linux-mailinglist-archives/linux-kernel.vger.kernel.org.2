Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF5036CDAC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 23:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239125AbhD0VGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 17:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237009AbhD0VGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 17:06:42 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A159C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 14:05:58 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id q192so17439572ybg.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 14:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IoJlsduknJ/b08uOaozO0yY+p6YDtir/9zlM0aAnGMk=;
        b=PRylapGes3m8NEw2Nyh7NWs9kywM372sEmLyr63S+eWi/dABqHiCOLj9RmtkGwVQ1V
         n5Q93dXnA0txjkWQDJlOkOhAyjftfj3Dxz1gKtL3m9j4d66BuXjntAMb/+x/jQm1nv8C
         C8+/qo0fnfol9TlNmpu5zkhzWdhH9do2vEYzRGZ2eaUWEnR1OETslAZwSeLLRR3Li85W
         qkiZuVlhhhSOxtw3S1gancA4nhzTlMQPMg5CpTlThHNE3UE46DcLTTFYuGfiBv6lWbAc
         zw2BzP/hU9ZfoHVDaGO5HPTdN9EN3JJszgd8Yuoe7R9575zWAgn6ilBjiGEaAo3Fazp4
         qvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IoJlsduknJ/b08uOaozO0yY+p6YDtir/9zlM0aAnGMk=;
        b=mGdi3F2Qjp6p9OBEgpfggMP3P2CZaZu1/tIJlBzvTqrEEW6sMEu7E6sCflJc9KwIsH
         RSJ7/Ea+mcT/HHBVWv8AcmBjVO72fZSfZu4+UUT7mJiTTPcvaCBYEo5LgGSMUjnvRyL5
         oBRgTAE6Rh69fZl9bLa1JppkHSILYHiqjGKPMVxO2av+KWdYpBy0fZTg1nRR0W9kRtOy
         7EFHhf8v7PbF4ybFsWLj407kNmCq/B3W+tgKoYTyzNDzFokREGzTtkdviO3YODM0j83d
         RDHD6OUARjSiEvSLZvas0bPZGoyYd6AIpgOrEUwZs0J0WdIlNByid2LHunyEc4Zv6j1V
         ZS9Q==
X-Gm-Message-State: AOAM532R3v1D8sJDe1z2AWZ9zd6U18f2uevUFv+AE96gTAkmeRJXNIFD
        v2UjyagANXzdxggDZs7CIuYdwptecRGKaav5EZmZWg==
X-Google-Smtp-Source: ABdhPJzLskJS7TJTnYeazzKteOwdt815mx7ltSN3zzM+XpXcV2UU43bz72+uVYVIvmspAewT2c/Kync+BqrESn+YsnI=
X-Received: by 2002:a5b:ed2:: with SMTP id a18mr36567861ybs.466.1619557557061;
 Tue, 27 Apr 2021 14:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210302211133.2244281-1-saravanak@google.com>
 <20210302211133.2244281-4-saravanak@google.com> <60989b90-7f8a-5306-e7d7-c5461bc9ac68@gmail.com>
 <CAGETcx_ayXd1uDR6WHWxLmskYwOSjyynNi3Rt8irRUrfnr266w@mail.gmail.com>
 <23ab7a11-330c-4d3d-00c1-984c5248464e@gmail.com> <20210427074807.GI43717@e120937-lin>
 <CA+-6iNz_kL0DnbRb0A=WSSLK0mnqw35S47TDXq5rhwXL_VWdPg@mail.gmail.com>
 <20210427141116.GJ43717@e120937-lin> <20210427151042.j7hku7pxqz56uyt6@bogus>
 <CAGETcx8Xt3SNoWS68+DjmAero1kuu8qsg=A9Yt2coXuKSqHMuw@mail.gmail.com> <895035b1-ac05-b193-ec3f-090a767305fc@gmail.com>
In-Reply-To: <895035b1-ac05-b193-ec3f-090a767305fc@gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 27 Apr 2021 14:05:20 -0700
Message-ID: <CAGETcx82Y8PBDJ2V5JbRGfzz96gZ3tS9hRP-774dQd-+k4s2MA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] Revert "Revert "driver core: Set fw_devlink=on by default""
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
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

On Tue, Apr 27, 2021 at 9:47 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
>
> On 4/27/2021 9:24 AM, Saravana Kannan wrote:
> > On Tue, Apr 27, 2021 at 8:10 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >>
> >> On Tue, Apr 27, 2021 at 03:11:16PM +0100, Cristian Marussi wrote:
> >>> On Tue, Apr 27, 2021 at 09:33:31AM -0400, Jim Quinlan wrote:
> >> [...]
> >>>>>
> >>>> I believe that the brcmstb-mbox node is in our DT for backwards
> >>>> compatibility with our older Linux only.   Note that  we use the compatible
> >>>> string '"arm,scmi-smc", "arm,scmi"'; the former chooses SMC transport and
> >>>> ignores custom  mailboxes such as brcmstb-mbox.
> >>>>
> >>>
> >>> Right..so it is even more wrong that it is waiting for the mailboxes...but
> >>> looking at the DT:
> >>>
> >>> brcm_scmi_mailbox@0 {
> >>>                 #mbox-cells = <0x01>;
> >>>                 compatible = "brcm,brcmstb-mbox";
> >>>                 status = "disabled";
> >>>                 linux,phandle = <0x04>;
> >>>                 phandle = <0x04>;
> >>>         };
> >>>
> >>> brcm_scmi@0 {
> >>>                 compatible = "arm,scmi-smc\0arm,scmi";
> >>>                 mboxes = <0x04 0x00 0x04 0x01>;
> >>>                 mbox-names = "tx\0rx";
> >>>                 shmem = <0x05>;
> >>>                 status = "disabled";
> >>>                 arm,smc-id = <0x83000400>;
> >>>                 interrupt-names = "a2p";
> >>>                 #address-cells = <0x01>;
> >>>                 #size-cells = <0x00>;
> >>>
> >>> it seems to me that even though you declare an SMC based transport (and in fact
> >>> you define the smc-id too) you also still define mboxes (as a fallback I suppose)
> >>> referring to the brcm_scmi_mailbox phandle, and while this is ignored by the SCMI
> >>> driver (because you have selected a compatible SMC transport) I imagine this dep
> >>> is picked up by fw_devlink which in fact says:
> >>>
> >>>> [    0.300086] platform brcm_scmi@0: Linked as a consumer to brcm_scmi_mailbox@0
> >>>
> >>> and stalls waiting for it. (but I'm not really familiar on how fw_devlink
> >>> internals works really...so I maybe off in these regards)
> >
> > Cristian,
> >
> > Great debugging work for not having worked on this before! Your
> > comments about the dependencies are right. If you grep the logs for
> > "probe deferral", you'll see these lines and more:
> >
> > [    0.942998] platform brcm_scmi@0: probe deferral - supplier
> > brcm_scmi_mailbox@0 not ready
> > [    3.622741] platform 8b20000.pcie: probe deferral - supplier
> > brcm_scmi@0 not ready
> > [    5.695929] platform 840c000.serial: probe deferral - supplier
> > brcm_scmi@0 not ready
> >
> > Florian,
> >
> > Sorry I wasn't clear in my earlier email. I was asking for the path to
> > the board file DT in upstream so I could look at it and the files it
> > references. I didn't mean to ask for an "decompiled" DTS attachment.
> > The decompiled ones make it a pain to track the phandles.
>
> Our Device Tree sources are not in the kernel since the bootloader
> provides a FDT to the kernel which is massaged in different ways to
> support a single binary for a multitude of reference boards and chip
> variants. That FDT is 90% auto-generated offline from scripts and about
> 10% runtime patched based on our whim. We should probably still aim for
> some visibility into these Device Tree files by the kernel community.
>
> >
> > The part that's confusing to me is that the mbox node is disabled in
> > the DT you attached. fw_devlink is smart enough to ignore disabled
> > nodes. Is it getting enabled by the bootloader? Can you please try
> > deleting the reference to the brcm_scmi_mailbox from the scmi node and
> > see if it helps? Or leave it really disabled?
>
> Removing the 'mboxes' phandle works, see my other reply to Sudeep and I
> should have captured the DT from the Linux prompt after it has been
> finalized and where the mbox node is marked as enabled unfortunately.
>
> >
> > Also, as a separate test of workarounds, can you please add
> > deferred_probe_timeout=1 to your commandline and see if it helps? I'm
> > assuming you have modules enabled? Otherwise, the existing smarts in
> > fw_devlink to ignore devices with no drivers would have kicked in too.
>
> deferred_probe_timeout=1 does help however all of these drivers are
> built into the kernel at the moment and so ultimately we reach
> user-space with no console driver registered.

Whether all the required drivers are built in already or not doesn't
matter for this workaround. fw_devlink can't tell if you are just
about to load a module that'll probe the mailbox. If CONFIG_MODULES is
disabled, then it can tell no more drivers are getting loaded by the
time you hit late_initcall_sync() and it would have automatically
applied this workaround without deferred_probe_timeout=1.

>
> >
> >> I was about to mention/ask the same when I saw Jim's reply. I see you have
> >> already asked that. Couple of my opinions based on my very limited knowledge
> >> on fw_devlink and how it works.
> >>
> >> 1. Since we have different compatible for SMC and mailbox, I am not sure
> >>    if it correct to leave mailbox information in scmi node. Once we have
> >>    proper yaml scheme, we must flag that error IMO.
> >>
> >> 2. IIUC, the fw_devlink might use information from DT to establish the
> >>    dependency and having mailbox information in this context may be
> >>    considered wrong as there is no dependency if it is using SMC.
> >
> > If this mbox reference from scmi is wrong for the current kernel and
> > never used, then I'd recommend deleting that.
>
> Yes that seems to be the way forward unless we want to set
> fw_devlink=permissive on the command line, either should hopefully be an
> option.

I read all the other emails from Sudeep, Geert and you. I'll just
respond to all of them here.

My preferred order of the workarouds:
1. Fix the DT sent to the kernel.
2. If deferred_probe_timeout=1 doesn't break anything else, use that.
This is better than (4).
3. Geert's early boot quirk suggestion.
4. fw_devlink=permissive (least preferred because this might mask
issues with fw_devlink=on in your future changes).

Changing the SCMI driver itself won't help fw_devlink.

Thanks,
Saravana
