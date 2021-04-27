Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6A036C9A6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236305AbhD0Qnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:43:55 -0400
Received: from foss.arm.com ([217.140.110.172]:54934 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236975AbhD0Qnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:43:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DF52D6E;
        Tue, 27 Apr 2021 09:42:56 -0700 (PDT)
Received: from bogus (unknown [10.57.61.96])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97A353F73B;
        Tue, 27 Apr 2021 09:42:54 -0700 (PDT)
Date:   Tue, 27 Apr 2021 17:42:52 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
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
Message-ID: <20210427164252.xwyxfhhiqluitgfb@bogus>
References: <20210302211133.2244281-4-saravanak@google.com>
 <60989b90-7f8a-5306-e7d7-c5461bc9ac68@gmail.com>
 <CAGETcx_ayXd1uDR6WHWxLmskYwOSjyynNi3Rt8irRUrfnr266w@mail.gmail.com>
 <23ab7a11-330c-4d3d-00c1-984c5248464e@gmail.com>
 <20210427074807.GI43717@e120937-lin>
 <CA+-6iNz_kL0DnbRb0A=WSSLK0mnqw35S47TDXq5rhwXL_VWdPg@mail.gmail.com>
 <20210427141116.GJ43717@e120937-lin>
 <20210427151042.j7hku7pxqz56uyt6@bogus>
 <0887ce92-e9d8-47ec-0077-4c1f2fd46f87@gmail.com>
 <CAGETcx9rcrdzt0QqSNDEsMN4Gfay8kryNjTktAuyBEQX74S9Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGETcx9rcrdzt0QqSNDEsMN4Gfay8kryNjTktAuyBEQX74S9Vg@mail.gmail.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 09:28:16AM -0700, Saravana Kannan wrote:
> On Tue, Apr 27, 2021 at 9:25 AM Florian Fainelli <f.fainelli@gmail.com> wrote:

[...]

> > Right, unfortunately, short of having some special casing for SCMI and
> > checking that if we have both an "arm,smc-id" and "mboxes" phandle we
> > should prefer the former, there is not probably much that can be done
> > here. Do we want to do that?
>
> Definite no for special casing per device nodes in fw_devlink code :)
>

Thanks for the confirmation, but I had already assumed so with 100% certainty
in my last reply 😄.

--
Regards,
Sudeep
