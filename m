Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5700A36D417
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 10:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237213AbhD1Ilt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 04:41:49 -0400
Received: from foss.arm.com ([217.140.110.172]:37134 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237532AbhD1Ils (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 04:41:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EB0A1FB;
        Wed, 28 Apr 2021 01:41:03 -0700 (PDT)
Received: from bogus (unknown [10.57.61.96])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 997D73F70D;
        Wed, 28 Apr 2021 01:41:01 -0700 (PDT)
Date:   Wed, 28 Apr 2021 09:40:59 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
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
Subject: Re: [PATCH v1 3/3] Revert "Revert "driver core: Set fw_devlink=on by
 default""
Message-ID: <20210428084059.ue34zgzjod7jawh3@bogus>
References: <20210302211133.2244281-4-saravanak@google.com>
 <60989b90-7f8a-5306-e7d7-c5461bc9ac68@gmail.com>
 <CAGETcx_ayXd1uDR6WHWxLmskYwOSjyynNi3Rt8irRUrfnr266w@mail.gmail.com>
 <23ab7a11-330c-4d3d-00c1-984c5248464e@gmail.com>
 <20210427074807.GI43717@e120937-lin>
 <CA+-6iNz_kL0DnbRb0A=WSSLK0mnqw35S47TDXq5rhwXL_VWdPg@mail.gmail.com>
 <20210427141116.GJ43717@e120937-lin>
 <20210427151042.j7hku7pxqz56uyt6@bogus>
 <CAGETcx8Xt3SNoWS68+DjmAero1kuu8qsg=A9Yt2coXuKSqHMuw@mail.gmail.com>
 <895035b1-ac05-b193-ec3f-090a767305fc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <895035b1-ac05-b193-ec3f-090a767305fc@gmail.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 09:47:08AM -0700, Florian Fainelli wrote:
> On 4/27/2021 9:24 AM, Saravana Kannan wrote:

[...]

> > The part that's confusing to me is that the mbox node is disabled in
> > the DT you attached. fw_devlink is smart enough to ignore disabled
> > nodes. Is it getting enabled by the bootloader? Can you please try
> > deleting the reference to the brcm_scmi_mailbox from the scmi node and
> > see if it helps? Or leave it really disabled?
>
> Removing the 'mboxes' phandle works, see my other reply to Sudeep and I
> should have captured the DT from the Linux prompt after it has been
> finalized and where the mbox node is marked as enabled unfortunately.

I know Saravana has compiled the list of workarounds in preferred order
which excludes this which is good. Anyways I will convey my point. Disabling
mailbox controller node may not be always available option as it could be
providing multiple channels and the stale mboxes reference in SCMI might
be just one of the consumer. Removing mboxes seems only reasonable solution
to me in such scenario.

--
Regards,
Sudeep
