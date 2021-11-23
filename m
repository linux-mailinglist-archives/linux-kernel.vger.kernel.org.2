Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1344F4599F7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 03:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbhKWCM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 21:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhKWCMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 21:12:25 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F99C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 18:09:18 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id q25so41752561oiw.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 18:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oWtND7ICJC5baRJLmgbeqWVA09fkkAkT0lOW2xOAyJA=;
        b=m3mF8I2q57/y6xpBC5OvdPhfr4I+5RBCdd9USl0029kSUrpHdINIWhf64v+VRjBels
         yVkrnNoCV5cvvS+NKUcmSFJ30HNXqS7CIj1imSBDldksG9WnRVuanbvKMNfeui42zYeL
         ZPKskr1IzPCovX9VFFwtuNrthRNj9AvWKBoNfdK3uIz+cPXDFIoXsWhXKX5++KBZJZHV
         Jl82/EeeASdyN8JqvhjrkKEjEV5IommoOlxafh1Cc4/56hxyQEd1qFez+Vo0g/aIluZF
         zfp19WD1ZIYaw2wNgm0XWhOCsr2Wzvka2oxSYu2lmwLkQHn2Jia1Wv8qkiYrXQk/P1qF
         NfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oWtND7ICJC5baRJLmgbeqWVA09fkkAkT0lOW2xOAyJA=;
        b=OA/JDWyicGNamucnU+zWumI9zEIJfzIFuWy6E1LmfTPIABa2a8sN9z4wq2Q2A88ons
         NGUhpzBwb6r5uDjZQhT9+fDkIMw69x13Q4CvHfXNtznDrj6IUNzznGCtj9IzOMgkVaFd
         ZDVz5icWzgy3jNlm9/z6A1/LV08/TNGi5Uk/M8nxy0ZaEyGAaCVuFGtT7cJcgejLuxHe
         4wOn2XHoN/xEnqNdVbTiYXp+DzWF9lptTQBVGon7+0fVMUbNr1c9EaSv+5QbUiXxHvSr
         VUrBaan8tCySp8w5GNeisUFXSUiO+ngEYK/K3Oa+1rz1iNe0pOAaOajD+fqK7aTtVbLb
         zABA==
X-Gm-Message-State: AOAM530vAlfSCpYys821AsNOMx6IgNQZDe+4pAEly3K9WxAfS6KVG5ap
        MYaY/6CSXm4HAuG1GiNOIj0=
X-Google-Smtp-Source: ABdhPJwkDBXGj2Uz2bCWuojDmrpQEqdteL8ZPZ9O9uiq6m7jFFWyra+ZYEvPXZGpLKIgyebfWd8Wlg==
X-Received: by 2002:a05:6808:98e:: with SMTP id a14mr26538208oic.48.1637633358122;
        Mon, 22 Nov 2021 18:09:18 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z14sm1904917otk.36.2021.11.22.18.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 18:09:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20211122230653.1779162-1-linux@roeck-us.net>
 <CACPK8XfM1e7b6m_QBhJFgXCXhqOajMKGUkWqRGxa5sCKyLxRQg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] fs: ntfs: Disable NTFS_RW for PPC
Message-ID: <b63d1758-b434-93c3-164c-b536c7437bdf@roeck-us.net>
Date:   Mon, 22 Nov 2021 18:09:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CACPK8XfM1e7b6m_QBhJFgXCXhqOajMKGUkWqRGxa5sCKyLxRQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/21 5:15 PM, Joel Stanley wrote:
> On Mon, 22 Nov 2021 at 23:58, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> NTFS_RW code allocates page size dependent arrays on the stack. This
>> results in build failures if the page size is 64k, which is now the
>> default for PPC.
> 
> It became the default for PPC_BOOK3S_64, which doesn't include all of
> PPC, in f22969a66041 ("powerpc/64s: Default to 64K pages for 64 bit
> book3s").
> 
> You might want to add a mention of this commit in your commit message.
> 
>>
>> fs/ntfs/aops.c: In function 'ntfs_write_mst_block':
>> fs/ntfs/aops.c:1311:1: error:
>>          the frame size of 2240 bytes is larger than 2048 bytes
>>
>> Increasing the maximum frame size for PPC just to silence this error does
>> not really help. It would have to be set to a really large value for 256k
>> pages. Such a large frame size could potentially result in stack overruns
>> in this code and elsewhere and is therefore not desirable. Disable NTFS_RW
>> for PPC instead.
>>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> v2: Introduce new configuration flag DISABLE_NTFS_RW and use it to disable NTFS_RW
>>      for PPC
>>
>>   fs/ntfs/Kconfig | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/fs/ntfs/Kconfig b/fs/ntfs/Kconfig
>> index 1667a7e590d8..324224febb6a 100644
>> --- a/fs/ntfs/Kconfig
>> +++ b/fs/ntfs/Kconfig
>> @@ -49,8 +49,13 @@ config NTFS_DEBUG
>>            When reporting bugs, please try to have available a full dump of
>>            debugging messages while the misbehaviour was occurring.
>>
>> +config DISABLE_NTFS_RW
>> +       bool
>> +       default y if PPC
> 
> PPC_64K_PAGES would be more accurate.
> 
> I think arm64 was seeing a similar build error, so you could include
> ARM64_64K_PAGES as well?
> 
Yes, you are correct.

fs/ntfs/aops.c: In function 'ntfs_write_mst_block':
fs/ntfs/aops.c:1311:1: error: the frame size of 2608 bytes is larger than 2048 bytes

Ok, I'll do that. And, digging for it, I see

config VMXNET3
         tristate "VMware VMXNET3 ethernet driver"
         depends on PCI && INET
         depends on !(PAGE_SIZE_64KB || ARM64_64K_PAGES || \
                      IA64_PAGE_SIZE_64KB || PARISC_PAGE_SIZE_64KB || \
                      PPC_64K_PAGES)

That adds hexagon, ia64, mips, parisc, and sh to the list of affected architectures.
Plus, of course, there is PAGE_SIZE_256KB and PPC_256K_PAGES.

So we are looking for something like

config DISABLE_NTFS_RW
	bool
	default y if PAGE_SIZE_256KB || PPC_256K_PAGES || \
		PAGE_SIZE_64KB || ARM64_64K_PAGES || IA64_PAGE_SIZE_64KB || \
		PARISC_PAGE_SIZE_64KB || PPC_64K_PAGES

Anything else ?

Guenter


>> +
>>   config NTFS_RW
>>          bool "NTFS write support"
>> +       depends on !DISABLE_NTFS_RW
>>          depends on NTFS_FS
>>          help
>>            This enables the partial, but safe, write support in the NTFS driver.
>> --
>> 2.33.0
>>

