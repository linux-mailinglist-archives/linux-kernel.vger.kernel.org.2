Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76DF3991D0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 19:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbhFBRiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 13:38:18 -0400
Received: from mail-oo1-f41.google.com ([209.85.161.41]:45599 "EHLO
        mail-oo1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhFBRiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 13:38:13 -0400
Received: by mail-oo1-f41.google.com with SMTP id h15-20020a4ad00f0000b0290245a068aae6so731412oor.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 10:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vo0Dg4bNuKJwo4nsGc+3dTQHi6trR9CwbCHIFpRvYTs=;
        b=XCl55SvXTjI217am7uNX6tchL7K2HRkFscrE7e3kl8Kk7gmi8wta4Fg9Jol1NlDUXG
         GNbi2hVwjOs9U3+JSozSr34bx4MsjKDnnI3/71Zeq9YRRKSoaZf7UZavx12Iuzi5ELQE
         26iamZgpcfIx7j0jFDFIiZjZ7zOX9l/2m6bztPRRSqoep3bBmrdDo2zGgQ6GJ49opBjI
         z21UtkGQbttC15w8VypNrqWZmIN3GbQrz49FpNFXqvf2vi2TLUCCAR23LHHE+Q0+YGXf
         VuzCLgylYtcyAVWL/iSOTQk+fowwP3PNE7sPfhq/S3leskKxaIl58P3ojqplrWBOOW5P
         ubdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vo0Dg4bNuKJwo4nsGc+3dTQHi6trR9CwbCHIFpRvYTs=;
        b=dpmMdQzu4/pqiI626UKxWgKXzYwLlXMC7+CJvpx7PFPOyUEtRJppfju5p9EpxiIUMY
         LLfP5a0UnSs3L/uRrkyn2Vy3B8bhn7a9EH13XxEfwEJLApKyaCe+nPADrJxS3eggBlWb
         Cqq8TZB8clrKBYsoEUPWDga1IN5+aCcnhaPth1w8vE6xdoLwd0zdeS/lg7KWONqOBDQd
         wJ0QuKRSmOcUGHwaX8r3hEntowQkATm/WfmQJKtIAgdgWM90cep4egAsSnnbvHHmbEp4
         xDHZDMhXx/935nIk6rk9ZCc2/9M/T6ZgO5HPlbNr5kxAaSSIY0OGpfo7daDbgt3f194M
         PJBA==
X-Gm-Message-State: AOAM531hL1E0PlqQ2Hbg6GJISZT/L9A4UViz0HGJpuzq9HKP5Ph1AYkU
        KX9EZ63aZFBoNV8IauDHf4lTbaBIk3E7Drj+Z94NOGFRW0uYjVA7
X-Google-Smtp-Source: ABdhPJzXtY55/blnpzkUvI/XEwAGea+QX3r6Avjyclj4Oel9wdgN+ymS83scKqqL/CgSzGs9cN8PHNaU+KGXWGebcbI=
X-Received: by 2002:a4a:e084:: with SMTP id w4mr25103329oos.59.1622655330563;
 Wed, 02 Jun 2021 10:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210602160333.62163-1-manikishanghantasala@gmail.com> <YLe8psfQLCb5bn2W@kroah.com>
In-Reply-To: <YLe8psfQLCb5bn2W@kroah.com>
From:   Manikishan Ghantasala <manikishanghantasala@gmail.com>
Date:   Wed, 2 Jun 2021 23:04:53 +0530
Message-ID: <CAKzJ-FNm-uYoSFvMmNjAtsXmOQ-_P=o3JhpZhzk0tuuNRDTB9Q@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8192u: fix coding-style issues in r8192U_hw.h
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2021 at 22:45, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jun 02, 2021 at 09:33:31PM +0530, Manikishan Ghantasala wrote:
> > staging: rtl8192u: r8192U_hw.h: Clear the coding-style issue
>
> Why is this line here?
>
Added it as description and I put a break due to char limit.
> >
> > "Macros with complex values should be enclosed in parentheses"
> > by enclosing values in parantheses.
>
> I can not understand this sentence, can you please reword it?
>
I meant, I cleared(fixed) the error in quotes by enclosing them in parentheses.

> > Modified spacing around "|" and removed a space before tab.
>
> This is not related to the first thing, please break this up into
> multiple patches like the bot asked...
>
Okay, will do. Do I have to make one for the 'space before tab' too?
or can I ignore it?
> thanks,
>
> greg k-h


Thanks,
Manikishan Ghantasala
