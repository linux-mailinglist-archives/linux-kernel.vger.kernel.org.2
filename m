Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82BD13AD21C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 20:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbhFRSbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 14:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhFRSbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 14:31:11 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41313C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 11:29:01 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id g8so17330311ejx.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 11:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BG4eKVHKznlsObIX3tbztA9VJHzMPAhtbR7iiL8ePI0=;
        b=Q23TrU3E6GAes3b7ZQW9O6WJuns8aX+hTXQnaJWCorE0GnA1a2diqu7X6Yt8/wdOiJ
         EsYzPVuFCOl4NQzraLZZH9TShwuxSzFuaYEsBFzBFA715CUqRAMIS6TGhG7VYJET8ZMS
         eIXMyE8eiH6kgzpB0UBiARyD83F77tSrL50PgHShHfvMvz4jnMA82dhiHfsD0fRaeXT3
         ibHDleHxO7zqaxEr3BXRZzEdCCbcP5rwDLFiJyLkQ/f+xSQpL2bZ6Zsy6wmTgS9RmGcI
         +Me/lDMtyPQV+9qfqhunBr9yI3A14aXJAKEcFlh63IjjJ4rCbCynphRaPTdQUY/LwIPg
         hHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BG4eKVHKznlsObIX3tbztA9VJHzMPAhtbR7iiL8ePI0=;
        b=UKDb9jfqDe5P/0imfyvmOND5fjzN21oFUGVDq35EjIdC/NkNhUIUCW0kTlbgQh8sJL
         Row1Kr4aB4/nXbNXx9ufcdBl3o1qH2Ynp6ZwjO34tGd154Ri7mtD1UEdu4JIRo/YSGEg
         9LDCG7YhNXZ9tbpXsQIy88xD9jx0uSNXR1idj5R9ef75pYpeeGWhLd6ae/6pLAr/ppv1
         cMWq01WACyX+Tb5pSloTdWlLxtFYf3RyR76qh5DYPWTMKWYxQWGM2c2dIsifkN/5dxla
         jHUdC0YnDVJ+D/5oM6H+fulDgG0OMMkqP22QmiViMYyj7fnGqemdvxCw/y7vIER0GFV1
         JUxQ==
X-Gm-Message-State: AOAM533dkhzzzk3ACFmKJHronTQ+L74XscDJd8keiet66u3jHqhVOwfO
        ytaM3J3dpzIgdP0chzrmuVpZSFHzsXAyu0msVgQ=
X-Google-Smtp-Source: ABdhPJzUTmuFnxnrbs89PnRsUk432kebaSBEk+xc/xA6GneetOr7+kC3P1prX2ZGQyxB/ZTXnzdLuDZlvYJVic3Vhu4=
X-Received: by 2002:a17:907:7848:: with SMTP id lb8mr12777004ejc.494.1624040939644;
 Fri, 18 Jun 2021 11:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210613122858.1433252-1-fbihjmeric@gmail.com>
 <YMX7SRSPgvMA/Pw1@kroah.com> <CAKgboZ8QUQpiinL0xCxUmcp6nEVU20jXkDXbrK_QisUMiLEo1A@mail.gmail.com>
 <YMdkN9cft6KHcFn3@zeniv-ca.linux.org.uk> <CAKgboZ9P2afm7-eOE3COrKVDkFZ_g288KfJAyQiwzC6fN75VmA@mail.gmail.com>
 <YMeL7PjstV601pbN@zeniv-ca.linux.org.uk>
In-Reply-To: <YMeL7PjstV601pbN@zeniv-ca.linux.org.uk>
From:   Jhih Ming Huang <fbihjmeric@gmail.com>
Date:   Sat, 19 Jun 2021 02:28:48 +0800
Message-ID: <CAKgboZ9NnN6FZ6XX5MhRk0T-TLvmPvsRWogSPuXu8m940mWNZg@mail.gmail.com>
Subject: Re: [PATCH v2] rtw_security: fix cast to restricted __le32
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg KH <gregkh@linuxfoundation.org>, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, maqianga@uniontech.com,
        marcocesati@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 1:03 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Jun 14, 2021 at 11:27:03PM +0800, Jhih Ming Huang wrote:
>
> > Thanks for your explanation.
> >
> > To clarify, even though it might be false positives in some senses,
> > following "hold the variable native-endian and check the conversion
> > done correctly"
> > is much easier than the other way. And it's exactly the current implementation.
> >
> > So it's better to keep the current implementation and ignore the
> > warnings, right?
>
> Umm...  If that's the case, the warnings should go away if you use
> cpu_to_le32() for conversions from native to l-e and le32_to_cpu()
> for conversions from l-e to native.
>
> IOW, the choice between those should annotate what's going on.
>
> In your case doing
>         *((u32 *)crc) = le32_to_cpu((__force __le32)~crc32_le(~0, payload, length - 4));
> is wrong - you have
> crc32_le(...) native-endian
> ~crc32_le(...) - ditto
> le32_to_cpu(~crc32_le(...)) - byteswapped native-endian on b-e, unchanged on
> l-e.  So result will be little-endian representation of ~crc32(...) in all
> cases.  IOW, it's cpu_to_le32(~crc32_le(...)), misannotated as native-endian
> instead of little-endian it actually is.
>
> Then you store that value (actually __le32) into *(u32 *)crc.  Seeing that
> crc is u8[4] there, that *(u32 *) is misleading - you are actually storing
> __le32 there (and, AFAICS, doing noting with the result).  The same story
> in rtw_tkip_decrypt(), only there you do use the result later.
>
> So just make it __le32 crc and
>         crc = cpu_to_le32(~crc32_le(~0, payload, length - 4));
> with
>                         if (crc[3] != payload[length - 1] || crc[2] != payload[length - 2] ||
>                             crc[1] != payload[length - 3] || crc[0] != payload[length - 4])
> turned into
>                         if (memcmp(&crc, payload + length - 4, 4) != 0)
> (or (crc != get_unaligned((__le32 *)(payload + length - 4))),
> for that matter, to document what's going on and let the damn thing
> pick the optimal implementation for given architecture).
>
> Incidentally, your secmicgetuint32() is simply get_unaligned_le32()
> and secmicputuint32() - put_unaligned_le32().  No need to reinvent
> that wheel...
>

Thanks for your comprehensive explanation.

I just sent the v3 PATCH, but I replied to this thread.
Should I create the other thread?

For the secmicgetuint32(), I am not the author of this function,
but you are right we should not reinvent the wheel.

Let's focus on sparse warning fixing in this commit.

thanks.

--jmhuang
