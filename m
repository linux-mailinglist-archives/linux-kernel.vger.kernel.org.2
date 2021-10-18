Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9050D431A52
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 15:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbhJRNFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 09:05:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36656 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231503AbhJRNFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 09:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634562197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MbqKh+ocsWx5WVLcHJZwNDE2rIoRehaxbUtlPRHh7fk=;
        b=F7WZAncSkbx8i2pCSh/HnW/7FERf5hhDjnrK69mQVlPQVlt3qK6AekEvAnw3Q3cY+QldvW
        maL44Fo7CvYUDNoMQlWBbXriyR29FBfeNlk7VlcgdRCToqsM8w0RM07Hvv86F+xWh9+j6R
        UjI2lAmvQZ1eoYyP9hk8okGfNR6fzVk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-2ALlBqz6OvWixf2XwUxiQA-1; Mon, 18 Oct 2021 09:03:15 -0400
X-MC-Unique: 2ALlBqz6OvWixf2XwUxiQA-1
Received: by mail-wr1-f71.google.com with SMTP id s18-20020adfbc12000000b00160b2d4d5ebso8878934wrg.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 06:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MbqKh+ocsWx5WVLcHJZwNDE2rIoRehaxbUtlPRHh7fk=;
        b=McMdfrguwzJhN6YceJ5zJWa8Jx3eOJbDTFOuoKHJ51Vc3xbvJPV5DapdQpyY5pZ16K
         6jSRZ+WVQYtSdxw1AP2zlIqx0BSXYDY0jHwfVXGb673tfGG/vTeHq3XfCCRfVtb/CpEd
         YGA/pLaaqkRbN9YR2IRhw7lSDiZjVZ30OK9w2IpC4loc30zEmmi/NQ3L7Y8y/jnWVSog
         QBHLMUYY2CXQx8IFrH60Se9uys79A58QXJYL73FUM6tBvoEqI4XKNQHS9y85T9PTBiAq
         7Z0GToVDEFo0Fg6s2uO82jDeCRX87fiSZ8ntUP9O7jD8tpORFUS4g7Rix+6JRAwj2gHF
         LhuQ==
X-Gm-Message-State: AOAM531Oc3K/SrGP9QyEX6OwXfCywDLbbvHGZz+dXozTqjht8whjn9ym
        24muytVbdCn5dcIiEbYv6SeaLcDKRIHnaNi7oXjz2dHDrtcaPrUXNteL7tQFab+lj/lf12Szewx
        yy6hV/iLlyGVelNCbGUCATeZa
X-Received: by 2002:a7b:c005:: with SMTP id c5mr29207891wmb.150.1634562189063;
        Mon, 18 Oct 2021 06:03:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKGrWseo2Kso/1wo1lrXrghvEjXbU1h2fq2TY4WEKcdurwFjg+8gtRAh9nmh+J+9nunIbHmg==
X-Received: by 2002:a7b:c005:: with SMTP id c5mr29207727wmb.150.1634562187753;
        Mon, 18 Oct 2021 06:03:07 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id t12sm2044049wmq.44.2021.10.18.06.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 06:03:07 -0700 (PDT)
Message-ID: <337bafa9-a627-f50a-f73c-0e36c2282d55@redhat.com>
Date:   Mon, 18 Oct 2021 15:03:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v3 0/2] x86: sgx_vepc: implement ioctl to EREMOVE all
 pages
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, seanjc@google.com, x86@kernel.org,
        yang.zhong@intel.com, bp@suse.de
References: <20211016071434.167591-1-pbonzini@redhat.com>
 <5f816a61bb95c5d3ea4c26251bb0a4b044aba0e6.camel@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <5f816a61bb95c5d3ea4c26251bb0a4b044aba0e6.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/21 14:51, Jarkko Sakkinen wrote:
> BTW, do you already have patch for QEMU somewhere, which uses
> this new functionality? Would like to peek at it just to see
> the usage pattern.

Yang was going to post them this week; the way to trigger them is just 
to do a reboot from within a Linux guest.

Paolo

> Also, can you provide some way to stress test QEMU so that this
> code path gets executed? I'm already using QEMU as my main test
> platform for SGX, so it's not a huge stretch for me to test it.
> 
> This way I can also provide tested-by for the corresponding QEMU
> path.

