Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB7D35A0C4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 16:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbhDIOMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 10:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbhDIOM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 10:12:28 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B78C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 07:12:14 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id p23so2967056ljn.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 07:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NDsvXUdltGvvpLLyVAvKO+pIIX+hnM4/5t6QQsKamX4=;
        b=KIx+P5g+pGir5D4L/bl008ypkOLxkw9EMUHHovL+BOej8xyb0weCq1XijtSDfDpTFA
         SqMYfgMvQiJW4sfTBLebyhjCFW7UpdD4b0Evc1txWo0q3ACeRe8vHAnTP/xsXN7tCznb
         lq0qYYe3ZsK2lONfy+hLR3ywcj7L0C3h20w8vffd0U14WwWJrAhEqlATTAc1iTFKeWcC
         5vRsEUQTcR0Ze97CB1m/XctanDdaeVKwhfbKioYUG7rBgq7QA20GQmSLB8tSI4g4f5Rp
         qixidefXZQiEvkqMSeMSLFhbuCinCREOfV4po/6LpNF6wd9hPaz8xPsoYWp87DcyCDoS
         6hnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NDsvXUdltGvvpLLyVAvKO+pIIX+hnM4/5t6QQsKamX4=;
        b=d8bfigFxvMuBTYg6upPtFoUbUXmhLxEIwJL21wL5cBDW8F/O6Ykn2lX3/3MY8E4BJL
         +P5a6IAeyBooS50hQIWyOlwJtsOxFSrZMUk/alheulGGYuDER9amAdswM2Sh4JIcLz1b
         dT5xqQfXDCwqq+v1DycNkHptFSFnsyVSKp6aMWrAlKquG+xCTfMcJIykqxbF3ezVKGtI
         UA/0/1G/1k++yXUoVwf09HmpXq0WqXIDMNDruZh/vOn/Hw8agL1Nd7Xv+fM/K7+aD7jo
         woTPOAI/2iTet4qGoDyfROErI3ja0g1aNN4nS0bBKUwAWRyU7buRf7AkRxtQozJFipl6
         I8yA==
X-Gm-Message-State: AOAM533USHRmRb6QQzgl/RbpQChitm2N+865yp3GO3/umRQAfsXxUU9P
        4zm3TtdfgdVf0253K8l7oFpzCQ==
X-Google-Smtp-Source: ABdhPJygMC32GdhqTvZsDSgSixX9aK7vPRPI1+Ns5bn6Vxj6vZL4UquVC6LKIQ8m6/0BYLMDzKTNBQ==
X-Received: by 2002:a05:651c:200b:: with SMTP id s11mr9021619ljo.177.1617977532354;
        Fri, 09 Apr 2021 07:12:12 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id r23sm282443lfm.73.2021.04.09.07.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 07:12:11 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 1B878102498; Fri,  9 Apr 2021 17:12:11 +0300 (+03)
Date:   Fri, 9 Apr 2021 17:12:11 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     David Hildenbrand <david@redhat.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Rientjes <rientjes@google.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Subject: Re: [RFCv1 7/7] KVM: unmap guest memory using poisoned pages
Message-ID: <20210409141211.wfbyzflj7ygtx7ex@box.shutemov.name>
References: <20210402152645.26680-1-kirill.shutemov@linux.intel.com>
 <20210402152645.26680-8-kirill.shutemov@linux.intel.com>
 <5e934d94-414c-90de-c58e-34456e4ab1cf@redhat.com>
 <20210409133347.r2uf3u5g55pp27xn@box>
 <5ef83789-ffa5-debd-9ea2-50d831262237@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ef83789-ffa5-debd-9ea2-50d831262237@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 03:50:42PM +0200, David Hildenbrand wrote:
> > > 3. Allow selected users to still grab the pages (esp. KVM to fault them into
> > > the page tables).
> > 
> > As long as fault leads to non-present PTEs we are fine. Usespace still may
> > want to mlock() some of guest memory. There's no reason to prevent this.
> 
> I'm curious, even get_user_pages() will lead to a present PTE as is, no? So
> that will need modifications I assume. (although I think it fundamentally
> differs to the way get_user_pages() works - trigger a fault first, then
> lookup the PTE in the page tables).

For now, the patch has two step poisoning: first fault in, on the add to
shadow PTE -- poison. By the time VM has chance to use the page it's
poisoned and unmapped from the host userspace.

-- 
 Kirill A. Shutemov
