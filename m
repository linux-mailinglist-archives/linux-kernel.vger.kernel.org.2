Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20CC1326B3F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 04:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhB0DG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 22:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhB0DGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 22:06:25 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FBBC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 19:05:44 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id 17so6280220pli.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 19:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=CErTn4OA/0ZhE2vq/HB1zN/NVtPl48RSykIsKZFvFZQ=;
        b=z8KY6PvLZ5e2O8z3iDTzzfY7WlI/SjutcIjnorrbmHPIdXe5XqnJPxjg7nJcRCsNsW
         tGtmMpfr3Yvid44eWaBicqP8k7/ZgZ3BMMmWLsyBPn+OYkRlmxAOm8NWflTJWAEapWvH
         z8OKrar/3yErQxPQGu3342K3kmhrlWpok95Awh1z7WDi6n4FCC6/giCkF0HlvrUG3QPs
         3N0Id0+WPrfvky+CAbEwIgHWJg59M5JqbpONJihiCvh5gHB4Xpl9m4CFjWw2E4f5IXPS
         uT74A/oP605z378Qt70h7SmfR2NC35CAZ3tP/z/sdmaJ/aX8lDx7n62EtLefWiKhiMvW
         q7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=CErTn4OA/0ZhE2vq/HB1zN/NVtPl48RSykIsKZFvFZQ=;
        b=ltkfErTBZgMBDUka/rMz01WKa46nkr6+uQght0Cqp8ASGxpcbxD4tm4kKXV/RRRBk7
         4bMlHkcEoPYgT1RfKtWjeYr4Sgix0WXdk/WdHIJLj1M0a1x/2LAazt8qbcGk7zC2Ovi3
         eIsNOgpe5cywE042U8ys138XPpeyviiJwEK/rTpW/kfH9FmKlEiPf0/8+b/QpQ/egaYb
         nDENhgut0AbNWanvp9ds58s3tCfnnGzqJOnaBpm+4bj3phNr3UI1Hn5EEmZdsb26Fp2e
         WTtG4vzedsVBKTrBLjDDgWqpLngHVtyJFrx2OocOSKd4BVU9WGv3+RR7bTXpLQuW49Cy
         TIkA==
X-Gm-Message-State: AOAM531CIEx5Jc0NYN1GyZceMpyhgjAIhqazr4CsHu7yCslG/Zhymg0s
        /AOauch4FKyF7MwVQj8I0lxv1Q==
X-Google-Smtp-Source: ABdhPJyBnXuV/s+DrX/Or6kRPo7C8q8gGVT+esbNFeOphxZLYo2TOJem6uMnQ7L4s/oV5oDtdDibTQ==
X-Received: by 2002:a17:90a:e2cb:: with SMTP id fr11mr6489864pjb.2.1614395143997;
        Fri, 26 Feb 2021 19:05:43 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id e129sm11103372pfh.87.2021.02.26.19.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 19:05:43 -0800 (PST)
Date:   Fri, 26 Feb 2021 19:05:43 -0800 (PST)
X-Google-Original-Date: Fri, 26 Feb 2021 19:05:09 PST (-0800)
Subject:     Re: [PATCH 1/2] mm: Guard a use of node_reclaim_distance with CONFIFG_NUMA
In-Reply-To: <alpine.LSU.2.11.2102261724370.15322@eggly.anvils>
Message-ID: <mhng-379d20e4-35c6-4349-b067-f2ff851eca86@penguin>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
CC:     akpm@linux-foundation.org, atishp@atishpatra.org,
        peterz@infradead.org, srikar@linux.vnet.ibm.com,
        valentin.schneider@arm.com, vbabka@suse.cz, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@android.com, kirill.shutemov@linux.intel.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     hughd@google.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Feb 2021 17:31:40 PST (-0800), hughd@google.com wrote:
> On Fri, 26 Feb 2021, Andrew Morton wrote:
>> On Fri, 26 Feb 2021 12:17:20 -0800 Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> > From: Palmer Dabbelt <palmerdabbelt@google.com>
>> >
>> > This is only useful under CONFIG_NUMA.  IIUC skipping the check is the
>> > right thing to do here, as without CONFIG_NUMA there will never be any
>> > large node distances on non-NUMA systems.
>> >
>> > I expected this to manifest as a link failure under (!CONFIG_NUMA &&
>> > CONFIG_TRANSPARENT_HUGE_PAGES), but I'm not actually seeing that.  I
>> > think the reference is just getting pruned before it's checked, but I
>> > didn't get that from reading the code so I'm worried I'm missing
>> > something.
>> >
>> > Either way, this is necessary to guard the definition of
>> > node_reclaim_distance with CONFIG_NUMA.
>> >
>> > Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
>> > ---
>> >  mm/khugepaged.c | 2 ++
>> >  1 file changed, 2 insertions(+)
>> >
>> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> > index a7d6cb912b05..b1bf191c3a54 100644
>> > --- a/mm/khugepaged.c
>> > +++ b/mm/khugepaged.c
>> > @@ -819,8 +819,10 @@ static bool khugepaged_scan_abort(int nid)
>> >  	for (i = 0; i < MAX_NUMNODES; i++) {
>> >  		if (!khugepaged_node_load[i])
>> >  			continue;
>> > +#ifdef CONFIG_NUMA
>> >  		if (node_distance(nid, i) > node_reclaim_distance)
>> >  			return true;
>> > +#endif
>> >  	}
>> >  	return false;
>> >  }
>>
>> This makes the entire loop a no-op.  Perhaps Kirill can help take a
>> look at removing unnecessary code in khugepaged.c when CONFIG_NUMA=n?
>
> First lines of khugepaged_scan_abort() say
> 	if (!node_reclaim_mode)
> 		return false;
>
> And include/linux/swap.h says
> #ifdef CONFIG_NUMA
> extern int node_reclaim_mode;
> extern int sysctl_min_unmapped_ratio;
> extern int sysctl_min_slab_ratio;
> #else
> #define node_reclaim_mode 0
> #endif
>
> So, no need for an #ifdef CONFIG_NUMA inside khugepaged_scan_abort().

Ah, thanks, I hadn't seen that.  That certainly explains the lack of an 
undefined reference.

That said: do we generally rely on DCE to prune references to undefined 
symbols?  This particular one seems like it'd get reliably deleted, but it 
seems like a fragile thing to do in general.  This kind of stuff would 
certainly make some code easier to write, though.

I don't really care all that much, though, as I was just sending this along due 
to some build failure report from a user that I couldn't reproduce.  It looked 
like they had some out-of-tree stuff, so in this case I'm fine on fixing this 
being their problem.
