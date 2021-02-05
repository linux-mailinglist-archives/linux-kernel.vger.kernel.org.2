Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19AB311094
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 20:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbhBERRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 12:17:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:50218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229988AbhBEROQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 12:14:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FD4C64F19;
        Fri,  5 Feb 2021 18:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612551358;
        bh=Dut+c1FVyHBMznczx7YPl/WFEcO5YCjuRBcQn/cce0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HIQ53G/rdyIEmK4O5Pwo+d7o20ZMKNsfvwD6vY3+oeW7Ok3RpP/ZH9udF/0EyxiAa
         SjnrxihAS62M2VaFx3DlhLvwLDhoMg6VD6xQnjWRZ/fb5JwYNvj7/t98zkcRLthvBe
         3VuZzf4WM00pXfnbVr/AjfIZsbfmV+Z/GMZui1RwHZf0gV5pEyOasuftjk5tsjYufU
         fxMGNxa1BYmz5J4PgajSgCMtxPDF2HAqR6iDqG+BrzldnTxifqSgpUNwzXYtxYKOao
         8KPhxvNGtvM2oHfebe5rRQohaqYoS+j/Fx8HvazL2Xf+gRTlNTZ794sw6Htljq1ant
         maJG6gpTixiaQ==
Date:   Fri, 5 Feb 2021 18:55:53 +0000
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH V2 1/2] arm64/mm: Fix pfn_valid() for ZONE_DEVICE based
 memory
Message-ID: <20210205185552.GA23216@willie-the-truck>
References: <1612239114-28428-1-git-send-email-anshuman.khandual@arm.com>
 <1612239114-28428-2-git-send-email-anshuman.khandual@arm.com>
 <20210202123215.GA16868@willie-the-truck>
 <20210202123524.GB16868@willie-the-truck>
 <f32e7caa-3414-9dd7-eb8c-220da1d925a1@redhat.com>
 <20210202125152.GC16868@willie-the-truck>
 <4d8f5156-8628-5531-1485-322ad92aa15c@redhat.com>
 <0e649f28-4d54-319d-f876-8a93870cda7f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e649f28-4d54-319d-f876-8a93870cda7f@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 09:20:39AM +0530, Anshuman Khandual wrote:
> On 2/2/21 6:26 PM, David Hildenbrand wrote:
> > On 02.02.21 13:51, Will Deacon wrote:
> >> On Tue, Feb 02, 2021 at 01:39:29PM +0100, David Hildenbrand wrote:
> >>> As I expressed already, long term we should really get rid of the arm64
> >>> variant and rather special-case the generic one. Then we won't go out of
> >>> sync - just as it happened with ZONE_DEVICE handling here.
> >>
> >> Why does this have to be long term? This ZONE_DEVICE stuff could be the
> >> carrot on the stick :)
> > 
> > Yes, I suggested to do it now, but Anshuman convinced me that doing a
> > simple fix upfront might be cleaner --- for example when it comes to
> > backporting :)
> 
> Right. The current pfn_valid() breaks for ZONE_DEVICE memory and this fixes
> the problem in the present context which can be easily backported if required.
> 
> Changing or rather overhauling the generic code with new configs as proposed
> earlier (which I am planning to work on subsequently) would definitely be an
> improvement for the current pfn_valid() situation in terms of maintainability
> but then it should not stop us from fixing the problem now.

Alright, I've mulled this over a bit. I don't agree that this patch helps
with maintainability (quite the opposite, in fact), but perfection is the
enemy of the good so I'll queue the series for 5.12. However, I'll revert
the changes at the first sign of a problem, so please do work towards a
generic solution which can replace this in the medium term.

Even just adding hooks with well-defined (documented) semantics to
pfn_valid() instead of having architectures override it wholesale would be a
massive step forward in my opinion.

Will
