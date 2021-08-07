Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011053E346A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 11:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbhHGJrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 05:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbhHGJrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 05:47:12 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9303FC0613CF;
        Sat,  7 Aug 2021 02:46:54 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id e5so10535927pld.6;
        Sat, 07 Aug 2021 02:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8koQuKZyEuJuuWYSxYvN0Gjl34pe9vlL2qfZoDPh0Ns=;
        b=Dios3hd8a12b1cXhtDjftT88MfewDJh5k/izGvn9T5CqyAgH0R6+sZdKjFyyXFhD8d
         7SAsh711ApmdnQ6Dhpe5v+XSFTfnK4WTlaqHVyxfLMPaLYVTUN0mQvdk88EwFSUjB7lm
         DI15XVEal3F2rObq2DvH842wBv0FD6xAIrWZVy8gYWbrBy4kBDE/ZVdw6T/JUtqABXJL
         4FIP52NGlXnNIo1CaQNTF/3TypPi/w9ikUGUYJebDKdyC5r5JyTwYM9p71UX1xa6/Xg1
         sMFIOPp6gFfytS1nlBW9vXC6IMIU5wXIutK2yUzJUsTxQzoo/UAc1TjK9UjMManEJ3h8
         p0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8koQuKZyEuJuuWYSxYvN0Gjl34pe9vlL2qfZoDPh0Ns=;
        b=iA6Diaq+KOf9qphYzrAM6fXZNOdoY9GHE4zwB5qql4dZVu1V/Wc+7hO2KuNRK2orwq
         Sb2qemm+5O/KNIORhLBv7NWskhFclUIqBxmr/iFm553Tgv7zH0biclynlrBUZ9REnQ/3
         CU3E5h9L7mkq8W/4WNB/ZWaoayAb6Tvvaqm9RbU1aSnOr7lNlewm6GIlh/pR5nCipgYA
         CiCFEYYEmkl98Tmi+4Y/96u/3ppA126MWywtnGnDGMbjejSn5qqd8HZhR3I9mi1fkpx7
         GtMHqNWYozqEC1iJTn847Lse+YUy3wnapef46XYurfyZFDVyfzEHAFLbzApvhtBh2B2t
         alug==
X-Gm-Message-State: AOAM533JRGVynshLH38XfdWKC+Ivg90rMt0xF8Ak2LUeYQkACwJ7DyH/
        /A/XbX+G1Lxo9FEL7nYzCdNvLDImZWXgIu4qHrA=
X-Google-Smtp-Source: ABdhPJwTt6zim+bQC84iWCETJCA1dqlH1S6Gg1WguqiXW0lAEH+AUw44b5A4uoAscePs6cVO0JutXOMjiWerr/lw40U=
X-Received: by 2002:a65:5ccd:: with SMTP id b13mr165535pgt.203.1628329614039;
 Sat, 07 Aug 2021 02:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210806154951.4564-1-andriy.shevchenko@linux.intel.com> <fdf5b050-2c8d-f3f1-f8bd-0dbc616c9bc6@gmail.com>
In-Reply-To: <fdf5b050-2c8d-f3f1-f8bd-0dbc616c9bc6@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 7 Aug 2021 12:46:17 +0300
Message-ID: <CAHp75VfNkinQn1SsTU24THA=0XQZUX1KeAW42TvsCYO0DfadRQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] platform/x86/intel: int3472: Use y instead of objs
 in Makefile
To:     Daniel Scally <djrscally@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 7, 2021 at 3:20 AM Daniel Scally <djrscally@gmail.com> wrote:
> On 06/08/2021 16:49, Andy Shevchenko wrote:
> > The 'objs' is for user space tools, for the kernel modules
> > we should use 'y'.
>
> Oops, now you mention it I remember you saying that for the cio2-bridge
> code too - thanks.

Just for the sake of reference (I spent some time to realize from
where I have got this):
https://www.kernel.org/doc/html/latest/kbuild/makefiles.html#composite-userspace-programs
(Note, that there is the first section with the first "objs" mention)

...

> Reviewed-by: Daniel Scally <djrscally@gmail.com>

Thanks!

-- 
With Best Regards,
Andy Shevchenko
