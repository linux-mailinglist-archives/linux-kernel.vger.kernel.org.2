Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7CE043B978
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 20:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236900AbhJZS1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 14:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbhJZS07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 14:26:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D97C061745;
        Tue, 26 Oct 2021 11:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SKVPRp8QWsSk8ZgHZrLxDGZRN/Q7dRClGxVumXlu1ZY=; b=Teyeqh7Huw8bhKcMXPttBtp+gS
        837G3HJeGdTiA3TWiiaF5haLIYRjemb4QNAnOiBIPNDPNT5vdroNeVd+fPTz4hLqKjl95jU6kEKB7
        ul6MNswaA78pepRxTDWjuKNTvZzrheO0pIko4nPDsZf+s7MPQjmZO0ShuR5uapfV+GRO/2I7ZubdB
        PAIakkdwrraDDIveZyrpXtQF0M83ZrPeSeUsyBpSzM8qgcO6Js7UuodGGvmQ5XMeTHI6brXiuy8CR
        vAk0SPV5woUbBB9B3jD8PKy4MRNPgkxHwDj6Ieik55P5sKgh28LIo6VTmRFHqdpbaOos8XmjDYZ2X
        iLFOSolg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfR6p-00H4T7-BN; Tue, 26 Oct 2021 18:23:54 +0000
Date:   Tue, 26 Oct 2021 19:23:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-m68k@lists.linux-m68k.org, anshuman.khandual@arm.com,
        akpm@linux-foundation.org, william.kucharski@oracle.com,
        mike.kravetz@oracle.com, vbabka@suse.cz, geert@linux-m68k.org,
        schmitzmic@gmail.com, rostedt@goodmis.org, mingo@redhat.com,
        hannes@cmpxchg.org, guro@fb.com, songmuchun@bytedance.com,
        weixugc@google.com, gthelen@google.com
Subject: Re: [RFC 0/8] Hardening page _refcount
Message-ID: <YXhHq52jDrU61V4E@casper.infradead.org>
References: <20211026173822.502506-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026173822.502506-1-pasha.tatashin@soleen.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 05:38:14PM +0000, Pasha Tatashin wrote:
> It is hard to root cause _refcount problems, because they usually
> manifest after the damage has occurred.  Yet, they can lead to
> catastrophic failures such memory corruptions.
> 
> Improve debugability by adding more checks that ensure that
> page->_refcount never turns negative (i.e. double free does not
> happen, or free after freeze etc).
> 
> - Check for overflow and underflow right from the functions that
>   modify _refcount
> - Remove set_page_count(), so we do not unconditionally overwrite
>   _refcount with an unrestrained value
> - Trace return values in all functions that modify _refcount

I think this is overkill.  Won't we get exactly the same protection
by simply testing that page->_refcount == 0 in set_page_count()?
Anything which triggers that BUG_ON would already be buggy because
it can race with speculative gets.

