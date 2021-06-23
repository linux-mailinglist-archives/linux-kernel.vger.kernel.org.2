Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7503B1EDA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 18:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhFWQnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 12:43:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29880 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229812AbhFWQnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 12:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624466482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ynli02bru2/iFuBR+RJeS0ZwL27DEp0PRrtJUjqVDDQ=;
        b=XMPTKliHfBZvUtyq+0/eG7NnC9QHpFL84UuQfOWExIi2nFlhsoLpokniBIbrroPgMPxEDc
        /DNGUkZrQEquX7+VKpSfmPm9xwAzuiiwM+hVwK7P8jukjBGvqEapZUwnGqVrryWU+wTV6G
        QrtcXxfjAFXpRcwqnhWG+x/hl1CaAV4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-3h5f4WPjPbm_7zHc8CBcvg-1; Wed, 23 Jun 2021 12:41:21 -0400
X-MC-Unique: 3h5f4WPjPbm_7zHc8CBcvg-1
Received: by mail-ej1-f70.google.com with SMTP id nd10-20020a170907628ab02903a324b229bfso1210269ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 09:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ynli02bru2/iFuBR+RJeS0ZwL27DEp0PRrtJUjqVDDQ=;
        b=ocy7hAZAgUZq9Ra5T0YO4RLWcetG2nrE9/iHkNtDA6P/jwIb0MBl9udRKZuOqCRtKw
         3l0p5EC0MbVVcUVCsEA7Dg9MLMMJwIhCPv+V5xfM47FEoSgZpw2q9wmO4abiodp7dqwc
         BH+8EFSzK2jCXwf2vPnNk2C4aKkTDhse2aI2aOTeY96TavAB3PLKh97mmZQxd4H/X3Az
         AGBxW4a65i73n7mG1x2iNJRbdYQslWkfNIA4YmVV/kYME1Ngr8l3R1RgwSh3K8yJ96jT
         mjYte72hApnWQQLNYidFPo8HyQpBm13h2GTq8iRgJDAusAHEhVjjLcw0jfj8jQYvT4QN
         L3dA==
X-Gm-Message-State: AOAM532VJ6PRkaXzvVIO5kK9CFWAlqLrydiu9dOxSKGCxK+3jEe18w33
        1IV8z27xCK05jVcM1tuvEpnBwNp3WE43VPOa6HGAuK7D6kkSNV39WMF/KyPhalzGgP/yCbnLCMR
        R+njTiOnWM6k+BDwGyopT5e7Y
X-Received: by 2002:a05:6402:40c4:: with SMTP id z4mr899709edb.364.1624466479821;
        Wed, 23 Jun 2021 09:41:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGYf2bIPtd6IssXH+uNOdj4qa4yCHAz5dsjWzB7o0RMDCxlFvyB20ju7RNqXmiyMvp+mEt8g==
X-Received: by 2002:a05:6402:40c4:: with SMTP id z4mr899685edb.364.1624466479678;
        Wed, 23 Jun 2021 09:41:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id g15sm117603ejb.103.2021.06.23.09.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 09:41:19 -0700 (PDT)
Subject: Re: [PATCH 10/54] KVM: x86/mmu: Replace EPT shadow page shenanigans
 with simpler check
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
References: <20210622175739.3610207-1-seanjc@google.com>
 <20210622175739.3610207-11-seanjc@google.com>
 <8ce36922-dba0-9b53-6f74-82f3f68b443c@redhat.com>
 <YNNegF8RcF3vX2Sh@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <df77b8e9-b2bb-b085-0789-909a8b9d44c3@redhat.com>
Date:   Wed, 23 Jun 2021 18:41:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YNNegF8RcF3vX2Sh@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/21 18:17, Sean Christopherson wrote:
>> What the commit message doesn't say is, did we miss this
>> opportunity all along, or has there been a change since commit
>> 47c42e6b4192 ("KVM: x86: fix handling of role.cr4_pae and rename it
>> to 'gpte_size'", 2019-03-28) that allows this?
>
> The code was wrong from the initial "unsync" commit.  The 4-byte vs.
> 8-byte check papered over the real bug, which was that the roles were
> not checked for compabitility.  I suspect that the bug only
> manisfested as an observable problem when the GPTE sizes mismatched,
> thus the PAE check was added.

I meant that we really never needed is_ept_sp, and you could have used 
the simpler check already at the time you introduced gpte_is_8_bytes. 
But anyway I think we're in agreement.

Paolo

