Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839C131F3A5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 02:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhBSBcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 20:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhBSBcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 20:32:13 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78FCC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 17:31:32 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id o38so2542065pgm.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 17:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=on3Xc1kBgya2mQ7PYzrDRMNVrOI3FgA//zQyIz5f6Ck=;
        b=UD8xyuSA7oEUWkY01nX3UQto5fSE1E3SYJmEIbKQgMo9Tjwnh0IZnqET/U1low3KHH
         Fd/D+fV0BPwn2SzaD7qpH6icokDQoKJeb53cSxTJaroQQUse8pJr60/q+qnP2b7MFZsA
         yE0TZ0LV96LC2YBxbkmhAbKa0IM3YAlld/uuN5NSkWQcA4N1YEybw2JYz9OV07+NPEpe
         Xf+EVPpxdHbyEFuLrDcDfM2pCVt86TQnwvuEXZ67Tg+5kcBx6vP29XbOvR1ld8TxfBxZ
         APXtT0C4c85Xv+nHw8gHIg/3eNtRg+glflOdvR5MyUexuL9pnERrvw1Ta3Ok1Z0kEkiJ
         h5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=on3Xc1kBgya2mQ7PYzrDRMNVrOI3FgA//zQyIz5f6Ck=;
        b=jWstBpC9F2deYjDm6Hqv8f5w6Ulo1BHaswxueS5OkS7E6yVnDBiA06F0R/+0Ymd+Vd
         uvsHx+smrqHWK/w/7bos3w745XgZghlR9RAn+S9sXyLI4wr7zc8ABNXuY5qB0hPEC8fE
         4cYQFadoBd193a9TFLhNjPmlBDAU8ozUkZi5Z8jTMBqRdkXvXJ0y19AVhQfdXUjkmm5E
         PpXqod3xdaSp6sE2c2VNtFXYy6QOPlIr9HZNLzo9kIFFq4B7JnJ2MPcU1+F0Hggeivey
         UkO+WU86LFoZwwgulGa04XlfFWkd3J0KRNn7lalNbHLHDVurpH66m7AZ4ucvGlDLHW1E
         hguA==
X-Gm-Message-State: AOAM532R8rjY58xszVY9UZ9ElbeQ5W/paktl9cJm1sU5qThGnQ8nzho8
        y58u+auF4SupAC4OPpw7b4uy9A==
X-Google-Smtp-Source: ABdhPJz+0RxCQ1buHKHhC9nAomV4SeEGZheG5rRB3NgkMO+fVeDVGEBz8TJc09l1ix1ZbTs2qSiaQQ==
X-Received: by 2002:a63:2b82:: with SMTP id r124mr6350359pgr.310.1613698292070;
        Thu, 18 Feb 2021 17:31:32 -0800 (PST)
Received: from google.com ([2620:15c:f:10:903f:bec1:f9d:479b])
        by smtp.gmail.com with ESMTPSA id m10sm6396678pjn.33.2021.02.18.17.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 17:31:31 -0800 (PST)
Date:   Thu, 18 Feb 2021 17:31:24 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Makarand Sonare <makarandsonare@google.com>
Subject: Re: [PATCH 05/14] KVM: x86/mmu: Consult max mapping level when
 zapping collapsible SPTEs
Message-ID: <YC8U7IagCOfzeBpW@google.com>
References: <20210213005015.1651772-1-seanjc@google.com>
 <20210213005015.1651772-6-seanjc@google.com>
 <caa90b6b-c2fa-d8b7-3ee6-263d485c5913@redhat.com>
 <YC6UmukeFlrdWAxe@google.com>
 <df6eb767-0ae0-84a3-3f05-1ece4cb9ce22@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df6eb767-0ae0-84a3-3f05-1ece4cb9ce22@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021, Mike Kravetz wrote:
> On 2/18/21 8:23 AM, Sean Christopherson wrote:
> > On Thu, Feb 18, 2021, Paolo Bonzini wrote:
> >> On 13/02/21 01:50, Sean Christopherson wrote:
> >>>
> >>>  		pfn = spte_to_pfn(iter.old_spte);
> >>>  		if (kvm_is_reserved_pfn(pfn) ||
> >>> -		    (!PageTransCompoundMap(pfn_to_page(pfn)) &&
> >>> -		     !kvm_is_zone_device_pfn(pfn)))
> >>> +		    iter.level >= kvm_mmu_max_mapping_level(kvm, slot, iter.gfn,
> >>> +							    pfn, PG_LEVEL_NUM))
> >>>  			continue;
> >>
> >>
> >> This changes the test to PageCompound.  Is it worth moving the change to
> >> patch 1?
> > 
> > Yes?  I originally did that in a separate patch, then changed my mind.
> > 
> > If PageTransCompoundMap() also detects HugeTLB pages, then it is the "better"
> > option as it checks that the page is actually mapped huge.  I dropped the change
> > because PageTransCompound() is just a wrapper around PageCompound(), and so I
> > assumed PageTransCompoundMap() would detect HugeTLB pages, too.  I'm not so sure
> > about that after rereading the code, yet again.
> 
> I have not followed this thread, but HugeTLB hit my mail filter and I can
> help with this question.
> 
> No, PageTransCompoundMap() will not detect HugeTLB.  hugetlb pages do not
> use the compound_mapcount_ptr field.  So, that final check/return in
> PageTransCompoundMap() will always be false.

Thanks Mike!

Paolo, I agree it makes sense to switch to PageCompound in the earlier patch, in
case this one needs to be reverted.
