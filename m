Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0D045D386
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 04:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344446AbhKYDTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 22:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344691AbhKYDRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 22:17:39 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C37C0613FA
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 18:56:45 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id j3so8296961wrp.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 18:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nuLDJqDSgx5jw6+md20Ao1BdxvJoQh1BpzGT4fULlbM=;
        b=U+r3BsIt96UUMwoDIqTyobReO4ofCZ31cK3JrT3IS+503p0dgglH3x59feL9BdSpdi
         MR5+H0yi5aOl5f96vlLkQwdaTR+xxrWxCF0NWkejymKgCcoR029Q0X5shrtm0pJyznLQ
         y4IU2d1Zn+M178rLyVOSmmWZytiUKbEulQcfWdkugeMrVN3uTb6azlj4tKpNtIVlEih/
         lgh9GBt6k28OqgaqRyuWjWKdaoan1MyqxD9mXoJtarCpz4y0YmI+1NaFumpj56JF3M/F
         jlwj/GQCIRvQOiRcCRplE4lnlls+U9ANvXEVbZQ6JQ4yQPCjLcGa915lFjKkiFwtdzmW
         SrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nuLDJqDSgx5jw6+md20Ao1BdxvJoQh1BpzGT4fULlbM=;
        b=IRnJiBI5HG4l+gpRkeEUcygXeLx1DYpcN17F4w/5g9J5fcVu+TfmD/YglesfeYoLIA
         dVVq50v3tIXE7mhWXc5FRe98+9ZYlAgUYylQBBWybQZSxr7ig9+Ce/16rNLht4lWg3n9
         kpDUZa0c64yzQsmn+4kyytNWQUsFye/08ZIGOkf15X2dR2SRuy8MGgLI7CdWRaIu3jwp
         BRtncld/MF/OWeE0lBJlj2Xf2qhPT1neyj3xVm8bk43NnQr28j4P9bzm/xpMNmUqlc3h
         sawFV3MK+mmQmN2kQj67PWLFmtRRsymTTRBv70JsAkSuE8ps3V2TsLx2SM7uZZWd7vIm
         x4ig==
X-Gm-Message-State: AOAM530XQHSHMIvjzeQ47WlnYD193sinh8G5niPCXl34GPdQgY/amqTW
        Tl9Onp6NsPyMiaPyRGOrg34SlsR7lTkuW+yMmwDZ1ZLGFTOtYQ==
X-Google-Smtp-Source: ABdhPJyWm4wVvpFH93tXwa0OLcwjk9kBWn8db3CLF1HfdUuaqHZa8DHMMsjimDOa3IXGg3rpgYqSTdvy4Ml2pxt8i1Y=
X-Received: by 2002:adf:f0c5:: with SMTP id x5mr2600439wro.484.1637809003258;
 Wed, 24 Nov 2021 18:56:43 -0800 (PST)
MIME-Version: 1.0
References: <CANn89i+hQTn26hK-4CA=cAwCxEMzogqD30PYdqz4NP8kjmH2gg@mail.gmail.com>
 <CANn89i+K6=Kc0weayD_phAPn9YT=2UUje+1BZfg=kUiLp7ELqQ@mail.gmail.com> <619eee05.1c69fb81.4b686.4bbc@mx.google.com>
In-Reply-To: <619eee05.1c69fb81.4b686.4bbc@mx.google.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 24 Nov 2021 18:56:31 -0800
Message-ID: <CANn89iJdQ1VTLYUKu1hYNm4wF__ZzrwNYr28v_vGM0MCybJpxg@mail.gmail.com>
Subject: Re: [tip:x86/core 1/1] arch/x86/um/../lib/csum-partial_64.c:98:12:
 error: implicit declaration of function 'load_unaligned_zeropad'
To:     Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>, alexanderduyck@fb.com,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-um@lists.infradead.org, lkp@intel.com, peterz@infradead.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 5:59 PM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
>

>
> Hi, I'm not sure if this is intentional or not, but I noticed that the output
> of 'csum_partial' is different after this patch. I figured that the checksum
> algorithm is fixed so just wanted mention it incase its a bug. If not sorry
> for the spam.
>
> Example on x86_64:
>
> Buff: [ 87, b3, 92, b7, 8b, 53, 96, db, cd, 0f, 7e, 7e ]
> len : 11
> sum : 0
>
> csum_partial new : 2480936615
> csum_partial HEAD: 2472089390

No worries.

skb->csum is 32bit, but really what matters is the 16bit folded value.

So make sure to apply csum_fold() before comparing the results.

A minimal C and generic version of csum_fold() would be something like

static unsigned short csum_fold(u32 csum)
{
  u32 sum = csum;
  sum = (sum & 0xffff) + (sum >> 16);
  sum = (sum & 0xffff) + (sum >> 16);
  return ~sum;
}

I bet that csum_fold(2480936615) == csum_fold(2472089390)

It would be nice if we had a csum test suite, hint, hint ;)

Thanks !
