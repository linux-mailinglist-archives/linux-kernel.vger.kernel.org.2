Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDAD3F29ED
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 12:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238945AbhHTKM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 06:12:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35585 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232572AbhHTKMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 06:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629454305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PjEaCYCRogYG/WsTjECE7ZORWN2nCY9AZG2C4Rf3ynA=;
        b=K4ttp/+tRYlof0O7ph2zp9UsgjcaefgC6Kll9OSFw7ks8cTYj6EJ6zT0ypRls09+ViES74
        eyG4GVw51EzC/4bzCD2S4pgkr78buam36Nrjyz49ieCtu1nQHh7vRD5AH7KGsgE+AW8+gP
        GYQ0qm83UXsI2vzwKGAv1bYNbBFLJTQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-M1LH0cPuMT-h_yRNLZxKcg-1; Fri, 20 Aug 2021 06:11:43 -0400
X-MC-Unique: M1LH0cPuMT-h_yRNLZxKcg-1
Received: by mail-ej1-f72.google.com with SMTP id j10-20020a17090686cab02905b86933b59dso3522587ejy.18
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 03:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PjEaCYCRogYG/WsTjECE7ZORWN2nCY9AZG2C4Rf3ynA=;
        b=bUmAZ6eCvJbDbbYNbOo5baIh0H/rJ//KMy/oCjXOGCc/TD1KtJ9EnVt/D6huHYfBkz
         sszIpJB47w/1Scl4ZX7RAD9IOdlV+X9s7Xw5UuusKEUZutnn+N6kfJU2zxE7ygYXxjan
         KNn0Dk3zauNArJQz902WHe5qAmA2lpzI3gXPU4/r3QUeRxm9mKzMbXcSyDSEhu7mK7S/
         PZRUDhFDYWWY3fwCd/jOhGlLZ3T4lvfW6L6sYpPBD4hDIdxuux6eMirE/PiPJTB7yAnY
         DZl00Nrc3GxwQtmKKMJ1mVx2chGOJ9nxCy2BQ2AMQICYBQO5QUY2MkmVYVRoWcw6KyVo
         2NkA==
X-Gm-Message-State: AOAM533h1CdYmLJUwT7HrqOARIpqVg20ti8dePxWy3WsgctoOPWRMwTW
        Ow40lzrRYDyBJdy4nLJvt9nvzlsiJffrWSrwd4eJMiYtK9Q3fKuPQGS+KRFmHFVaa6yvMTKWS8O
        IayLnul4PlmXh//29WwTWGpZY
X-Received: by 2002:aa7:db95:: with SMTP id u21mr21114896edt.152.1629454302678;
        Fri, 20 Aug 2021 03:11:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcCyAeKEwj9goJVz7uy5NTJA6ZvwLj4KDC64me3YtwjFIqVstziwCl9YjISimG4vhWk7iBlA==
X-Received: by 2002:aa7:db95:: with SMTP id u21mr21114873edt.152.1629454302486;
        Fri, 20 Aug 2021 03:11:42 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id f19sm3323541edt.44.2021.08.20.03.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 03:11:41 -0700 (PDT)
Subject: Re: linux-next: build failure after merge of the drivers-x86 tree
To:     M D <whenov@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mark Gross <mark.gross@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20210820150022.2160a348@canb.auug.org.au>
 <CAA2grmaYg8Qc4LXhcFAvNRN-zJaPcq+y3=MFVSFETr2pNb-Vgw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d6099b61-d825-5a3d-4088-da865db35451@redhat.com>
Date:   Fri, 20 Aug 2021 12:11:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAA2grmaYg8Qc4LXhcFAvNRN-zJaPcq+y3=MFVSFETr2pNb-Vgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/20/21 9:31 AM, M D wrote:
> On Fri, Aug 20, 2021 at 1:00 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Hi all,
>>
>> After merging the drivers-x86 tree, today's linux-next build (x86_64
>> allmodconfig) failed like this:
>>
>> drivers/platform/x86/ideapad-laptop.c: In function 'ideapad_wmi_notify':
>> drivers/platform/x86/ideapad-laptop.c:1469:3: error: a label can only be part of a statement and a declaration is not a statement
>>  1469 |   unsigned long result;
>>       |   ^~~~~~~~
>>
>> Caused by commit
>>
>>   18cfd76e7b84 ("ideapad-laptop: Fix Legion 5 Fn lock LED")
>>
>> I have used the drivers-x86 tree from next-20210819 for today.
>>
>> --
>> Cheers,
>> Stephen Rothwell
> 
> Hi Stephen,
> 
> Thanks for your work!
> 
> This error occurs because only a statement is allowed after a label,
> but a definition is not a statement in C99.
> This can be fixed by wrapping the case block with curly braces like this:
> case 208: {
> ...
> }

Yes, or just move the declaration of result to the beginning of
the function, which is a bit cleaner IMHO.

I've moved the declaration to the beginning of the function and
squashed this fix into the original commit. I'll do a forced
push with the squashed in fix to for-next as soon as a test-compile
completes.

Stephen, as always thank you your work on linux-next and for reporting this.

> However I don't know why my compiler did not report this error. I was
> using gcc 11.1.0 under Arch Linux.

Yes gcc 11.2.1 under Fedora also happily compiles this, and this
sat in my review-hans branch for a while and got happily compiled
by "kernel test robot <lkp@intel.com> " there too.

So this compile error slipped through the crack of all our (compile)
testing until Stephen caught it :)

Regards,

Hans

