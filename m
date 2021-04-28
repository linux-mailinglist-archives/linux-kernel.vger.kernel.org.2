Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E1736D67C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 13:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238733AbhD1Lba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 07:31:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44322 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229928AbhD1Lb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 07:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619609444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jdsbTTMzPGFGxDRh0SbwnkbDTsMuhtjbRoLXEGmuhf8=;
        b=BKDviLWtt7f7VL8rGD/J2xZ8oxGVvqxaIvhjnlOdPjx34iYmls7qCMAZj+hT9SaA3aCMGT
        cbSEKLHx7mB14HRc2XvzdNASTazY4SJqag5P/mx3iBtvYPCdEpoldvXk8KhKygSZVPM+5W
        3tknsYfFQaPWMlhBcr4pJf4gZ3u1L/w=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-uWVEQj9vNceGYucy9TDTyw-1; Wed, 28 Apr 2021 07:30:42 -0400
X-MC-Unique: uWVEQj9vNceGYucy9TDTyw-1
Received: by mail-ed1-f70.google.com with SMTP id z3-20020a05640240c3b029037fb0c2bd3bso26859292edb.23
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 04:30:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jdsbTTMzPGFGxDRh0SbwnkbDTsMuhtjbRoLXEGmuhf8=;
        b=mZvLxdXlHscI3819r7XNhwtCK/BR5R0MfgVhGjJ60x/Zp2EU37PfXalAKYbkj1axy5
         cHWfG9LRKk2ZW/y5ZL5RggIqb5AcQJcXL0raZ0SnwhYB5TwX6xbGjdGh1wK16Sp6TaQX
         PJ1xpX+1EOU4c3rGu0gMeYL5A/R1IC/6pjksuR+2kvV3TJ/MYBjRt0ZSCDUc+VyzlMsi
         F9jpDc6NiHPgRY6Mz+Xo/g4U41I+4yUB93nF662Rbkr4ijVKqTIcV2E/Wc55ue69cCmm
         KlyuCS4d5hNrAa4aaYUcazkbBzXNf8HvzEEHdpUQ8gwxhs3a0y/gcEzGYze+UPV0uFyU
         kS3g==
X-Gm-Message-State: AOAM531DtIXNzqsmixank73QwTkJIyhwr4XSNISi6w2Iz6/QZksN6XDJ
        pifXAvw9d07CO60t/ljSHQyooS5WxJ/Q7ryQ9Q5gCAZitkXzKBBazLvuOmLbXMJ5nDg3YT1CJSs
        84Nq8mLwco9fImz1BW4B6Sz6v
X-Received: by 2002:a17:906:747:: with SMTP id z7mr1756728ejb.252.1619609440531;
        Wed, 28 Apr 2021 04:30:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWZO6y9ftLimupDCzGBMR+ik/03erDzkGLxMFCaB0DrpSuF6wU/r1zL4EsXfYR4R3ey0+p+w==
X-Received: by 2002:a17:906:747:: with SMTP id z7mr1756712ejb.252.1619609440395;
        Wed, 28 Apr 2021 04:30:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id q25sm1727304ejd.9.2021.04.28.04.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 04:30:40 -0700 (PDT)
Subject: Re: [PATCH 3/3] x86/msr: Rename MSR_K8_SYSCFG to MSR_AMD64_SYSCFG
To:     Borislav Petkov <bp@alien8.de>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        tglx@linutronix.de, jroedel@suse.de, thomas.lendacky@amd.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20210427111636.1207-1-brijesh.singh@amd.com>
 <20210427111636.1207-4-brijesh.singh@amd.com> <YIk8c+/Vwf30Fh6G@zn.tnic>
 <9e687194-5b68-9b4c-bf7f-0914e656d08f@redhat.com> <YIlGvdxZVa0kiJf4@zn.tnic>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8dee542f-889f-ab38-80cf-214af2fcd369@redhat.com>
Date:   Wed, 28 Apr 2021 13:30:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YIlGvdxZVa0kiJf4@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/21 13:27, Borislav Petkov wrote:
> On Wed, Apr 28, 2021 at 12:55:26PM +0200, Paolo Bonzini wrote:
>> There shouldn't be any conflicts right now, but perhaps it's easiest to
>> merge the whole series for -rc2.
> 
> You mean, merge it upstream or into tip? I think you mean upstream
> because then it would be easy for everyone to base new stuff ontop.

Yes, upstream.

Paolo

