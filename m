Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCE54551A7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 01:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241920AbhKRAcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 19:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbhKRAcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 19:32:01 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B23C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 16:29:02 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id z5so18913391edd.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 16:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OIMXt5BlJzONIEqbNsrjJJzddvQcjeheSuCiqaUmhPo=;
        b=iBMsyFuRgW63GMLP0eKHN0OkRIej+ZvKezsjrMMM8yfI9oAIgB75wDQTbB4GsEe/a6
         PPC0hX0b4WFpuAD3VHnkhf85FQa1rRocgyaGnFvSiHrZrt99nuEx0PJAqQ9oNb2Tz7Xu
         U8I2ihimE7fOqaQDT1Fb/RwA4D/22B8p6WwdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OIMXt5BlJzONIEqbNsrjJJzddvQcjeheSuCiqaUmhPo=;
        b=l0GZ3jKuKkt9EdUIKz9N1pFPtD7VzusPmF5z4uwarmOtoENhtdAeCDMSJvpc5j7mFC
         t8PoFCw5OVOSyVOs8iO395jqqE36YON9Wr//sw8OzGaMJDp+AOIVWvFtDbtQsZCWgp5f
         61MxopDCNIUNhJ1YtCicoJ2tWIurzLmv3otdbit5rYTCOm0XnrebQN3G/ilo7k7HbGIA
         0gY3nxVktPgChS6OfJ4FfaEPPVuTV/01uT0lnkbBF7UGjWFgpVm1tJQoGIi2Y0G2DY0B
         5BnfMqofSz5zf6af7XAIVjFwsLlTNHRdB1vIxi3pen5hkg/UtU7/h4HruCYPa2KwZ14p
         HVGg==
X-Gm-Message-State: AOAM531nMyRy5LIsHcM9TLO/nhQc5PFeAaLeMExu3zTcdGCLDDomzmZO
        6VHc1aFmQxwQmcTuOrDML/kEExQXW3hzTRQF
X-Google-Smtp-Source: ABdhPJx846FE0TU8ZNNMQBrDs4a0hQdKUocZFj64JvRwPJf0DY1fEcW5AFHezOtOM6UUd6+7sPF3PQ==
X-Received: by 2002:a17:906:619:: with SMTP id s25mr27646092ejb.237.1637195340751;
        Wed, 17 Nov 2021 16:29:00 -0800 (PST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id gz26sm582339ejc.100.2021.11.17.16.28.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 16:28:59 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id r8so7959997wra.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 16:28:58 -0800 (PST)
X-Received: by 2002:adf:cf05:: with SMTP id o5mr26507137wrj.325.1637195338618;
 Wed, 17 Nov 2021 16:28:58 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjF=JzLkCi2wV+G=f8OWa5rNjPsZd2RMFG5MHwKZPgYvw@mail.gmail.com>
 <20211115045616.GA1012538@roeck-us.net> <CAHk-=whca4JrEExUZCf+iGhP+mV-_D2uyqiFHnaYqnfCOKyEVg@mail.gmail.com>
 <652edea7-28a0-70d9-c63f-d910b5942454@roeck-us.net> <87a6i4miwu.fsf@mpe.ellerman.id.au>
 <CAMuHMdVrpQJKKzpxrKKCCD_2+DzAvgFW+jsjPdR9JhBYeRgvNw@mail.gmail.com> <8D79B547-D606-4975-A79A-AEA65684F3A0@tuxera.com>
In-Reply-To: <8D79B547-D606-4975-A79A-AEA65684F3A0@tuxera.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 Nov 2021 16:28:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgvzH=BaFg+kiWk1DXGLNELSmPS2VWcgSSmW5Y6vz-v_A@mail.gmail.com>
Message-ID: <CAHk-=wgvzH=BaFg+kiWk1DXGLNELSmPS2VWcgSSmW5Y6vz-v_A@mail.gmail.com>
Subject: Re: Linux 5.16-rc1
To:     Anton Altaparmakov <anton@tuxera.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 3:29 PM Anton Altaparmakov <anton@tuxera.com> wrote:
>
> What we need here is an array to store pointers to in-memory inodes that correspond to inodes in the inode table page being written out.

Do we actually need the array?

The ntfs_inode pointers in that array are always locked (using
'mrec_lock'), so ti could be just a linked list of entries.

Yeah, that would require adding a 'next' pointer to 'struct
_ntfs_inode', but maybe that would be the right thing to do?

I don't know the code, but it looks to me like it's literally just a
stack of locked ntfs_inode pointers - where the lock is taken before
adding it to the stack, and released after taking it off the stack. So
a singly-linked list would seem to be a very simple implementation.

                      Linus
