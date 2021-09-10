Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC0D4071BA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 21:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbhIJTLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 15:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbhIJTLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 15:11:47 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D23C061756
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 12:10:36 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id c8so6085238lfi.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 12:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O+kk743scj4vQ3QtINkHDre6/4jEJJ4749GFq5mUTx4=;
        b=eKLWgpcpn9OANXNGYiqnFDT13PZcMsJeDEn9Rs2myjv61X5TE9VAPYJ84lduvNrUtK
         AHqewLaLF8mTpfd2orazz1Y+fJBfxtZfondH5rrQjdsZyqV0w/4TdJrDX8LjxW0q44t/
         ofLwcwjgnhW3kMy+wdI98byWSe/3UPzwO74AU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O+kk743scj4vQ3QtINkHDre6/4jEJJ4749GFq5mUTx4=;
        b=sO5AhdGZW9eIvPIKt8wiPGrrX6HhLDiKYvqGSmPI/X62mcT5xMjJ6VG23vhwKwLHLX
         rkJabiCU21pIc/tBOInC6XHicsbszvPSG9K7J+QwQbuyN5bWubQF/cU+YILpd7saQ2eE
         BTJNbpNAkRq+K7mML5mkbF8rVH6JVbxjrfJguyRHmv6Utr6qnnjbK5LrBUhD0fBKeNnz
         M/4AEeZbujjtSHjprwWOmdx+BM4Kh9NuIVckR0z6avpLyeMkXxxFRmYjJZx35wUaOKHG
         fsN6OYLAeYNITe6Z1epIdO5gE+p1CLuQE6dPpDfZTpUeGOtEnriIvlC9j6P2rAJdG+fg
         siQg==
X-Gm-Message-State: AOAM533aKK8T6VvQICNctWr6gcwsiJOrjj5nnoLC/9IXKAdroVVvodw1
        Yzw1RvAPbyrGGK41rKZAgjTMGG6C6X0efkD4cyI=
X-Google-Smtp-Source: ABdhPJw87PDL5YxUxuptiy0yxaHCVSIihEuAA3X8lFdAK2GK5PSU8zv1lgEyvWfREAdHXNwpq1oJCQ==
X-Received: by 2002:ac2:5f0a:: with SMTP id 10mr5013531lfq.14.1631301033965;
        Fri, 10 Sep 2021 12:10:33 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id b17sm662498ljj.35.2021.09.10.12.10.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 12:10:33 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id h16so6035788lfk.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 12:10:32 -0700 (PDT)
X-Received: by 2002:a05:6512:2611:: with SMTP id bt17mr5149905lfb.141.1631301032359;
 Fri, 10 Sep 2021 12:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <YTrQuvqvJHd9IObe@zeniv-ca.linux.org.uk> <f02eae7c-f636-c057-4140-2e688393f79d@kernel.dk>
 <YTrSqvkaWWn61Mzi@zeniv-ca.linux.org.uk> <9855f69b-e67e-f7d9-88b8-8941666ab02f@kernel.dk>
 <4b26d8cd-c3fa-8536-a295-850ecf052ecd@kernel.dk> <1a61c333-680d-71a0-3849-5bfef555a49f@kernel.dk>
 <YTuOPAFvGpayTBpp@zeniv-ca.linux.org.uk> <CAHk-=wiPEZypYDnoDF7mRE=u1y6E_etmCTuOx3v2v6a_Wj=z3g@mail.gmail.com>
 <b1944570-0e72-fd64-a453-45f17e7c1e56@kernel.dk> <CAHk-=wjWQtXmtOK9nMdM68CKavejv=p-0B81WazbjxaD-e3JXw@mail.gmail.com>
 <YTuogsGTH5pQLKo7@zeniv-ca.linux.org.uk> <CAHk-=wg8O4NBTUr9GvNo=vnUmONUGYypN4dFr7QNEGUFcN=tBw@mail.gmail.com>
In-Reply-To: <CAHk-=wg8O4NBTUr9GvNo=vnUmONUGYypN4dFr7QNEGUFcN=tBw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Sep 2021 12:10:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiJ_iDEQtDTjU-+QKgob1xnQzfqsn6Xm4FL+sn1Uqw-BQ@mail.gmail.com>
Message-ID: <CAHk-=wiJ_iDEQtDTjU-+QKgob1xnQzfqsn6Xm4FL+sn1Uqw-BQ@mail.gmail.com>
Subject: Re: [git pull] iov_iter fixes
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 12:04 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So only 'struct iovec' and 'struct kvec' actually have the same format
> and can be used interchangeably.

That was very badly and confusingly phrased. They obviously don't
actually have the same format, and cannot be used interchangeably in
general.

But the pointer arithmetic works the same for those two union members,
so for that very specific case (and _only_ that) you can treat them as
equivalent and use them interchangeably.

Al clearly understood that, but I just wanted to clarify my phrasing
for anybody else reading this thread. Please don't use the iov/kvec
members interchangeably in general.

              Linus
