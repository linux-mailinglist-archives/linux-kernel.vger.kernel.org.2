Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07BB41B891
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 22:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242825AbhI1Uoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 16:44:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21246 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242818AbhI1Uo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 16:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632861766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q/j8lu7tFVONNif5bHLiSAgHNxKsf9udcHGujsFhPw0=;
        b=Kl6HE9gvaIFKOzAuZMFEg366fqhmNoH0bdj6GvzOoRRQ8bchad6K60H+wrm6xTnDpEfMFg
        LCPW32kImaZ5qawxD6SsMygset9GajSLbfqdcpSZWCfwdH5VqjPlCcqUS7BoIRdWQa5gQh
        b++0SCM/U6mFlgj7Ru9LhZY9yYax+Lo=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-2vm290QkOFqE8sa30m2DpA-1; Tue, 28 Sep 2021 16:42:45 -0400
X-MC-Unique: 2vm290QkOFqE8sa30m2DpA-1
Received: by mail-oo1-f71.google.com with SMTP id 68-20020a4a0d47000000b0028fe7302d04so159400oob.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 13:42:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=q/j8lu7tFVONNif5bHLiSAgHNxKsf9udcHGujsFhPw0=;
        b=D2b/S9rnX8HoMjN6eSyMldlDlgLxilkiG+TC9mCPE/A4o37Lu9IxmW3Lr3ZYrYdMQn
         sTGx21TunQXbynXrlVMwzQqj4DK/BImElyqIjFlECj5MjLNdvlBjG8qd+tsuIGfJiV6Q
         pwX3j3S/NXETIYvNSuT4+p5548YkJ7iZMmCQNChnWBVlBr+cpj4K2NAttbb8qaRXt9J1
         TOxr9j7S4wzxK/fPLK6KOgwIHPd/v4cmysJEQqj56i+DvbqCD8sICnWBorKJy/cnBlo1
         ggxhqWYUmlqgRdHCM4K5SxyP/CWOZe65tXtlMOpwtVVrBG+kF0xNjRhEzz91Pgs5URgh
         da5w==
X-Gm-Message-State: AOAM532WVBwX3ST5WfJqrgZGpoHEELT+cm2W6uth757I8c5RQGLJeIyh
        ieTJ/+SjYhb3fFI7wgOjU/PfWF1odoTqQJPdQh3ArGHSLtgnLhlEWvfcwj3ygN+487Eibb/V5dk
        n6o/4bKQyuAWgdID8VqD6MRPCR8Sj6u33dyXu3J0OBhYC2W4NVqmWzv4G5FDfB2+kNeHm0QU=
X-Received: by 2002:a05:6808:287:: with SMTP id z7mr5155503oic.8.1632861764290;
        Tue, 28 Sep 2021 13:42:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwLFJvr/Tu92X62J2GJbZgkOlFxzve+GFpDXa35TsS80V/B6TDgkF0Ov4pbMtPZ4zTEjDCkg==
X-Received: by 2002:a05:6808:287:: with SMTP id z7mr5155486oic.8.1632861764052;
        Tue, 28 Sep 2021 13:42:44 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id u12sm36724otq.20.2021.09.28.13.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 13:42:43 -0700 (PDT)
Subject: Re: [PATCH] of: remove duplicate declaration of of_iomap()
To:     Randy Dunlap <rdunlap@infradead.org>, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210928201214.294737-1-trix@redhat.com>
 <e706d330-87ab-75e6-7118-e9b280039409@infradead.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <da68bba8-bb38-cb11-df5e-e69fc4848e98@redhat.com>
Date:   Tue, 28 Sep 2021 13:42:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <e706d330-87ab-75e6-7118-e9b280039409@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/28/21 1:33 PM, Randy Dunlap wrote:
> On 9/28/21 1:12 PM, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> A ranconfig produces this linker error
>
> randconfig .. on what arch, please?
s390
>
>> irq-al-fic.c:252: undefined reference to `of_iomap'
>>
>> The declaration of of_iomap() is dependent on OF
>> The definition of of_iomap() is dependent on OF_ADDRESS
>> These should match.  There are duplicate declarations
>> of of_iomap(), remove of_iomap() and the
>> of_address_to_resource() duplicate.
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>   include/linux/of_address.h | 8 +-------
>>   1 file changed, 1 insertion(+), 7 deletions(-)
>>
>
>
> thanks.

