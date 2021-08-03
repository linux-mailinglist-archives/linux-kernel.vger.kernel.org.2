Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1692C3DE90D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 10:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbhHCI6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 04:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbhHCI6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 04:58:13 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906BFC061764
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 01:58:01 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id b1-20020a17090a8001b029017700de3903so2306502pjn.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 01:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=We/acfPRwhLDIriskY+WhTs3fSv02ptiPnn+28cRj7A=;
        b=AON2BLn5KWQ1f81r9+ETwq2QTbnE0R0SXzm344y6YYW1JiGmfnsVLU40ZtO11Uwnl7
         vjbjWghraNrMVX5KyD8bGpk/0JQapsek6XIAT7PmsKylAMf8HFg8Unq2X/uww4YNrVx6
         l3PpQaUZ+paSQfTbRNOWYgUhB+wc54aKmerIFNtZR5rQJf+03zXem/rWuK6MGvFKHOtO
         SX17H1h8JeL2bHO2yUx6k7mmBz4xFVct3gvhmG2bSdo9HxJJf9OW4nYJEDTG98UJkUOU
         a7FbJwVhTybxcU91hWRlU/M8uG82KH1sR/pB+5o87WZI+aXetU3ZbEQXQVBe0FVCuoAg
         u2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=We/acfPRwhLDIriskY+WhTs3fSv02ptiPnn+28cRj7A=;
        b=XPNlwrJKRtWNV+jS63RVjGgwyK0crMzdf0yuwfzq+Lc0wf2b55vEb71huS/oOTqbIZ
         fjfS2OW89hAzcujzKmB9XZXy+N/jSOYFJspvPLGZa99r2eIJcQEa2GydZ6yhkz2QlhVE
         5X8YhM1Xuaf8OvjzIigI/qZKC/NY3D7gOgGTlrxNZ4LhLfuMjnXMyEn+L4VPr7ac0r1D
         RRrNJiJc1OShm/46sLdu8W9ehppNNMWUfbaO9oF8MZdakXZAb7Jq0yw5OL/zp07rS+5w
         jBPdhiVaw8JXTuv6m/iQL3tIw2xkfwqDQXBPBkekGzpWEVrZAZqpRZedPq2Ax3Rtop9m
         GHAg==
X-Gm-Message-State: AOAM531N6pU8ki8p4LgNoCNaMTRUfbVVJQPRVlWwygUYtxGOFCgbfBwd
        QRPrN2TRcViWD9FUQbDaZV4Sl3XvReZ+HSi1W5t5cA==
X-Google-Smtp-Source: ABdhPJy4+zhCiecjkitlZnXmMY+QF2JUQXqeTtvV0bDg2mPfFE4UEZt1+Sa27wjHyuHyYTkH3MypYSqH3s9CCd0MU7k=
X-Received: by 2002:a63:f961:: with SMTP id q33mr590820pgk.82.1627981081075;
 Tue, 03 Aug 2021 01:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210802233339.25285-1-broonie@kernel.org>
In-Reply-To: <20210802233339.25285-1-broonie@kernel.org>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Tue, 3 Aug 2021 09:57:50 +0100
Message-ID: <CAA=Fs0k95E3FN-9rwzSQcK4JmejHDKBbvk-yhRynJBTbqBNVxQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the staging tree with the net-next tree
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg KH <greg@kroah.com>, "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Aug 2021 at 00:33, Mark Brown <broonie@kernel.org> wrote:
>
> Hi all,
>
> Today's linux-next merge of the staging tree got conflicts in:
>
>   drivers/staging/r8188eu/include/rtw_android.h
>   drivers/staging/r8188eu/os_dep/rtw_android.c
>
> between commit:
>
>   89939e890605 ("staging: rtlwifi: use siocdevprivate")
>
> from the net-next tree and commit:
>
>   2b42bd58b321 ("staging: r8188eu: introduce new os_dep dir for RTL8188eu driver")
>
> from the staging tree.
>
> I fixed it up using the net-next version and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Dear Mark,

Thank you for your e-mail - not sure what is going on here as the
r8188eu files are totally new - the net-next commit is touching files
from a different directory (rtl8188eu) so perhaps it is getting
confused and considering it a rename or similar? Regardless, all
commits for r8188eu subdirectory should come from staging, as it is a
different driver.

Regards,
Phil
