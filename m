Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE773B1CA8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 16:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhFWOjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 10:39:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59265 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231185AbhFWOjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 10:39:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624459014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VBMDG4UXrSJboSIzPzYeNyQOJqoBBhGOYVr8H5cUqrM=;
        b=g8wnmVT8OM8ekkQeo8A20bNDK3hSOvjhKql31HpoczOcziNVUvb9hBVWf61bsOAGtnpeRt
        SUtXwltXshb2InLHgbBdEWxsATDYkoxYArg/fa1TME8ETZ+8IW+3Qw/6BTuSVbMiWpa69V
        H9Iq4C+wzERYhnKdVAg8E5pA8xBsxWk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-WsYo9_bmNFCK8aHhURxH2A-1; Wed, 23 Jun 2021 10:36:53 -0400
X-MC-Unique: WsYo9_bmNFCK8aHhURxH2A-1
Received: by mail-ed1-f69.google.com with SMTP id r6-20020a05640216c6b0290394ed90b605so1318121edx.20
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 07:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VBMDG4UXrSJboSIzPzYeNyQOJqoBBhGOYVr8H5cUqrM=;
        b=VL9u84ktfsTzJM13FIYJECke8Goyq9432gJlDCOh0tV9k/kjtuK/4WtetbTBu3FrQB
         wgtrz9ejamNEBjQTev2r0AvXRSYd3DOBDmn30oKF8N3lKYez3nTXhRIYOpDRIslvumrx
         4YydTDl6YA5+F0cdE8kumcW0Po0++KIanwmQLvqpCnXqs2fIHb93ePJemxKJ8v+8vQbs
         UI6c0ip7bD/MY0qcIQ7+QyAQxVzc9tqbZwlHMcGTrtkWrEB1VmAw8w0JuBdBlZR+Osoi
         uuHV5CuL1+JTfH/+KHzuDMnYJQrudiKplYSMCXVd4uyowvRDeqwrrCDZD+jSTVd0Wj8e
         fisg==
X-Gm-Message-State: AOAM5310jDLkkqLq8p8FFYgoH8lXqB3ViCR03U0UsTjh1r6QL+F6qe8X
        gfctojp3fQIpFqRKWrmrmNXR0d3WVP5hqX+VqJk5I7RsUKqQm7jWGES31uzcSos4Ow8zRg5xH0T
        BELTRei3kjF7jMdxpoehAKfqQ
X-Received: by 2002:a05:6402:27c9:: with SMTP id c9mr13083961ede.371.1624459011908;
        Wed, 23 Jun 2021 07:36:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxn6E7ZOsBU41zrf1ugX7X/dOmdoRD+dXxMpFcDw6hD51zUhNu4HUdFstpH5YCILWNR9OpFag==
X-Received: by 2002:a05:6402:27c9:: with SMTP id c9mr13083945ede.371.1624459011780;
        Wed, 23 Jun 2021 07:36:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id g15sm7358368ejb.103.2021.06.23.07.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 07:36:51 -0700 (PDT)
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
References: <20210622175739.3610207-1-seanjc@google.com>
 <20210622175739.3610207-10-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 09/54] KVM: x86/mmu: Unconditionally zap unsync SPs when
 creating >4k SP at GFN
Message-ID: <f2dcfe12-e562-754e-2756-1414e8e2775f@redhat.com>
Date:   Wed, 23 Jun 2021 16:36:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210622175739.3610207-10-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/21 19:56, Sean Christopherson wrote:
> When creating a new upper-level shadow page, zap unsync shadow pages at
> the same target gfn instead of attempting to sync the pages.  This fixes
> a bug where an unsync shadow page could be sync'd with an incompatible
> context, e.g. wrong smm, is_guest, etc... flags.  In practice, the bug is
> relatively benign as sync_page() is all but guaranteed to fail its check
> that the guest's desired gfn (for the to-be-sync'd page) matches the
> current gfn associated with the shadow page.  I.e. kvm_sync_page() would
> end up zapping the page anyways.
> 
> Alternatively, __kvm_sync_page() could be modified to explicitly verify
> the mmu_role of the unsync shadow page is compatible with the current MMU
> context.  But, except for this specific case, __kvm_sync_page() is called
> iff the page is compatible, e.g. the transient sync in kvm_mmu_get_page()
> requires an exact role match, and the call from kvm_sync_mmu_roots() is
> only synchronizing shadow pages from the current MMU (which better be
> compatible or KVM has problems).  And as described above, attempting to
> sync shadow pages when creating an upper-level shadow page is unlikely
> to succeed, e.g. zero successful syncs were observed when running Linux
> guests despite over a million attempts.

One issue, this WARN_ON may now trigger:

                         WARN_ON(!list_empty(&invalid_list));

due to a kvm_mmu_prepare_zap_page that could have happened on an earlier 
iteration of the for_each_valid_sp.  Before your change, __kvm_sync_page 
would be called always before kvm_sync_pages could add anything to 
invalid_list.

Paolo

