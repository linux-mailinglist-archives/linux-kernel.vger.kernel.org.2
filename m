Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81B530FB5F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 19:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238978AbhBDS0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 13:26:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:43752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239017AbhBDSYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 13:24:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C14564F45;
        Thu,  4 Feb 2021 18:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612463051;
        bh=dn4Y26xu9vyOVgTk8Xpb97T9X87MClTDWTRp/3WldJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uwitVKbjRGW6MhrPvbGIAjt5Wrs616/BcrBjh6KRmE00R3ZOvoqrjrliGcQ6njHrC
         vj9ZIHQX9AQv0Yk/TQh0joJrkcWCLRkfs3vc3fi2G4gZZCCCqUSYIHMNigLJhcQoF/
         TMcWQv6Me0kyb9AHBKXMLyJmYcbgrMm/7hMwYndMdIG4lQpBT8MMwQbUXg8CFRjQEa
         xld8kqfkXg8cmyd4jEwfdexlmKZ5XoHRgywfnDc4UbrJEsnBltlqHInA+tNGauoXgT
         6sxqBBtVylwFvh+Em/z/lkKk1TDJlulCpsCDOSZ/a4wiXww5NkMABkgNVxzkfoa+w0
         VQ84Fng81mg9Q==
Date:   Thu, 4 Feb 2021 18:24:05 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, android-kvm@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>
Subject: Re: [RFC PATCH v2 12/26] KVM: arm64: Introduce a Hyp buddy page
 allocator
Message-ID: <20210204182404.GB21526@willie-the-truck>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-13-qperret@google.com>
 <20210202181307.GA17311@willie-the-truck>
 <YBrsep4xK1F4YRWb@google.com>
 <20210204143106.GA20792@willie-the-truck>
 <YBw6uInyY+AlE7D3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBw6uInyY+AlE7D3@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 06:19:36PM +0000, Quentin Perret wrote:
> On Thursday 04 Feb 2021 at 14:31:08 (+0000), Will Deacon wrote:
> > Just feels a bit backwards having __find_buddy() take an order parameter,
> > yet then return a page of the wrong order! __hyp_extract_page() always
> > passes the p->order as the order,
> 
> Gotcha, so maybe this is just a naming problem. __find_buddy() is simply
> a helper to lookup/index the vmemmap, but it's perfectly possible that
> the 'destination' page that is being indexed has already been allocated,
> and split up multiple time (and so at a different order), etc ... And
> that is the caller's job to decide.
> 
> How about __lookup_potential_buddy() ? Any suggestion?

Hey, my job here is to waffle incoherently and hope that you find bugs in
your own code. Now you want me to _name_ something! Jeez...

Ok, how about __find_buddy() does what it does today but doesn't take an
order argument, whereas __find_buddy_of_order() takes the order argument
and checks the page order before returning?

Will
