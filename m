Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35ABD36C978
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237812AbhD0Q3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237436AbhD0Q3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:29:37 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7868C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:28:53 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id i4so32520797ybe.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vg/3UAWpZVgUQLhNp+Bd6xmGRy7RqLRSD/4LgKSvCpk=;
        b=l2RgyGVz2JdZqT/meO0ObJh5KaXo7AIGnyzUaFmS8w2BpiyXPqPemHmOqUNnD7qJTC
         w2FSQI0xPVfM+x5RN+O5eLalmIflxz96DTQ6vP7Y6fQHG89iDN4FSiF/V1pBB9wRfA02
         T+HaEmDCeDTtaED28XXRnF2ZwLZOCK5uw4tpBKe9T8wPYhJf5g4INv3l4OvulcjZsl8e
         wWwXRdhcx9KE1AmVY5ZQ2Il+bKxgKor1vc9dfDygeXnZ2v43VbQZ6ihBHiW5ovvAbiKK
         z3OppqpdcD09pA0hw0U9sO2jPEG3D51fXwaDHXuZjpCcfDmNWMbn/8l7N0kgpJni9Ejy
         kSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vg/3UAWpZVgUQLhNp+Bd6xmGRy7RqLRSD/4LgKSvCpk=;
        b=WnPOI8qW5WpVhzMKSPFbIUXWNUpARpHjPAmRr6NkvTFjNm5edYcvXR1TX2hLTeXPTc
         2n30Qr+xbHzvYtcHUiompIxSHkJy7+B3uAg9YQ2Ccup1Xss7Mn816d8TACiCEXG0GMD2
         tX+4wp5YVjQX/KKx+9Ao3o/yyr19P4H9g86WPWdsPYm0YXHDT4oTKPDK9qj6YzvWhmqK
         PU7/tU1YZM9DgjNKskqnxPW7rPH7XYoy2cqjfj1Cw02va9ZdlOzZ1NwklNN/CrdVuZGl
         qWG/4DxgBPvMfMP7sxsJWYig1PxYAZJU9VQF0gXWc5Kl1ZJ9jq/iS8j+QAEbH+jAk1Jq
         oKtg==
X-Gm-Message-State: AOAM532unWswGJWAZDqPJbQUS3p8P4pfTPed75WtDkBj02tDYVvex6dC
        2yJjub48vy6jS+V0GdQ2rv/ZdILdIDXAnAQ/U+gksw==
X-Google-Smtp-Source: ABdhPJxrDAsYBExwPcy1m3lvMq6eaPOzlWdscdEn/kH1KhMVZL3D8dhlA53hdB59BmSfoS/b2AaVbWXoyjq/k51C+uc=
X-Received: by 2002:a25:cbca:: with SMTP id b193mr24855273ybg.412.1619540932759;
 Tue, 27 Apr 2021 09:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210302211133.2244281-1-saravanak@google.com>
 <20210302211133.2244281-4-saravanak@google.com> <60989b90-7f8a-5306-e7d7-c5461bc9ac68@gmail.com>
 <CAGETcx_ayXd1uDR6WHWxLmskYwOSjyynNi3Rt8irRUrfnr266w@mail.gmail.com>
 <23ab7a11-330c-4d3d-00c1-984c5248464e@gmail.com> <20210427074807.GI43717@e120937-lin>
 <CA+-6iNz_kL0DnbRb0A=WSSLK0mnqw35S47TDXq5rhwXL_VWdPg@mail.gmail.com>
 <20210427141116.GJ43717@e120937-lin> <20210427151042.j7hku7pxqz56uyt6@bogus> <0887ce92-e9d8-47ec-0077-4c1f2fd46f87@gmail.com>
In-Reply-To: <0887ce92-e9d8-47ec-0077-4c1f2fd46f87@gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 27 Apr 2021 09:28:16 -0700
Message-ID: <CAGETcx9rcrdzt0QqSNDEsMN4Gfay8kryNjTktAuyBEQX74S9Vg@mail.gmail.com>
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

On Tue, Apr 27, 2021 at 9:25 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
>
> On 4/27/2021 8:10 AM, Sudeep Holla wrote:
> > On Tue, Apr 27, 2021 at 03:11:16PM +0100, Cristian Marussi wrote:
> >> On Tue, Apr 27, 2021 at 09:33:31AM -0400, Jim Quinlan wrote:
> > [...]
> >>>>
> >>> I believe that the brcmstb-mbox node is in our DT for backwards
> >>> compatibility with our older Linux only.   Note that  we use the compatible
> >>> string '"arm,scmi-smc", "arm,scmi"'; the former chooses SMC transport and
> >>> ignores custom  mailboxes such as brcmstb-mbox.
> >>>
> >>
> >> Right..so it is even more wrong that it is waiting for the mailboxes...but
> >> looking at the DT:
> >>
> >> brcm_scmi_mailbox@0 {
> >>                 #mbox-cells = <0x01>;
> >>                 compatible = "brcm,brcmstb-mbox";
> >>                 status = "disabled";
> >>                 linux,phandle = <0x04>;
> >>                 phandle = <0x04>;
> >>         };
> >>
> >> brcm_scmi@0 {
> >>                 compatible = "arm,scmi-smc\0arm,scmi";
> >>                 mboxes = <0x04 0x00 0x04 0x01>;
> >>                 mbox-names = "tx\0rx";
> >>                 shmem = <0x05>;
> >>                 status = "disabled";
> >>                 arm,smc-id = <0x83000400>;
> >>                 interrupt-names = "a2p";
> >>                 #address-cells = <0x01>;
> >>                 #size-cells = <0x00>;
> >>
> >> it seems to me that even though you declare an SMC based transport (and in fact
> >> you define the smc-id too) you also still define mboxes (as a fallback I suppose)
> >> referring to the brcm_scmi_mailbox phandle, and while this is ignored by the SCMI
> >> driver (because you have selected a compatible SMC transport) I imagine this dep
> >> is picked up by fw_devlink which in fact says:
> >>
> >>> [    0.300086] platform brcm_scmi@0: Linked as a consumer to brcm_scmi_mailbox@0
> >>
> >> and stalls waiting for it. (but I'm not really familiar on how fw_devlink
> >> internals works really...so I maybe off in these regards)
> >>
> >
> > I was about to mention/ask the same when I saw Jim's reply. I see you have
> > already asked that. Couple of my opinions based on my very limited knowledge
> > on fw_devlink and how it works.
> >
> > 1. Since we have different compatible for SMC and mailbox, I am not sure
> >    if it correct to leave mailbox information in scmi node. Once we have
> >    proper yaml scheme, we must flag that error IMO.
>
> This is a self inflicted problem that we have in that the bootloader
> provides a Device Tree to the kernel which is massaged in different ways
> and intends to stay backwards compatible as much as possible. And indeed
> after removing the 'mboxes' property gets us going with fw_devlink=on.

I'm sure you'll see my other email and reply to it, so I'll not
respond to this part.

>
> >
> > 2. IIUC, the fw_devlink might use information from DT to establish the
> >    dependency and having mailbox information in this context may be
> >    considered wrong as there is no dependency if it is using SMC.
>
> Right, unfortunately, short of having some special casing for SCMI and
> checking that if we have both an "arm,smc-id" and "mboxes" phandle we
> should prefer the former, there is not probably much that can be done
> here. Do we want to do that?

Definite no for special casing per device nodes in fw_devlink code :)

-Saravana
