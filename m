Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2B2318A64
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 13:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhBKMZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 07:25:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:49206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230420AbhBKMXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 07:23:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDE0964E9A;
        Thu, 11 Feb 2021 12:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613046108;
        bh=o3YtiUDjeinRUlnclOK4o3qUHnz1oyjiknS7o6mlojU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MovGASDhlPuy0OGL9HveOomvFFWZOx3I4EpxBWaKS6XvXdfrFmfkpoZJeky09CoXk
         k5jC6nBKAHPNa0YfmIQ4AGEg3XhZkJKUYZ5xS7QphKa9WkvpGGI0z020DzApjnX9Vi
         fUVZPt2baXxhlqpd4/Dlph55KkomG+0dei+Rd1CFxHhUzHthMYoPgCRD29M6kHCco6
         kHzMSY0ICFH2HP6xrtjlyV304n9Y711WMcuV+OoFbMJPxLcnJ0xi5GdWexFn1yF+1z
         pmj8K8Ho0R6vx73nQRj4/nHI1wAHiNfQPVGKBErgyce58PZ024j5Ddy7zhQVT2lE66
         +HBHVpHSyBMYA==
Date:   Thu, 11 Feb 2021 12:21:43 +0000
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        linux-mm@kvack.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        James Morse <james.morse@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 1/2] arm64/mm: Fix pfn_valid() for ZONE_DEVICE based
 memory
Message-ID: <20210211122143.GC29894@willie-the-truck>
References: <1612239114-28428-2-git-send-email-anshuman.khandual@arm.com>
 <20210202123215.GA16868@willie-the-truck>
 <20210202123524.GB16868@willie-the-truck>
 <f32e7caa-3414-9dd7-eb8c-220da1d925a1@redhat.com>
 <20210202125152.GC16868@willie-the-truck>
 <4d8f5156-8628-5531-1485-322ad92aa15c@redhat.com>
 <0e649f28-4d54-319d-f876-8a93870cda7f@arm.com>
 <20210205185552.GA23216@willie-the-truck>
 <20210211115354.GB29894@willie-the-truck>
 <23e5eb93-a39c-c68e-eac1-c5ccf9036079@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23e5eb93-a39c-c68e-eac1-c5ccf9036079@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 05:40:35PM +0530, Anshuman Khandual wrote:
> On 2/11/21 5:23 PM, Will Deacon wrote:
> > On Fri, Feb 05, 2021 at 06:55:53PM +0000, Will Deacon wrote:
> >> On Wed, Feb 03, 2021 at 09:20:39AM +0530, Anshuman Khandual wrote:
> >>> On 2/2/21 6:26 PM, David Hildenbrand wrote:
> >>>> On 02.02.21 13:51, Will Deacon wrote:
> >>>>> On Tue, Feb 02, 2021 at 01:39:29PM +0100, David Hildenbrand wrote:
> >>>>>> As I expressed already, long term we should really get rid of the arm64
> >>>>>> variant and rather special-case the generic one. Then we won't go out of
> >>>>>> sync - just as it happened with ZONE_DEVICE handling here.
> >>>>>
> >>>>> Why does this have to be long term? This ZONE_DEVICE stuff could be the
> >>>>> carrot on the stick :)
> >>>>
> >>>> Yes, I suggested to do it now, but Anshuman convinced me that doing a
> >>>> simple fix upfront might be cleaner --- for example when it comes to
> >>>> backporting :)
> >>>
> >>> Right. The current pfn_valid() breaks for ZONE_DEVICE memory and this fixes
> >>> the problem in the present context which can be easily backported if required.
> >>>
> >>> Changing or rather overhauling the generic code with new configs as proposed
> >>> earlier (which I am planning to work on subsequently) would definitely be an
> >>> improvement for the current pfn_valid() situation in terms of maintainability
> >>> but then it should not stop us from fixing the problem now.
> >>
> >> Alright, I've mulled this over a bit. I don't agree that this patch helps
> >> with maintainability (quite the opposite, in fact), but perfection is the
> >> enemy of the good so I'll queue the series for 5.12. However, I'll revert
> >> the changes at the first sign of a problem, so please do work towards a
> >> generic solution which can replace this in the medium term.
> > 
> > ... and dropped. These patches appear to be responsible for a boot
> > regression reported by CKI:
> 
> Ahh, boot regression ? These patches only change the behaviour
> for non boot memory only.

Sure, but this thing is horribly fragile, which is why I was nervous about
touching it in the first place ;)

> > https://lore.kernel.org/r/cki.8D1CB60FEC.K6NJMEFQPV@redhat.com
> 
> Will look into the logs and see if there is something pointing to
> the problem.

We don't have a log yet, but I've asked whether earlycon works on the
problematic machine (the failure seems to be specific to a certain TX2).

Either way, this is too late for 5.12 now.

Will
