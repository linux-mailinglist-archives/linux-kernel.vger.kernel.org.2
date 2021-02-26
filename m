Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942663269B8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 22:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhBZVyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 16:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhBZVyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 16:54:47 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8E6C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 13:54:07 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id e2so5117467ljo.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 13:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UNEvIq/qxA6OOZG+WYtlwoaiZCAR2je7MAQSUMeP9zU=;
        b=DoVnxvMGwTiuuY8O+425FVCTFrq9wNuvueHtEeECVa/XKMdj6xistUI4rdrazTj76y
         XDlZ9YJ2LZYSON2YmvMKUjiBrtggSI4Pj1XvyPkiEzbROntPyENI2Ww/e/wu7cDSgbxw
         vdZt/hRmEAHBldrmdWyQnxz9yANDFw2DHfvoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UNEvIq/qxA6OOZG+WYtlwoaiZCAR2je7MAQSUMeP9zU=;
        b=au4d+fnlSXp8gmXu+mfEZadhijyW2hWEWPtZkowgdapeL/DU9FB7dHC4kOL5ydhtMI
         rAd3bVwoDSNbJ3sFDqyOKxFu7BmnG9jbd2qdM3dPqZLDLi30L9jyZ6kctSFSnQAl0soc
         OHUeq//kTBq7PK46VLauH0jNyrZKSreVHhZwkDjkXa2kQ7jIG2ydh8fhOMAGMF34jmww
         w/nhvwYNo0Q6zYzApP6N68RHJtCFK2veDu6nf7avrh7LFS4T26us/3qIH3jjqXtnz6K5
         0L0cnM7H64Zbe1wGHK3Ee4aKkL2UxwUI9Nu90OUj3f86fLmS1NI3DgCUEJP8i3eat9de
         sHrw==
X-Gm-Message-State: AOAM5338JbK3CYvDTh2Y1Mrlt0CPtIKFSB/IZM/c8NgOpnik4YtASL2E
        S3Kcu1HfPcX8d7xU91VuUJOAKTbO/7Gjvg==
X-Google-Smtp-Source: ABdhPJySa527LYsa/eoOQkn+tcdVPs907XC7z2hfI/HBorR3fnYIxSJZ/KF3+d0ZjTujrLr0J286qg==
X-Received: by 2002:a2e:309:: with SMTP id 9mr2857091ljd.377.1614376445717;
        Fri, 26 Feb 2021 13:54:05 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id w11sm1564789ljw.97.2021.02.26.13.54.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 13:54:05 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id d3so15978994lfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 13:54:04 -0800 (PST)
X-Received: by 2002:a05:6512:2287:: with SMTP id f7mr2765167lfu.40.1614376444470;
 Fri, 26 Feb 2021 13:54:04 -0800 (PST)
MIME-Version: 1.0
References: <YDlXWHkYntoO4fk0@localhost.localdomain>
In-Reply-To: <YDlXWHkYntoO4fk0@localhost.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Feb 2021 13:53:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjZJPqmPE_gzvzPtPsojxw-Xg8QTBCn+Oi-ca2s0818NA@mail.gmail.com>
Message-ID: <CAHk-=wjZJPqmPE_gzvzPtPsojxw-Xg8QTBCn+Oi-ca2s0818NA@mail.gmail.com>
Subject: Re: #pragma once (was Re: incoming)
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 12:17 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> I want to sent treewide "#pragma once" conversion:

Are there *any* advantages to it?

It's non-standard, and the historical argument for it ("it can reduce
compile times because the preprocessor doesn't open the file twice" is
pure and utter hogwash. Any preprocessor worth its salt does the same
thing for the standard and traditional #ifndef/#define guard sequence.

Honestly, "#pragma once" was always a hack for bad preprocessors that
weren't smart enough to just figure it out from the regular guarding
macros.

I can't imagine that any preprocessor that incompetent exists any
more, and if i does, we sure shouldn't be using it.

So #pragma once seems to have no actual advantages.

               Linus
