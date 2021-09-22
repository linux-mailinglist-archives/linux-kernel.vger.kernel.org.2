Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB22A414D56
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 17:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbhIVPtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 11:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhIVPtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 11:49:51 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E84C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 08:48:21 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id e15so13405837lfr.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 08:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0H3WnzLNl9XVNcbQNQJGtiq6AbRFnhMOnYeTPU48Lvg=;
        b=E0hhli6FQnH2K1o7onz6hfgzh/90j1O7mvySwCF4Awrfm4Aap5h+DKLp61yUFZJFFt
         OBKpB/sRASOmyILOilFb/A9q3zxOnsBHfRT/FapLV0Yjn2NJKtO0oa2BKP3IZuo+BuNX
         YR6TBdh1uYKJnYNl3YjlZfdSXXzy0uybfFazI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0H3WnzLNl9XVNcbQNQJGtiq6AbRFnhMOnYeTPU48Lvg=;
        b=eWY26GjWNeTR247nSoWXpSmQLMawmUcltDb4dQSFdoXJwSgH32Cnu8EZpTzmv46esG
         IwTT3Sdpo9sxL6UPSs1KxBEBNz8mqdUcmtgYVOiI3ecn5Ah3KaBLgX60fXaVcFH5PECn
         RII2mp5tvjtooU1rnjS0ymqSoAt+4KW891XXb1z2s1AJg0i4RoQcetmwVdj1HiFubMTx
         897pE+jNnkbJR+QSorzKoTILPrvZyhoXI5tTLv7RNbwh3i+Z4cbAk8ij9E3Y1NimcY4E
         AaALiW5Rqf3CUWctfy8agMJSm6a3UqPS6F0R0JU58BhH4qo95yrceZ0z5B7OLkg6imgn
         Gh4g==
X-Gm-Message-State: AOAM532L+StB3f95rrCAfCKwHbzclQn/gFbGKEiTdJxPld8WJ/gBz1yt
        nElLz9Bw+ik7a5rVrUAHloy9w7P/WVIV/3JjMV8=
X-Google-Smtp-Source: ABdhPJxSOq+Zsgypf3uSTlnM47+BMTRjkLkLnyjxA6al51xzyDA+Nl/+eEqyck0hS3ikRZttkHjiXQ==
X-Received: by 2002:a2e:9ed3:: with SMTP id h19mr285444ljk.354.1632325624010;
        Wed, 22 Sep 2021 08:47:04 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id y13sm207062lfs.17.2021.09.22.08.47.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 08:47:03 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id i25so13723724lfg.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 08:47:03 -0700 (PDT)
X-Received: by 2002:a2e:4e01:: with SMTP id c1mr239859ljb.31.1632325533336;
 Wed, 22 Sep 2021 08:45:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210922063558.26417-1-jslaby@suse.cz>
In-Reply-To: <20210922063558.26417-1-jslaby@suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Sep 2021 08:45:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wha23+dMWi=D6NENtTJw20rQEpuXBx2sV2EV2j=08o1SQ@mail.gmail.com>
Message-ID: <CAHk-=wha23+dMWi=D6NENtTJw20rQEpuXBx2sV2EV2j=08o1SQ@mail.gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: ARM/VT8500, remove defunct e-mail
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 11:36 PM Jiri Slaby <jslaby@suse.cz> wrote:
>
> Remove it from MAINTAINERS and make thus the ARM/VT8500 entry an orphan.

Looks fine. Some git history checking shows that while Tony has been
cc'd since, the last actual activity seems to have been in 2014.

Russell, I'll just take this directly and you can ignore it.

            Linus
