Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291D4391430
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 11:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbhEZJ6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 05:58:17 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47806 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbhEZJ6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 05:58:17 -0400
X-Greylist: delayed 555 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 May 2021 05:58:16 EDT
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by smtp-out2.suse.de (Postfix) with ESMTP id 24CB71FD29;
        Wed, 26 May 2021 09:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622022450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1I4Fgx3Wsu9b4i+qkfJ6NLcukv/nrkr5xfQ4pMZYpcM=;
        b=jPRSzya/SZPLGu40Y/Pn4aMJM6uQImJAsZ3cTRzh8tRnwE3Pw6drInbDphgqg4F+8ghy+3
        Fe7uk+2A3BTtdCPZcWFLHs7WBHTLqQQbC1cqz1z7jxop481vQQSKiWu2cVon4urJXKjLV2
        5DNss7gehP8SE3kkV0bVkIdzrgmKqfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622022450;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1I4Fgx3Wsu9b4i+qkfJ6NLcukv/nrkr5xfQ4pMZYpcM=;
        b=HdbQ0wDwwNSJckYD2D3ngt+tcvXWBB8NmdyXbdK9MySHHUQREbZ4xSMjpwuilsBpIu/mZg
        V61MUy/knevzRCAw==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id 60ADD11A98;
        Wed, 26 May 2021 09:47:29 +0000 (UTC)
Date:   Wed, 26 May 2021 11:47:27 +0200
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
Subject: Re: [PATCH v5 1/3] mm/memory-failure: Use a mutex to avoid
 memory_failure() races
Message-ID: <20210526094722.GA1656@linux>
References: <20210521030156.2612074-1-nao.horiguchi@gmail.com>
 <20210521030156.2612074-2-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521030156.2612074-2-nao.horiguchi@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 12:01:54PM +0900, Naoya Horiguchi wrote:
> From: Tony Luck <tony.luck@intel.com>
> 
> There can be races when multiple CPUs consume poison from the same
> page. The first into memory_failure() atomically sets the HWPoison
> page flag and begins hunting for tasks that map this page. Eventually
> it invalidates those mappings and may send a SIGBUS to the affected
> tasks.
> 
> But while all that work is going on, other CPUs see a "success"
> return code from memory_failure() and so they believe the error
> has been handled and continue executing.
> 
> Fix by wrapping most of the internal parts of memory_failure() in
> a mutex.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Reviewed-by: Borislav Petkov <bp@suse.de>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE L3
