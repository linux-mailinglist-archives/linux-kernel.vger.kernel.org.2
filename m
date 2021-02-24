Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B993242C1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 18:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbhBXQ6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 11:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235784AbhBXQ4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 11:56:38 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9532C061788
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 08:55:55 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id h38so668005ooi.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 08:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=qzIzE3gw2sE+uqnG1z5ybJKgabwnkpbeDNpeXkPoLLA=;
        b=rOMFMda0e0+PgT6qyZtEzWuybeZnEKJIq6hNGk1YkcwiufEVQh5WEa/JtL2jQ2uKO5
         HpdcBPqBgOOOgiHQhWyue1AkWGjy2BonhXvCMAWl4OSdsbsp7m8hoKg+mhW7s1nWKvFt
         23rsozxkrbJcEBaa/BzcgCmZZPshxvsnLKtEPLpaaFoGdzSjRu8lHlmFY/9BBH934XfQ
         uzkGj8x4S0/RCrCnW9y3Qsu/E0yuIiiSMX3rCA1ATrj7Q0F0CjP2cLrW7yDADVFvYYCZ
         NZvMxR6VhmZqhfJTw0gTacdNIhatEfvz2YhdVQ2qPA6c5ls2rY0M2SZRE2WZee3VMwnt
         Xx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=qzIzE3gw2sE+uqnG1z5ybJKgabwnkpbeDNpeXkPoLLA=;
        b=EsSmtrdahTz3NL+eb6C8IWT/YwJ4RbR4Zwx7LmGKYrglruaHTnti21AfLTQkb8i08l
         iY0yyfY3b0xdyTNGFazQBJWptWg/Nm7+VdZab7a5X8HRVvvStbZF0vZEHECUMdcOyEGi
         QEvlmAhZX8U66maR2eKEyH7+hLkgnXXV+g29Stm6VzzPBa80z1WNid7oAbvJ3y+SjBTa
         uKzDNF65W7VvedDLkqW2wMu80AYuD0sVFYJiwqC5nb6i8s7//mq1sE1eBWveApyfXTJn
         a3o3jkhIClcxbjdu2MIg+vyhOHLH+Qk6iWDBZLjgraqxsB9xTZJo+7yAk+NJsyWoHslo
         x2Uw==
X-Gm-Message-State: AOAM530qTznxhzM3jieqMLoaTO6D9vE/3QdRTuVNotBzJwbTKlBrqHa/
        nbdnVD26lIRxj6gT+OUJscDbGQ==
X-Google-Smtp-Source: ABdhPJyRwCKX5qHjV0sZ3hvYKAC052p7WG7STZ76eIno3EcNLNlFLX3uD3g/DSnbU6oWxCn90Vyt8Q==
X-Received: by 2002:a4a:b815:: with SMTP id g21mr1964494oop.13.1614185754931;
        Wed, 24 Feb 2021 08:55:54 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id l202sm450958oib.16.2021.02.24.08.55.53
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 24 Feb 2021 08:55:54 -0800 (PST)
Date:   Wed, 24 Feb 2021 08:55:40 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Rik van Riel <riel@surriel.com>
cc:     Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        xuyu@linux.alibaba.com, mgorman@suse.de, aarcange@redhat.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, linux-mm@kvack.org, mhocko@suse.com
Subject: Re: [PATCH v6 0/3] mm,thp,shm: limit shmem THP alloc gfp_mask
In-Reply-To: <a7a85f81bd21254805bc91772530f237c9b73c04.camel@surriel.com>
Message-ID: <alpine.LSU.2.11.2102240854140.10197@eggly.anvils>
References: <20201124194925.623931-1-riel@surriel.com> <alpine.LSU.2.11.2012141226350.1925@eggly.anvils> <e3f67a5f-9835-2752-3d35-fb5f6d701cf1@suse.cz> <alpine.LSU.2.11.2102232329180.9202@eggly.anvils>
 <a7a85f81bd21254805bc91772530f237c9b73c04.camel@surriel.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Feb 2021, Rik van Riel wrote:
> On Wed, 2021-02-24 at 00:41 -0800, Hugh Dickins wrote:
> > On Mon, 14 Dec 2020, Vlastimil Babka wrote:
> > 
> > > > (There's also a specific issue with the gfp_mask limiting: I have
> > > > not yet reviewed the allowing and denying in detail, but it looks
> > > > like it does not respect the caller's GFP_ZONEMASK - the gfp in
> > > > shmem_getpage_gfp() and shmem_read_mapping_page_gfp() is there to
> > > > satisfy the gma500, which wanted to use shmem but could only
> > manage
> > > > DMA32.  I doubt it wants THPS, but shmem_enabled=force forces
> > them.)
> > 
> > Oh, I'd forgotten all about that gma500 aspect:
> > well, I can send a fixup later on.
> 
> I already have code to fix that, which somebody earlier
> in this discussion convinced me to throw away. Want me
> to send it as a patch 4/3 ?

If Andrew wants it all, yes, please do add that - thanks Rik.

Hugh
