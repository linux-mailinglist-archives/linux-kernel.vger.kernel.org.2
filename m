Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80D244E024
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 03:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbhKLCLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 21:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234499AbhKLCLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 21:11:42 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA4CC061766;
        Thu, 11 Nov 2021 18:08:52 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id x64so7196274pfd.6;
        Thu, 11 Nov 2021 18:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=wkuX/LcrDqABQYU3AYpmtEhQWgL1vKbTP2XzXPyAEUA=;
        b=UMdazhu47yDbUtH0kifh//b8S6Slp+PQFegech9sifujMXX8fxJLZMuyjDmebU/YhR
         k+KHoiBr5TQTekbGXwdpuz8z3l2NQAdxiNkABVqZpLu6V1m3c1WzTxKYR4Ea7WE9xHe7
         JPBbcbGm+g7sZlBG7cERJNsISvjjzgCkgqURzenXBAVybqGr39qPNEmKwf7FV800H2pi
         9xOIG1qpYrPIhXYz1Jxvu5+dM+lYL+zy/j7VPQbRY+ssfYJXMvz3gC/JaUX1fYJSqKJS
         siB3zTLoAE5Z4mDfgN6CceN4LBC41KI/9S0vnaMragQuo24K9Z8TTNq/mGqsasnowC2z
         f09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=wkuX/LcrDqABQYU3AYpmtEhQWgL1vKbTP2XzXPyAEUA=;
        b=FrvId0UbE5gIFiiL9If+jRsgsMmq00aW21H8iOfDH2vscvDTX8oRcdLTCdxfNSBhSw
         pwTWsbK7ZgdDDNx2ek1hAfrTi7+Vhivo1pKEggy9FdJl7Vjkb818jtM046w04d0DgEcC
         MFyg+VnNdzKou4Z8jWHTsJ1M5ruR6YDqy8vcJa7OfJTGlfFpTGZTQfUaAOYPoUWf/DtX
         sFeEwVT20E8nbYOZoZOHRqAXPX8/I7AvJX7Yo5jEtMScW3uxyhDQUe6lfIbGlTqZ8wCn
         VgA89/XNEyz94mjMbjnK48LkmRuIrUGI2xc02ywcVH0qw18v+9rE0Wdts86RtjTeTRJ+
         vlFQ==
X-Gm-Message-State: AOAM533edmkH4DURrcgW9W4NpCp2vS5s0y7DQMB8QZprwE4GEKEfFojE
        mHZk7ZJIdrnEK5WXTj7C4HhEnSMuSK4=
X-Google-Smtp-Source: ABdhPJzyCsVTgp/sRurnFp+A83InKoAX/9h5CUqsy3oj3H8w3HtGQKQDuR2EOFOa3RM2GVgtwU1LSA==
X-Received: by 2002:a05:6a00:1996:b0:49f:d1b0:5d1f with SMTP id d22-20020a056a00199600b0049fd1b05d1fmr10840686pfl.36.1636682931733;
        Thu, 11 Nov 2021 18:08:51 -0800 (PST)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id q89sm3556300pjk.50.2021.11.11.18.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 18:08:51 -0800 (PST)
Message-ID: <618dccb3.1c69fb81.44daa.b8f0@mx.google.com>
X-Google-Original-Message-ID: <20211112020850.GA4733@cgel.zte@gmail.com>
Date:   Fri, 12 Nov 2021 02:08:50 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     corbet@lwn.net
Cc:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>, yang.yang29@zte.com.cn,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] docs/zh_CN: Add zh_CN/accounting/delay-accounting.rst
References: <20210923081951.261281-1-yang.yang29@zte.com.cn>
 <CAJy-AmnDr-i6E7JPAGpt6EgVDTSxgFtygzriKJeOmuLd061P+Q@mail.gmail.com>
 <618bc88b.1c69fb81.9fc2c.1d65@mx.google.com>
 <CAJy-Am=mHUhU9XNyiaTkmLJo27qTkLrgAm7PzX6LeU=BBgrQ+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJy-Am=mHUhU9XNyiaTkmLJo27qTkLrgAm7PzX6LeU=BBgrQ+Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 09:48:06PM +0800, Alex Shi wrote:
> On Wed, Nov 10, 2021 at 9:26 PM CGEL <cgel.zte@gmail.com> wrote:
> >
> > On Fri, Sep 24, 2021 at 11:41:52AM +0800, Alex Shi wrote:
> > > On Thu, Sep 23, 2021 at 4:23 PM <cgel.zte@gmail.com> wrote:
> > > >
> > > > From: Yang Yang <yang.yang29@zte.com.cn>
> > > >
> > > > Add translation zh_CN/accounting/delay-accounting.rst and links it
> > > > to zh_CN/accounting/index.rst while clean its todo entry.
> > > >
> > > > Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> > >
> > > Hi Yangyang,
> > > You  could pick up the 'reviewed-by' conveniently when you update to
> > > new version.
> > >
> > > Thanks
> > Hi Alex,
> > I had sent patch v4, see:
> > https://lore.kernel.org/all/20210924055135.262327-1-yang.yang29@zte.com.cn/
> > Is there any other problem of this patch?
> 
> Uh, it looks fine to me.  may it don't need my ack again, since it's
> with my reviewed-by. :)
> 
> Just ping Jonathan is fine. guss the patch just covered in his emails flood. :)
> 
> Thanks
> Alex

Hi Jonathan,
Is this patch OK?
I had sent patch v4, see:
https://lore.kernel.org/all/20210924055135.262327-1-yang.yang29@zte.com.cn/
