Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C537236AFF9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 10:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhDZIuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 04:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbhDZIuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 04:50:14 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3259AC061756
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 01:49:31 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u3so4530645eja.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 01:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=keMrPxdnuQ2eyE2+o6RIGcLK/2JgBIc9v2ZJ/1tg/H0=;
        b=vOdz2AyqkR3N5gPVxiZCUvx3pwe8/rQGZ+2j+E/JBgMN8eOJSORqUBLvDSsqshjjqq
         9f2as81NwE9dqyACbniLf8mDhhtOT3NT/9b2rb0L73tdKMug+c4ShHAQYdyVjstEf93I
         hCBG2UyqoHUVG9LLYjqyyzMFHEe1PvogaJz0PpHVfQzHio3FDdO4IQZnAcoODX0x8ZaK
         1Pw3nEwJYCLq6do0GScc+6NXzb02uu5W7cSgLLwM+ZwhncxObEr9ccn44pPAgVssZ1lm
         3bHw+vn0mQjufyGzQy427dLjK9lmODSn8yy/VLLVAYw6DqWu/yhEpojz+SmnGKn4H6a0
         yXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=keMrPxdnuQ2eyE2+o6RIGcLK/2JgBIc9v2ZJ/1tg/H0=;
        b=ikvKuUx9qXT5j1MGzxs7f8qay8MG6oCx3wa4fkWlhpgTgAKoocrv5EMv+13BsHNR3j
         cMYkQW+BYfXOpNOCCX+B/w3Z2mk15H4NfRXCHyriv1cyTB9E/Hc8WgIkS+USrusnICBl
         9bRF/k1bU3ZcoUCTtxy1fgiaAXRKKXrrxzvZGLHW8DO2My+MeB9qlBXc/gnDSBHr1vid
         FPC2ZAlmig5ghRVbSc9fssMHlEkOtyZ2X8e9xMkH4tvTOxw2BgyuA9XweXfvcvHOvp7w
         bX02pYM2b8XUXuHgNduoKGedvtB63XLGli3waaqtUfeQ0nmBb8+NwBHW2Jg1JagFLNPB
         46mA==
X-Gm-Message-State: AOAM532WX8li9M9rAR2hEDvjlfjm++mVykogilJjsRBjf1HXw38HaWqe
        trgdpk+a6hSkXSsrZ5cKtYBcZxNwNKAZEx62Lw==
X-Google-Smtp-Source: ABdhPJwqaMEQcuKfPyhQlZO2Ldty9Q32hy0Rd8cJYaxnYq/jZ5M1ilOtRmGoaGrhrGb8QlvfWHn8eSHwPcza1j87ikQ=
X-Received: by 2002:a17:906:3613:: with SMTP id q19mr412831ejb.231.1619426969899;
 Mon, 26 Apr 2021 01:49:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210316141916.447493-1-rsalvaterra@gmail.com>
 <CALjTZvaX8miSycr4oGmF_rGN4KWWBzfyBj1-7jefT=Uz3w9Oww@mail.gmail.com> <ee050b2dce3a233318748df416be0ebff4402ed2.camel@infradead.org>
In-Reply-To: <ee050b2dce3a233318748df416be0ebff4402ed2.camel@infradead.org>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Mon, 26 Apr 2021 09:49:18 +0100
Message-ID: <CALjTZvZ5-c3+v2db=mqwVF12yn68BwRk8HWi2rr2yK8F-kZzvg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] jffs2: add support for zstd compression
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        lizhe67@huawei.com, christian.brauner@ubuntu.com,
        gustavoars@kernel.org, trix@redhat.com, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, David,

On Mon, 26 Apr 2021 at 09:24, David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Thu, 2021-03-25 at 14:47 +0000, Rui Salvaterra wrote:
> > Friendly ping (and also cc'ing dwmw2).
> >
> > On Tue, 16 Mar 2021 at 14:19, Rui Salvaterra <rsalvaterra@gmail.com> wrote:
> > >
> > > Implement support for zstd compression in jffs2 at the default compression
> > > level (3).
> > >
> > > Lightly tested in OpenWrt, on a single CPU embedded MIPS32 system (AirGrid M2).
>
> Seems reasonable. Do you have the corresponding addition for mkfs.jffs2
> and can you report the boot time / image sizes with it vs. zlib on a
> typical platform?

I haven't done any changes to userspace, other than OpenWrt's fstools
(to force-enable zstd compression at mount time, with compr=zstd).

> And if it doesn't make a difference to boot time or image size... why
> are we doing it?

In OpenWrt, we're carrying an enormous patch [1] which enables lzma
compression in (and only in) jffs2. Having a single compression
algorithm with good all-around performance, usable by other subsystems
(e.g. zram, ubifs) would allow us to disable other redundant
algorithms and consequently reduce the total image size (I measured an
increase of nearly 200 kB by the lzma patch alone).

[1] https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=target/linux/generic/pending-5.10/530-jffs2_make_lzma_available.patch;h=1bccb30a69f69ff8e2e70a747b1f3b25d1079c8f;hb=HEAD
