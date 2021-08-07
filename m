Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94363E3482
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 11:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbhHGJtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 05:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbhHGJt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 05:49:28 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8655EC0617A5;
        Sat,  7 Aug 2021 02:48:53 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id a20so10597705plm.0;
        Sat, 07 Aug 2021 02:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GskZaT13YlJGqejg2eU7t7TuDiL9laCdLiuZ6B45MEo=;
        b=BRgknVKbLaTZu80X5rAzn1+wbFGDw4Hwq4MDZQ7g2WXLLRokE46T5TVYJvWj64Jxqp
         ps/9sEMaCNsNPccl9jCVMI/6hTvaV3vbvOuV82ouay3mZ1js+VvEd2hC3dsYMvOhCNWU
         +wYPtf+lu+Lz56JBW60uREif0i+f4dqg31hPT1tsUFs0sE33DBk1A3arUYRUY5pFVnes
         e63J3I2vxngefGgHu4rUt/39NJmcvxSES+Xs/1icWOk7j8poJZ+F32qoLHhKJc9DpiJw
         9D8/XCRuPn4AbxspE6D5hcxuN8tudhKmddx17XEr38oA0K1rQqyo8RAjVeBprf87GFZ3
         Ox7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GskZaT13YlJGqejg2eU7t7TuDiL9laCdLiuZ6B45MEo=;
        b=CpoaMPfOK+Qnh4cdmHdmr2iJVqncl/TKD4wIx6O5jG8XKfhxUy1UfLj5N6q+n/tRJ9
         57xWVng98E1wtC8mS3Ri4I9Q+XF9OnW38sRShF4djdkHjwRfd9elLfAJi4bQY6tXzNLv
         EF8XSDuTqOOo2jz4qBchFlhGAjUTUS7bj2hD33LqK22DQQNY9YbULKpWPG3all+NdNZh
         upGjgy0Syh5tgA0LenGS3KsfjrTwD+QnftdteUVG2VsIqXDhuctf0RhOu6VDEuGafR7w
         b1mBJ/3zBKVXRtpKHO2PxFNFxM9exc1rLJ1Bh0jagdLzxy6aKUcP5OcoEPpZEHO3piv/
         Yv1g==
X-Gm-Message-State: AOAM533oH3nIDGEnipZPfgdoFzDqWdiQuF/SLRWCLISf8wGemsiM6/Hr
        plGTwEMmcno2md13dMV5ul4YCpqJVavkA75Kxv4=
X-Google-Smtp-Source: ABdhPJxNYWSO61ooNmT0K7y0xYS0BzlXcIn2/K/RTbf7QSAoQJNpvDaAf/5wrEFoK0wWGZUmhTmO19U7FCx33V1CTnM=
X-Received: by 2002:a17:902:b713:b029:12b:b249:693f with SMTP id
 d19-20020a170902b713b029012bb249693fmr2296771pls.17.1628329733511; Sat, 07
 Aug 2021 02:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210806154951.4564-1-andriy.shevchenko@linux.intel.com>
 <fdf5b050-2c8d-f3f1-f8bd-0dbc616c9bc6@gmail.com> <CAHp75VfNkinQn1SsTU24THA=0XQZUX1KeAW42TvsCYO0DfadRQ@mail.gmail.com>
In-Reply-To: <CAHp75VfNkinQn1SsTU24THA=0XQZUX1KeAW42TvsCYO0DfadRQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 7 Aug 2021 12:48:17 +0300
Message-ID: <CAHp75VchB=gfKfmg7yQW0wpJUAjVRH=8C1aY2gc=NWne5KOqpg@mail.gmail.com>
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

On Sat, Aug 7, 2021 at 12:46 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sat, Aug 7, 2021 at 3:20 AM Daniel Scally <djrscally@gmail.com> wrote:
> > On 06/08/2021 16:49, Andy Shevchenko wrote:
> > > The 'objs' is for user space tools, for the kernel modules
> > > we should use 'y'.
> >
> > Oops, now you mention it I remember you saying that for the cio2-bridge
> > code too - thanks.
>
> Just for the sake of reference (I spent some time to realize from
> where I have got this):
> https://www.kernel.org/doc/html/latest/kbuild/makefiles.html#composite-userspace-programs
> (Note, that there is the first section with the first "objs" mention)

Actually this one
https://www.kernel.org/doc/html/latest/kbuild/makefiles.html#composite-host-programs
But it doesn't change the point.

-- 
With Best Regards,
Andy Shevchenko
