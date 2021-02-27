Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC06326B8A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 05:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhB0EPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 23:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbhB0EP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 23:15:29 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F14C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 20:14:48 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id b21so7459997pgk.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 20:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=HAWqJh5bH0SBnTvxI36sdd7e6koG3nqFv5InO++pzdY=;
        b=xve7mwNKx/vYEK9kReHFU6UyxBQOISTwlspvgLp0jv/P/32Kf7hFq9gUPaG9xa+A/w
         9ZEx9OOTv6zBRKyJ7LtXlcLxvgLux3qIzvIphJ4ByyKHyvX3uEwBQ174q8dBT2w8Se/y
         uyxEpUUDPJkfNO/JLBjS9iqT9jwSCEsCPrnwdZ/UjDRluSdyj1FIfei/xbSSV0dGNZoh
         hKoMerrPp0K5eZGpivKf4dN8+XSYzpdrOcj3lW4EHAiD7f2m3ZPG50c89UAURhXKvkDB
         LejmDB9lsqlfoLIjqYOuFkAuungCwwkNYKcKcP5fg0u8AyLc6BdNnm6CpvfSMyPRoC7/
         AxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=HAWqJh5bH0SBnTvxI36sdd7e6koG3nqFv5InO++pzdY=;
        b=tueK5YzwsT4Z6MNuFEKl3e8NSMb42mlq24a1D9ri8y6CbLtpLnvvVHEdfeFCBk0J2k
         4pMvMWQ6Zc/TamQqs4fSxfq6vc+YM5316MWeSv51ekTV7pn7ygN2Ckdxo+/88R0qEX3m
         fS5YDQT7xLujNq6quKnblmfTor9WeEppqXRgW0hDSJadwwFSorQnTJLNGTNeqV4WkZMo
         ygojHmEz8kIFINx0uf3gL+x6AqwvQG6XP0xSCiuLN9h1/bxgx6QaP1wo1ImCN6c7h3GB
         JcIjsoF//MHTwUo81Xh7ht62NPyLqZpYtS8N/wxaWOfHpUiaEWNdVfaCiVcV4xnzbfBZ
         Nwgw==
X-Gm-Message-State: AOAM531Ysy/yUwOACXeYRrxI5uEORPhHf5FYp5jCA9ZiaEWZJf61mPdz
        qs/M9l2durLAMgQCsOrMEq1cs9xSuEYAiFbA
X-Google-Smtp-Source: ABdhPJwnZHCvJ5CYxZZAoue5BWmBrNhTCBhcDNKZasUQtgpWSzXSHo89jKW2v0Xwu7h2k9YiFZTQYA==
X-Received: by 2002:a63:1505:: with SMTP id v5mr5782922pgl.95.1614399288412;
        Fri, 26 Feb 2021 20:14:48 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id j1sm10773163pfr.78.2021.02.26.20.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 20:14:47 -0800 (PST)
Date:   Fri, 26 Feb 2021 20:14:47 -0800 (PST)
X-Google-Original-Date: Fri, 26 Feb 2021 20:14:32 PST (-0800)
Subject:     Re: [PATCH 1/2] mm: Guard a use of node_reclaim_distance with CONFIFG_NUMA
In-Reply-To: <alpine.LSU.2.11.2102261918250.15774@eggly.anvils>
CC:     hughd@google.com, akpm@linux-foundation.org, atishp@atishpatra.org,
        peterz@infradead.org, srikar@linux.vnet.ibm.com,
        valentin.schneider@arm.com, vbabka@suse.cz, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@android.com, kirill.shutemov@linux.intel.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     hughd@google.com
Message-ID: <mhng-3f22abd3-c7a3-4a5f-b068-ed5bfe9a2e71@penguin>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Feb 2021 19:41:40 PST (-0800), hughd@google.com wrote:
> On Fri, 26 Feb 2021, Palmer Dabbelt wrote:
>> On Fri, 26 Feb 2021 17:31:40 PST (-0800), hughd@google.com wrote:
>> > On Fri, 26 Feb 2021, Andrew Morton wrote:
>> > > On Fri, 26 Feb 2021 12:17:20 -0800 Palmer Dabbelt <palmer@dabbelt.com>
>> > > wrote:
>> > > > From: Palmer Dabbelt <palmerdabbelt@google.com>
>> > > >
>> > > > This is only useful under CONFIG_NUMA.  IIUC skipping the check is the
>> > > > right thing to do here, as without CONFIG_NUMA there will never be any
>> > > > large node distances on non-NUMA systems.
>> > > >
>> > > > I expected this to manifest as a link failure under (!CONFIG_NUMA &&
>> > > > CONFIG_TRANSPARENT_HUGE_PAGES), but I'm not actually seeing that.  I
>> > > > think the reference is just getting pruned before it's checked, but I
>> > > > didn't get that from reading the code so I'm worried I'm missing
>> > > > something.
>> > > >
>> > > > Either way, this is necessary to guard the definition of
>> > > > node_reclaim_distance with CONFIG_NUMA.
>> > > >
>> > > > Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
>> > > > ---
>> > > >  mm/khugepaged.c | 2 ++
>> > > >  1 file changed, 2 insertions(+)
>> > > >
>> > > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> > > > index a7d6cb912b05..b1bf191c3a54 100644
>> > > > --- a/mm/khugepaged.c
>> > > > +++ b/mm/khugepaged.c
>> > > > @@ -819,8 +819,10 @@ static bool khugepaged_scan_abort(int nid)
>> > > >  	for (i = 0; i < MAX_NUMNODES; i++) {
>> > > >  		if (!khugepaged_node_load[i])
>> > > >  			continue;
>> > > > +#ifdef CONFIG_NUMA
>> > > >  		if (node_distance(nid, i) > node_reclaim_distance)
>> > > >  			return true;
>> > > > +#endif
>> > > >  	}
>> > > >  	return false;
>> > > >  }
>> > >
>> > > This makes the entire loop a no-op.  Perhaps Kirill can help take a
>> > > look at removing unnecessary code in khugepaged.c when CONFIG_NUMA=n?
>> >
>> > First lines of khugepaged_scan_abort() say
>> > 	if (!node_reclaim_mode)
>> > 		return false;
>> >
>> > And include/linux/swap.h says
>> > #ifdef CONFIG_NUMA
>> > extern int node_reclaim_mode;
>> > extern int sysctl_min_unmapped_ratio;
>> > extern int sysctl_min_slab_ratio;
>> > #else
>> > #define node_reclaim_mode 0
>> > #endif
>> >
>> > So, no need for an #ifdef CONFIG_NUMA inside khugepaged_scan_abort().
>>
>> Ah, thanks, I hadn't seen that.  That certainly explains the lack of an
>> undefined reference.
>>
>> That said: do we generally rely on DCE to prune references to undefined
>> symbols?  This particular one seems like it'd get reliably deleted, but it
>> seems like a fragile thing to do in general.  This kind of stuff would
>> certainly make some code easier to write, though.
>
> Yes, the kernel build very much depends on the optimizer eliminating
> dead code, in many many places.  We do prefer to keep the #ifdefs to
> the header files as much as possible.

OK, makes sense.  Thanks!

>> I don't really care all that much, though, as I was just sending this along
>> due to some build failure report from a user that I couldn't reproduce.  It
>> looked like they had some out-of-tree stuff, so in this case I'm fine on
>> fixing this being their problem.
>
> I didn't see your 2/2 at the time; but wouldn't be surprised if that
> needs 1/2, to avoid an error on undeclared node_reclaim_distance before
> the optimizer comes into play.  If so, best just to drop 2/2 too.

Ya, definitely.  Sorry for the noise!
