Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B00323593
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 03:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhBXCJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 21:09:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:54116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230019AbhBXCJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 21:09:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7204064DB1;
        Wed, 24 Feb 2021 02:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1614132501;
        bh=J/idOd4U/xdQvIOqcnv1+MFAlMoe/TRWb+F3T2Y+rac=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pjG3AvG0v+uBR79HlkjNSzvRcHmWYvx6gyp+uCHLcXpV/eeX+VczpDu9UyRSs8vVd
         eyK3bv8ShzCLz2ISimXghxnXwJ1MZbrS6/kRwWkBQyO0T232FS+05HaKw3DsOoN93O
         v298QBh/QdylM+2WPEZ7dOlewXZS8m9qFziUlPm4=
Date:   Tue, 23 Feb 2021 18:08:20 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [RFC] linux-next panic in hugepage_subpool_put_pages()
Message-Id: <20210223180820.ee39f1544f2630d0eecf3a57@linux-foundation.org>
In-Reply-To: <44d50df7-9940-6a37-179f-ee2aa6cf34b9@oracle.com>
References: <20210223155740.553df3ee@thinkpad>
        <3c536d3c-a180-301b-5cb7-c737a178a9d7@oracle.com>
        <20210223155806.8e2284682df5d08ce9b3da68@linux-foundation.org>
        <44d50df7-9940-6a37-179f-ee2aa6cf34b9@oracle.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Feb 2021 17:29:48 -0800 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> >> I will do a bit more verification and put together a patch (it should
> >> be simple).
> > 
> > There's also Michel's documentation request:
> > https://lkml.kernel.org/r/20210127102645.GH827@dhcp22.suse.cz
> > 
> 
> Thanks Andrew, I forgot about that.
> 
> It looks like the patch which added synchronization documentation requested
> by Michal may not have be picked up.
> https://lore.kernel.org/linux-mm/9183032f-3d77-d9e3-9cc8-fbaf3e892022@oracle.com/

OK, I grabbed that.

> If you still need to add that patch, I could redo and add the page[1]->private
> documentation request mentioned here.  Just let me know what is the easiest for
> you.

Please send along an additional patch?
