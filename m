Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F35326B73
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 04:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhB0Dmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 22:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhB0Dmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 22:42:39 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7B8C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 19:41:59 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id f3so11902253oiw.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 19:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=keonSni5KzT7UNGp5t1reqV6Ec+MJb82Tsofpm8Ddmo=;
        b=o/Oi/OZEBr1wYPbH//Ig77KhLPp5QbU8WPaaEyV1jEXkPBLklDV9wudeAACSsML3VW
         NL1TUtXJGBQw05mVwdpt306XdlVoj8R3WOJo3W0X3thuq6F2PiLN2UpgzAurfFUFp0AF
         bepBCcfur/l7TOwB9XXEIJeYNj5/ogzm6asRR1NJ7q2a1UerZDIU9BmDxyqXztUUfF8/
         LwN0pPFcRIP+L70MVy2VgyPtxNOCqAcx0Ubl+U2qmxeGwh7yaV6obb6p6bM39424pCxg
         C+ayptOfbpUaQKYldAKFRcfCEmdfpbQVv0x8NQMB2A+sLHxlEZtT2vKnLgfUaaSst9WM
         rPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=keonSni5KzT7UNGp5t1reqV6Ec+MJb82Tsofpm8Ddmo=;
        b=cxBZ5KwJpmnV9M/besOpAo8/2yZKV6IUOJg7/yGSzIFaPr80PDMSdgXSZ4M5lZFDrq
         4CMrajuzHWq6aGCPbsJiZVcZPveAsv0VhyLgWQTLETqoOwoUUWzaUzwt/fiYoCJE6zqH
         kReT0dlWvoo2W5Do5CpGoJJ74sAiUDa60PiQJsrLbsBOHoa0jOh17kvQAPjZEjB1NC+s
         QxhsIpcY3vUZESJ/26nAe/Da/MLj72jJrDVxSfTO4A+t+xMHdytirPYEm7rHLxYYh+jA
         72wSKHCb7tJoFA9/HbXKBrps78JsIqjucHA9RzxwXzd56WDR6RgtDq5vTfoBIhpnSpx+
         mHIA==
X-Gm-Message-State: AOAM531/mXaEkx1vZYQVxJBgINtyqDcPBul3Ia4tJpufLeO5yuYnCAcb
        63ahNC1HvBEArJai9cla2McyAg==
X-Google-Smtp-Source: ABdhPJyHFg7qCfdEzJ9RXDQa8jVcrInzF0XjOIbQd5MVxFV918Cn9MslLs4GiQbMuP0Pb122XycLLQ==
X-Received: by 2002:aca:b655:: with SMTP id g82mr4457116oif.91.1614397318187;
        Fri, 26 Feb 2021 19:41:58 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id u190sm513434oif.40.2021.02.26.19.41.56
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 26 Feb 2021 19:41:57 -0800 (PST)
Date:   Fri, 26 Feb 2021 19:41:40 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Palmer Dabbelt <palmer@dabbelt.com>
cc:     hughd@google.com, akpm@linux-foundation.org, atishp@atishpatra.org,
        peterz@infradead.org, srikar@linux.vnet.ibm.com,
        valentin.schneider@arm.com, vbabka@suse.cz, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@android.com, kirill.shutemov@linux.intel.com
Subject: Re: [PATCH 1/2] mm: Guard a use of node_reclaim_distance with
 CONFIFG_NUMA
In-Reply-To: <mhng-379d20e4-35c6-4349-b067-f2ff851eca86@penguin>
Message-ID: <alpine.LSU.2.11.2102261918250.15774@eggly.anvils>
References: <mhng-379d20e4-35c6-4349-b067-f2ff851eca86@penguin>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Feb 2021, Palmer Dabbelt wrote:
> On Fri, 26 Feb 2021 17:31:40 PST (-0800), hughd@google.com wrote:
> > On Fri, 26 Feb 2021, Andrew Morton wrote:
> > > On Fri, 26 Feb 2021 12:17:20 -0800 Palmer Dabbelt <palmer@dabbelt.com>
> > > wrote:
> > > > From: Palmer Dabbelt <palmerdabbelt@google.com>
> > > >
> > > > This is only useful under CONFIG_NUMA.  IIUC skipping the check is the
> > > > right thing to do here, as without CONFIG_NUMA there will never be any
> > > > large node distances on non-NUMA systems.
> > > >
> > > > I expected this to manifest as a link failure under (!CONFIG_NUMA &&
> > > > CONFIG_TRANSPARENT_HUGE_PAGES), but I'm not actually seeing that.  I
> > > > think the reference is just getting pruned before it's checked, but I
> > > > didn't get that from reading the code so I'm worried I'm missing
> > > > something.
> > > >
> > > > Either way, this is necessary to guard the definition of
> > > > node_reclaim_distance with CONFIG_NUMA.
> > > >
> > > > Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
> > > > ---
> > > >  mm/khugepaged.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > > index a7d6cb912b05..b1bf191c3a54 100644
> > > > --- a/mm/khugepaged.c
> > > > +++ b/mm/khugepaged.c
> > > > @@ -819,8 +819,10 @@ static bool khugepaged_scan_abort(int nid)
> > > >  	for (i = 0; i < MAX_NUMNODES; i++) {
> > > >  		if (!khugepaged_node_load[i])
> > > >  			continue;
> > > > +#ifdef CONFIG_NUMA
> > > >  		if (node_distance(nid, i) > node_reclaim_distance)
> > > >  			return true;
> > > > +#endif
> > > >  	}
> > > >  	return false;
> > > >  }
> > > 
> > > This makes the entire loop a no-op.  Perhaps Kirill can help take a
> > > look at removing unnecessary code in khugepaged.c when CONFIG_NUMA=n?
> > 
> > First lines of khugepaged_scan_abort() say
> > 	if (!node_reclaim_mode)
> > 		return false;
> > 
> > And include/linux/swap.h says
> > #ifdef CONFIG_NUMA
> > extern int node_reclaim_mode;
> > extern int sysctl_min_unmapped_ratio;
> > extern int sysctl_min_slab_ratio;
> > #else
> > #define node_reclaim_mode 0
> > #endif
> > 
> > So, no need for an #ifdef CONFIG_NUMA inside khugepaged_scan_abort().
> 
> Ah, thanks, I hadn't seen that.  That certainly explains the lack of an
> undefined reference.
> 
> That said: do we generally rely on DCE to prune references to undefined
> symbols?  This particular one seems like it'd get reliably deleted, but it
> seems like a fragile thing to do in general.  This kind of stuff would
> certainly make some code easier to write, though.

Yes, the kernel build very much depends on the optimizer eliminating
dead code, in many many places.  We do prefer to keep the #ifdefs to
the header files as much as possible.

> 
> I don't really care all that much, though, as I was just sending this along
> due to some build failure report from a user that I couldn't reproduce.  It
> looked like they had some out-of-tree stuff, so in this case I'm fine on
> fixing this being their problem.

I didn't see your 2/2 at the time; but wouldn't be surprised if that
needs 1/2, to avoid an error on undeclared node_reclaim_distance before
the optimizer comes into play.  If so, best just to drop 2/2 too.

Hugh
