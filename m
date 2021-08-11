Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CA13E9250
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 15:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhHKNNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 09:13:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59715 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229737AbhHKNNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 09:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628687561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2NUW/hFy3oKZH4mmTKs/nk2n/0GK2CKMBtpxsO4eQow=;
        b=NE6FG/sOHmDGU+8w06VPrqwfsBL4Tkp46svd5RJNVCtiRWKJ4TFu7ypOkdM8JZiyskjR0/
        nre+1AkvIT/1TTGzgC8LcytAMb+CfoygkQhZTnGBtkYYPm46S9QamKri8uwpGu14BZ8NTL
        rb5xWMRJ69/VZMLnoynA8JRqW2+GFw8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-9FSFYolsOxawa54OxEPzkQ-1; Wed, 11 Aug 2021 09:12:39 -0400
X-MC-Unique: 9FSFYolsOxawa54OxEPzkQ-1
Received: by mail-qk1-f199.google.com with SMTP id a72-20020ae9e84b0000b02903d1f6aa7886so1280968qkg.21
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 06:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2NUW/hFy3oKZH4mmTKs/nk2n/0GK2CKMBtpxsO4eQow=;
        b=OXDEGCK16SQ/W43X3n/mE4iKswvCiWzVYGzT6xXEjn2Sgio+u7i6yTpnsgT4ukusec
         mvRHpbm0pKhSnvYUgR3CrkTqiW8hE5vkohrXChN4P/wahts1WzcI9viAERGQVHsg5uc6
         j9HqiEzIoy5Fxtihmaqd0GWAtlc4iIQXUt2gSFaW938NhczwzDXLl4BjbjN16vuwq+bK
         GzMZDK7iaGyYTVFFhkwGGMote86F1ANzc15qsUoNjGw6+FvxpXW43Vn9kvTDdZO7S4Nq
         lpShxupDGxoAvsHcUf1D1m9LtfNnJCSLjDxw/FtSt/dOL74trkkAECz0CFqYrdJNK8Zu
         y/Xw==
X-Gm-Message-State: AOAM532yhibwead0BTpajXG3sd9l1U5pL5U5x+3OsCO+G5ctFijJX+b/
        J1TscEBPqcflEPKGVakpta4aIJGMsMSE4cCTyGwHl7HWTiD3gF3BIutbTbHAG9vv6rElCYroYjM
        IqatyTjGwhVly8osACG539q48
X-Received: by 2002:a37:9e12:: with SMTP id h18mr26581534qke.269.1628687559235;
        Wed, 11 Aug 2021 06:12:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUEmKnJEHSZ0KQnrVX16waRKFwS+41amT0mSFyyGRu0A/WJoOskG6slHX0D4+bfgBYmlmxUA==
X-Received: by 2002:a37:9e12:: with SMTP id h18mr26581513qke.269.1628687559009;
        Wed, 11 Aug 2021 06:12:39 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-92-76-70-75-133.dsl.bell.ca. [76.70.75.133])
        by smtp.gmail.com with ESMTPSA id k1sm6848200qkj.21.2021.08.11.06.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 06:12:38 -0700 (PDT)
Date:   Wed, 11 Aug 2021 09:12:36 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Gardon <bgardon@google.com>,
        David Matlack <dmatlack@google.com>,
        Jing Zhang <jingzhangos@google.com>
Subject: Re: [PATCH v4 3/3] KVM: x86/mmu: Add detailed page size stats
Message-ID: <YRPMxLdL5vsZRyux@t490s>
References: <20210803044607.599629-1-mizhang@google.com>
 <20210803044607.599629-4-mizhang@google.com>
 <CALMp9eR4AB0O7__VwGNbnm-99Pp7fNssr8XGHpq+6Pwkpo_oAw@mail.gmail.com>
 <CAL715WJLfJc3dnLUcMRY=wNPX0XDuL9WzF-4VWMdS_OudShXHg@mail.gmail.com>
 <CAL715WLO9+CpNa4ZQX4J2OdyqOBsX0+g0M4bNe+A+6FVxB2OxA@mail.gmail.com>
 <YRMKPd2ZarXCX6vm@t490s>
 <CAL715WJWPzBqmjeTJ6mZa=dUaF5+MdqaCrk5CEzvcz1X99cm0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL715WJWPzBqmjeTJ6mZa=dUaF5+MdqaCrk5CEzvcz1X99cm0g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 06:06:51PM -0700, Mingwei Zhang wrote:
> Regarding the pursuit for accuracy, I think there might be several
> reasons. One of the most critical reasons that I know is that we need
> to ensure dirty logging works correctly, i.e., when dirty logging is
> enabled, all huge pages (both 2MB and 1GB) _are_ gone. Hope that
> clarifies a little bit?

It's just for statistics, right?  I mean dirty log should be working even
without this change.

But I didn't read closely last night, so we want to have "how many huge pages
we're mapping", not "how many we've mapped in the history".  Yes that makes
sense to be accurate.  I should have looked more carefully, sorry.

PS: it turns out atomic is not that expensive as I thought even on a 200 core
system, which takes 7ns (but for sure it's still expensive than normal memory
ops, and bus locking); I thought it'll be bigger as on a 40 core system I got
15ns which is 2x of my laptop of 8 cores, but it didn't really grow but shrink.

Thanks,

-- 
Peter Xu

