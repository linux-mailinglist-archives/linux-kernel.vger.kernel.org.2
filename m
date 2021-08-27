Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D133F95F9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 10:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244489AbhH0IXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 04:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbhH0IXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 04:23:51 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE642C061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 01:23:02 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id s3so10031238ljp.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 01:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cGwCG4HWLVFH04pdCsg/k68G0ZdJYQVWI5q4QdMN3/o=;
        b=duKXzoEFn/SCWVeUH1ArFyk7tlUT7O2ap6nnddPyP28QSn7A3DvXS64jCE0dXQOGdw
         BD8KoYSUt8dz+w25h39FcTNt9gbXmVrk8K5T8ZZYh8y68/60jjl0hvA7wxXjGsaENNBI
         ohafQ3LqWXsIQbQVSbv1Cuzz6IXbS5Z0wpV4+mvGNxZApHB2ku3wc72hjpAVnKvDtpKf
         vjkyxb/Da9zG5uJb1iQRq93Cf0ft5JvOi1xxlN0Jtz3KzXIUOqm8/tQ1IVk1x3WIUPQO
         2imh0nt+zQNYkmpBlJrv/qBC6kZI+4yoXq/z+RaQi8ekxWh/Hp6xW1BVcileC1qLgwZb
         M40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cGwCG4HWLVFH04pdCsg/k68G0ZdJYQVWI5q4QdMN3/o=;
        b=j5Be2dQzQthTndCiZ2XWpbSzAaekEQ9D+SCDowK8XyLVTO5r30xXZwsF8wLQDOiwhg
         0SY6ebh8ZVMvVe+Q4X6A7ml6dMvatnhnEEf+9wQaE12irt8YMOGRIlhXGqR8wV4zxU7f
         oWB5Q9gUi4EmITWsMMVpw84Uzh2NjgKm6jp2yo+FeiCWORmVFIf1LxxtF1mJ+0KwiYn/
         o+RM+dlgSXijE4T+o1soOvPye7IjBFbJ2WK/tMDjxiBFrHAvQLsXwb6qbEj89LtfXjFR
         HP004m1YfgPxgKKLLDNikigtpQ3v0qiiV3odxOriuRYt++EtghFlTNAvMJPrR1+JfHXs
         6d+Q==
X-Gm-Message-State: AOAM533Dyqu5KEibrAwgNoUxkVQwV4I9w4x1yi+84zuwX2eHzDYiBTqB
        McUJ4EEDFJ4H3os5KrlpyTSmQw1W5uK3Aw==
X-Google-Smtp-Source: ABdhPJwzbZ61gzIoMYR8ibWU3hLXcE/h5UhDkzbUHSdKlfEe+cAu990EorN0eez/nBnDHDBC9t1pgg==
X-Received: by 2002:a2e:934b:: with SMTP id m11mr7038709ljh.284.1630052580989;
        Fri, 27 Aug 2021 01:23:00 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id z5sm608034ljz.23.2021.08.27.01.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 01:23:00 -0700 (PDT)
Subject: Re: [PATCH v3 3/6] staging: r8188eu: add error handling of rtw_read8
To:     David Laight <David.Laight@ACULAB.COM>,
        'Dan Carpenter' <dan.carpenter@oracle.com>
Cc:     "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "phil@philpotter.co.uk" <phil@philpotter.co.uk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "straube.linux@gmail.com" <straube.linux@gmail.com>,
        "fmdefrancesco@gmail.com" <fmdefrancesco@gmail.com>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1629789580.git.paskripkin@gmail.com>
 <c59d5d850bf9aab208704182c83086609289cb9c.1629789580.git.paskripkin@gmail.com>
 <f5c20e0f1b934e04ad11a3627d71f5db@AcuMS.aculab.com>
 <20210826112745.5e1421ed@gmail.com>
 <a251767ca181405b93b5ea55a26c3ff0@AcuMS.aculab.com>
 <20210826112127.GZ1931@kadam>
 <dc133b63e1f54f45a19e67d75a6fcb40@AcuMS.aculab.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <b4d8ed8f-db03-a5b1-bb7a-0f086ea8ffbd@gmail.com>
Date:   Fri, 27 Aug 2021 11:22:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <dc133b63e1f54f45a19e67d75a6fcb40@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/21 11:14 AM, David Laight wrote:
> From: Dan Carpenter
>> Sent: 26 August 2021 12:21
> ...
>> > > > ...
>> > > > > +		len += snprintf(page + len, count - len,
>> > > > > "rtw_read8(0x%x)=0x%x\n",
>> > > > > +				proc_get_read_addr, (u8) tmp);
>> > > >
>> > > > That is broken.
>> > > >
>> > >
>> > > Don't get it, sorry. Previous code did exactly the same thing, but
>> > > didn't check if read() was successful.
>> >
>> > Look up the return value of snprintf().
>> >
>> 
>> It's hard to understand what you are saying.  I think you are confusing
>> libc snprintf with the kernel snprintf?  In libc the snprintf function
>> can return negatives but in the kernel it cannot.  This is not going
>> to change.  Any code which checks for negative snprintf returns in the
>> kernel is wrong and should be fixed.
>> 
>> Anyway, the code works fine.  snprintf here is going to return a number
>> between 18-32 range.  It's not going to overflow the PAGE_SIZE buffer.
> 
> IIRC it is also in a loop ...
> 
> Maybe, but the idiom is just broken.
> Largely the result of snprintf() is never the value you are looking
> for and should be ignored.
> 

AFAIK, snprintf return value is largely used in sysfs at least.

$ grep -Ir "= snprintf" | wc -l
1200

Anyway, I will convert this dead code to sysfs interface and maybe 
snprintf will go away...



Thank you for your help and comments


> Userspace fprintf() is even worse.
> If you care about the write failing you need to call fflush()
> and then ferror() (typically before fclose()).
> 
> Fortunately I've never seen a 'must check' attribute on it.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 


With regards,
Pavel Skripkin
