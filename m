Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBB039000E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 13:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbhEYLfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 07:35:06 -0400
Received: from outbound-smtp11.blacknight.com ([46.22.139.106]:33961 "EHLO
        outbound-smtp11.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231653AbhEYLeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 07:34:50 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp11.blacknight.com (Postfix) with ESMTPS id 018121C3D31
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 12:33:18 +0100 (IST)
Received: (qmail 9938 invoked from network); 25 May 2021 11:33:18 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 25 May 2021 11:33:18 -0000
Date:   Tue, 25 May 2021 12:33:17 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [RFC 02/26] mm, slub: allocate private object map for
 validate_slab_cache()
Message-ID: <20210525113317.GM30378@techsingularity.net>
References: <20210524233946.20352-1-vbabka@suse.cz>
 <20210524233946.20352-3-vbabka@suse.cz>
 <20210525101742.GK30378@techsingularity.net>
 <aad15d62-23c0-9eeb-d61f-a214eb57fb19@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <aad15d62-23c0-9eeb-d61f-a214eb57fb19@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 12:36:52PM +0200, Vlastimil Babka wrote:
> > Most callers of validate_slab_cache don't care about the return value
> > except when the validate sysfs file is written. Should a simply
> > informational message be displayed for -ENOMEM in case a writer to
> > validate fails and it's not obvious it was because of an allocation
> > failure?
> 
> he other callers are all in the effectively dead resiliency_test() code, which
> has meanwhile been replaced in mmotm by kunit tests meanwhile. But it's true
> those don't check the results either for now.
> 

Ok.

> > It's a fairly minor concern so whether you add a message or not
> 
> I think I'll rather fix up the tests. Or do you mean that -ENOMEM for a sysfs
> write is also not enough and there should be a dmesg explanation for that case?
> 

I mean the -ENOMEM for a sysfs write. While it's very unlikely, it might
would explain an unexpected write failure.

-- 
Mel Gorman
SUSE Labs
