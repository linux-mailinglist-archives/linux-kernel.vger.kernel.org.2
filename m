Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509F539B0BF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 05:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhFDDRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 23:17:33 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]:34581 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhFDDRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 23:17:33 -0400
Received: by mail-qk1-f170.google.com with SMTP id k11so6443644qkk.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 20:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=FLTijI0qtWn0Gr6xLjK6ZMfCKnwIuGsHja/fIL/u8Nk=;
        b=GYyyLvoDRE7Yb4Jcrj7W2St5vOQJhmelZYfcmVWFRN5a01CXXukjthcvsdvUonxBCJ
         1UD87DLXnmpCFBhEEg0dZmwzPCw1kGspz1gU6rChfHshaSAdUqJngD2dWsl9s7Y1ssHi
         iDNHZap+6opPvskaTmXVOoD/sfvi3WdhXYYtGHR5z7UYVMQwR3XL6+0E4qx37mh+ciAd
         FoEa76z5ZI6aDZfCQFqjJDUm0aefNAr8qElZuvkzKFpLR5poLjvcL2b4lsvT96Bn9nzU
         GeD29FkgA3NvCkzLaDGPVjCKPxyaxhPKGiDzPc/kGyBCBRyMWLOGNi2GsmgBbitshv8V
         xGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=FLTijI0qtWn0Gr6xLjK6ZMfCKnwIuGsHja/fIL/u8Nk=;
        b=s4D25odicrMCrefIVFLO6PQnl3HI1SyNxqdgszQAW7vp+DdefuGbLOr8uNxtTliYkO
         9SoIZIlCstpO/Zz6KW8Me77jG6I6bscMaLp2m9NsOMKBzW/UzCOMcRLngcPrC5YzS/Jg
         oeG9hd5EVWDLBrEWYKCG6WqeDox3i9x/fJkLEkTkLVBkjpc7NdBEryCUGwHlJgkYALaC
         Lc6I9f5XAhsO6kgba4ztU2gfa2bFU6eCFyC1zT43k5sT2DxNS4UjghXOaa5Hb1rKczIX
         gcY57USUPbOTVCGWekWbuYzUq4jrc78TwZ2L2O+p16eKhaK9Rth7L1dI3DRz7YuY3Jka
         ogTg==
X-Gm-Message-State: AOAM530DOXttF1aUAkYt4MENkQFnPak6ywIa91godtU0HDLUjcxPMHdq
        gWWIvPCtnJTsG/ddteckCjhIOg==
X-Google-Smtp-Source: ABdhPJwtG7KBNA+9nOH+6w+vKhjcwj4i2cwWs0sxMbftMbUoDFHoU5MkEf0SX53FKoOB6xmDupdl8g==
X-Received: by 2002:a05:620a:e09:: with SMTP id y9mr2356795qkm.359.1622776474736;
        Thu, 03 Jun 2021 20:14:34 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v25sm2942592qtf.68.2021.06.03.20.14.32
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 03 Jun 2021 20:14:34 -0700 (PDT)
Date:   Thu, 3 Jun 2021 20:14:31 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Alistair Popple <apopple@nvidia.com>
cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 04/27] mm/userfaultfd: Introduce special pte for
 unmapped file-backed mem
In-Reply-To: <1780227.rxkhHXaqZV@nvdebian>
Message-ID: <alpine.LSU.2.11.2106031954570.12760@eggly.anvils>
References: <20210527201927.29586-1-peterx@redhat.com> <4688876.HeLTNyGTSD@nvdebian> <YLjsZ4PVQcx0/vb8@t490s> <1780227.rxkhHXaqZV@nvdebian>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2021, Alistair Popple wrote:
> 
> The detail which is perhaps less important is whether to implement this using 
> a new swap entry type or arch-specific swap bit. The argument for using a swap 
> type is it will work across architectures due to the use of pte_to_swp_entry() 
> and swp_entry_to_pte() to convert to and from the arch-dependent and 
> independent representations.
> 
> The argument against seems to have been that it is wasting a swap type. 
> However if I'm understanding correctly that's not true for all architectures, 
> and needing to reserve a bit is more wasteful than using a swap type.

I'm on the outside, not paying much attention here,
but thought Peter would have cleared this up already.

My understanding is that it does *not* use an additional arch-dependent
bit, but puts the _PAGE_UFFD_WP bit (already set aside by any architecture
implementing UFFD WP) to an additional use.  That's why I called this
design (from Andrea) more elegant than mine (swap type business).

If I've got that wrong, and yet another arch-dependent bit is needed,
then I very much agree with you: finding arch-dependent pte bits is a
much tougher job than another play with swap type.

(And "more elegant" might not be "easier to understand": you decide.)

Hugh
