Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A00C31598F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 23:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbhBIWcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 17:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbhBITnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 14:43:08 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C977DC061A32
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 11:42:18 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id t23so6949048vsk.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 11:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VVkeQ98gZC/WtM29syvVdUx6myl4MG6yxXdk4w7aNRA=;
        b=OJJXtGL9c7jgVhHGqmY3y6H4AfhaGCwQWX+BR76qw1BMHgZ9fHPifCSkfH1lySA53a
         ZJFzSpG9cYf+jJgStIOVP+nM5TysSLKLadf4pJ4DBl7p4KIwd4dhhKdKpNE64KFtw8aA
         thh9mA+G74hZhJnhthV9lhzQsQ7o6IrOGab1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VVkeQ98gZC/WtM29syvVdUx6myl4MG6yxXdk4w7aNRA=;
        b=hvPLPuu7ynbvIIiaSfE8g6XtblBnrCnRiIvq43dEDvTJ0v10507/VbsYNuNi02XhmM
         0DL8bnWRa2M00RBmb9a2Qe0Nj34TAl8ETjs9OyxF33QzK+HEDd6sGjXD87RPIlXaGloO
         LqRlb8m6Qf9j3aQjaXd1zrDO8O5IhcYF5lxlwENYMOEkqP0APYdiOCy+lmMjXhY7cWee
         hwEfzzmfLUU3FUXuvIg1gjgH3BA/wAudIxYcqf1Ols0uCaHQgRMraW3JMazRLLNFArUX
         rl2x9QT9CulNhPwhdMYwgX17yVHZ+Nl1N92Geg/NQA+kT/IdNDJxId3iCaXVzPhP9OH3
         r5VA==
X-Gm-Message-State: AOAM531Wk59Y5RPgM+UrDHazPeH4Dpz+3RZyCAxV7a229fZKrIX9rHdy
        AjRoQLVhF7mIL0buCWmD/U40Q7QxRJitdDz5NJK+XQ==
X-Google-Smtp-Source: ABdhPJxGtm5AhIYFG7mwoNYSB5MZ2gRSgS3unJDW4SrX/3ZQi3am0dy2Qrn9lYwlZdhmt02q4UH085BD0g4Mf7JlBcQ=
X-Received: by 2002:a67:2283:: with SMTP id i125mr14546958vsi.21.1612899737896;
 Tue, 09 Feb 2021 11:42:17 -0800 (PST)
MIME-Version: 1.0
References: <20210124232007.21639-1-richard@nod.at> <3a9c19cf-2c25-a3bf-a200-6d223952797a@studio.unibo.it>
 <443281182.378615.1612885278254.JavaMail.zimbra@nod.at> <b2424246-d42b-d0bc-8951-8cefdf5b681d@studio.unibo.it>
 <1517729157.378701.1612886684264.JavaMail.zimbra@nod.at> <ad4fd822-016e-e11e-682c-077a1ced2a18@studio.unibo.it>
 <231074135.378774.1612888173941.JavaMail.zimbra@nod.at> <705c010b-653a-1dd0-87b9-f3cc83c21802@studio.unibo.it>
 <492787386.378826.1612889412476.JavaMail.zimbra@nod.at> <dc083537-fced-f502-f8b5-189b1827ab1b@studio.unibo.it>
In-Reply-To: <dc083537-fced-f502-f8b5-189b1827ab1b@studio.unibo.it>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 9 Feb 2021 20:42:06 +0100
Message-ID: <CAJfpeguRtL=MwaCWpRVDWhVwqyTLHgp5FJ5Hb7PFALw+devDTw@mail.gmail.com>
Subject: Re: [fuse-devel] [PATCH 0/8] MUSE: Userspace backed MTD v3
To:     Luca Risolia <luca.risolia@studio.unibo.it>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Ron Minnich <rminnich@google.com>, sven <sven@narfation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 9, 2021 at 6:46 PM Luca Risolia
<luca.risolia@studio.unibo.it> wrote:
>
> On 09/02/21 17:50, Richard Weinberger wrote:
> > Well, I think having a generic mmap() for CUSE is hard to achieve.
>
> Hard or not it did work for what I can tell you. I was not the original
> author but I certainly contributed with testing that patch. Just to be
> clear, by "not considered" I meant both the patch and the request were
> completely ignored with no answers at all, silence in other words.

I don't have any bad feelings about CUSE mmap, it was definitely not a
personal thing.   But it also wasn't something that many people were
requesting, and the silence was probably at about the time that I was
taking a leave from paid maintainership.   So a number of factors.

Patches are still welcome, if it's something that is used in practice
(e.g. by Android) that's a plus point.

Thanks,
Miklos
