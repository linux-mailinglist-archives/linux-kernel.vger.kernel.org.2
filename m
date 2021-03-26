Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8EFF34AD27
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 18:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhCZRM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 13:12:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52915 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230070AbhCZRL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 13:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616778718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Apq3QGY5HZXG/uM2pLcZnDEDEALJq2/nq3GVPp6oDqE=;
        b=KmQHWJBwN0gdhOe3KRZU9EXKXXKZ7Zv04xwzxjSE+6SN9igwVsBHSgaxE3cIhuz5q+d8CK
        iWOMOIiqpKT+7rBp45xo2wRSlrg5vLCSo2yi4uObFLx8yu7Hc+wMouhXDQvvg2uqJ4SZ1L
        xcCYfmFKtWfERm3SqcX4UFF9rSM8AX4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213--N5BOUUHOwexDcJBBEkdPA-1; Fri, 26 Mar 2021 13:11:56 -0400
X-MC-Unique: -N5BOUUHOwexDcJBBEkdPA-1
Received: by mail-ej1-f69.google.com with SMTP id a22so4347767ejx.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 10:11:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Apq3QGY5HZXG/uM2pLcZnDEDEALJq2/nq3GVPp6oDqE=;
        b=Oyi9mojrbgGfRB/rS7GNZQfdmioIwGgo/vALE1QZomVUVGY6PJTlq9YrG9URjz6t4T
         8583qiLRvWKwwv9PEc5Wo18kPdma7/oNdNZM459UTTFNwBf53G9RZyWkMPKX1qBMcpVr
         IiyfHsdec+0Nw0tziBEzvFn7nkW2gIOzH8BBqJ/HjApbbgjR5LBpMDQACs9jdR4dl0v6
         cIeZrGIQM19u+ieSjGoRxK9i9uO0qyVRCRcjW79IqCLll0um5voG4xHy9/tyNvC1P1z2
         UF+4cxdcoB1g+DAVT15htjkksIGCoYOu3+eVFfgVLv8gbGO7V2heu9a9G8u1Ixy7o1z+
         ohSQ==
X-Gm-Message-State: AOAM531hLRDTLGKKEMmRnDFh0aPsAmLu2GqRJMXPbtujjOeQi1vADYU0
        He60Bgqa50xmOlsEBebTr0h0S3H4SLAay1gtCHB4ygEug1ff65rjSAf49lAHqP4ky22es6l0sQK
        phML5uDhxsqwTs4MENHxpsN8Xusvj5kLPqNmLVzktGFv97jk0s6oceMO9+Sfd878vp8n69rum9I
        DT
X-Received: by 2002:a05:6402:4245:: with SMTP id g5mr16509423edb.306.1616778715377;
        Fri, 26 Mar 2021 10:11:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFYf3Dz9wMDvYlxGB2u4oUf+cmO9eCmIEDXpZ/pkWQRGINsOfvV9EyNJr1l7VWJoEGKUoj3g==
X-Received: by 2002:a05:6402:4245:: with SMTP id g5mr16509393edb.306.1616778715165;
        Fri, 26 Mar 2021 10:11:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id h8sm4478188ede.25.2021.03.26.10.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 10:11:54 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] KVM: x86/mmu: Don't allow TDP MMU to yield when
 recovering NX pages
To:     Ben Gardon <bgardon@google.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210325200119.1359384-1-seanjc@google.com>
 <20210325200119.1359384-4-seanjc@google.com>
 <CANgfPd8N1+oxPWyO+Ob=hSs4nkdedusde6RQ5TXTX8hi48mvOw@mail.gmail.com>
 <YF0N5/qsmsNHQeVy@google.com>
 <CANgfPd98XttnW0VTN3nSyd=ZWO8sQR53C2oygC6OH+DecMnioA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3a7a4040-91ad-354e-25a6-10471163a3ce@redhat.com>
Date:   Fri, 26 Mar 2021 18:11:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CANgfPd98XttnW0VTN3nSyd=ZWO8sQR53C2oygC6OH+DecMnioA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/21 23:45, Ben Gardon wrote:
> I think in an earlier version of the TDP that I sent out, NX reclaim
> was a seperate thread for the two MMUs, sidestepping the balance
> issue.
> I think the TDP MMU also had a seperate NX reclaim list.
> That would also make it easier to do something under the read lock.

Yes that was my suggestion actually, I preferred to keep things simple 
because most of the time there would be only TDP MMU pages.

Paolo

