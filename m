Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F4740A70E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240482AbhINHGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240468AbhINHGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:06:25 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD06C061762
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:05:08 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id kt8so26576426ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B2/VApyJZoRqB7L/N6VX+qLKsuRTi0j0Ev7mIRjfSzk=;
        b=IemX1JxGW12b/l8eossorB4QY091xodevGLbTavaDgizjgxnuUyf/hunquBOn2xbr3
         HZMMGQVAS1gBFy9qMLnbclwWPfNwCH1uKE0+JBJkIz70jkjNjq/B4BqjupE8y50kG8QS
         02OoJYwW8RHILm9bXFAHwFXgKLBJNEnJ9qM5DnoTOCzFX8QC4PFQfnHYzHbQSRcSANbK
         PI9Zfm+8xhispKdYwn1NpURo2Vcl6kYiXgkIHWX9Djr8AGf1Ze8NCun97cqDPI0sbMzd
         aFXOW4D2zaykbvTiEyvHJBJfIgo8Ah9XjdWS/jf2DwLJBnAB9dlCS5uz8q9RYhAGqRik
         kfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B2/VApyJZoRqB7L/N6VX+qLKsuRTi0j0Ev7mIRjfSzk=;
        b=YThPnvxPl54FA+bTCG+epObdqB/WsI2hqsciPvkjFefe1jLQn75DvShQg3ZFVSTK2s
         +3DB+aiJK8X2G/fl9NrboELm6oxiugFLsAn4JD+0jb78oxbRPrd+GF2gBL1MXUEjh3iP
         yoZEzieqMJHj1/0ZYJcKPsb1cAuc0boo/XzG+PR/7oknhgGtqTn2Yn5P81d3Wcx37M0m
         YihH/KUCEU5P0LPxsgqotzFtSZTaEqalQMj/G5dV6A0WE+ayj/XaAbAo9/mkO15bxqrP
         QK35jyoAK+34As8Lm2cVRTr1WhGwPICKf4q1wR8iC6biSQlRjk7OmpZ62P027BpvyyTX
         yQYw==
X-Gm-Message-State: AOAM530I89nBl3LhdM0jG1qitjefXANsMkY4KgIoi+EnxATa/NSmOwTv
        J6odNVXGPKCrz1wl2fQ+mi0WhSpka8Mcqt5ShPo=
X-Google-Smtp-Source: ABdhPJxaEPRWvCIK9AkYNuVoiK5RN68ymDm6C1UbwFr+PQNZ/GUvsrSOyDSIyEbP1n7Hb1vYqyZXGCxGI88xCl3vsI4=
X-Received: by 2002:a17:906:4dc1:: with SMTP id f1mr17398909ejw.288.1631603107570;
 Tue, 14 Sep 2021 00:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210912025235.3514761-1-linux@roeck-us.net> <315e4a23990444f585a15d2e23a39b8f@AcuMS.aculab.com>
 <46f59bf8-f243-b65c-07b3-8ecbf7b410fa@roeck-us.net>
In-Reply-To: <46f59bf8-f243-b65c-07b3-8ecbf7b410fa@roeck-us.net>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 14 Sep 2021 00:04:56 -0700
Message-ID: <CAMo8BfLOhr8Gw9RbSM_pVhgokDcBZ3PgwQAG6sCxDBAm_rMy7Q@mail.gmail.com>
Subject: Re: [PATCH] xtensa: Increase size of gcc stack frame check
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     David Laight <David.Laight@aculab.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 9:11 AM Guenter Roeck <linux@roeck-us.net> wrote:
> The functions I checked typically have pretty large local data
> (like, more than 700-800 bytes). The errors are only observed
> with xtensa:allmodconfig test builds. While it may be arguable
> if those functions really need that much data on the stack, it
> is unreasonable to assume that all those errors (again, more
> than 50) are ever going to get fixed, especially since the errors
> are only seen with xtensa and not with any other architecture

That's not what I observe. If I build allmodconfig on v5.15-rc1
for arm with gcc-8.3 I get 69 of them.

> (including parisc; setting a stack limit of 1024 works just fine
> with that architecture, at least with gcc 11.x). So the realistic

This comparison is a bit biased because allmodconfig on xtensa
enables KASAN which is not supported by the parisc. Disabling
KASAN roughly halves the size of stack frames for a few
instances that I've checked.

-- 
Thanks.
-- Max
