Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611AC3EF2E7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 21:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbhHQTyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 15:54:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229466AbhHQTyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 15:54:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 820736023D;
        Tue, 17 Aug 2021 19:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1629230006;
        bh=9GEGh06hgVZ4wI/Kk+52EPsOEBhM9iF9HKLdjFqgxfg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CS//o0DK+yKr6+6YKszPb0vm5D7X9Hj5mNaX71mkAZyA1XVhoVXklXMQZPvHuKMJ9
         pWxenJ0tAOxyq0/kkJjLkYoUsZytFWCBHRgb3feDF8Q6y1fxZ5j0QQ6qU5JzLqT6AB
         PWCLHKPFisgeK7tvPjP318XW6sJUlLre4zYmTchw=
Date:   Tue, 17 Aug 2021 12:53:25 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v4 35/35] mm, slub: convert kmem_cpu_slab protection to
 local_lock
Message-Id: <20210817125325.d0ed45d664596d1e80a591d7@linux-foundation.org>
In-Reply-To: <e907c2b6-6df1-8038-8c6c-aa9c1fd11259@suse.cz>
References: <20210805152000.12817-1-vbabka@suse.cz>
        <20210805152000.12817-36-vbabka@suse.cz>
        <e907c2b6-6df1-8038-8c6c-aa9c1fd11259@suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Aug 2021 12:14:58 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:

> Another fixup. Is it too many and should we replace it all with a v5?

Maybe do a full resend when things have settled down and I can at least
check that we match.

What's your confidence level for a 5.15-rc1 merge?  It isn't terribly
well reviewed?
