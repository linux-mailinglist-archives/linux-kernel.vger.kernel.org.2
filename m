Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B7A35944B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 07:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbhDIFGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 01:06:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:50592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233233AbhDIFFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 01:05:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40B3F61179;
        Fri,  9 Apr 2021 05:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1617944719;
        bh=Vbh86dNOli+jsV5mE5RUuwS5Kns4P84iRq+prUTBXhI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SybUq4U1TDTlLRMlV9u1u5X9RZPGCReoj+Me+kj2NJmrg71Lu9F89w2wiYQxYYgfu
         lHcESZzJJUoH+UHbwc2qiM3nPc3hu3DTtBh1h908rSMWoJrj/AOAeIpJJEfySAPwpt
         GP7ZSwZl9QHsBRCrs9mZfNFCoO9Iy9u6ZyMtF5Q0=
Date:   Thu, 8 Apr 2021 22:05:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/8] mm,memory_hotplug: Allocate memmap from the
 added memory range
Message-Id: <20210408220518.ea64131255e1b5732a05e57a@linux-foundation.org>
In-Reply-To: <89dcbcd749f1993303749f2c46220144@suse.de>
References: <20210406111115.8953-1-osalvador@suse.de>
        <20210406111115.8953-5-osalvador@suse.de>
        <YGzEe1XH0kGgwsxp@localhost.localdomain>
        <89dcbcd749f1993303749f2c46220144@suse.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Apr 2021 22:38:37 +0200 Oscar Salvador <osalvador@suse.de> wrote:

> On 2021-04-06 22:28, Oscar Salvador wrote:
> > Heh, it seems I spaced out today.
> > 
> > We need a few things on top:
> > 
> 

Yes please.
