Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A347E36C861
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 17:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237198AbhD0PLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 11:11:31 -0400
Received: from foss.arm.com ([217.140.110.172]:53892 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236512AbhD0PLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 11:11:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 793FA31B;
        Tue, 27 Apr 2021 08:10:46 -0700 (PDT)
Received: from bogus (unknown [10.57.61.96])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 719AA3F73B;
        Tue, 27 Apr 2021 08:10:44 -0700 (PDT)
Date:   Tue, 27 Apr 2021 16:10:42 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
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
Subject: Re: [PATCH v1 3/3] Revert "Revert "driver core: Set fw_devlink=on by
 default""
Message-ID: <20210427151042.j7hku7pxqz56uyt6@bogus>
References: <20210302211133.2244281-1-saravanak@google.com>
 <20210302211133.2244281-4-saravanak@google.com>
 <60989b90-7f8a-5306-e7d7-c5461bc9ac68@gmail.com>
 <CAGETcx_ayXd1uDR6WHWxLmskYwOSjyynNi3Rt8irRUrfnr266w@mail.gmail.com>
 <23ab7a11-330c-4d3d-00c1-984c5248464e@gmail.com>
 <20210427074807.GI43717@e120937-lin>
 <CA+-6iNz_kL0DnbRb0A=WSSLK0mnqw35S47TDXq5rhwXL_VWdPg@mail.gmail.com>
 <20210427141116.GJ43717@e120937-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427141116.GJ43717@e120937-lin>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 03:11:16PM +0100, Cristian Marussi wrote:
> On Tue, Apr 27, 2021 at 09:33:31AM -0400, Jim Quinlan wrote:
[...]
> > >
> > I believe that the brcmstb-mbox node is in our DT for backwards
> > compatibility with our older Linux only.   Note that  we use the compatible
> > string '"arm,scmi-smc", "arm,scmi"'; the former chooses SMC transport and
> > ignores custom  mailboxes such as brcmstb-mbox.
> >
>
> Right..so it is even more wrong that it is waiting for the mailboxes...but
> looking at the DT:
>
> brcm_scmi_mailbox@0 {
>                 #mbox-cells = <0x01>;
>                 compatible = "brcm,brcmstb-mbox";
>                 status = "disabled";
>                 linux,phandle = <0x04>;
>                 phandle = <0x04>;
>         };
>
> brcm_scmi@0 {
>                 compatible = "arm,scmi-smc\0arm,scmi";
>                 mboxes = <0x04 0x00 0x04 0x01>;
>                 mbox-names = "tx\0rx";
>                 shmem = <0x05>;
>                 status = "disabled";
>                 arm,smc-id = <0x83000400>;
>                 interrupt-names = "a2p";
>                 #address-cells = <0x01>;
>                 #size-cells = <0x00>;
>
> it seems to me that even though you declare an SMC based transport (and in fact
> you define the smc-id too) you also still define mboxes (as a fallback I suppose)
> referring to the brcm_scmi_mailbox phandle, and while this is ignored by the SCMI
> driver (because you have selected a compatible SMC transport) I imagine this dep
> is picked up by fw_devlink which in fact says:
>
> > [    0.300086] platform brcm_scmi@0: Linked as a consumer to brcm_scmi_mailbox@0
>
> and stalls waiting for it. (but I'm not really familiar on how fw_devlink
> internals works really...so I maybe off in these regards)
>

I was about to mention/ask the same when I saw Jim's reply. I see you have
already asked that. Couple of my opinions based on my very limited knowledge
on fw_devlink and how it works.

1. Since we have different compatible for SMC and mailbox, I am not sure
   if it correct to leave mailbox information in scmi node. Once we have
   proper yaml scheme, we must flag that error IMO.

2. IIUC, the fw_devlink might use information from DT to establish the
   dependency and having mailbox information in this context may be
   considered wrong as there is no dependency if it is using SMC.

--
Regards,
Sudeep
