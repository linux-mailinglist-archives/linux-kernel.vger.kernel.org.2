Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499F23F5FD7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 16:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237714AbhHXOGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 10:06:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237669AbhHXOGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:06:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C14161212;
        Tue, 24 Aug 2021 14:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629813955;
        bh=t4e2cm3gb1n1OucC5GO6DcA/X+Kew8TVxJ8GdOTEUtM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C4e0oBi8AN2a8ghIAD0nL7gCg90aJHiLdwld94QkvRhotWfHuCUqu2IfNeXYM46ya
         uDc5AZQQ5mhtSO0S9QX43NSGfK7dLgdcu9QaNmHA8kWrSDNS1aGATh1DL5YfFtkiNX
         GuMiTO9IQhQDDFapRHgMyOhd4Q52wmODZ+E76fm5UtqFz3RlsXhkNnge6Uikz9BIFv
         0TamGOIWOU44lRXUdICbgm7hKXmzXOy6/A1nvLL6kHEuZbvMre0yCo+pcgaw/mDdtX
         xW/s1TeMoAaNXIBtIAmF6Einl83plBj+ICSmO4pLQKYbdQA7UlpqVOBKIvUmK8lPTQ
         qOOxokX58P9Rw==
Date:   Tue, 24 Aug 2021 17:05:50 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jordy Zomer <jordy@pwning.systems>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        James Bottomley <jejb@linux.ibm.com>
Subject: Re: [PATCH] mm/secretmem: use refcount_t instead of atomic_t
Message-ID: <YST8vi6J1NlCdirU@kernel.org>
References: <20210820043339.2151352-1-jordy@pwning.systems>
 <202108192227.8BE02F1C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202108192227.8BE02F1C@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 10:33:49PM -0700, Kees Cook wrote:
> On Fri, Aug 20, 2021 at 06:33:38AM +0200, Jordy Zomer wrote:
> > When a secret memory region is active, memfd_secret disables
> > hibernation. One of the goals is to keep the secret data from being
> > written to persistent-storage.
> > 
> > It accomplishes this by maintaining a reference count to
> > `secretmem_users`. Once this reference is held your system can not be
> > hibernated due to the check in `hibernation_available()`. However,
> > because `secretmem_users` is of type `atomic_t`, reference counter
> > overflows are possible.
> 
> It's an unlikely condition to hit given max-open-fds, etc, but there's
> no reason to leave this weakness. Changing this to refcount_t is easy
> and better than using atomic_t.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> > As you can see there's an `atomic_inc` for each `memfd` that is opened
> > in the `memfd_secret` syscall. If a local attacker succeeds to open 2^32
> > memfd's, the counter will wrap around to 0. This implies that you may
> > hibernate again, even though there are still regions of this secret
> > memory, thereby bypassing the security check.
> 
> IMO, this hibernation check is also buggy, since it looks to be
> vulnerable to ToCToU: processes aren't frozen when
> hibernation_available() checks secretmem_users(), so a process could add
> one and fill it before the process freezer stops it.
> 
> And of course, there's still the ptrace hole[1], which is think is quite
> serious as it renders the entire defense moot.

I thought about what can be done here and could not come up with anything
better that prevent PTRACE on a process with secretmem, but this seems to
me too much from usability vs security POV.

Protecting against root is always hard and secretmem anyway does not
provide 100% guarantee by itself but rather makes an accidental data leak
or non-target attack much harder.

To be effective it also presumes that other hardening features are turned
on by the system administrator on production systems, so it's not
unrealistic to rely on ptrace being disabled.

-- 
Sincerely yours,
Mike.
