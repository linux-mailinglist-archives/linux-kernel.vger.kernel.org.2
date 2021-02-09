Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B04314CC4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbhBIKS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 05:18:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20316 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231320AbhBIKDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612864899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k1i4kA2ikoqEIy73WvpsH9kR9GpwZKdO/NHE9o+wheQ=;
        b=FjKU0y4JGGEP0fy2WK2BS32WItnIEcNU7+hACOJz1uBuHTzLx/vfKgunl3xjN7CqIS+ey1
        HX3gmi3FEtOFBUDcXVenJB+BAEvPNuM1ntMxmBOlYe8ko8kgO+/f8iJIA/l0p8IEK8PH5Q
        g2gf4lA45I67NdmXZuFt5IPJbrcaETU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-YWZannIgNSmhHCnt7mRSFQ-1; Tue, 09 Feb 2021 05:01:37 -0500
X-MC-Unique: YWZannIgNSmhHCnt7mRSFQ-1
Received: by mail-wm1-f69.google.com with SMTP id l21so2024702wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 02:01:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k1i4kA2ikoqEIy73WvpsH9kR9GpwZKdO/NHE9o+wheQ=;
        b=l1M1EDeumIL97XOvs9LhKdb/j3X0u1Ow6+KGk0F6IjMiwT6Z7ZnR/V1pzMMbm7UC6U
         8hzSV+2YJlLzYqQ48Lf0mnTLpE0qbjRzub4dbskKPhkGMtBduPrEt2G1ewUCIUmseAkQ
         DU2jkeZkp6Y5V3dyjXCiAJ//MhFMb993u0tQPHAcItfdGBbHOyDe5meBR8yzQeUiqI/s
         ZrEdXRo4F3+BCOe15SNo2IO1xff6jgpqDZvf3qGNHn6QSzfNNdiSjaDF6388fOvfX9cQ
         N8wBJBZiaU/E6D7Vwk8ShYxsbmgCYcd7LADKPDmDbeq+sRl5PIAgz7VKYYOLsMV7KyS7
         2nTA==
X-Gm-Message-State: AOAM531IVcXN0dNz6qWd0ofVNiOJzpfrbXm08+AhHKpGgRZyiATZfbqd
        ap82VW+psm/LsgBxJ5ydEWQoV+dH4Db2px8llXMPMAxlo4jrUcA7AKn4xMF0r78zQE6uMU+zZ+8
        VX8Te7nJUR3OyFW1/l17Ie69l
X-Received: by 2002:a1c:318a:: with SMTP id x132mr2667849wmx.6.1612864896708;
        Tue, 09 Feb 2021 02:01:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxpw6BIjnxiqkkeBjvrgae2D4o30y8fHuHqIVL3LcVSiw5rpDZgzP228TVvO4qazqkSUeeNQw==
X-Received: by 2002:a1c:318a:: with SMTP id x132mr2667839wmx.6.1612864896557;
        Tue, 09 Feb 2021 02:01:36 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id b13sm13625804wrs.35.2021.02.09.02.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 02:01:35 -0800 (PST)
Subject: Re: linux-next: build warning after merge of the kvm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>, KVM <kvm@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>
References: <20210209205950.7be889db@canb.auug.org.au>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <23ec3e79-1b6d-a116-ff52-3c5c1d0308d1@redhat.com>
Date:   Tue, 9 Feb 2021 11:01:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210209205950.7be889db@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/21 10:59, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the kvm tree, today's linux-next build (htmldocs) produced
> this warning:
> 
> Documentation/virt/kvm/api.rst:4927: WARNING: Title underline too short.
> 
> 4.130 KVM_XEN_VCPU_GET_ATTR
> --------------------------
> 
> Introduced by commit
> 
>    e1f68169a4f8 ("KVM: Add documentation for Xen hypercall and shared_info updates")
> 

Thanks, will fix.

Paolo

