Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7723198DE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 04:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhBLDkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 22:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhBLDkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 22:40:01 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A421DC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 19:39:21 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id 189so5004175pfy.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 19:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9pfqimY918txMekV6200j2kXsBs+f5cQJygUowRP0KQ=;
        b=Br7DcgxhhjHydvnpOAxSeYaNdpX8E+TNUdaxgJpW8f1JLqjn3FjsES8NPybkQiSv47
         JP1fYHObl3y/WvHVUzzr2gc/k2a4F/hNphRt+68cLzWh7wFEP6UXlfB7l1qtuKQHCKeM
         3lwMUosT426B+cJOeYVYrd5fmF5OYoNYHPV2qRNM37nPEmeY21cQLDWt61I1uiaJr2ZJ
         Mwr872PJW9XjzkGZW8PgFTv0c2XG5BoIMwvFrOd0m+HI/tPDUPjfaICk0g1CIXqKf2p/
         NOgGHRZYxIj0jhtV+Sh6qCwI1w1dsQJXt6cmSuOlITUKRls6jOxR8qEkmGDicFVAqx6n
         NeeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9pfqimY918txMekV6200j2kXsBs+f5cQJygUowRP0KQ=;
        b=E5FQ5yS9mPaClru6Eu/sgYwQdnJIqfaSs71//m06RmvOmlOXgPW/ha3lOuZlLydXjx
         VAV1MhNJkhCK2YMqvzkvV5NGGvizeS2qjESJLdpU0L1jBKISf8huX4lURwwshx94XTPv
         uXOmvD7AmH3j6E2a2ynKQpA1+j+epul9kaA5N43cQgeHRN+20/V6AdZc6t4mcAQ3Olpo
         +S0urDacVobbcPfpMbByQm06L2Gql/JoLeT25qjI1HRZsan/VxjFdx2qMSkaybl6lBHG
         AbpIuEkozQRhCoAxp4mowjgXW9hntAzeWy4teAb1ls3Lw2XHrkRxYMb734EVVaPEgeTO
         R1Fw==
X-Gm-Message-State: AOAM530uoWUtArITKH7lzBlb7woCNS9CMAqln3Oz17uui4G1xDGcKfsf
        Yksgf7CthiTkxK5RrRWPvoXWhQ==
X-Google-Smtp-Source: ABdhPJx5HI/LxBuG1ZAJ8h58O3iGwtVKU179JoespLGWeWEjcEaX5I+nD+W9hMZ0ezMdR/Sdr8fVqQ==
X-Received: by 2002:a63:c10f:: with SMTP id w15mr1252144pgf.99.1613101161204;
        Thu, 11 Feb 2021 19:39:21 -0800 (PST)
Received: from x1 ([2601:1c0:4701:ae70:3a7f:bbfb:1664:2a63])
        by smtp.gmail.com with ESMTPSA id n15sm7290212pgl.31.2021.02.11.19.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 19:39:20 -0800 (PST)
Date:   Thu, 11 Feb 2021 19:39:18 -0800
From:   Drew Fustini <drew@beagleboard.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Joe Perches <joe@perches.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v4 2/2] pinctrl: pinmux: Add pinmux-select debugfs file
Message-ID: <20210212033918.GC347396@x1>
References: <20210210222851.232374-1-drew@beagleboard.org>
 <20210210222851.232374-3-drew@beagleboard.org>
 <CAMuHMdW3dZWEbHzXZ-62S-bb3WKbrfwR_EKf7b_fQ6z913SX1A@mail.gmail.com>
 <CAHp75VeBbv8YzsnOsdXKOwPFd2WpjueCwMgm9mQPR2Xq4zW3QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeBbv8YzsnOsdXKOwPFd2WpjueCwMgm9mQPR2Xq4zW3QQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 11:53:24AM +0200, Andy Shevchenko wrote:
> On Thu, Feb 11, 2021 at 10:09 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Wed, Feb 10, 2021 at 11:33 PM Drew Fustini <drew@beagleboard.org> wrote:
> 
> 
> > > +#define PINMUX_MAX_NAME 64
> 
> > > +       if (len > (PINMUX_MAX_NAME * 2)) {
> > > +               dev_err(pctldev->dev, "write too big for buffer");
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       buf = kzalloc(PINMUX_MAX_NAME * 2, GFP_KERNEL);
> 
> > > +       ret = strncpy_from_user(buf, user_buf, PINMUX_MAX_NAME * 2);
> >
> > While this guarantees buf is not overflowed...
> >
> > > +       if (ret < 0) {
> > > +               dev_err(pctldev->dev, "failed to copy buffer from userspace");
> > > +               goto free_gname;
> > > +       }
> > > +       buf[len-1] = '\0';
> > > +
> > > +       ret = sscanf(buf, "%s %s", fname, gname);
> >
> > ... one of the two strings can still be longer than PINMUX_MAX_NAME,
> > thus overflowing fname or gname.
> >
> > As buf is already a copy, it may be easier to just find the strings in
> > buf, write the NUL terminators into buf, and set up fname and gname
> > to point to the strings inside buf.
> 
> You beat me up to it. I was about to comment the same.
> 
> So, indeed, instead of sscanf it's simply better and faster to do just
> something like
> 
> fname = strstrip(buf) ;
> if (*fname == '\0') {
>   ...
>   return -EINVAL;
> }
> 
> gname = strchr(fname, ' ');
> if (!gname) {
>  ...
>   return -EINVAL;
> }
> *gname++ = '\0';
> 
> on top of the buf pointer.
> 

Thank you for the suggestion about how to implement this.  I'll use that
in the next revision.

-Drew
