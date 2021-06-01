Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20A03979B2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 20:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbhFASEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 14:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbhFASEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 14:04:54 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81451C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 11:03:11 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id s19so227903oic.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 11:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fBK7i8eOCWD7bhsE5M2Uc/50Bg2gXfvHWSF0m3uzUmM=;
        b=LnrSeewa+v24qnBzJliqTIX8159l+VdnoAsvT4KHaU5f8k8D6lD428BufJUiXBBw5j
         wH4z6NKEncrcfV82RLY3MbBz8g3P3kPOlQyGNRNDph4hYhKZikfx3XuukA6Ei/NuMVqS
         WbcA9mp6ey51P5OCGeE1KXU0Kt5rMYexrs59F1dnnCbTJSP8Soh+f3/fyCPsQk60oyfQ
         Lgrn1vcJdM9dLnz2Am/ndB+s+XtoYf0UmViHFXRZswELtuLIwrfIaGU2vsOSBIH3uudz
         KmUo8iBJy65UbiJN8Uao08H9Crm8jRm5CujkLR3NEAp/99RRcN9x/1r4kvs+5mMg0d/g
         QEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fBK7i8eOCWD7bhsE5M2Uc/50Bg2gXfvHWSF0m3uzUmM=;
        b=W9hOQ9wf/aGaOK4B1qtmZHRtS7bQhKTHf9ZFpliQR1zQkwqA0tunX+zW/QDH7KjjTH
         DE09++kKMrirfS9HkjinUDJUfGXpQLS/Fga9DvKJ22MpQ7U0abQtS4iHIQebtMhUeS7r
         2TLJtcmMwDng1QkTXCdfbP2PW/XvigLbbDAeP8X6aWyChdqBYFT6e3OYThWhAvauouXb
         BVyGEsgnDZbU/e2tbyoAU3VnAVP701oxIX1kv6O6SdUYgVSVvZgVid5BdKEdbnxVPI2G
         XgxfeqjZt/coM6v0QrazciZXD+AINGhMrHxnsX1FK2uwsMWpuurxURZk24GoUbhiKh1c
         BYzQ==
X-Gm-Message-State: AOAM533KuQqZScHS1ptpQFrQu0kgIwK7IcVLnaLDMWW57xgyVtTFdOke
        smjn+2lXEmsodpacBpcPj8q9RbAyoXvldyHP
X-Google-Smtp-Source: ABdhPJyVPnUkCmmFwHeHSJkQyiP8pFVashqQQa5tEsHea86rjeVsxiTYqAFDUT1H33rToJ3vgvGJjg==
X-Received: by 2002:a05:6808:a97:: with SMTP id q23mr3076754oij.39.1622570590479;
        Tue, 01 Jun 2021 11:03:10 -0700 (PDT)
Received: from [192.168.86.140] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id w10sm3727739ott.75.2021.06.01.11.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 11:03:09 -0700 (PDT)
Subject: Re: [PATCH] Replace use of perl with sed and tr in s390x build.
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <a48c51f8-5fe4-87e7-284e-c96e2381801a@landley.net>
 <your-ad-here.call-01622498121-ext-5758@work.hours>
From:   Rob Landley <rob@landley.net>
Message-ID: <91e7a6bd-847b-3cbc-9ebf-b73921d456f0@landley.net>
Date:   Tue, 1 Jun 2021 13:19:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <your-ad-here.call-01622498121-ext-5758@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/21 4:55 PM, Vasily Gorbik wrote:
> On Mon, May 17, 2021 at 11:46:44PM -0500, Rob Landley wrote:
>> From: Rob Landley <rob@landley.net>
>>
>> Commit 246218962e21 in November added a perl dependency to the s390x vmlinux
>> build, complicating the "countering trusting trust" build approach ala
>> http://lists.landley.net/pipermail/toybox-landley.net/2020-July/011898.html
>>
>> Signed-off-by: Rob Landley <rob@landley.net>
>> ---
>>
>>  arch/s390/boot/compressed/Makefile |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/boot/compressed/Makefile b/arch/s390/boot/compressed/Makefile
>> index de18dab518bb..e941b165bd4f 100644
>> --- a/arch/s390/boot/compressed/Makefile
>> +++ b/arch/s390/boot/compressed/Makefile
>> @@ -33,7 +33,7 @@ $(obj)/vmlinux.syms: $(obj)/vmlinux.lds $(objtree)/arch/s390/boot/startup.a $(OB
>>  
>>  quiet_cmd_dumpsyms = DUMPSYMS $<
>>  define cmd_dumpsyms
>> -	$(NM) -n -S --format=bsd "$<" | $(PERL) -ne '/(\w+)\s+(\w+)\s+[tT]\s+(\w+)/ and printf "%x %x %s\0",hex $$1,hex $$2,$$3' > "$@"
>> +	$(NM) -n -S --format=bsd "$<" | sed -nE 's/^0*([0-9a-fA-F]+) 0*([0-9a-fA-F]+) [tT] ([^ ]*)$$/\1 \2 \3/p' | tr '\n' '\0' > "$@"
>>  endef
> 
> The change itself is fine. Yields the same result as before with
> binutils/llvm/elfutils versions of nm.

...

> So, would you mind if I pick your patch changing the commit message
> like the following?
> """
> s390/decompressor: replace use of perl with simple sed/tr
> 
> Use simple sed/tr instead of perl to generate decompressor symbols
> file with the same result.

Works for me.

> Signed-off-by: Rob Landley <rob@landley.net>
> """

Thanks,

Rob
