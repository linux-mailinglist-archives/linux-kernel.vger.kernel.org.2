Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8E14339D8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 17:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbhJSPLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 11:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234472AbhJSPKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:10:55 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33796C061772
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 08:08:28 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id d198-20020a1c1dcf000000b00322f53b9b89so3482586wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 08:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=gcQrXOybNP4D8/Nco8U5T3IxRjktElzEEGrbggjgINQ=;
        b=HRsuf+PktFjntEg75/IjEX1kOFv+6WgmeqVWzTJLm+FeZDiEz0Etm+WwvXDf/qri1q
         /ad3Kcxl2Eh9U+pLG0F8i1O1zATGX3hXty9GndO9jK9w+5ya2J5iLkZSYQOa6EUJSrUZ
         kEmfR5Jf20TvRd53OXajRY8RKwOiKVuVQ+8tgcHtvoJoFrAJLnJJozP2733OnDQP0YuT
         ZrY4GuW9BUrY8VhVZbFdOraPJ3B6/o6cCuyaAltJWeeOajSA3TQ9ypfr/16f2stmL3tq
         fiRlOPwieaVD85ICcKiQE9UnTriu40mYqewpgDkZRAA8DsyYVODCcurWdsIo28s0g8Xj
         Oruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=gcQrXOybNP4D8/Nco8U5T3IxRjktElzEEGrbggjgINQ=;
        b=Z8xGhYh27o9jYsrjV0O5/zWKSI7bJiqVwKCQEc4riIyAFqzMZNme5PFPtGj43aDBSh
         vCLSe0rHcRrUe9ya75TsXRnrg6wjMPrBLfjwRVzE2ym3AOA12E2fdpG6HQesUXYjcOCq
         +fM9zqOdLZo7cBBq5qkyJoLcObv+iiCZhL523B+YOMutmSuT00qCkX5aoxDWMrAiRGBR
         4A/vbHPOCkK5gJkjZxyxy8BXYeK6aGTHRHdD/0L9RCXvbnfkHBYDxSmV2DWo7QsErGsu
         OBfE9JLsI0vEamgFmkFD+j7/+w9sE+NI3hdmwfo2ii06OEFK7wzCH9owFG4oYE5Z0xMb
         1qOA==
X-Gm-Message-State: AOAM533eDwAh2K6sOhBGSmUviWSiNhCtOO3yvS/ko1J0MCLKrnZAg789
        FXOx0iKA2NTyY/vBNaM0m3aalSkEHASjOmq8
X-Google-Smtp-Source: ABdhPJzCyaDf2Mgin+1KAcpcIB7A4XE5TNMNvzt8X8Xk5XdvxgQWirDLgrLQz21FDc7ii565QFF9nw==
X-Received: by 2002:a05:6000:552:: with SMTP id b18mr7987543wrf.112.1634656106768;
        Tue, 19 Oct 2021 08:08:26 -0700 (PDT)
Received: from ?IPv6:2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62? ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id o8sm2577439wme.38.2021.10.19.08.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 08:08:26 -0700 (PDT)
Message-ID: <a11249f8eaefb22896c7702ab6eb594fc40795e1.camel@gmail.com>
Subject: Re: [Outreachy kernel] Re: [PATCH] staging: vt6655: Fix line
 wrapping in rf.c file
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Joe Perches <joe@perches.com>,
        outreachy-kernel@googlegroups.com
Cc:     forest@alittletooquiet.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Date:   Tue, 19 Oct 2021 16:08:25 +0100
In-Reply-To: <1647209.5AoB3rP6bQ@localhost.localdomain>
References: <20211018150526.9718-1-karolinadrobnik@gmail.com>
         <84f3c940fedb961e6e7e88d47c3d15e598bc32c3.camel@perches.com>
         <810a4e29b0c54520a30cae4d37fde0a59ea3d83b.camel@gmail.com>
         <1647209.5AoB3rP6bQ@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-10-19 at 05:26 -0700, Joe Perches wrote:
> What I suggested is not a patch it's just an example.

Sure, I understand. In this case, I'll take some inspiration from
your example and break down the changes into smaller chunks, thank you.

> There's quite a lot of code in that driver that _could_
> be updated/refined/refactored (none of which _I_ will submit),
> but it's up to you do whatever _you_ want.

Indeed there is, I'm trying to tackle one thing at a time. I thought
I could fix a couple of line length warnings in an easy way but I was
wrong.

Ok, I'll come back to CamelCase squashing and removing the Hungarian
notation before working on this refactor. I think this is a good
candidate for a patchset.

On Tue, 2021-10-19 at 15:07 +0200, Fabio M. De Francesco wrote:
> Hi Karolina,

Hi Fabio,
Thank you for describing everything in such detail, really appreciate
it.

> No, there is no problem in using a[i - 1]. Personally I prefer the
> former when 1 <= index <= ARRAY_SIZE(a). 

I see, thanks for explaining this.

> If you code "index = index -1;" or 
> "index--;" (that is the same) and then you use 'index' many lines
> below that decrement in "a[index]" it may be not immediately clear
> that you are not indexing past the end of the array.

That's what I thought as well.

> I prefer to state it again: if you choose to do such kind of works,
> be careful to split self-contained patches in a series and explain
> each change you make and why you make it.
> Each patch must do only one logical change.

Will definitely do so, thank you.

> Each patch of a series must be self-contained also in the sense that
> it must build without introducing errors or warnings at any point:
> for instance, five patches => five clean builds.

Makes sense, will keep that in mind. Also, I think it would be good to
mention it on the FPT page. I can suggest adding such comment in later
on.


Thanks,
Karolina

