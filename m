Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C88C3FE7F6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 05:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbhIBD0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 23:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbhIBD0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 23:26:40 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9CAC061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 20:25:42 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q68so475271pga.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 20:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=Hdf7I2a0TwdT9/hf+sdOXkC7oi98e/8luB2lwlTVGw8=;
        b=ao5rBVuN0+0lULIb33de3tPsOUWNRGXExvnOSbodha/awyoHM9WLwz9pXtV2x7k+w0
         WmIDdakhfW5/rw/7LzPaPCJ/7zisXfUh1dxCNGwHcvT+k1LtTth2Opu72YU/9dqibl2Q
         bwMtuf6+TItNc0RAKOCYlJqR97QsNz8OBqJsR/AJCY3emyurvyKuiZ7fB/tA3m8RBYor
         GRvG3uAFgHHo+g2VADVI8DkBO8ZRHnu4DATR6/6flAbTONUJ0xq7FqCtiOH4gcBFska3
         5MhiTL2w7rOM5J/ZvsYwS+uuBSxbp3XVlZgJg4KBlY6muZFHcN2ZD3Ec4pXRVAWeRnYf
         2tBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=Hdf7I2a0TwdT9/hf+sdOXkC7oi98e/8luB2lwlTVGw8=;
        b=jJiyRlj4TGiH8k9XIpbcpKaXc7MJHpeou5Uvh9RCfqaaVYsaIJiudx8K2sQexPCuXn
         JbAXZq+DIQbOnx342Jg1d7A6W5zEn28/GvEpVBF1Xk1u8C7DZEqmQqEUHRnyjsumifD6
         fIpGlxGqOXP8KNmryKl0Zxay+pAqhjOItSfRphUwD7U5KSl5/dNB4bc9ibdXxQfRINFY
         tyRAoS5x/R78Dalo2HTDWozJ58W7zepKUvx/ew6jmYwp6/QEXvfj2H+hkHFaOOq9sSmu
         rQJNcDDRywNHcLgW73QZp9+sKBu+gzrXl9GfROgnR5b+66R+3Z4M4KbJ1LaOc+kkyR0C
         sODQ==
X-Gm-Message-State: AOAM531pZrZb9Em9Iktk71yECIP5SLcpUFOeHUYcUflrratPF6XqUZwY
        A8MfygCW0vHNEJIBWnG4Vew=
X-Google-Smtp-Source: ABdhPJwZ4QizbvpLRKy6rIt2yM+imsF/wi8Dqc8V1XetpB+cdH1Krbou7JfpujSg4375FmbenWs+WA==
X-Received: by 2002:a05:6a00:1ac7:b0:3e2:2d05:3b31 with SMTP id f7-20020a056a001ac700b003e22d053b31mr1206537pfv.2.1630553142069;
        Wed, 01 Sep 2021 20:25:42 -0700 (PDT)
Received: from localhost (220-244-72-10.tpgi.com.au. [220.244.72.10])
        by smtp.gmail.com with ESMTPSA id l11sm359345pjg.22.2021.09.01.20.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 20:25:41 -0700 (PDT)
Date:   Thu, 02 Sep 2021 13:25:36 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: Is it possible to implement the per-node page cache for
 programs/libraries?
To:     Shijie Huang <shijie@amperemail.onmicrosoft.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, song.bao.hua@hisilicon.com,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        Frank Wang <zwang@amperecomputing.com>
References: <a2f423cf-9413-6bc8-e4d8-92374fc0449e@amperemail.onmicrosoft.com>
        <YS7yjcqA6txFHd99@casper.infradead.org>
In-Reply-To: <YS7yjcqA6txFHd99@casper.infradead.org>
MIME-Version: 1.0
Message-Id: <1630552995.2mupnzoqzs.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Matthew Wilcox's message of September 1, 2021 1:25 pm:
> On Wed, Sep 01, 2021 at 11:07:41AM +0800, Shijie Huang wrote:
>>     In the NUMA, we only have one page cache for each file. For the
>> program/shared libraries, the
>> remote-access delays longer then the  local-access.
>>=20
>> So, is it possible to implement the per-node page cache for
>> programs/libraries?
>=20
> At this point, we have no way to support text replication within a
> process.  So what you're suggesting (if implemented) would work for
> processes which limit themselves to a single node.  That is, if you
> have a system with CPUs 0-3 on node 0 and CPUs 4-7 on node 1, a process
> which only works on node 0 or only works on node 1 will get text on the
> appropriate node.
>=20
> If there's a process which runs on both nodes 0 and 1, there's no support
> for per-node PGDs.  So it will get a mix of pages from nodes 0 and 1,
> and that doesn't necessarily seem like a big win.  I haven't yet dived
> into how hard it would be to make mm->pgd a per-node allocation.
>=20
> I have been thinking about this a bit; one of our internal performance
> teams flagged the potential performance win to me a few months ago.
> I don't have a concrete design for text replication yet; there have been
> various attempts over the years, but none were particularly compelling.

What was not compelling about it?

https://lists.openwall.net/linux-kernel/2007/07/27/112

What are the other attempts?

Thanks,
Nick
