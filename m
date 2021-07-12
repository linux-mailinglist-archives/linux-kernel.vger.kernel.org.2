Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54453C631D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 21:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbhGLTGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 15:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbhGLTGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:06:45 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC526C0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 12:03:55 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id r16so25937548ljk.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 12:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7WiNJIiaIhP0ITIaCFoHZ/apyeJkl80WSQwZO5ZgRFI=;
        b=Df+dHdh0txM8jFXaJ3OUwuRpwFnXk6bWsLK40PwdC0t/njPC0VJa/NcvhLtwME5er3
         H2Yg9FS8TaOk1V4vx9g2AOZPbk2/dhVKjv2TtRkKYhVNl4dG2Q3m63Unv4tqpC+xmZID
         tT8+o73FihiECV0Epb6V25HCt4gTN197YsOJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7WiNJIiaIhP0ITIaCFoHZ/apyeJkl80WSQwZO5ZgRFI=;
        b=lCtFeL0IgIzbXudSjMUBtqDiZMcSV0HJEDGjhOAHLBFajjk16CIy662yfotGYlBWzJ
         eH0aAKq+q28kix4MNTljgFBc/WJbutkgCMeK64jjI9cOyVXDXissJS5bYQvx9LfF6YVC
         3Wpr0YmG7zg/RiNDNJBAuHHcKkthd1H3hasrjHj0C2LdmbdHYJccf2dN9TPGsoa9/ZMU
         eI0Q8Su1oIup2ExwKAAiLC2AmdzhwCPNu8Qu5j7A4wYKrhK7N5DvuzP7Cwvp1d7QMb9I
         bH7xp0MP2TCyylMTnpfZJk5pVfx23mJ2PGFLBjyVjFLzfwX0Qg5ZYNHoVp5FfNgV6BrQ
         mHBg==
X-Gm-Message-State: AOAM531t2rqrhEMQ67kgR0yhgiWjnKlMnDCN1ieVHMNQ9bNEi+0uBO8x
        fQ3jPRf3OlSG0QKX8E11+77aRBUbvD72yRaP
X-Google-Smtp-Source: ABdhPJytLjAVOu+w2purS7Yo3eEqbfHHPgFA7LKwywQRy4FldNYNKtmwgWxFfaKLgxhBtvIwmalFdA==
X-Received: by 2002:a2e:9ecd:: with SMTP id h13mr600689ljk.162.1626116633849;
        Mon, 12 Jul 2021 12:03:53 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id w17sm1271808lfd.126.2021.07.12.12.03.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 12:03:53 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id r16so25937469ljk.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 12:03:53 -0700 (PDT)
X-Received: by 2002:a2e:9241:: with SMTP id v1mr569825ljg.48.1626116632804;
 Mon, 12 Jul 2021 12:03:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjB5XBk4obhMPfrU3mnOakV9VgHAYOo-ZGJnB2X0DnBWA@mail.gmail.com>
 <20210712015619.GA3547193@roeck-us.net> <20210712041423.GA97217@roeck-us.net>
 <20210712052046.GB8042@lst.de> <0cf6d000-f886-4e99-2e80-78da4ae9367d@roeck-us.net>
In-Reply-To: <0cf6d000-f886-4e99-2e80-78da4ae9367d@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Jul 2021 12:03:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjkQb8DzNg-qAWKWFAS-3Uy-4BUYR0ympb_W-Om=TabNg@mail.gmail.com>
Message-ID: <CAHk-=wjkQb8DzNg-qAWKWFAS-3Uy-4BUYR0ympb_W-Om=TabNg@mail.gmail.com>
Subject: Re: Linux 5.14-rc1
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 6:53 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 7/11/21 10:20 PM, Christoph Hellwig wrote:
> >
> > This should f=D1=96x it:
> >
> > -#if !defined(CONFIG_DEBUG_BLOCK_EXT_DEVT)
> >   #define SD_MINORS   16
> > -#else
> > -#define SD_MINORS    0
> > -#endif
> >
> >   static void sd_config_discard(struct scsi_disk *, unsigned int);
> >   static void sd_config_write_same(struct scsi_disk *);
> >
>
> Yes, that fixes the problem for me.
>
> Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks for reporting and testing.

Christoph, can I get that as a proper patch with a commit message?

                 Linus
