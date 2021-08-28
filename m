Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBE73FA55C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 13:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbhH1LOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 07:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbhH1LOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 07:14:42 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655D0C061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 04:13:52 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id lc21so19693049ejc.7
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 04:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X9J7QVqkb+h1L05qRuxksgd8BRKIzsS4rtSxbcYkOD4=;
        b=OxQ992I2XLDfyUuoDMcDx0GG7HoIKgDw6t34rTb8L/oK5Fn+A+l/69XFjPCtS/rny4
         nT1AB0DSPZld7ajPDHhM/ChEDGIK6BzfctFyV9iZyiI5GZpPeMjd6P7O3Zmfl6DM+XkG
         +KQLnMfYU27JKHmJP2VcpS4XGNZUplHluwUh32kR28rNg5cigfSNmzlcHhxuzR3YkEga
         XUf+S6U2CKJdZzZvo3uXj7Y4dBrq7hfDzcMIiXv41NkMtQ0MUm6VHJxjyRnBy1yFBxEE
         HSTghpynyiyTEC9qmwSFHiXQPKCrPYxDR6opN6wZjLlafubWOBuANewP8XRo4/+IjAN4
         CtiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X9J7QVqkb+h1L05qRuxksgd8BRKIzsS4rtSxbcYkOD4=;
        b=BEHyQ7LdjHHf6+d8kCr6cmm+7QZTzfL0rTwXLSwHNnKMO1ZqYS4moy56FyJj7Iw25p
         FpgbdbRhJKQ2o7FFbsVcKi45stlHNB9FgwUjJriuVUOAwveW9/xv0P9PqOuVUxiFvM0o
         utUeS2Ki1QtLvKb3ZDX1zY8FVwJR7cFIh9HxAvmxiKEhV1tl29ikaL1txl3vl3Kj1Slp
         kLujrxk67Ay4c3VQuaDD4+ahddnGjy6SXNo1vnDp6W1/ieb+6e1TU3BS4DhS+/b1hIv0
         j0gk/OCBb1Mi0q00hmw7U7cvDlENWFynHBLaPtWsccAoXhaRNjN14ioB3m12D8vnAeuI
         mwXA==
X-Gm-Message-State: AOAM530uidRqLZNki4BEpQ6UTfgCTFaT86lDrgqLBt0vgGkAi8CsB9Ph
        9lQV9HF5OT2q08pvZXyKgID8JGX97wM=
X-Google-Smtp-Source: ABdhPJx9jsrDt8mfFxjJLaxsSOvVtrqWSB4mp6B9fllLK/dRpf+L558OCs0oAjPp6GVN4BoleYXfvg==
X-Received: by 2002:a17:906:93e8:: with SMTP id yl8mr15215967ejb.524.1630149230999;
        Sat, 28 Aug 2021 04:13:50 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id y10sm4642649eda.47.2021.08.28.04.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 04:13:50 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Krish Jain <krishjain02939@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Declare the file_operations struct as const
Date:   Sat, 28 Aug 2021 13:13:48 +0200
Message-ID: <1720585.ZkIvycaLSE@localhost.localdomain>
In-Reply-To: <CAPGkw+wcZRcr0W2ay6ZJY5yW7-EEMpK-yH-3j=UkDpj3kA-ySg@mail.gmail.com>
References: <CAPGkw+x+B1731SL=afoSKiWwH-n-FA5YJ+WOwYdv8iyFhWk1zA@mail.gmail.com> <YSoF+VcDuW/2ojjF@kroah.com> <CAPGkw+wcZRcr0W2ay6ZJY5yW7-EEMpK-yH-3j=UkDpj3kA-ySg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, August 28, 2021 11:52:39 AM CEST Krish Jain wrote:
> On Sat, Aug 28, 2021 at 11:46 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > A: http://en.wikipedia.org/wiki/Top_post
> > Q: Were do I find info about this thing called top-posting?
> > A: Because it messes up the order in which people normally read text.
> > Q: Why is top-posting such a bad thing?
> > A: Top-posting.
> > Q: What is the most annoying thing in e-mail?
> >
> > A: No.
> > Q: Should I include quotations after my reply?
> >
> > http://daringfireball.net/2007/07/on_top
> 
> 
> Now I get it. I've never used this style of email ever before so am a
> novice. Forgive me. Also I didn't get what you mean should I include
> quotations after my reply?

No, Krish. Greg placed the lines you read above only to let you understand
how much confusion we get with top-posting :)

> > On Sat, Aug 28, 2021 at 11:37:50AM +0200, Krish Jain wrote:
> > > Hi. Thanks for your response. Changing to  "const static" would fix
> > > the first error but looking at the second error indicates that it
> > > can't be a const, right? So checkpatch.pl was wrong?

You misunderstood my first message in reply to your patch:

(1) that structure shouldn't be "const". You broke the build with that so I
guessed that you didn't build the driver;

(2) You should place "static" as the first keyword of a declaration. It doesn't
change the semantics, but it is better style and so it is used in the kernel.

> > checkpatch.pl is a perl script that does its best here.  You always have
> > to then look at the code itself to see if what it is asking you to do is
> > correct.
> >
> > And you always have to at the very least, test build your changes to
> > verify that they do not break anything.
> >
> > thanks,
> >
> > greg k-h
> 
> Thank you so much. I didn't realize that I could have tested it by
> just building the driver and not the entire kernel. Anyway, I'd still
> love to learn more and contribute to the kernel. Where can I find
> "small fixes" I can make?

Don't expect that someone here says to you which "fixes" you should
address. Read the code and find them on your own. Get hints from 
checkpatch.pl and the other static analyzers too (Sparse, Coccinelle,
make that-driver-you-chose W=1, etc..).

Thanks,

Fabio
> Warm Regards,
> 
> Krish
> 
> 




