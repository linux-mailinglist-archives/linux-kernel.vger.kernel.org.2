Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5A436074C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhDOKjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:39:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:52398 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbhDOKjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:39:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AEB95AE20;
        Thu, 15 Apr 2021 10:38:45 +0000 (UTC)
Date:   Thu, 15 Apr 2021 12:38:43 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/8] Allocate memmap from hotadded memory (per device)
Message-ID: <YHgXs1uCmjkb72uR@localhost.localdomain>
References: <20210408121804.10440-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408121804.10440-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 02:17:56PM +0200, Oscar Salvador wrote:
> Hi,
> 
> I decided to send another version with the fixups included as it seemed a bit
> awkward otherwise. It should ease the review.
> Sorry for the spam.

Gentle ping :-) 

hint: patch#4 is the one that needs some looking

-- 
Oscar Salvador
SUSE L3
