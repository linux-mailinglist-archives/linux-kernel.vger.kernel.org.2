Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0063DB2DA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 07:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236666AbhG3FeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 01:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbhG3FeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 01:34:03 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475B9C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 22:33:59 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n21so5153365wmq.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 22:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C1WY5v0DZXHTp8X+jU1XBLMpyZKc7p/7Jj3rqiqH4LA=;
        b=lSscHTftFvVptU0RS+B9xY4/Kl/vKO0fmd8RJGUtS0QJ7Cr+HIxgoDwzNcHLV2KcRq
         yaT6keM0oGDXc3g8ZUrvahCgeQ8zhc0bV9uDYtmXoO/w4FeCIKbeGql0cmwWkc9uMWNp
         7J4wlepD4tHdJAgjt3sIf2nWEEpOnAVnSd3s25CSzaItqfe23aRogMnFmjUcQ0H8SVhj
         Qao+bSdulih83AGQIt98is8fwF9t6zY8EyA301QW4G1xdTWL5faEh+ATQZax/v91wtpJ
         fKK/bm2q5IXTx0xCN7WDvo7cKg67B0PK75se07A5oWQyPOfJLPWKax5F6WtOFWWqgXxO
         KjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C1WY5v0DZXHTp8X+jU1XBLMpyZKc7p/7Jj3rqiqH4LA=;
        b=RNL6kDjc3ATw/Cheo1slGwxJK8aa3T7wfDXT6u50vLST0DNwydl9QipGrJsII1FaDh
         TOk2z/vTd7scflRE8uQgskQUePxB+oIIvWHG0QhKu8nEfn5+5wnRpMvyuWg2T9deqOgC
         WRTGvmdC68o88S17GIwi1SpcFeJnDEg2IqcFZZ0/CGvuC8/Jr7IrNtgky8XHBfxT7RlZ
         /pciPOBKUIG0MDyrQjYezOyVdMbdlj++Obqds2sOTLwhbQGrKYZS3VvHDeHuUrPKKywZ
         ub0Y61HKm3lN907x3d1uM59Z54q1H+o9tTY6SBW1ypJC3wrgKWavvVj98vpLNRIgyTeD
         r4ng==
X-Gm-Message-State: AOAM530hjnFLqgLpjMLgA4sozmNqwl+mnR/lDju77KT0qVvcxFyaXaLK
        1oAAc/KCeyKfQc+QArcoR5MffC21s61p8JzBAbo39w==
X-Google-Smtp-Source: ABdhPJy99kphmNZI2cUkbVS6HIZYZEcjuxBuzxR25itmrpo9gyztj1XHxGHYctWdO87pV6jxujWlnPyusuvuvlFn3Fw=
X-Received: by 2002:a1c:1dcf:: with SMTP id d198mr981162wmd.103.1627623237784;
 Thu, 29 Jul 2021 22:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210715213138.1363079-1-dlatypov@google.com> <20210715213138.1363079-2-dlatypov@google.com>
 <20210723064328.GA7986@gondor.apana.org.au> <CAGS_qxqOD+Bcvy7xti7_eg8+H1cJcfp94BtnRhuzijDcaGF_uA@mail.gmail.com>
 <20210730025544.GA12781@gondor.apana.org.au>
In-Reply-To: <20210730025544.GA12781@gondor.apana.org.au>
From:   David Gow <davidgow@google.com>
Date:   Fri, 30 Jul 2021 13:33:46 +0800
Message-ID: <CABVgOSnde5VmF8TLfF=B4Nbvo7C5GUJ91OY9Rct-ksyPaTtpcw@mail.gmail.com>
Subject: Re: [RFC v1 1/2] crypto: tcrypt: minimal conversion to run under KUnit
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Daniel Latypov <dlatypov@google.com>, davem@davemloft.net,
        linux-crypto@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 10:55 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Fri, Jul 23, 2021 at 12:31:28PM -0700, Daniel Latypov wrote:
> >
> > Thanks, that makes a lot of sense.
> > In that case, how useful would `kunit.py run` be? I.e. Do people
> > mostly want to see numbers on bare metal?
>
> I think it's a mix of both.  As in performance on bare metal and
> under virtualisation may be of interest.  I don't think you're going
> to be going through kunit for the speed tests though, because you
> need to supply module parameters for tcrypt to do that.

FYI, there is a patch for kunit_tool which will allow kernel
parameters to be passed through:
https://patchwork.kernel.org/project/linux-kselftest/patch/20210715160819.1107685-1-dlatypov@google.com/

That being said, no-one's ever used any of the KUnit tooling for
performance testing before, as far as I know, so whether or not it
turns out to be useful or not remains to be seen. With this patch,
it'd at least be an option if you wanted to try it.

-- David
