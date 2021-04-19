Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36AB23639C0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 05:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbhDSDds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 23:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbhDSDdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 23:33:47 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0565C06174A;
        Sun, 18 Apr 2021 20:33:17 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id g8so53735801lfv.12;
        Sun, 18 Apr 2021 20:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1dX/f0w7ErwIm3iFa+XWw9FPcd6+ojl8eQzmQqY6a6I=;
        b=L23LRlqMQLhF8koKtWeCEBMy7mraWRcoByTIxgmWRb58C7zFvmE6eQu3sy8YF3RmZ4
         Ux4NOvY1UD+A2VFwus6fzX8Z0M1tPGaY56p+PkXrj1/ED4AJfwxvaVGG2pnrC6x/zyUN
         Iaep4zobudRaTjBQuhvJGpkTghw0HksxHQbn7UFZ+DCSdLh9U/F+uD0ePcvNI9kKXL1P
         AL+Jtea3Ae8xHmVJR6rrnfJop+OW66sfLye/W1V6rmLT7FY/YIooVxtWnwZSSMG4kmUc
         pEh53ZxbNvMM7fecwq09qADzO3EuJfLO1YuYs6t0PGfWemcRDHY40RRhwTz/vpZTLmNA
         7lrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1dX/f0w7ErwIm3iFa+XWw9FPcd6+ojl8eQzmQqY6a6I=;
        b=rUlkbrQXXk78Hi+xpEYWoQzuZOZHXUTz4A3mITH1RfGt2vFUDjZsEKeY8iHkZ/BSu5
         7QRXnZNFajG3NZFTvJxYtLszVPGV7ESok8Ul+2IlLWz4P6yrdMgsG2vylCRO5t/IsoVu
         ZbUtiLSXli2n2FclhUZecRMg0ClqWUFpzUDxXcS54WYXAMXcNuo1w+3gKcihyNyI66gn
         hn7Nqah+Th6g0tIk/4juRxcamQ5FkEWNEWEgLDcSkdRwHX3/xB+8lIJbhVM3MNqVJzXF
         kA/ANGyS9EXPqJF84WWUcAaR66OOmhQVqqjjaYhpX7wWRAOLMg1x6md9sPaJc9h5EKD6
         zu9Q==
X-Gm-Message-State: AOAM531NybiN8/wOpHZ7V6IEey3LYP6COqkUOfIs2zxj0+oo/Yoz+umg
        +l66xNGoDzlU/LNMmSoxNSMF6FaDcLzC6S5INbk=
X-Google-Smtp-Source: ABdhPJxLn7+iMMxaWsHuQQby20p5nAw1LS+/u4iYHNbY2EdBph7L02KVFkY7dbiD/HCvPikPYP7B0k6X7zjErQXqj+E=
X-Received: by 2002:a05:6512:2256:: with SMTP id i22mr3489061lfu.651.1618803196384;
 Sun, 18 Apr 2021 20:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210316054727.25655-1-foxhlchen@gmail.com> <20210316054727.25655-2-foxhlchen@gmail.com>
 <20210419021730.GV2531743@casper.infradead.org> <CAC2o3D+kq+U9vSp_9DNM3UGA=UGhS84Y+mwm=9S6eMPpf2-ogQ@mail.gmail.com>
 <20210419032513.GW2531743@casper.infradead.org>
In-Reply-To: <20210419032513.GW2531743@casper.infradead.org>
From:   Fox Chen <foxhlchen@gmail.com>
Date:   Mon, 19 Apr 2021 11:33:05 +0800
Message-ID: <CAC2o3DLJpMJDzQByJixPyLe47ajXXVFPRQBh3MaYPargrqS4tg@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] docs: path-lookup: update follow_managed() part
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Neil Brown <neilb@suse.de>, Jonathan Corbet <corbet@lwn.net>,
        vegard.nossum@oracle.com, Al Viro <viro@zeniv.linux.org.uk>,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 11:25 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Apr 19, 2021 at 10:33:00AM +0800, Fox Chen wrote:
> > On Mon, Apr 19, 2021 at 10:17 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Tue, Mar 16, 2021 at 01:47:16PM +0800, Fox Chen wrote:
> > > > -In the absence of symbolic links, ``walk_component()`` creates a new
> > > > +As the last step of ``walk_component()``, ``step_into()`` will be called either
> > >
> > > You can drop ``..`` from around function named which are followed with
> > > ().  d74b0d31ddde ("Docs: An initial automarkup extension for sphinx")
> > > marks them up automatically.
> > >
> >
> > Got it, thanks for letting me know. But I will still use them in this
> > patch series to keep consistency with the remaining parts of the
> > document.
>
> Well, you weren't.  For example:
>
> +As the last step of ``walk_component()``, ``step_into()`` will be called either
> +directly from walk_component() or from handle_dots().  It calls
> +``handle_mount()``, to check and handle mount points, in which a new
>
> Neither of the functions on the second line were using ``.

Oh, That was a mistake,  They should've been wrapped with ``.
Thanks for pointing it out. I will go through the whole patch set and
fix this type of inconsistency in V3.


thanks,
fox
