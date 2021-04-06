Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCB5355890
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243616AbhDFPyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346071AbhDFPyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:54:49 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BE7C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 08:54:40 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id v140so5768428lfa.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 08:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M8D5SkpZw86nXuzjclR4fG3nQDhB5s59GcClodpHva0=;
        b=DO4yLefsSCH5lzWN41R9EyfyrDFMXAUuVLjdmx+vvcR9sV86v1BCDTas1MyXjXw2wh
         Bzfodspti/i/iiRanQPMaA7zL+WbziFWfcYfQs7aiRPNuskK4vQAMntthOKqncWoWbr2
         eRAZIF15svJEA0iTHytW+RIsiZzIkbe194OmETtkwHym+wlgjTjfNTTW8SbVaDZjKJU7
         0V+yCVEXE3YxFIrNpMpevK6DW8kEOBqkpGHG60UqBaIZeCsj0PwBO96+MtlcAWrp9sOA
         pKgz/q8tv/OWsgb6xbkNa//RZ56a5mK0RmRC5ctBFYcqeF9hFi4Z6NWwpNSau/eFRqVy
         zqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M8D5SkpZw86nXuzjclR4fG3nQDhB5s59GcClodpHva0=;
        b=F9giDCGP2FoQ7OCeDNER7AR7T6Z5hNN3v9pa3WuvA4StFj4WypWXvZrIis4Z7eBMq2
         qcU0MoLxTWB5kEcJ9oH0pylTI2p2WDHnoEjH/JHDbduNpMpEiMeCkp3lZRIRi9cnoyXX
         Dgy9eIvskNpIJwPeGwJFFrvBbIkzlTV/KdK4/NITaCAKEZx3z4y39XqKCFmJI8R0T+fI
         WXMaRVUSMv+UsQFDTmhz3dVoqU3dis80B8F4AGkblLTbt4xaaNKctWGL15dorbGrxY+u
         GCTgYFAFjJEJwce44Ky9VIFlDvBFgR+Ye9w5blsb9E6uj/iZboPXyole1+TeQlPPejxd
         5lrQ==
X-Gm-Message-State: AOAM531FNR7ebLOePQuN5N3DUwGLHSu/jsHRH+fNhBgDXYk7k3dNjunu
        Z5EnFbrdXpmVM+eg3KPybXeS+A==
X-Google-Smtp-Source: ABdhPJw0GjKX68W8iooPYCmFRlghZnsUiXcWLL8hIUFTnu7Iz7l7iK4JfMwSMHKTXdraZEh/NfqZuQ==
X-Received: by 2002:a05:6512:3a81:: with SMTP id q1mr21094809lfu.388.1617724479133;
        Tue, 06 Apr 2021 08:54:39 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id b16sm53280lfq.6.2021.04.06.08.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 08:54:38 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 5558F101FF7; Tue,  6 Apr 2021 18:54:41 +0300 (+03)
Date:   Tue, 6 Apr 2021 18:54:41 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v1 22/26] x86/tdx: Exclude Shared bit from __PHYSICAL_MASK
Message-ID: <20210406155441.a6ez7ehw7wbc63tk@box>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <76d1bc03ab6f12d1943f5bb83fcf0ff8eac55bc1.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <007362e2-a8df-050b-8c41-1756981bb071@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007362e2-a8df-050b-8c41-1756981bb071@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 01:13:16PM -0700, Dave Hansen wrote:
> > @@ -56,6 +61,9 @@ static void tdx_get_info(void)
> >  
> >  	td_info.gpa_width = rcx & GENMASK(5, 0);
> >  	td_info.attributes = rdx;
> > +
> > +	/* Exclude Shared bit from the __PHYSICAL_MASK */
> > +	physical_mask &= ~tdx_shared_mask();
> >  }
> 
> I wish we had all of these 'physical_mask' manipulations in a single
> spot.  Can we consolidate these instead of having TDX and SME poke at
> them individually?

SME has to do it very early -- from __startup_64() -- as it sets the bit
on all memory, except what used for communication. TDX can postpone as we
don't need any shared mapping in very early boot.

Basically, to make it done from the same place we would need to move TDX
enumeration earlier into boot. It's risky: everything is more fragile
there.

I would rather keep it as is. We should be fine as long as we only allow
to clear bits from the mask.

-- 
 Kirill A. Shutemov
