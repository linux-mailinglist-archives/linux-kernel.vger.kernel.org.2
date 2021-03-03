Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B71532BEDD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386054AbhCCRqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383350AbhCCObR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:31:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667E6C061226
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 06:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZH1C/G3uhNYXYHLyRoi9Xr5MI5GoH8WMp548MeloCis=; b=Crw7M0Lc+wxp42QJC8iqj/AodZ
        RBoFd5Okwm21AmLXrF02/0bXsuEpYbm5LHfL2Hi+FVyTD2p0D9JOyaDVJ0fOOm6SLU9qXgUxtsEW4
        g7x8hiSCt6uoXKbxfPiNyYOWUFcBedpQLmiwOz5fWSwBzQUv8DbiIr0eYB+h3Cvr2y/fzPb7xVu7k
        hsu2FoIEa0DE4nBW2VNJX150lB3Rdd08e/af9NuwOB0m2FT+sLStRlngPoQMnh6E+qQuXrQmv9lP9
        MBPuAkOwWcIUVW89FiyXwFJU2zAh+tx95RRNjhPSU4A4XLXADV3NKgo3PKRisXjZnSvxEaJ+Gn/zf
        O1y/OVMA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lHSS4-002wEW-N2; Wed, 03 Mar 2021 14:26:14 +0000
Date:   Wed, 3 Mar 2021 14:26:12 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     Xunlei Pang <xlpang@linux.alibaba.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, Pekka Enberg <penberg@gmail.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v2 3/3] mm/slub: Use percpu partial free counter
Message-ID: <20210303142612.GC2723601@casper.infradead.org>
References: <1597061872-58724-1-git-send-email-xlpang@linux.alibaba.com>
 <1597061872-58724-4-git-send-email-xlpang@linux.alibaba.com>
 <alpine.DEB.2.22.394.2103021012010.860725@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2103021012010.860725@gentwo.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 10:14:53AM +0100, Christoph Lameter wrote:
> On Mon, 10 Aug 2020, Xunlei Pang wrote:
> > -	atomic_long_t partial_free_objs;
> > +	atomic_long_t __percpu *partial_free_objs;
> 
> A percpu counter is never atomic. Just use unsigned long and use this_cpu
> operations for this thing. That should cut down further on the overhead.

What about allocations from interrupt context?  Should this be a local_t
instead?

