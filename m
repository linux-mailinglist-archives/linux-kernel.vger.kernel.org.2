Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64248357C9A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 08:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhDHG2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 02:28:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhDHG2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 02:28:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A635060FF0;
        Thu,  8 Apr 2021 06:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617863282;
        bh=3CBGbTus3iyR2kStFocLAP1r4ANkWnNDiwwXO2RQGeg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MZPw56dGGoMb4dr8Sk+waAmCBW4XnztSdMy2AmqsReqPn7qirRduRdE+gaFWDV327
         DXlU2nF6tbnW972PCgHgbmp9alr1jdTIZ00s4O7n06eOtls0z5W5o6tlJjyZh5j7Z2
         814rcMgrxxRsrz1GtyL5hPwsUimhylJ0vct9CeIaq9OBEUyn4zdkP3eMLFrSgH5IxP
         4B9+0SMBFFX7lbg/GOWrQ4eMNOAHfsjm91i6uF5/NyZTFfAPFpeXq7r4v6A1Pz/E1k
         wAXqRekhgYwjfF/i/bAxi2JEiNtsCTULy1e8sNFZaOBWAp9qmlcQhng2zLNOzwbio5
         cCiSXbIkCEy6g==
Date:   Thu, 8 Apr 2021 09:27:53 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        James Morse <james.morse@arm.com>
Subject: Re: [RFC/RFT PATCH 0/3] arm64: drop pfn_valid_within() and simplify
 pfn_valid()
Message-ID: <YG6iaZJI/RiUwXzv@kernel.org>
References: <20210407172607.8812-1-rppt@kernel.org>
 <2f68ea11-7c56-1c55-f0be-3aad7188c00a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f68ea11-7c56-1c55-f0be-3aad7188c00a@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 10:49:02AM +0530, Anshuman Khandual wrote:
> Adding James here.
> 
> + James Morse <james.morse@arm.com>
> 
> On 4/7/21 10:56 PM, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Hi,
> > 
> > These patches aim to remove CONFIG_HOLES_IN_ZONE and essentially hardwire
> > pfn_valid_within() to 1. 
> 
> That would be really great for arm64 platform as it will save CPU cycles on
> many generic MM paths, given that our pfn_valid() has been expensive.
> 
> > 
> > The idea is to mark NOMAP pages as reserved in the memory map and restore
> 
> Though I am not really sure, would that possibly be problematic for UEFI/EFI
> use cases as it might have just treated them as normal struct pages till now.

I don't think there should be a problem because now the struct pages for
UEFI/ACPI never got to be used by the core mm. They were (rightfully)
skipped by memblock_free_all() from one side and pfn_valid() and
pfn_valid_within() return false for them in various pfn walkers from the
other side.
 
> > the intended semantics of pfn_valid() to designate availability of struct
> > page for a pfn.
> 
> Right, that would be better as the current semantics is not ideal.
> 
> > 
> > With this the core mm will be able to cope with the fact that it cannot use
> > NOMAP pages and the holes created by NOMAP ranges within MAX_ORDER blocks
> > will be treated correctly even without the need for pfn_valid_within.
> > 
> > The patches are only boot tested on qemu-system-aarch64 so I'd really
> > appreciate memory stress tests on real hardware.
> 
> Did some preliminary memory stress tests on a guest with portions of memory
> marked as MEMBLOCK_NOMAP and did not find any obvious problem. But this might
> require some testing on real UEFI environment with firmware using MEMBLOCK_NOMAP
> memory to make sure that changing these struct pages to PageReserved() is safe.

I surely have no access for such machines :)
 
> > If this actually works we'll be one step closer to drop custom pfn_valid()
> > on arm64 altogether.
> 
> Right, planning to rework and respin the RFC originally sent last month.
> 
> https://patchwork.kernel.org/project/linux-mm/patch/1615174073-10520-1-git-send-email-anshuman.khandual@arm.com/

-- 
Sincerely yours,
Mike.
