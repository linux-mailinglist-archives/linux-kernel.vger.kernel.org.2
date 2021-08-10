Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73AE33E8668
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 01:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbhHJXXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 19:23:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44671 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235242AbhHJXXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 19:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628637762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zebpogOe1quBLKE4Uo3idNxbcVJ3dkkOF+OjhdeOFhQ=;
        b=FJV3Enk97eLoVlCtxOazQGI2hPVz2Xvfl4Ymd65Nv75CEGMgNAIoRz6c7mjPvjZ2nY7vNg
        P3zhyex+KCRPMWvTMLFVcCm0Tb4TCXjnntBeB/DNYwzT1vQfaQVFmgbYcGzyLOR0Y7YL7B
        hw3D2tPYHpRsRYuzQmETGvBgI9DB/lU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-8sUeBw2HMiS1znibykBByA-1; Tue, 10 Aug 2021 19:22:40 -0400
X-MC-Unique: 8sUeBw2HMiS1znibykBByA-1
Received: by mail-qt1-f200.google.com with SMTP id w11-20020ac857cb0000b029024e7e455d67so321340qta.16
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 16:22:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zebpogOe1quBLKE4Uo3idNxbcVJ3dkkOF+OjhdeOFhQ=;
        b=PdBviySRWf2lRXZsvfVDP66fodQ82UvLK2tSL07LF/9KdVmooJ8X2Cm6pmsUk9Khtr
         e/wMfukeZohPb23DlyNQfMdSvR02Vg36WfcK6BbUBZWm+fjjwQCVbEkS5f9oAEmqVeJi
         Ycm2D9vDQME3RcmYCVHIDTTmpUCAb/P2PGH9lsgG1Nu15GEeNgvU+zd9BJaWXIY7yY+4
         MdBBjAj04W6bfz3WeAbfQpVrtKx6CBsEFJYo8j82vwuuNyk+B0v7E4XYP79oEZMz2Ved
         0A8EBKcqqZN+CO393e8k1atXF4/MgnYlfTOYBmK/DxAKC+sirXgr52H17M5OJTzVjNzQ
         BSqw==
X-Gm-Message-State: AOAM530qR+uHA91WQU/58l7JyGjvKUoQREsI6BFtNB1GqYAP0g7Mh7GH
        Eo9ILGYOrbObWylWbhmdI4/Of3dDk9VSjuMYkUFReaeKThZdcYNOJH4j1dsfmIBb8Z6F18EyKWB
        V4QLLbLaVLulyUz7HJPCrfyPZ
X-Received: by 2002:a05:620a:318b:: with SMTP id bi11mr17242552qkb.302.1628637759724;
        Tue, 10 Aug 2021 16:22:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRqxrHLUeXL8415G82p0kwf+OoH+p90MLbtMF/Y3gvXjd4Z1rzFmseE9OfMSwFwyYvyHyAVA==
X-Received: by 2002:a05:620a:318b:: with SMTP id bi11mr17242527qkb.302.1628637759517;
        Tue, 10 Aug 2021 16:22:39 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-92-76-70-75-133.dsl.bell.ca. [76.70.75.133])
        by smtp.gmail.com with ESMTPSA id b11sm5934711qtt.42.2021.08.10.16.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 16:22:38 -0700 (PDT)
Date:   Tue, 10 Aug 2021 19:22:37 -0400
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
Message-ID: <YRMKPd2ZarXCX6vm@t490s>
References: <20210803044607.599629-1-mizhang@google.com>
 <20210803044607.599629-4-mizhang@google.com>
 <CALMp9eR4AB0O7__VwGNbnm-99Pp7fNssr8XGHpq+6Pwkpo_oAw@mail.gmail.com>
 <CAL715WJLfJc3dnLUcMRY=wNPX0XDuL9WzF-4VWMdS_OudShXHg@mail.gmail.com>
 <CAL715WLO9+CpNa4ZQX4J2OdyqOBsX0+g0M4bNe+A+6FVxB2OxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL715WLO9+CpNa4ZQX4J2OdyqOBsX0+g0M4bNe+A+6FVxB2OxA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2021 at 05:01:39PM -0700, Mingwei Zhang wrote:
> Hi Paolo,

Hi, Mingwei,

> 
> I recently looked at the patches queued and I find this patch from
> Peter Xu (Cced), which is also adding 'page stats' information into
> KVM:
> 
> https://patchwork.kernel.org/project/kvm/patch/20210625153214.43106-7-peterx@redhat.com/
> 
> From a functionality point of view, the above patch seems duplicate
> with mine.

The rmap statistics are majorly for rmap, not huge pages.

> But in detail, Peter's approach is using debugfs with
> proper locking to traverse the whole rmap to get the detailed page
> sizes in different granularity.
> 
> In comparison, mine is to add extra code in low level SPTE update
> routines and store aggregated data in kvm->kvm_stats. This data could
> be retrieved from Jing's fd based API without any lock required, but
> it does not provide the fine granular information such as the number
> of contiguous 4KG/2MB/1GB pages.
> 
> So would you mind giving me some feedback on this patch? I would
> really appreciate it.

I have a question: why change to using atomic ops?  As most kvm statistics
seems to be not with atomics before.

AFAIK atomics are expensive, and they get even more expensive when the host is
bigger (it should easily go into ten-nanosecond level).  So I have no idea
whether it's worth it for persuing that accuracy.

Thanks,

-- 
Peter Xu

