Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEAD63591E6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 04:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbhDICRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 22:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbhDICRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 22:17:01 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BCEC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 19:16:49 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id x27so1955579qvd.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 19:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=vHCqILecOIPMQuLKMX6nqeGWPqCzxrgf7erUzPmed2M=;
        b=vUlcX0JmHoAeHVh7mvYJUTN5IFH3I+jOTc7imFq83Jp9W+LzGr01bfpD1NAdJONbx/
         vmHAARqJImYAeb863Nw2TMmzMLnBwCPpBhlVK7osUmveksTSMmyPS63zeKwEzbnyor2P
         BRI2aNvNZPLAaBl4snSim/3oaOiMgMN6xv4KlN4ndDDtOZVH/bRjjclTNHhpZMkw8LUo
         YSW0L1QUf0a8sA0NA3i0to87xFzxwEk8xOWWCK7KYYuDNupwRE9k9TU9Dy/fz5y0hgQi
         khqzeLYJW8ihZiO8tl9wqzEwi3PNd1hkfy3+jUJE6ZuixrOCdKP3JRtWJmD4ljQUsZf6
         5E/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=vHCqILecOIPMQuLKMX6nqeGWPqCzxrgf7erUzPmed2M=;
        b=qQijZiW/2LcAaMh1KUrXJFNa3f19irpkUuHUC6nGo6goWjjEP717nPebV/faPlBMKb
         WDLfNBua3xZ1vXTH2I0jWYaxO1tZAI51Kj3uMiMOiqdBdPS28VWmHiedfh0UJfyxpvGG
         PyB0nyW0bv5AL/d7lMid+pJe5TZgWKeQUr09RBn+lgDpKau9RkhWGRX8aOGAuizePt17
         FhCTtIW4uc8WLKiDX4P49SSKsAhQylPTzaLSQJuFZ7uPzsouCNTVODdDOmfgSVjUis2G
         DKfOYKXBhxDTj9/wc1Z/1q6ar1pv0kld+CRX+qAmxazDPRdNiIhUXJBLwx8X56e1BSFo
         pPrQ==
X-Gm-Message-State: AOAM532+liT8Hv5xd+OjlroJ6k3tGhjzuDcds+gseaUTx2a9177irarv
        8UhO3bTG3LNQU9f5aaI8JU6nZhb+xSc=
X-Google-Smtp-Source: ABdhPJzxiJ8LOxfShzSQ06LGn73uHCtnki60lqvmhHu+BVJZf39NIe4lJ5RSfdLC0VSskVlAPboFQw==
X-Received: by 2002:ad4:560e:: with SMTP id ca14mr9581170qvb.20.1617934608675;
        Thu, 08 Apr 2021 19:16:48 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com ([2804:14c:482:7b04::1000])
        by smtp.gmail.com with ESMTPSA id z24sm843211qkz.65.2021.04.08.19.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 19:16:47 -0700 (PDT)
Message-ID: <09c57b599f8dd95f4ff1c02b83aa093615257f2f.camel@gmail.com>
Subject: Re: [PATCH 1/3] powerpc/mm/hash: Avoid resizing-down HPT on first
 memory hotplug
From:   Leonardo Bras <leobras.c@gmail.com>
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sandipan Das <sandipan@linux.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Mike Rapoport <rppt@kernel.org>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Thu, 08 Apr 2021 23:16:41 -0300
In-Reply-To: <YFg+Edy6dfmZx3lr@yekko.fritz.box>
References: <20210312072940.598696-1-leobras.c@gmail.com>
         <20210312072940.598696-2-leobras.c@gmail.com>
         <YFg+Edy6dfmZx3lr@yekko.fritz.box>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David, thanks for your feedback.

On Mon, 2021-03-22 at 17:49 +1100, David Gibson wrote:
> I don't love this approach.  Adding the extra flag at this level seems
> a bit inelegant, and it means we're passing up an easy opportunity to
> reduce our resource footprint on the host.

I understand, but trying to reduce resource footprint in host, and
mostly failing is what causes hot-add and hot-remove to take so long.

> But... maybe we'll have to do it.  I'd like to see if we can get
> things to work well enough with just the "batching" to avoid multiple
> resize attempts first.

This batching is something I had thought a lot about.
Problem is that there are a lot of generic interfaces between memory
hotplug and actually resizing HPT. I tried a simpler approach in
patches 2 & 3, so I don't touch much stuff there.

Best regards,
Leonardo Bras




