Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4983226A0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 08:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbhBWHth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 02:49:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:59634 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230248AbhBWHtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 02:49:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BF22AACBF;
        Tue, 23 Feb 2021 07:48:39 +0000 (UTC)
Date:   Tue, 23 Feb 2021 08:48:37 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, VlastimilBabkavbabka@suse.cz,
        pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v2 0/7] Allocate memmap from hotadded memory (per device)
Message-ID: <20210223074832.GA32687@linux>
References: <20210209133854.17399-1-osalvador@suse.de>
 <20210217101851.GA28996@linux>
 <20210222111506.GA23651@linux>
 <8b4670fa-583a-b68b-a65f-7eeca184afd3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b4670fa-583a-b68b-a65f-7eeca184afd3@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 12:28:22PM +0100, David Hildenbrand wrote:
> -EBUSY, will try having a look this week!

sure, thanks for the effort David ;-)

-- 
Oscar Salvador
SUSE L3
