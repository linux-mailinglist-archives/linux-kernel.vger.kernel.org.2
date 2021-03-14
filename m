Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5442533A359
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 07:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbhCNGVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 01:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhCNGVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 01:21:35 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103B6C061574;
        Sat, 13 Mar 2021 22:21:35 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so12723942pjh.1;
        Sat, 13 Mar 2021 22:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rph+DllBJw5pxzAmfhUhmv7C1Vvgzgzf1YgbvK7mPSA=;
        b=UIsHzdDDF5FSXYG8V2EMtj8alAO+hy8IdATaWB69OR5lYtvjpNfeqTqB8VP1bOH52H
         1z3WFEXuD5l+OBHCtsa4aguBPGV2J5POOi+0XyfkvzffXPh9chlisvE6MRdQBGo5jO1o
         ZvbWuXiDcJz/3+2eIca2wzd79bS1LuOKMAKy25W+h1TQHbgZp71onO/lR18KLhr/Jkn2
         GvsJFmAAseWRqjZ9+5lxIuaqRNFDivrzLoYJOfETG0440qJ/Ew5Fb30m5+9hAO/4r5kC
         EWKHM06+zRSLyjn7QtVKet7qvHtiY1vy8iQGVNzRkcN66zXpZs8Jlnj9JqK78H3JbIsE
         s1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rph+DllBJw5pxzAmfhUhmv7C1Vvgzgzf1YgbvK7mPSA=;
        b=ojYxy+oI22yFiF/V7twqBqJz0LNXF6Jlnqai2QFEIWlfaBCh10OAFh+oBfnujzNAj1
         k5W5QaS9BFHwsQwCqxDTIS7odMsHcyZf+tH7vtmNkTWRzA2TTpIO5oFeJyDx9nHVHVbV
         bFUHsmBDDezLx4oJVGZHMKMpEQntZ/OV230z+X0AEbfFiVbbRhI+toXxxCUU9j6yeE9c
         WGaQ3QUiVtzpdEJRRuwfGvxGlLr5Aq3rrQyKaXRB5UwxoKqZlNrCU6nPtDeHLnDdFQw5
         sCwIAPpnEkdJiaDSiKzt23g6jJRMdaW+9/2HRi9EQZ77m6euBYpy2BdgWS3pHmVdbshZ
         ylUg==
X-Gm-Message-State: AOAM5330KKw8L1mdIVl5s8muXB9XSNDb/EQ/4dCX0kVyMvUm4N4adCHE
        gC2RlpO+xeb/V1wJqa8EZo4gkGPAVzD1irKmlZ0=
X-Google-Smtp-Source: ABdhPJzxmKJ9gj6/4m2mHd6/zI3LRbuXXa/oaGtebd9YoH3GxSS0dQ6fmaLQOM3cCdns+P/RmCnABaTj1cgNjzNbqyM=
X-Received: by 2002:a17:90a:31cf:: with SMTP id j15mr6502039pjf.41.1615702894701;
 Sat, 13 Mar 2021 22:21:34 -0800 (PST)
MIME-Version: 1.0
References: <20210313034112.eqa7zxtes2ruklqj@pallavi> <161566957437.1478170.3351022111021245800@swboyd.mtv.corp.google.com>
In-Reply-To: <161566957437.1478170.3351022111021245800@swboyd.mtv.corp.google.com>
From:   Pallavi Prabhu <rpallaviprabhu@gmail.com>
Date:   Sun, 14 Mar 2021 11:51:21 +0530
Message-ID: <CA+aYaU8XfQbnbtSa9RRW6LYwC9nE1oJ6T0tvbJJnhrWyezDrTg@mail.gmail.com>
Subject: Re: [PATCH] clk: clk.c: Fixed statics initialized to 0
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Mar 2021 at 02:36, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Pallavi Prabhu (2021-03-12 19:41:12)
> > Uninitialized static variable from 0, as statics get auto-initialized to 0 during execution.
> > Signed-off-by: Pallavi Prabhu <rpallaviprabhu@gmail.com>
>
> Need a newline between signed-off-by line and commit text. Also please
> wrap the commit text at 80 or 78 characters or so.
>
> > ---
> >  drivers/clk/clk.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index 5052541a0986..763ad2c960bd 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -2931,7 +2931,7 @@ EXPORT_SYMBOL_GPL(clk_is_match);
> >  #include <linux/debugfs.h>
> >
> >  static struct dentry *rootdir;
> > -static int inited = 0;
> > +static int inited;
>
> I think it's being explicit; although it is the same. Is this noticed by
> some static checker or something? I'd like to ignore this patch if
> possible.
The Static variable initialized to 0 was noticed by the checkpatch.
This error message was corrected.
Would you want me to send a v2 with the proper commit text?
