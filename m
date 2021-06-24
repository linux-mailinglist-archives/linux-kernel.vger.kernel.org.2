Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77E43B390B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 00:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbhFXWGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 18:06:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42451 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232650AbhFXWGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 18:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624572226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xINwPHS+dfHZopNTm0uHfsDrjJ9951BYIaDBQCjjtec=;
        b=auOIuPrcQXdygrnnWKib6NnLx/OF3Aqwj7PkxWx7k2AWMGm9gzHdKeAjGy/UoczpwXcOdm
        Qnl97IDmnQRWimVcs8uRKjpmRGQPh4+lhrM8SRCExg9FThr7xAOxSojtOgMOLGid2jeSw1
        TpP5HbHA5ShpuxNWzaAwgnWHQpV7WIQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-oeOwFXImMvmjsCVHTAe-AA-1; Thu, 24 Jun 2021 18:03:45 -0400
X-MC-Unique: oeOwFXImMvmjsCVHTAe-AA-1
Received: by mail-wm1-f69.google.com with SMTP id u17-20020a05600c19d1b02901af4c4deac5so2160246wmq.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 15:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xINwPHS+dfHZopNTm0uHfsDrjJ9951BYIaDBQCjjtec=;
        b=nCNurv/jWaqPD9tSV6ZvdWSGhmkVwYgpzBw/o3jSGIpPIGJgUCstJK9zddOIZokPBx
         CgFU8IWpW9T9ipSWZK6NmT5HCVIg+WXcZjd0YjDdxqUkZINQdeyzD45GGnwaYpY0P9Gj
         sOKaxZc6QfmcSEpNN3Q7AYNrUqBKraZVFoZ0ynS1bcplnpAnjZsFtv2hmutqPbELVb0p
         7LwIftzZWRiaYOwMHz/UGjjmvyxyg4gKJEzxSVsXQDGtWFvLVD1A4PNxQ7/g60OIxcsh
         k7PxHvAXRT25eiiK5kVjINfi6kU/Xx78OXJbBuWemfFIgaNFAgW7SyYXS4+jEYC1fcRc
         12+g==
X-Gm-Message-State: AOAM5322cFzNw3A0Zvfa7TmS8d8JW1BiTKZFxc1faBCgDBe5cDbzlGxn
        +k/sPKeAp/E7Yyi7OMz1PuB+b+2MouitcUzin62fyRyTXK2njL697hxvmzlFiLRxFKROz//1ls+
        hUqsE9GgDN/FimdVhdt9/KSyy
X-Received: by 2002:a5d:5259:: with SMTP id k25mr3794471wrc.331.1624572223964;
        Thu, 24 Jun 2021 15:03:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCgqS09+IiM0mecZm6NBFzQwOQy0GTv6Ec+vOZajqOGoB1Q1LI/2+ZdB/c10FvH+UwrAQ+JQ==
X-Received: by 2002:a5d:5259:: with SMTP id k25mr3794455wrc.331.1624572223821;
        Thu, 24 Jun 2021 15:03:43 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id x25sm10368574wmj.23.2021.06.24.15.03.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 15:03:43 -0700 (PDT)
Subject: Re: linux-next: Signed-off-by missing for commits in the kvm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>, KVM <kvm@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20210625075849.3cff81da@canb.auug.org.au>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9409cf8b-3d56-748f-64e6-6d1e42d62413@redhat.com>
Date:   Fri, 25 Jun 2021 00:03:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210625075849.3cff81da@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/21 23:58, Stephen Rothwell wrote:
> Hi all,
> 
> Commits
> 
>    df40a7ffa871 ("KVM: debugfs: Reuse binary stats descriptors")
>    01bb3b73038a ("KVM: selftests: Add selftest for KVM statistics data binary interface")
>    a4b86b00ad24 ("KVM: stats: Add documentation for binary statistics interface")
>    da28cb6cd042 ("KVM: stats: Support binary stats retrieval for a VCPU")
>    170a9e1294a7 ("KVM: stats: Support binary stats retrieval for a VM")
> 
> are missing a Signed-off-by from their committers.
> 

Fixed, thanks.  Still getting used to b4.

Paolo

