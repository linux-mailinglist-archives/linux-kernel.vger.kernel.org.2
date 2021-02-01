Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B990E30A968
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 15:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhBAONO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 09:13:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:52128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231695AbhBAONN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:13:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AC6364DE1;
        Mon,  1 Feb 2021 14:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612188752;
        bh=bhH1EtxkV570baZYIdO2ZQx3Qz4p1Kp0KAuVJO2Tg0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qz1IgX5S9ddahNwh/RMFVP9g2eA95R5fUDDf16jlgOlI3MsVoO4VA9seW8wX2S4KD
         MpLisyTUAc5Rg8lUCWrlafEFJ8DaADH5isQBfqXsOI2H7T6mMxvOwaAl14Kj72QPjt
         ktWG6uBPY/s+Zyx8MvJsgEkQK9APbNaEfmQCOisY1ZVDqFJAxuN2w8/cgl6+Kgn3+U
         v37PE2uqaT5tvwi7as8dS9lxxbVN5+bSsiLEQpmYuEYpS9jj16CqSzMP0Zv7DMJmnt
         CT4ZnJsv3du9axuLoOTVpKogG/QdG5AEKZ5nx/0UbPVHB6lbOJScOmlS/omikR7/Lx
         Lcdj/fDYJ3Qxg==
Date:   Mon, 1 Feb 2021 16:12:22 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v3 2/2] mm: fix initialization of struct page for holes
 in memory layout
Message-ID: <20210201141222.GH242749@kernel.org>
References: <20210111194017.22696-1-rppt@kernel.org>
 <20210111194017.22696-3-rppt@kernel.org>
 <fe30ad3e-fab8-f9c6-b0ad-0d1d1a8e2807@redhat.com>
 <20210201093958.GD28734@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201093958.GD28734@MiWiFi-R3L-srv>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 05:39:58PM +0800, Baoquan He wrote:
> On 02/01/21 at 10:14am, David Hildenbrand wrote:
> > On 11.01.21 20:40, Mike Rapoport wrote:
> > > +
> > > +static void __init init_unavailable_mem(void)
> > > +{
> > > +	int zone;
> > > +
> > > +	for (zone = 0; zone < ZONE_MOVABLE; zone++)
> > > +		init_zone_unavailable_mem(zone);
> > 
> > Why < ZONE_MOVABLE?
> > 
> > I remember we can have memory holes inside the movable zone when messing
> > with "movablecore" cmdline parameter.
> 
> Maybe because we haven't initialized MOABLE zone info at this time.

We already have zone_movable_pfn initialized at this point. 
So if there is a possibility for holes in the movable zone, we should take
care of it.

-- 
Sincerely yours,
Mike.
