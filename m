Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0863F9D52
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 19:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236497AbhH0RLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 13:11:34 -0400
Received: from verein.lst.de ([213.95.11.211]:34663 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234297AbhH0RLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 13:11:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0EE4967373; Fri, 27 Aug 2021 19:10:42 +0200 (CEST)
Date:   Fri, 27 Aug 2021 19:10:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [GIT PULL] arm64 fix for 5.14
Message-ID: <20210827171041.GA28149@lst.de>
References: <20210826131747.GE26318@willie-the-truck> <CAHk-=wi8Wxazuq+E4_V0GG4eda0rNpZi76AYWQe7xfPZAAexAQ@mail.gmail.com> <20210827074041.GA24309@lst.de> <CAHk-=wjd28sN9khO=1j6zmBk+2n4_e+SY1URjW9hzsHSAZU+7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjd28sN9khO=1j6zmBk+2n4_e+SY1URjW9hzsHSAZU+7Q@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 10:03:29AM -0700, Linus Torvalds wrote:
> The ARM code actually uses that complex pfn_to_section_nr() and
> memblock_is_memory() etc. That seems a bit of an overkill, since the
> memblock code should have translated all that into being reserved.
> 
> But again, I don't actually know exactly what triggered the issue on
> ARM, so the above is just my "this seems to be a more proper check"
> suggestion.

They CCed me on their earlier discussion, but I did not catch up on it
until you responded to the pull request  If I understood it correct it
was about a platform device mapping a MMIO region (like a PCI bar),
but something about section alignment cause pfn_valid to mistrigger.
