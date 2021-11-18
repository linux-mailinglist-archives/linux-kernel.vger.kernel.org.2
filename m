Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C604551C6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 01:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241991AbhKRAi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 19:38:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34305 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232441AbhKRAi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 19:38:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637195756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H2M4Gb3cmHoSrafJN3mnHsisz7WttR12tk9W7yfyJiE=;
        b=LWJOSC1LAl/KXI4JN692UdRar7ah9EIzSByhdNEt32aP5o+GModqicMEv6ynRSj5vyr4vU
        r7WBRmGualiGIbAi4j+d/F2Vynvi4iKSgArAmkTA2mu2VDrUSzu5pVAJJGNt7ZWLLhwGAd
        vITZo90Z4Ty2f2sUtWJGGhcrBu+ZEZU=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-8ai4baslOAaJmdamQfWCOw-1; Wed, 17 Nov 2021 19:35:55 -0500
X-MC-Unique: 8ai4baslOAaJmdamQfWCOw-1
Received: by mail-pf1-f200.google.com with SMTP id x25-20020aa79199000000b0044caf0d1ba8so2582416pfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 16:35:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H2M4Gb3cmHoSrafJN3mnHsisz7WttR12tk9W7yfyJiE=;
        b=rSgf7RiRPD8RIPQW5+d/BxN5YzeTwMKZJETA/rZ+EhibF3yGPM+w9SlcC5kgWNGgA7
         JV3VknXfu4glBhz3BdhcAyLMv/anOso/P5r/PKjjiIxCDSfztwCKElcKmp6cWDT++X+P
         s6S0PRCKXYssmMuPa5/rCUfxX7Lo++RT3/T6OM+B4ZHri9E4QYG7O5VbIOSlBIA7BRFq
         aU3hXC3eTMhCPp+CDlUnW4hXW1WqewQC8zMHLjrczyBzCtu0Ro5mH3FcSRtaXSx/6bu0
         96MSf1KKLmjPrSsZPhlmLSP4805YbNQ27QdjghWxGJaPhz2H+4gMm+Ne8oVRM7oUTx19
         Mn6w==
X-Gm-Message-State: AOAM532otJz1bKpg3ZX/OXnzNjHB46DGj2TTdQ4j9DjGrMt0kGwgMbnx
        GTNR+zV46UE1ze43Uneno6Vrr3kVGervmn1mdro3bFP4jF9TAXmoiIhDfSGQrzbbiLYLDcRD2rt
        rI1Ha1JnNnVzAzRr9iaq4Wd/2
X-Received: by 2002:a17:90b:4c4f:: with SMTP id np15mr5059076pjb.65.1637195754465;
        Wed, 17 Nov 2021 16:35:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzcRORMJpC3aKxfkFfHsfxftNO67uoZZZxJhoO5F4dyLPPoH8H48jpWfr6Egtb1+uLIeGVrBw==
X-Received: by 2002:a17:90b:4c4f:: with SMTP id np15mr5059031pjb.65.1637195754166;
        Wed, 17 Nov 2021 16:35:54 -0800 (PST)
Received: from xz-m1.local ([191.101.132.73])
        by smtp.gmail.com with ESMTPSA id pi17sm7089247pjb.34.2021.11.17.16.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 16:35:53 -0800 (PST)
Date:   Thu, 18 Nov 2021 08:35:46 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Yu Zhao <yuzhao@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v4] mm: Add PM_HUGE_THP_MAPPING to /proc/pid/pagemap
Message-ID: <YZWf4utHNPhUic7u@xz-m1.local>
References: <20211107235754.1395488-1-almasrymina@google.com>
 <YYtuqsnOSxA44AUX@t490s>
 <CAHS8izP9zJYfqmDouA1otnD-CsQtWJSta0KhOQq81qLSTOHB4Q@mail.gmail.com>
 <YY4bFPkfUhlpUqvo@xz-m1.local>
 <CAHS8izP7_BBH9NGz3XoL2=xVniH6REor=biqDSZ4wR=NaFS-8A@mail.gmail.com>
 <YZMQbiV9JQWd0EM+@xz-m1.local>
 <CAHS8izPwQidVLAEApJ4vnERwwK6iJ8phfedA0d4_NPwumzRFcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHS8izPwQidVLAEApJ4vnERwwK6iJ8phfedA0d4_NPwumzRFcw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 11:50:23AM -0800, Mina Almasry wrote:
> Awesome, thanks! PM_THP_MAPPED sounds good to me and I just sent v6
> with these changes.

Sorry I just noticed one paragraph of the new commit message that may need some
amending. I commented in the new version, please have a look.  Thanks,

-- 
Peter Xu

