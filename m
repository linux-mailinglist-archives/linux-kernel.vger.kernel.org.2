Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C28C39708C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 11:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbhFAJtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 05:49:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47094 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbhFAJs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 05:48:56 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A3A4121928;
        Tue,  1 Jun 2021 09:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622540834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9G3Kpyx+CwhO/99NFfmbRZHrvD5QiFT32bQzKFAn7/Q=;
        b=GvuEo/HOq76opQ8mc4wpz1Gm/ff1RvdFOyFKZY6AuVdL3EJuyOJmt4yLa4EJeL3USQGsnx
        9CyqtlrdlltWBFJoKbOLuFcXrX6KszlWbDapfZRV9Zmi94n3TVjx3S9qNWIuyVQ5OZXcgi
        XMpuqWbv+kiIBs+1XcmqxwPrRhkw48s=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 53E7FA3B84;
        Tue,  1 Jun 2021 09:47:14 +0000 (UTC)
Date:   Tue, 1 Jun 2021 11:47:13 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm,memory_hotplug: Drop unneeded locking
Message-ID: <YLYCIZ5XNXGoE95p@dhcp22.suse.cz>
References: <20210531093958.15021-1-osalvador@suse.de>
 <679d311a-8ad4-bb53-18f0-11190a2bf1b5@arm.com>
 <20210601074737.GA30768@linux>
 <f655ced2-281e-33ee-e1ea-89a0e13fc7a3@redhat.com>
 <20210601081250.GA32364@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601081250.GA32364@linux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 01-06-21 10:12:54, Oscar Salvador wrote:
> On Tue, Jun 01, 2021 at 10:02:54AM +0200, David Hildenbrand wrote:
> > If there is no writer anymore, why do we have to protect readers?
> 
> Yeah, you are right. 
> Let me prepare a v2 as this is getting too sloppy.

While you are touching this and want to drill all the way down then it
would be reasonable to drop pgdat resize locks as well.
It is only used in the early boot code and we have one executing thread
context per numa node during the deferred initialization. I haven't
checked all potential side effects the lock might have but it sounds
like there is quite some clean up potential over there.

-- 
Michal Hocko
SUSE Labs
