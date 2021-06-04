Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0781B39BB72
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 17:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhFDPM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 11:12:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55749 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229778AbhFDPMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 11:12:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622819438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rY04b6/ZRmaZK8r9pldsFNxxxfCAPomp4y4kXbJNY2s=;
        b=G46XFy8SLgZQm3OnIDfb8npzmhcgfqn5J8VmAyt/RMZYEN/CyvmUpHks+MxrbFdFMFUkK5
        k2fkHCQadjpr7Zla/YaFERYz5S2eGSSPolj37uqU0OFAuttjc5vDXfirtNIZL+ruc2X++R
        pMPLQcPJa+tA5OGpt8B++eWJnjvr37Q=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-C2UGg3LDMxGByiTwhmPJBw-1; Fri, 04 Jun 2021 11:10:34 -0400
X-MC-Unique: C2UGg3LDMxGByiTwhmPJBw-1
Received: by mail-qv1-f72.google.com with SMTP id bl11-20020ad4564b0000b029021d1fdffd5aso6932747qvb.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 08:10:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rY04b6/ZRmaZK8r9pldsFNxxxfCAPomp4y4kXbJNY2s=;
        b=Eme8K9nipVtfVSYNESMWKPSKTUj/zUDsKSGibJG+7YZoIsdZmAy+wZVoUzk9HtLuBE
         SFP1uiWXiXngFq72Sc7ZZEX94UhdytqUsfE/LuhqPsvEilVIG/SdBsagYI6Edcfi/CAJ
         VJpzBOc/IAY9V0EF53FuRUmGH7Y+ZzYRIDWBzaCXytqEAoGltT/UInDcsHCtSzaTxkDr
         c1F6kVFd6kawBbTgZYfi8s8920bJmBx6Wq7iGZQS7nHrYaNK9ktEqOqeMhEpIjt/1/U5
         AH0HMfyewc044aT46mP/N4/1Bk3oyABAYY4dbW/z2nDwfJwf12sN4IqEGIZ8NA1Li8ti
         S3Kg==
X-Gm-Message-State: AOAM532i+Ch6zZIyaRZNhaQ/hDKdmbTn7JYBbaDX3ZPDHo7Fsjo1eVkS
        TEknW4XmFRjqRbqVMilRS1BEHVyWxu1+NIQutxk/EUvLUwjyZ/pC9MVJJeH14RCcsWfwoKXpXnG
        Y061M426ij1h1psbmvJ5TYh0q
X-Received: by 2002:a05:620a:4410:: with SMTP id v16mr4841404qkp.387.1622819433549;
        Fri, 04 Jun 2021 08:10:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6+UagA80qzlImEErke2pvQrrl+/pEnQY+1T+0ccLCf3Gk/r95MsHbFPJ5TR5FuCtMgSGDLg==
X-Received: by 2002:a05:620a:4410:: with SMTP id v16mr4841381qkp.387.1622819433348;
        Fri, 04 Jun 2021 08:10:33 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-61-184-147-118-108.dsl.bell.ca. [184.147.118.108])
        by smtp.gmail.com with ESMTPSA id y1sm4320510qkp.21.2021.06.04.08.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 08:10:32 -0700 (PDT)
Date:   Fri, 4 Jun 2021 11:10:31 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH] mm/swap: Fix pte_same_as_swp() not removing uffd-wp bit
 when compare
Message-ID: <YLpCZ6PGxDGt06gQ@t490s>
References: <20210603180546.9083-1-peterx@redhat.com>
 <alpine.LSU.2.11.2106032015250.12760@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2106032015250.12760@eggly.anvils>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 08:26:02PM -0700, Hugh Dickins wrote:
> On Thu, 3 Jun 2021, Peter Xu wrote:
> 
> > I found it by pure code review, that pte_same_as_swp() of unuse_vma() didn't
> 
> Yes, that is an odd corner, easily missed.
> 
> > take uffd-wp bit into account when comparing ptes.  pte_same_as_swp() returning
> > false negative could cause failure to swapoff swap ptes that was wr-protected
> > by userfaultfd.
> > 
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> I expect you're right: swapoff used to hang forever (but interruptibly)
> when this went wrong on powerpc originally.  I don't know the uffd_wp
> (nor the soft_dirty) end of it, but treating uffd_wp and soft_dirty
> together looks a very good approach, so I'll venture an
> 
> Acked-by: Hugh Dickins <hughd@google.com>

Thanks!

> 
> But I think it should have a uffd_wp Fixes tag and be Cc stable.

Yes, should be:

Cc: stable@vger.kernel.org # v5.7+
Fixes: f45ec5ff16a7 ("userfaultfd: wp: support swap and page migration")

-- 
Peter Xu

