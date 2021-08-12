Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526473EABB7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 22:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbhHLUXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 16:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237537AbhHLUXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 16:23:06 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D121C0617A8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 13:22:40 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id t9so15726789lfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 13:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lD9P9nE94kR+CL+KH4TKKi2qyNFlxYCyV9udAgSMPuk=;
        b=xaNDyhy88byYnIIk4BDvaJifaQ3BFM2799N3xhmZu3XCpJXK6fGOG2OL1+ne0TARRU
         9vf8APrv9QSkUtaBzwzgGbkVKiwbR7Q+5QemRBksc5mujL2R1IY2OPoJVVtRxFIgDsDy
         mlkgIXH8kLQ7pqfv1IEaURoQXtPQIqSqw/6vXZbYABgivFdUehFYxo6gLlyGrsq5gTmu
         QreyA4Dza+o8Qo0kEmhaH62oopN6QWlqRmZALFkzU3J0NjVgKTqCemkJgR/Q1d1TCf7R
         9gSGa2MV6lC2gh6f6aqQbjymZ5CDWiJdGu6ux4U1C2d15ZhMhqBFAIkjzqkpR1QIlbQa
         YUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lD9P9nE94kR+CL+KH4TKKi2qyNFlxYCyV9udAgSMPuk=;
        b=nMzBwJwIn4wGOXJKh3FAX+FWJIE+WlNrIkFJA9jEpRErFhr80HgEQErzLAu92ehbWW
         DC9TIhSw51MhomiXi5id+A/UuyVURvM+f9ya6kkwH7HYAkhzz9va44FDotqgEsrXByhb
         FxCx1mJSOa2/IDiDIcSlPXaEwGUdC9bva/kEwb1v2J/nZ2BvXCOCXxAgZPoaAuau7aO9
         Zjx7negK+sRaBeL9LHzywLuj7G32eFyekhTY8ryh4pjVow3T+GszLg//i3L8LAMmqpD/
         8puYfqHnaN8t8Al6aFHhctCFtQZdm/ZneGB7EEHio+/sysC1vdz0GjRPL2fhMFweTyXW
         dF3g==
X-Gm-Message-State: AOAM533a2JIPPynrqtVlUe+5ofhH1hebvH8Yi6t6C0ZzU4LcSsCVugyS
        T9xwX9u/oevF0cgwhLqZtpTRPg==
X-Google-Smtp-Source: ABdhPJxeBkiE8ikw29XNB8mMQnkymNKk4mH63Wj2JCylomBb7HKCsIjevdUDN654nitfIPtyjCkmrw==
X-Received: by 2002:ac2:5e76:: with SMTP id a22mr3640177lfr.500.1628799758664;
        Thu, 12 Aug 2021 13:22:38 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id s14sm358017lfe.268.2021.08.12.13.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 13:22:37 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 72DF4102BEE; Thu, 12 Aug 2021 23:22:51 +0300 (+03)
Date:   Thu, 12 Aug 2021 23:22:51 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH 0/5] x86: Impplement support for unaccepted memory
Message-ID: <20210812202251.hn3c2xykm2l73avu@box.shutemov.name>
References: <20210810062626.1012-1-kirill.shutemov@linux.intel.com>
 <YRTafEovVZme+KO9@suse.de>
 <20210812101054.5y6oufwwnisebuyy@box.shutemov.name>
 <e72e34b5-a232-6dc9-0cdb-cc8c97783772@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e72e34b5-a232-6dc9-0cdb-cc8c97783772@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 12:33:11PM -0700, Andi Kleen wrote:
> 
> On 8/12/2021 3:10 AM, Kirill A. Shutemov wrote:
> > On Thu, Aug 12, 2021 at 10:23:24AM +0200, Joerg Roedel wrote:
> > > Hi Kirill,
> > > 
> > > On Tue, Aug 10, 2021 at 09:26:21AM +0300, Kirill A. Shutemov wrote:
> > > > Accepting happens via a protocol specific for the Virtrual Machine
> > > > platform.
> > > That sentence bothers me a bit. Can you explain what it VMM specific in
> > > the acceptance protocol?
> > For TDX we have a signle MapGPA hypercall to VMM plus TDAcceptPage for
> > every accepted page to TDX Module. SEV-SNP has to something similar.
> 
> 
> I think Joerg's question was if TDX has a single ABI for all hypervisors.
> The GHCI specification supports both hypervisor specific and hypervisor
> agnostic calls. But these basic operations like MapGPA are all hypervisor
> agnostic. The only differences would be in the existing hypervisor specific
> PV code.

My point was that TDX and SEV-SNP going to be different and we need a way
to hook the right protocol for each.

-- 
 Kirill A. Shutemov
