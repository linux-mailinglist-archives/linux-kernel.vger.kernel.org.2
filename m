Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CDE32AA99
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 20:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350368AbhCBTwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 14:52:01 -0500
Received: from rcdn-iport-3.cisco.com ([173.37.86.74]:27943 "EHLO
        rcdn-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1579959AbhCBRVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 12:21:20 -0500
X-Greylist: delayed 458 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Mar 2021 12:21:19 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1625; q=dns/txt; s=iport;
  t=1614705679; x=1615915279;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ImvxV88MVdFuksRY57yHoR9ifNWa1nbpC7IuceuHtdI=;
  b=DHJAmi6pIanMDzLMZhoQrTts24E3LqKzVJ5nni6NvEjg3FmDN2j6Cumj
   YNKnQsGi3qQYsPTsRONPszom2VzU34ebhAKmJS4FY5TSaqBi75QZ7h90z
   j5/OwAcQSq63ofvt3UYFXTCKwun+OV4SrCd1soTUhyUgt3Ws+86YfOH0R
   U=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0BKAwC9cD5g/5RdJa1iHAEBAQEBAQc?=
 =?us-ascii?q?BARIBAQQEAQFAgU+CK3ZWATkxA5Yaj3oWilOBaAsBAQENAQEqCgQBAYRNAoF?=
 =?us-ascii?q?6AiU4EwIDAQELAQEFAQEBAgEGBHGFYQ2GRQEFOjQLEAsYLjwKEQYTgnGDBw+?=
 =?us-ascii?q?sa3SBNIRAAYRigT4GIoEWjUMmHIFJQoQrPoQJARIBg2uCKwSEAYIxQ5MVAYo?=
 =?us-ascii?q?tm3uDBoEfiCCSUjEQgyeQSo9VLZYxiTSWYAIEBgUCFoFrI2dwMxoIGxU7gmk?=
 =?us-ascii?q?TPRkNjisWiGGFZiADLwI2AgYKAQEDCYwTAQE?=
X-IronPort-AV: E=Sophos;i="5.81,217,1610409600"; 
   d="scan'208";a="842559803"
Received: from rcdn-core-12.cisco.com ([173.37.93.148])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 02 Mar 2021 17:12:53 +0000
Received: from zorba ([10.24.9.198])
        by rcdn-core-12.cisco.com (8.15.2/8.15.2) with ESMTPS id 122HCpOe014626
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Mar 2021 17:12:52 GMT
Date:   Tue, 2 Mar 2021 09:12:51 -0800
From:   Daniel Walker <danielwa@cisco.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Max Uvarov <muvarov@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Android Kernel Team <kernel-team@android.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 0/2] Fix CMDLINE_EXTEND handling for FDT "bootargs"
Message-ID: <20210302171251.GB109100@zorba>
References: <20210225125921.13147-1-will@kernel.org>
 <CAL_JsqJX=TCCs7=gg486r9TN4NYscMTCLNfqJF9crskKPq-bTg@mail.gmail.com>
 <20210301144153.GA16716@willie-the-truck>
 <CAL_JsqJ11D-7a3pwLTVd+rHjqDGBb=b8OU_a6h3Co-at+2qMtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ11D-7a3pwLTVd+rHjqDGBb=b8OU_a6h3Co-at+2qMtQ@mail.gmail.com>
X-Outbound-SMTP-Client: 10.24.9.198, [10.24.9.198]
X-Outbound-Node: rcdn-core-12.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 11:26:14AM -0600, Rob Herring wrote:
> +PPC folks and Daniel W
> 
> On Mon, Mar 1, 2021 at 8:42 AM Will Deacon <will@kernel.org> wrote:
> >
> > On Mon, Mar 01, 2021 at 08:19:32AM -0600, Rob Herring wrote:
> > > On Thu, Feb 25, 2021 at 6:59 AM Will Deacon <will@kernel.org> wrote:
> > > > We recently [1] enabled support for CMDLINE_EXTEND on arm64, however
> > > > when I started looking at replacing Android's out-of-tree implementation [2]
> > >
> > > Did anyone go read the common, reworked version of all this I
> > > referenced that supports prepend and append. Here it is again[1].
> > > Maybe I should have been more assertive there and said 'extend' is
> > > ambiguous.
> >
> > I tried reading that, but (a) most of the series is not in the mailing list
> > archives and (b) the patch that _is_ doesn't touch CMDLINE_EXTEND at all.
> > Right now the code in mainline does the opposite of what it's documented to
> > do.
> 
> Actually, there is a newer version I found:
> 
> https://lore.kernel.org/linuxppc-dev/1551469472-53043-1-git-send-email-danielwa@cisco.com/
> https://lore.kernel.org/linuxppc-dev/1551469472-53043-2-git-send-email-danielwa@cisco.com/
> https://lore.kernel.org/linuxppc-dev/1551469472-53043-3-git-send-email-danielwa@cisco.com/
> 
> (Once again, there's some weird threading going on)
> 

I'm happy to work with anyone to resubmit the changes. We currently use the
changes in Cisco, and we have used them for many years.

I was planning to update and resubmit since someone has recently inquired about
why it wasn't upstream.

Daniel
