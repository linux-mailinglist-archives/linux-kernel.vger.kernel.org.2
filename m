Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C7B3B91F1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 15:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236626AbhGANDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 09:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236630AbhGANCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 09:02:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F63CC0611C1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 05:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QRaGlVqQxKh9WQJkeW4dawAj001OxCCf88GK3Bqe4I4=; b=hxUEbXmA11V3cAoBt8+TuCIy7Q
        bQjoQGrS0GOkh7nTMlsWDCxuJXu4BdK7DOAj/0Jh3U/894aT3Ih19pOtVbc+jntu5/v4yXb6zN6o8
        uVtOiV6tqmoOGJKoMR2agcXOclbxGPV5qzZy7eYl8o2gkSXl6VQ6kOgEgeEIXd27cSTeJy6e2MGop
        ltWtp8p82SmIwM4zjt5jjDelEJODajk3PheJJ2/9VsBLhpePhpn0VkPvtClESodvJit23Ntl79ca5
        JmAqO/ovwDPQsO7goZFYMN9ZOWyF2JO3uu+OdZ/Eqk42H5rbM2Gd2QlnFj8V3d0j1WJ0NADcRama0
        O0WQsWOg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lywG1-006ZTc-7r; Thu, 01 Jul 2021 12:57:33 +0000
Date:   Thu, 1 Jul 2021 13:57:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm/thp: Make ALLOC_SPLIT_PTLOCKS dependent on
 USE_SPLIT_PTE_PTLOCKS
Message-ID: <YN27uc64s/yllfQR@casper.infradead.org>
References: <1621409586-5555-1-git-send-email-anshuman.khandual@arm.com>
 <YKZFRPqg4wKjOdVg@casper.infradead.org>
 <9d1ce685-e0fd-febd-5ff2-179f7fa6e3fa@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d1ce685-e0fd-febd-5ff2-179f7fa6e3fa@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2021 at 10:51:27AM +0530, Anshuman Khandual wrote:
> 
> 
> On 5/20/21 4:47 PM, Matthew Wilcox wrote:
> > On Wed, May 19, 2021 at 01:03:06PM +0530, Anshuman Khandual wrote:
> >> Split ptlocks need not be defined and allocated unless they are being used.
> >> ALLOC_SPLIT_PTLOCKS is inherently dependent on USE_SPLIT_PTE_PTLOCKS. This
> >> just makes it explicit and clear. While here drop the spinlock_t element
> >> from the struct page when USE_SPLIT_PTE_PTLOCKS is not enabled.
> > 
> > I didn't spot this email yesterday.  I'm not a fan.  Isn't struct page
> > already complicated enough without adding another ifdef to it?  Surely
> > there's a better way than this.
> 
> This discussion thread just got dropped off the radar, sorry about it.
> None of the spinlock_t elements are required unless split ptlocks are
> in use. I understand your concern regarding yet another #ifdef in the
> struct page definition. But this change is simple and minimal. Do you
> have any other particular alternative in mind which I could explore ?

Do nothing?  I don't understand what problem you're trying to solve.
