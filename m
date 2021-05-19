Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3BB389287
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 17:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354742AbhESP2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 11:28:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39270 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240301AbhESP2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 11:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621438006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BPRLpBAjZNhjflwwDzXS2G9ItWCI1OxLrIqekCHLw0A=;
        b=TinEsRcCPVWx5NAQEZEmIaeQc+Ca9e0+wmyuRuXnHIe9DG6Xe+48sN730wqeGPRhxa0GXS
        MdQXZPJppegYvAc/ZXqE2/cc3xOFusgRXMlJooOyhHbqzEL+RCut7CCzLT37JGSq0dPkME
        3vhbT/jGd5Xq164Uay0Di7o9WI0IKVM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-B2j5_HKwOS-eGOLOEKihXw-1; Wed, 19 May 2021 11:26:45 -0400
X-MC-Unique: B2j5_HKwOS-eGOLOEKihXw-1
Received: by mail-wr1-f70.google.com with SMTP id 93-20020adf80e60000b0290106fab45006so7289337wrl.20
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 08:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BPRLpBAjZNhjflwwDzXS2G9ItWCI1OxLrIqekCHLw0A=;
        b=MZ/c9dczLHyhyeDDGwB90p62NWq/v2zbifnpyufe7c1Zjq8VN5pCZgrHPAwXhHlWb8
         WHlqdYR59SIRkTQRTFkjtxreswIJzTOc2Hg/dRwoGfaKA25bCnD4yzLNOpUw4rbndyYD
         g7Urf+4MC8nZjxMG29Xl9lPKhibCh/q7KSELJvNemGE1xtxPiBBU2fAyZQ4FQ2sQZt3a
         CGgWX9jJDawTnH+qYyRxYTvLP5V06GZQN+wryuGqPYkS0OIAjPOwjKndkMqpsyk57CRj
         4uQ7THeDWYazN47/4ol7032Uad1FmBBDxnNGH5o4tJCmA2QQUhq1jDL4V4TM4KqLUQnB
         imvg==
X-Gm-Message-State: AOAM532A1b3co/c5YYX4/5gNBlivTOfGiRE+gPeD7c9QabgK36hQRal3
        CnU5qjSiwxYuGxfXjbvdIoGD2/D/GWZ2PGxPqA4T7K5iIghfEEyj6QAR65pwA0oSSWhwgTtfHvo
        bbGB8kALyEtrGtLZ7GbPwwJQx
X-Received: by 2002:a5d:570c:: with SMTP id a12mr15048777wrv.354.1621438003869;
        Wed, 19 May 2021 08:26:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKFgM0dMznbTO2YJBPi9PLyM0fdlyyhnY2E+SOMK4tY3xOEu2tCm4NOpliSoEFl1o4vdaeSw==
X-Received: by 2002:a5d:570c:: with SMTP id a12mr15048755wrv.354.1621438003711;
        Wed, 19 May 2021 08:26:43 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id y137sm350209wmc.11.2021.05.19.08.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 08:26:43 -0700 (PDT)
Subject: Re: [PATCH v18 00/18] KVM RISC-V Support
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Anup Patel <anup@brainfault.org>, Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Graf <graf@amazon.com>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        KVM General <kvm@vger.kernel.org>,
        kvm-riscv@lists.infradead.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-doc@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev
References: <20210519033553.1110536-1-anup.patel@wdc.com>
 <YKSa48cejI1Lax+/@kroah.com>
 <CAAhSdy18qySXbUdrEsUe-KtbtuEoYrys0TcmsV2UkEA2=7UQzw@mail.gmail.com>
 <YKSgcn5gxE/4u2bT@kroah.com> <YKTsyyVYsHVMQC+G@kroah.com>
 <d7d5ad76-aec3-3297-0fac-a9da9b0c3663@redhat.com>
 <YKUDWgZVj82/KiKw@kroah.com>
 <daa30135-8757-8d33-a92e-8db4207168ff@redhat.com>
 <YKUZbb6OK+UYAq+t@kroah.com> <20210519150814.GY1955@kadam>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1ce20fe0-0fea-406a-f7bf-1dde686b411a@redhat.com>
Date:   Wed, 19 May 2021 17:26:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210519150814.GY1955@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/21 17:08, Dan Carpenter wrote:
> It's sort of frustrating that none of this information was in the commit
> message.
> 
> "This code is not ready to be merged into the arch/risc/ directory
> because the RISC-V Foundation has not certified the hardware spec yet.
> However, the following chips have implemented it ABC12345, ABC6789 and
> they've already shipping to thousands of customers since blah blah blah
> so we should support it."
> 
> I honestly thought it was an issue with the code or the userspace API.

Yes, I was expecting this to be in the staging TODO file - I should have 
been more explicit with Anup.

Paolo

