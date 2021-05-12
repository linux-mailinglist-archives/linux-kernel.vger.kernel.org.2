Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43FF37BC1E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 13:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhELL6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 07:58:48 -0400
Received: from verein.lst.de ([213.95.11.211]:40985 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230037AbhELL6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 07:58:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DD22967373; Wed, 12 May 2021 13:57:36 +0200 (CEST)
Date:   Wed, 12 May 2021 13:57:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        intel-gfx@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org, hch@lst.de
Subject: Re: 5.13 i915/PAT regression on Brasswell, adding nopat to the
 kernel commandline worksaround this
Message-ID: <20210512115736.GA10444@lst.de>
References: <b6b61cf0-5874-f4c0-1fcc-4b3848451c31@redhat.com> <YJu4tzXmCJbKp7Fm@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJu4tzXmCJbKp7Fm@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 01:15:03PM +0200, Peter Zijlstra wrote:
> IIRC it's because of 74ffa5a3e685 ("mm: add remap_pfn_range_notrack"),
> which added a sanity check to make sure expectations were met. It turns
> out they were not.
> 
> The bug is not new, the warning is. AFAIK the i915 team is aware, but
> other than that I've not followed.


The actual culprit is b12d691ea5e0 ("i915: fix remap_io_sg to verify the
pgprot"), but otherwise agreed.  Someone the i915 maintainers all seem
to be on vacation as the previous report did not manage to trigger any
kind of reply.

