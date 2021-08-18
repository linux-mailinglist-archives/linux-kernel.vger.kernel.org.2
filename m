Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9283F09DE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 19:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhHRRFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 13:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhHRRFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 13:05:31 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC42C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 10:04:56 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id b10so6397509eju.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 10:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Si7U6HwgT/s1/0DUykgf8Mxxnbx+qV+oZXkcnS5dKHQ=;
        b=AChYjDKZR7xEN/R81QQ9I2hRsbNGAI7NqftHe4v8mPniSSGnl/OrNvA5bEeVQApm+O
         ibB1uQgvIRSxkzQx4SECL93cgAfhppiDnrNRpIl1zsFnwkqprUOkuVE5Z0bsNwqKy1DK
         AQpCFTY1JVxMWMxVOUFVrPpc/+axmg4D1Mp12sDjducva8Umbc439ZhN5lsokrQEfN+V
         wCjzQ268htspW9T9IGu5U9JiHo+mrVh/6a43zfQdeG2u+2zlni0wJ81QYsD/oM5TJ0tx
         LCAn5PA/Rl5fV175bfdLlDt3KCgvLpCyvpNcj5pFtAsB1cTNaA5If82yuAZE8eBRavgZ
         wdug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Si7U6HwgT/s1/0DUykgf8Mxxnbx+qV+oZXkcnS5dKHQ=;
        b=g+Yiolw4Zmmn3/uS9R0urnIPJYuVR8V98xcBrakRRLw5SindvTNh3d4qVlUI/ifNdG
         zM3zLq0P3jY5vNuMWmLY9zzCvcPlyzM3af3xjwk5WO+T/NhBdaScyZOwVjbY0Wbg3Jwo
         qgbEEadZJ/dgRIB/TSObVbCj8b04+bQwhaj/AcLoZrVM83KoSLa7ZQ9P33oEvidzxTeS
         gxTYoRCi/2TgpAu8xOWyyIH6Yi2I41mDjARrB8ozwr20yqG2S+qLZE/XB99wJl2Rhrzr
         fQ5FUFQNCS86v0PF5DbHBB+GZdqgDw915FOMqLsIxNc+rBBpJB310dSY9gNk82/9C9+e
         rJWw==
X-Gm-Message-State: AOAM532oAL7wvMD70HJi6hnoBu808nNnSnyMLRo8K9kF/Akue+DZ6T06
        GNLMdjb1yKdqwgz/JB5NZCGxZgAjU97InIAeeF0=
X-Google-Smtp-Source: ABdhPJwsmFeTJicZf4gc/8UKoIhnK1UkHukA04WmnpY7zZI030kGbN9o3u27fYTEth+eye5/qhxeuEakJIo/vBLukbg=
X-Received: by 2002:a17:906:b890:: with SMTP id hb16mr10503469ejb.383.1629306294582;
 Wed, 18 Aug 2021 10:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210816180909.3603-1-shy828301@gmail.com> <20210818063042.GA2310427@u2004>
 <dd225992-ec89-a911-b318-f4a91c70ed42@redhat.com> <20210818075316.GB501393@hori.linux.bs1.fc.nec.co.jp>
 <c0082d37-dd36-5d83-f759-cf05a9e00b77@redhat.com>
In-Reply-To: <c0082d37-dd36-5d83-f759-cf05a9e00b77@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 18 Aug 2021 10:04:42 -0700
Message-ID: <CAHbLzkq7M5aDOxmgHGkoh95bC6DfZqQgdMSKS_m-REM4WbYEGw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: hwpoison: don't drop slab caches for offlining
 non-LRU page
To:     David Hildenbrand <david@redhat.com>
Cc:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "tdmackey@twitter.com" <tdmackey@twitter.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 12:55 AM David Hildenbrand <david@redhat.com> wrote=
:
>
> On 18.08.21 09:53, HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3 =E7=9B=B4=E4=B9=9F)=
 wrote:
> > On Wed, Aug 18, 2021 at 09:24:01AM +0200, David Hildenbrand wrote:
> > ...
> >>
> >> Might we want to add a TODO in the code? We have a similar one in
> >> mm/page_isolation.c:set_migratetype_isolate() and it's certainly a rem=
inder
> >> that something of value is missing.
> >
> > Yes, that will be helpful.  The below's what's in my mind, but if someo=
ne
> > has better idea, that's fine.
> >
> > @@ -296,11 +296,9 @@ void shake_page(struct page *p, int access)
> >       }
> >
> >       /*
> > -      * Only call shrink_node_slabs here (which would also shrink
> > -      * other caches) if access is not potentially fatal.
> > +      * TODO: Could shrink slab caches here if a lightweight range-bas=
ed
> > +      * shrinker will be available.
> >        */
> > -     if (access)
> > -             drop_slab_node(page_to_nid(p));
> >   }
> >   EXPORT_SYMBOL_GPL(shake_page);
>
> Just what I had in mind, thanks!

Fine to me, will add this in v2.

>
>
> --
> Thanks,
>
> David / dhildenb
>
>
