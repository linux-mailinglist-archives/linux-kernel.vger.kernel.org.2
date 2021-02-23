Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1D83231AD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 20:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbhBWT4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 14:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhBWT4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 14:56:49 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281F9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 11:56:09 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id u4so13212317lfs.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 11:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L4mlDtwcYBizMphLl0+q8ed7I9ZQvyrwpoUQhcn8W84=;
        b=aY0gUZnlQaZupCrgaznZC5ecubAzHDCJsqTyJ1WOU692qJNjqyA/ud/NHzOyY/lwxs
         xExEq5sODTYLLkEESdVIahsKXb7OUwiNi4J5uBr1KUUqgVP97Xvs1apRZLRh0TrZ2YKC
         kcq1qGwk/GY9lxGRvYtyUSJOnxJge3yFV/f+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L4mlDtwcYBizMphLl0+q8ed7I9ZQvyrwpoUQhcn8W84=;
        b=cwHI/8ek1MQHqQrSiojHu/ZIIeR371WcQqYvIYBrGkSn2t+5QGzMh54eWKr6ejg/K+
         jhv98OvSQ3z75B1RPhzGSBMnF19uu354/C3nZmfl+BbIvyFK+zZDtl+QvpqfT38iDfvB
         yh7DzdsYRLShZKtRBQfJjQ/1CNlQcDKXZAg3YCDUTrYuRI6G/li9xzKx7Eo6dk5iBzSH
         pAdD5DkpzWbCwtuii4G6qo63YTVSACndlaipKSjay2oud+AKbFbgRNdLFhEKyDYvFGSJ
         vCIkfwnjj3ojnURqKVrUuPz+xTt0ghYT4CZ6DuXsEmsNZqZrbUkGOu+2Nis64AwLtQtM
         ZDRw==
X-Gm-Message-State: AOAM532XuIp5Pu1fK+nti00sgDQuJvvQBd+IW2jWwqjhgMElPxq2GCVq
        NT1SFT8iklrQ9lrPLFXYjydDXK3D3d9jMg==
X-Google-Smtp-Source: ABdhPJzZLljOaW/lPM3wtlszG27dexlhYs3zE6ZEJgXD+d+UbE2b2STsf9Mmqz8nwEt0rlQy9eHNUA==
X-Received: by 2002:ac2:4d95:: with SMTP id g21mr2068542lfe.29.1614110167392;
        Tue, 23 Feb 2021 11:56:07 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id l18sm2817193lfg.294.2021.02.23.11.56.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Feb 2021 11:56:06 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id o16so59918180ljj.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 11:56:06 -0800 (PST)
X-Received: by 2002:a2e:b525:: with SMTP id z5mr9452355ljm.251.1614110166022;
 Tue, 23 Feb 2021 11:56:06 -0800 (PST)
MIME-Version: 1.0
References: <YDUibKAt5tpA1Hxs@gunter> <CAHk-=wipCbbXswcFvnrGae01H54dY1+XoaL+9YaiU71zGzko3Q@mail.gmail.com>
 <CAHk-=wh8vHL43v7GWK9MWrWitSmOmrEw1B0AJD9CrhBc4FvpxA@mail.gmail.com>
In-Reply-To: <CAHk-=wh8vHL43v7GWK9MWrWitSmOmrEw1B0AJD9CrhBc4FvpxA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 Feb 2021 11:55:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiuoRKa=F3txoVHvnca+H=7gJyL3SFYwd3549v-sa0+QQ@mail.gmail.com>
Message-ID: <CAHk-=wiuoRKa=F3txoVHvnca+H=7gJyL3SFYwd3549v-sa0+QQ@mail.gmail.com>
Subject: Re: [GIT PULL] Modules updates for v5.12
To:     Jessica Yu <jeyu@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?=EF=BF=BCMiroslav_Benes?= <mbenes@suse.cz>,
        Emil Velikov <emil.l.velikov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 10:42 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I think there is something horribly wrong in my tree, and my build
> process is now about 30% slower. It went from 5+ minutes to 8+
> minutes. The main suspect would be some lack of parallelism.

I don't see quite what is wrong, but bisection is clear, and points
the finger at

    367948220fce "module: remove EXPORT_UNUSED_SYMBOL*"

which looks entirely trivial, but clearly isn't.

It's repeatable. That commit slows down my build hugely.

              Linus
