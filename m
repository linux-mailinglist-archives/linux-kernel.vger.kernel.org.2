Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F1340D2C8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 07:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbhIPFHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 01:07:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33850 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233301AbhIPFHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 01:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631768768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CKN8XQ4WQkJPsTlSjGiV3oiFQPmnO4fijF4pI7KTQvg=;
        b=TTCVxV0RMF6VA8SwMPC83xZiF8xRYQf1WrjxywbmcGiDOmDXgB58oETXTx8dSFL6b+F8P/
        gobCE+ozkpE6nhwIa9lz9zJkmLFSsfHU53nLNy1FVGSigTS2ygENzhDj1OTo1ZeuD4CE7H
        wbNRckiN3drMIUUC8JliM/pOKjv/NIM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-uzCvfwqxMA6wNuFKdc2bNg-1; Thu, 16 Sep 2021 01:06:08 -0400
X-MC-Unique: uzCvfwqxMA6wNuFKdc2bNg-1
Received: by mail-ed1-f72.google.com with SMTP id n5-20020a05640206c500b003cf53f7cef2so1283179edy.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 22:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CKN8XQ4WQkJPsTlSjGiV3oiFQPmnO4fijF4pI7KTQvg=;
        b=12TAsDZbk5ILNWK2EDVhaGViYkJ+S7GiAg1Gs8nfq8qkWIw5e2lPiPPdabhCLovMPR
         KHBgUKWaMkzt/t6xWQiGqVRt/+dThL+oMUuJeHYz15MAML6qnrTnX+N9xEkcwUkgIhxI
         KRpldvM6KFH4rWSUk6mwb0kSbn6HeMgd2DSQKeMjmSVXwnsprW2pEQeiHEWKHiXWERUP
         LpAUaG8JHB0xRAswcqZ1N8nUzMcGHE0lp2xOsPeJU8A++k26i3OJmJnLaIiAErN7rXS6
         tWIFrqwl8m/x4l4PhJ6VqI3yi6OjZrNtwWjlP1LaoteU6fOsFV9BEdYjoS0v/HmnUBl5
         iYLw==
X-Gm-Message-State: AOAM532Xm3O2MzRpMWGeLM3lLgas4fGlWOkUjv9eh0qAdg9iuwNYTP4U
        B6KRyEJki2MLq3bzMGgN8MnfIDfUL8tkVw12U+xRsuTcmc+xDL4X5xim9oiRKxpPeUJ92gVwmW5
        26cpj4RQ3VO+B74qlD1S2CiRnw7+3sPV3P4XgADsDPVCk7pJytbxURI3VH27HRi8xkgvS3MpZkK
        MO
X-Received: by 2002:a05:6402:42d5:: with SMTP id i21mr4302154edc.14.1631768766426;
        Wed, 15 Sep 2021 22:06:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1bdIwbG7TUmxAk3tSV06VOIwCk8kiZfGgssZZPwl5DDnRixxI9jEnMirROatK9dy9eF1wuA==
X-Received: by 2002:a05:6402:42d5:: with SMTP id i21mr4302128edc.14.1631768766157;
        Wed, 15 Sep 2021 22:06:06 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id u4sm740910ejc.19.2021.09.15.22.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 22:06:05 -0700 (PDT)
Subject: Re: [PATCH 0/4] selftests: kvm: fscanf warn fixes and cleanups
To:     Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1631737524.git.skhan@linuxfoundation.org>
 <56178039-ab72-fca3-38fa-a1d422e4d3ef@redhat.com>
 <aca932b9-5864-be95-c9f6-f745b6a6b7f3@linuxfoundation.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d9da3a33-6ecc-3d52-8f9a-f465692ecb93@redhat.com>
Date:   Thu, 16 Sep 2021 07:06:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <aca932b9-5864-be95-c9f6-f745b6a6b7f3@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/21 02:02, Shuah Khan wrote:
> On 9/15/21 4:34 PM, Paolo Bonzini wrote:
>> On 15/09/21 23:28, Shuah Khan wrote:
>>> This patch series fixes fscanf() ignoring return value warnings.
>>> Consolidates get_run_delay() duplicate defines moving it to
>>> common library.
>>>
>>> Shuah Khan (4):
>>>    selftests:kvm: fix get_warnings_count() ignoring fscanf() return warn
>>>    selftests:kvm: fix get_trans_hugepagesz() ignoring fscanf() return
>>>      warn
>>>    selftests: kvm: move get_run_delay() into lib/test_util
>>>    selftests: kvm: fix get_run_delay() ignoring fscanf() return warn
>>>
>>>   .../testing/selftests/kvm/include/test_util.h |  3 +++
>>>   tools/testing/selftests/kvm/lib/test_util.c   | 22 ++++++++++++++++++-
>>>   tools/testing/selftests/kvm/steal_time.c      | 16 --------------
>>>   .../selftests/kvm/x86_64/mmio_warning_test.c  |  3 ++-
>>>   .../selftests/kvm/x86_64/xen_shinfo_test.c    | 15 -------------
>>>   5 files changed, 26 insertions(+), 33 deletions(-)
>>>
>>
>> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
>>
>> Thanks Shuah!
>>
> 
> Thank you. I can take these through linux-kselftest - let me know
> if that causes issues for kvm tree.

Go ahead if it's for 5.15-rc, I don't have any selftests patches pending.

Paolo

