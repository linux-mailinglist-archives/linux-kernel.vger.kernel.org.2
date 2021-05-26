Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043533914B7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 12:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbhEZKUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 06:20:09 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47950 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbhEZKUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 06:20:07 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by smtp-out2.suse.de (Postfix) with ESMTP id 89B511FD29;
        Wed, 26 May 2021 10:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622024314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/lF189cKjUcQuiw1WtquXCttyNOdFaFooRMhSIsE7mw=;
        b=cPGlOP7BjhX2917pIK6b+vg8P+fJ+YW7sI2Zmj7f1OOQh5zid0y1nmRz0Dr9H2qH1/Pr54
        GLzZ0LyQDgHjGH7c6/venibuhxh4N5GNq7F/ajXZbqQtAKSY56EX1iW42E4pizN0DjxK4L
        j5o9OrTEjs5zr5ZqyipdN6nQVW7mY68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622024314;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/lF189cKjUcQuiw1WtquXCttyNOdFaFooRMhSIsE7mw=;
        b=rTuVz3GUI42dX4hHZEFA3ALkn6iv7e2NRjQf7DUjj5yIetVid5LfyVP00FOqQSnS+2yu7n
        iWLIGM4Z1OSkkcCA==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id ECF6B11A98;
        Wed, 26 May 2021 10:18:33 +0000 (UTC)
Date:   Wed, 26 May 2021 12:18:32 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc:     linux-mm@kvack.org, Tony Luck <tony.luck@intel.com>,
        Aili Yao <yaoaili@kingsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Jue Wang <juew@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] mm,hwpoison: Return -EHWPOISON to denote that the
 page has already been poisoned
Message-ID: <20210526101832.GB1656@linux>
References: <20210521030156.2612074-1-nao.horiguchi@gmail.com>
 <20210521030156.2612074-3-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521030156.2612074-3-nao.horiguchi@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 12:01:55PM +0900, Naoya Horiguchi wrote:
> From: Aili Yao <yaoaili@kingsoft.com>
> 
> When memory_failure() is called with MF_ACTION_REQUIRED on the
> page that has already been hwpoisoned, memory_failure() could fail
> to send SIGBUS to the affected process, which results in infinite
> loop of MCEs.
> 
> Currently memory_failure() returns 0 if it's called for already
> hwpoisoned page, then the caller, kill_me_maybe(), could return
> without sending SIGBUS to current process.  An action required MCE
> is raised when the current process accesses to the broken memory,
> so no SIGBUS means that the current process continues to run and
> access to the error page again soon, so running into MCE loop.
> 
> This issue can arise for example in the following scenarios:
> 
>   - Two or more threads access to the poisoned page concurrently.
>     If local MCE is enabled, MCE handler independently handles the
>     MCE events.  So there's a race among MCE events, and the
>     second or latter threads fall into the situation in question.
> 
>   - If there was a precedent memory error event and memory_failure()
>     for the event failed to unmap the error page for some reason,
>     the subsequent memory access to the error page triggers the
>     MCE loop situation.
> 
> To fix the issue, make memory_failure() return an error code when the
> error page has already been hwpoisoned.  This allows memory error
> handler to control how it sends signals to userspace.  And make sure
> that any process touching a hwpoisoned page should get a SIGBUS even
> in "already hwpoisoned" path of memory_failure() as is done in page
> fault path.
> 
> Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
