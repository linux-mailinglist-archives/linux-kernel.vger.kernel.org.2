Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2262840762F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 13:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235681AbhIKLBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 07:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbhIKLBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 07:01:50 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA94C061574
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 04:00:38 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id k23-20020a17090a591700b001976d2db364so3191326pji.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 04:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LMOWBn/u3aVqbnWmF8p6o8arazc7UvhFXaE3d67u6n4=;
        b=QN7SJrTyCSMIyBHAc17ieT6dplKOZbkE5rooPK1SQ14X4xBKVqgd3AWSEfSLXX0lIJ
         hz8ASHsktLblp54wrq+oizyk4nxhAd6Syku/hay86bw7DywlNeZ1gbjfZtVvuIf30Cn4
         Ez3PXcTQNbYW8k7YDERRrLNGyberXh8uZatjwIwNGUw6yPc/iWZJyLdcYt82Y7/p2aO7
         K8Np2VFafUo8P01L5Gtq8jVR587gQ33yVvkGAPU/9ba78gTYgBdhg1dyHNxc5lplsWN0
         4hSaLhfiCqpT8kECOa3ix5k2WOrBeEb+/AotOtTsJZwjFKBsLCxzCa0vID2ZSiZaCbbi
         nwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LMOWBn/u3aVqbnWmF8p6o8arazc7UvhFXaE3d67u6n4=;
        b=omcBYt6DedlNeyny0aJwgvXCOlAVXpkLUBL5d2tSyfQBkLqO0HKotljLRBBa8Uq1AZ
         hCeqDRtxmDgfKDa95knS2dGgg14+7sHaAdK+y3st8lXvbtNzJGtINhRLSsCxWAQSG6TC
         1qoDlXBRzpUAs7/+PyhlIrWqB2sKyXRiLUNDQKOCjKd0ntZ8BWX1BXgT9ZU7MF4BU2aY
         81s99uzJR4CjbSrLNwBSN8YQBwc97ry71hqIOBDNvz8i8afBpuMtijR7Yq200X6Yod/+
         JwgcIBXiMoo16aTMdLbv2cngJisLByB/KNK1/PzTqfRyYNDbV8D5DTYZTt4sI9+euTXa
         3+Yg==
X-Gm-Message-State: AOAM533QYtXhFL/f29+wtYt+gdfkMyVxNH7wrFK9nHsfJDftEFfZ02Qb
        qFiWsuE41sLdfsTJFFf3wpDno1kFbNs43WxAMcVhKg==
X-Google-Smtp-Source: ABdhPJy5cGNaclwU+Wu7lP6BWkQDF5adMjybClEbKDSLZmxMjfP4ZCWLYauxivTUNLyUwHfncbGeD7NsKBTRJr1L2ns=
X-Received: by 2002:a17:902:e846:b0:13a:479:33e5 with SMTP id
 t6-20020a170902e84600b0013a047933e5mr1986123plg.25.1631358037720; Sat, 11 Sep
 2021 04:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210910211600.5663-1-lumip@lumip.de> <e3efb5ea-0884-c02a-cb81-408ec421463d@infradead.org>
In-Reply-To: <e3efb5ea-0884-c02a-cb81-408ec421463d@infradead.org>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Sat, 11 Sep 2021 12:00:27 +0100
Message-ID: <CAA=Fs0mEprM0hErRY-kw7bOVqEw3o6X=--OixQ=_fNXdV_-QGQ@mail.gmail.com>
Subject: Re: [PATCH v3] drivers/cdrom: improved ioctl for media change detection
To:     Lukas Prediger <lumip@lumip.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sept 2021 at 22:41, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi Lukas,
>
> Just a minor nit:
>
> On 9/10/21 2:16 PM, Lukas Prediger wrote:
> > +#define MEDIA_CHANGED_FLAG   0x1     /* Last detected media change was more \
> > +                                      * recent than last_media_change set by\
> > +                                      * caller.                             \
> > +                                      */
>
> Drop the "continuation" backslashes.
> They are not needed.
>
> thanks.
> --
> ~Randy
>

Dear Lukas,

Happy to take these out for you and save you resubmitting.
I'm very happy with patch anyway. Once I hear back from
you I'll send onto Jens with my approval after one final test :-)

Thanks again for the code.

Regards,
Phil
