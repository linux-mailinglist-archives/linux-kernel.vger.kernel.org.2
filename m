Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254743EABC9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 22:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbhHLUcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 16:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhHLUcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 16:32:08 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5889DC061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 13:31:42 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id n17so15669775lft.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 13:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KUUhLtTlH34qCrAMz8FLnyHB8kOZP64VRsvKeH3KR8s=;
        b=nOrRIYAAPbw5bHnn75Pm1qIco3wpb+lMROBcM7ri9KOPOhTw4kzAADCurwjRrUInst
         AXb0PTXH/Ifcg2m/DuYXno20AWpOr1UP3nS9ZCLJYk6Vvkv0cayMwMxZd+7RW49DkTc7
         5ghHighVMBccvkyAh5MMV0rI78r1gJdnmKDO88f61M7O4pTz9YBPRbFqroZPoi6+iWaR
         0DeXqL15wzNkOOaK4cHifr5LqGK+oqI9Zql05LdmdBoDzT9Hvi0K2+kJ2oIj4wT2gOIT
         S28D/7Aw2YvHu5ix/XLS27EequZ1oFuGbNVzTIm3vAe5ebX8CSfvvsdKPYTlFd+lOBUl
         YXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KUUhLtTlH34qCrAMz8FLnyHB8kOZP64VRsvKeH3KR8s=;
        b=euMrHPrOh+Sr4yflsxdjP+thnJI19hGHrMvDfERFAy66dpLCkSiN0UXlzADIsslF4f
         BkbbwqrGALYjpSuts8Uk88Eok5A2zMDMWhFPCEaw7e/ddTrEHIm0FzUM3nUXx17X7DW0
         541IvgKTt9O3R42VHObNgDIh+t59MARL/GDx+9ZTVfKN4cRxZk0b2aw4lPZEiAOEmGOJ
         0+UUK6cmu2H8a2EgKK06Eo6wO+SjoZQ8ZSgRNyROp57E6MjPC6pf8S2FAtsS5f6F0xz+
         Fkw3Y8o5u3on6ZVYZkpvdsWcvvC2hvcDlBz3cdqJeyoHiR1ypwgwwZQfq2d+Kyzm+jHJ
         +pTA==
X-Gm-Message-State: AOAM531OBk8khaTTMVXXzEcu2cmAnLcSau+CQSGTWRpmpZJp+Jyk9Hgy
        8O8kAN/3wzGiSI1MrV20Cf4DsQ==
X-Google-Smtp-Source: ABdhPJyvYaymFYFw8Uki/dQxRfjDAkBBlPMhq9oHb4aqfUAn1utra3SHn9C+FY7EgizSN1SPsk58yw==
X-Received: by 2002:a05:6512:2153:: with SMTP id s19mr3859298lfr.140.1628800300644;
        Thu, 12 Aug 2021 13:31:40 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id u19sm361918lfo.205.2021.08.12.13.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 13:31:39 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id A70E9102BEE; Thu, 12 Aug 2021 23:31:53 +0300 (+03)
Date:   Thu, 12 Aug 2021 23:31:53 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 4/5] x86/mm: Provide helpers for unaccepted memory
Message-ID: <20210812203153.uoa7nx7w5zdsmzck@box.shutemov.name>
References: <20210810062626.1012-1-kirill.shutemov@linux.intel.com>
 <20210810062626.1012-5-kirill.shutemov@linux.intel.com>
 <67ce254c-aacc-43b6-d8d5-168ef9200f9e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67ce254c-aacc-43b6-d8d5-168ef9200f9e@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 11:16:26AM -0700, Dave Hansen wrote:
> On 8/9/21 11:26 PM, Kirill A. Shutemov wrote:
> > +void accept_memory(phys_addr_t start, phys_addr_t end)
> > +{
> > +	if (!boot_params.unaccepted_memory)
> > +		return;
> > +
> > +	spin_lock(&unaccepted_memory_lock);
> > +	__accept_memory(start, end);
> > +	spin_unlock(&unaccepted_memory_lock);
> > +}
> 
> Isn't this taken in the:
> 
> 	del_page_from_free_list()->
> 	clear_page_offline()->
> 	accept_memory()
> 
> call path?
> 
> That's underneath:
> 
> 	spin_lock_irqsave(&zone->lock, flags);
> 
> Which means that accept_memory() can happen from interrupt context.  Is
> it always covered by another spin_lock_irqsave() which means that it can
> use a plain spin_lock()?

I didn't give it enough thought yet, but we always run under zone lock
which has to use spin_lock_irqsave() if it called from interrupt context.

Having said that I think it is good idea to move clear_page_offline() out
zone lock. It should help with allocation latency. Not sure how messy it
gets. Merging/splitting path looks complex and I'm not an expert in the
page allocator.

> If so, it would be nice to call out that logic.  It *looks* like a
> spinlock that we would want to be spin_lock_irqsave().

-- 
 Kirill A. Shutemov
