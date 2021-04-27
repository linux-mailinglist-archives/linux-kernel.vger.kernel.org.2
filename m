Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBD736C997
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237727AbhD0QkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:40:24 -0400
Received: from foss.arm.com ([217.140.110.172]:54874 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237685AbhD0QkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:40:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92E80D6E;
        Tue, 27 Apr 2021 09:39:35 -0700 (PDT)
Received: from bogus (unknown [10.57.61.96])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DE463F73B;
        Tue, 27 Apr 2021 09:39:33 -0700 (PDT)
Date:   Tue, 27 Apr 2021 17:39:13 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
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
Message-ID: <20210427163913.svx2w2mxo4w3is32@bogus>
References: <20210302211133.2244281-1-saravanak@google.com>
 <20210302211133.2244281-4-saravanak@google.com>
 <60989b90-7f8a-5306-e7d7-c5461bc9ac68@gmail.com>
 <CAGETcx_ayXd1uDR6WHWxLmskYwOSjyynNi3Rt8irRUrfnr266w@mail.gmail.com>
 <23ab7a11-330c-4d3d-00c1-984c5248464e@gmail.com>
 <20210427074807.GI43717@e120937-lin>
 <CA+-6iNz_kL0DnbRb0A=WSSLK0mnqw35S47TDXq5rhwXL_VWdPg@mail.gmail.com>
 <20210427141116.GJ43717@e120937-lin>
 <20210427151042.j7hku7pxqz56uyt6@bogus>
 <0887ce92-e9d8-47ec-0077-4c1f2fd46f87@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0887ce92-e9d8-47ec-0077-4c1f2fd46f87@gmail.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 09:24:55AM -0700, Florian Fainelli wrote:

[...]

> This is a self inflicted problem that we have in that the bootloader
> provides a Device Tree to the kernel which is massaged in different ways
> and intends to stay backwards compatible as much as possible. And indeed
> after removing the 'mboxes' property gets us going with fw_devlink=on.
>

I assume the bootloader checks the presence of SMC support and modifies
the DT node accordingly. Can't it remove the mbox properties as it make
no sense with SMC compatible ? However ...

> >
> > 2. IIUC, the fw_devlink might use information from DT to establish the
> >    dependency and having mailbox information in this context may be
> >    considered wrong as there is no dependency if it is using SMC.
>
> Right, unfortunately, short of having some special casing for SCMI and
> checking that if we have both an "arm,smc-id" and "mboxes" phandle we
> should prefer the former, there is not probably much that can be done
> here. Do we want to do that?

I *think* we could do that in the SCMI drivers, but:
1. I am not sure if that helps fw_devlinks if they are deriving the info
   purely based on DT
2. I am also afraid that someone might come up with exactly opposite
   requirement that let us prefer mailbox over SMC as they would use
   SMC only if h/w lacks proper mailbox support. I fear that we will get
   into rabbit hole trying to do something like that.

--
Regards,
Sudeep
