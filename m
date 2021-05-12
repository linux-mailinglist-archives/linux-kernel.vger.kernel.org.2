Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF9137D19D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 20:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240909AbhELR7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 13:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240882AbhELQZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 12:25:49 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D7DC061763
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 08:53:58 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id l70so3791719pga.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 08:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ICPdyZXgRBAbj7CZwz12a51xwM2NvcuqGhPg+kKEs68=;
        b=WRfFMP8FAsXBX5doVKGofdL4hb9UH5YmwTfiLq95ByKa23qd3+NlfzCD4APred1OVl
         e5Osg5WZjJEzzVSCNIb9r3z5Ym6/oFncGsbIdZJ3QCrERONT0jd6R8+2Bov4gauJkCXW
         J0aW3nKrF5JSqEgVYmttYuCDAVj931OYBP0j2hTU1aL1tGcyLWS8gLShmWRStwS1na5o
         3okqXLK+JpT799BWDzOECK3EQs93AGs75PHemQSdFdbeKsTHXcP+gZJ3TemNEqun8iZz
         3Iw4VMgY+5U0JtMH09eCDrP8REfrbxi6PTgcRrpa/zMt8ZHH9DhS7h5v8EZS2LTToCRB
         Mb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ICPdyZXgRBAbj7CZwz12a51xwM2NvcuqGhPg+kKEs68=;
        b=O0/u319mEzrJ18N1j984yqZai9dIqw//10RUcpc67b2Pk5Y4vFXGFdZ8ctrzrl1dPK
         lzXpMN0Bv1RSz2s4p3CEEBUpVZTcJoh6EWgIUogzKAip947FDWvfI6RFlD8O8QoTks5S
         6JFhZoK86xWydiMdwFnsr1eDoAhkP7CDnm6gR/BYQYkA0KOy+WlH58F//qTaIGOYneSb
         I4dKR1vVl7AfNHZmqkmjqtciYk12rpXKk5CZqAAZhDwy+zcdRa7HR8pzDME9fUo0OLXa
         Tyt2W2olEnJPE3UqqrgZQzkaN0gqAVHl3cm2Q8rRhBSv8VD8uyynkE7LilYkczR1rES0
         gM0A==
X-Gm-Message-State: AOAM5317ldY2ZekQm9lGC7EF6QAW2BL7fOdX08N7J8NW/Re9yr8WDsEa
        nK+SFXwBqZTgBJBU5uel+53tSw==
X-Google-Smtp-Source: ABdhPJxjjVYaIi+t31QOtss36tD43pS9VcAHQRx7BwGpSbz1EiFLY3aY+wnVwNvTaLIhrmMl549xTg==
X-Received: by 2002:aa7:8194:0:b029:2aa:db3a:4c1d with SMTP id g20-20020aa781940000b02902aadb3a4c1dmr27280097pfi.58.1620834838027;
        Wed, 12 May 2021 08:53:58 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id v17sm213521pfi.188.2021.05.12.08.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 08:53:57 -0700 (PDT)
Date:   Wed, 12 May 2021 15:53:53 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 26/32] x86/mm: Move force_dma_unencrypted() to common
 code
Message-ID: <YJv6EWJmDYQL4Eqt@google.com>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <7c5adf75d69ea327b22b404b7c37b29712d73640.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <5536639a-918d-de8d-ff32-934a13902a03@intel.com>
 <d04e5992-8800-a8df-99de-4dbb40e45d09@linux.intel.com>
 <bbcb688c-5aa0-eeb1-192a-45edaccc2f32@intel.com>
 <20210512130821.7r2rtzcyjltecun7@box.shutemov.name>
 <e8886298-83fa-212e-ab3a-5e5b21a7ab6c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8886298-83fa-212e-ab3a-5e5b21a7ab6c@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021, Dave Hansen wrote:
> On 5/12/21 6:08 AM, Kirill A. Shutemov wrote:
> >> That's not an excuse to have a bunch of AMD (or Intel) feature-specific
> >> code in a file named "common".  I'd make an attempt to keep them
> >> separate and then call into the two separate functions *from* the common
> >> function.
> > But why? What good does the additional level of inderection brings?
> > 
> > It's like saying arch/x86/kernel/cpu/common.c shouldn't have anything AMD
> > or Intel specific. If a function can cover both vendors I don't see a
> > point for additinal complexity.
> 
> Because the code is already separate.  You're actually going to some
> trouble to move the SEV-specific code and then combine it with the
> TDX-specific code.
> 
> Anyway, please just give it a shot.  Should take all of ten minutes.  If
> it doesn't work out in practice, fine.  You'll have a good paragraph for
> the changelog.

Or maybe wait to see how Boris' propose protected_guest_has() pans out?  E.g. if
we can do "protected_guest_has(MEMORY_ENCRYPTION)" or whatever, then the truly
common bits could be placed into common.c without any vendor-specific logic.
