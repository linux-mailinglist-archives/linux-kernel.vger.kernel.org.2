Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25566388F6A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 15:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353754AbhESNpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 09:45:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55057 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239919AbhESNpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 09:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621431864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LJSW7Dy9FR3zafoPH+EoEEnX0R29tbOmjGmAjRdxKk0=;
        b=etwHp+8QLZoTr8OfIdo46La3+xN4q0rpf0QxbiFu8pHyoggejMXsBL5AiEbSkh+DOYo2Af
        VWMF0uPZUO52a1aSAm0yG4u2tc8BnHwPO7hUZLY3CUing/cTHox7wJGCdisiERbMpAmu+D
        IEbeZUsPYUKVJZcsePXw7UjjSF5Z35E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-1HUnwwPsMfGb6x1JPK9EKw-1; Wed, 19 May 2021 09:44:21 -0400
X-MC-Unique: 1HUnwwPsMfGb6x1JPK9EKw-1
Received: by mail-wr1-f71.google.com with SMTP id 22-20020adf82960000b02901115ae2f734so7184008wrc.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 06:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LJSW7Dy9FR3zafoPH+EoEEnX0R29tbOmjGmAjRdxKk0=;
        b=O5YYkRVKl5LR3xLr5GFZXRqhJMQu6TZKJgBwScXYkZK7NfYnZ55l/kWVAvDMHVZc5S
         1Gzjs6dw1XMVMxAiCVx+NokYzbyrGH0IPWwFKSrhbr+eMOCVWlfr822bMc8/H6vHN3LZ
         Z45hi1Xsk3g6Y/IQJN9GsxJsj2BPqg+pkYIXaULJ/rR3wFVGNaIjAB73p1X4Jrc1J4mU
         9WHQwj52sx7jYGHiVbboKKU5M7pi0gKItyPzvuiKKaHG1GnSZHJNombGReX/praEe5Hr
         hBcHBG73FRPqihBgIOOGj6+IGhClKx4kZ6SzWqvP9Tz8r2rXe+C27m2RTmngp6/Nj38I
         1rHw==
X-Gm-Message-State: AOAM531Cf+xNkOYAKA3MKRryHCeColDhKHvLmHgJrrbisqkDYLvLE63K
        3UYEzy5wKcfaHY+pmn7wvVpokbqUAhBpF0367cqSo9895Jd03KkryAueNGmYOdHYXPGb1+DX2ab
        18udXRikA8I6xDz2hs7aY0YVy
X-Received: by 2002:a5d:6285:: with SMTP id k5mr14778072wru.50.1621431860366;
        Wed, 19 May 2021 06:44:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPny7uEtz/zZyoiwC9xBSb3weeyHOxeLbadHaxRJN/jHDXuBqP+gHrGOxsnOJ2kyJxeU9ong==
X-Received: by 2002:a5d:6285:: with SMTP id k5mr14778052wru.50.1621431860200;
        Wed, 19 May 2021 06:44:20 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id g5sm11409775wmi.8.2021.05.19.06.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 06:44:19 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] mm: x86: Invoke hypercall when page encryption
 status is changed
To:     Ashish Kalra <ashish.kalra@amd.com>,
        Steve Rutherford <srutherford@google.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        X86 ML <x86@kernel.org>, KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Venu Busireddy <venu.busireddy@oracle.com>,
        Brijesh Singh <brijesh.singh@amd.com>
References: <cover.1619193043.git.ashish.kalra@amd.com>
 <ff68a73e0cdaf89e56add5c8b6e110df881fede1.1619193043.git.ashish.kalra@amd.com>
 <YJvU+RAvetAPT2XY@zn.tnic> <20210513043441.GA28019@ashkalra_ubuntu_server>
 <YJ4n2Ypmq/7U1znM@zn.tnic> <7ac12a36-5886-cb07-cc77-a96daa76b854@redhat.com>
 <20210514090523.GA21627@ashkalra_ubuntu_server> <YJ5EKPLA9WluUdFG@zn.tnic>
 <20210514100519.GA21705@ashkalra_ubuntu_server>
 <CABayD+e9NHytm5RA7MakRq5EqPJ+U11jWkEFpJKSqm0otBidaQ@mail.gmail.com>
 <20210519120642.GA19235@ashkalra_ubuntu_server>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a4766cb8-be69-03d3-6320-55c10bdc1672@redhat.com>
Date:   Wed, 19 May 2021 15:44:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210519120642.GA19235@ashkalra_ubuntu_server>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/21 14:06, Ashish Kalra wrote:
> Now these buffers have very short life and only used for immediate I/O
> and then freed, so they may not be of major concern for SEV
> migration ?

Well, they are a concern because they do break migration.  But it may be 
indeed good enough to just have a WARN ("bad things may happen and you 
get to keep both pieces") and not disable future migration.

A BUG must always be avoided unless you're sure that something *worse* 
will happen in the future, e.g. a BUG is acceptable if you have detected 
a use-after-free or a dangling pointer.  This is not the case.

Paolo

> So disabling migration for failure of address lookup or mapping failures
> on such pages will really be an overkill.
> Might be in favor of Steve's thoughts above of doing a BUG() here
> instead.

