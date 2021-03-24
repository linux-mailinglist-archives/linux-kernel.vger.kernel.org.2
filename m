Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C21348518
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 00:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238981AbhCXXL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 19:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238939AbhCXXL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 19:11:57 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAEFC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 16:11:56 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id c16so223184oib.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 16:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xibY7VsM3uen8eBjYDMbBuXb62rn6BpP560y1L0HSGQ=;
        b=XnMWHCrr/H5Cm9K9HevZjnxOKrtkZdNrhBPmuncqm4xWB51/m5pBzeM0E654YnlUbK
         vWlBCnk78fQkejupUbZm+8QUcPU568gPos+gZc/+uXKY/Hp75FhDMq7vYDdaXPrnQm7e
         DbTlqhUBX3cgQBf/KT4Y8cxLaF3pZbMEH9PGwFT+O4ffRZVw7sVXyu54rgG+8vx3w/F+
         JxFUi0RctDWAkWSk2Cd6DYshdlEU/AIsr+vRsJwI8xJpL+9yo1Co8nmvyN5CsQZM/p80
         WghxVHXqG0Ih0GVg0DRf5ofgiRmzQThu/9FHTvGnhp2R1EzFoOOIc9PW+oZml+lW2mSd
         2lvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xibY7VsM3uen8eBjYDMbBuXb62rn6BpP560y1L0HSGQ=;
        b=XPeM73dk0mEGVReq4GRikLmmMVtFQXlqpCbhGAR8q4eQIH+TspQ8ogWeBXafRWoFl9
         yXBCV3CcOQ3AnCp62jUpOoOC/GzHDxGLkcDSTABPsE/2A6EvPLJBS2D8TsSL/nC9GEgt
         QvPk55UnJtzyuswiUoq3m6stzrmQtsrBKZwLIpet6/tLqj5jgH1/hcTFedry5zWAuUVw
         VHi889pHDR7b60HGq+sO8p2g23KWoszQ3438pBbjfqfLiFqtKfEW/UgCjQqvAnk/23Pv
         R0l58XG6xHdw6ZpJfNPoIHrnwjKU160DM9Rh0hFYK7fRXGMio6t/0AedNFcMIRxvSS2i
         2JZw==
X-Gm-Message-State: AOAM530uYGG/ZHKrdvkpBE22vEH01KJNJFjfmpIydqLAUGo37P5un5gI
        vBtxvDUwYn19KHim3ne5+Bfi5v8sTeDKQwrSboPHnw==
X-Google-Smtp-Source: ABdhPJzOgYirgRUWzuFnLSsjbC5YbWRe/tIL+XCoVD3DgD+uLW5KlX0MAiw0uOIdR9KNwxOd57vDQevEy5hWqiGQ59c=
X-Received: by 2002:aca:bb06:: with SMTP id l6mr3931467oif.121.1616627516008;
 Wed, 24 Mar 2021 16:11:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210323062303.19541-1-tl445047925@gmail.com> <CACT4Y+atQZKKQqdUrk-JvQNXaZCBHz0S_tSkFuOA+nkTS4eoHg@mail.gmail.com>
 <CANpmjNMFfQs6bV4wrigfcWMwCvA_oMwBxy9gkaD4g+A1sZJ6-Q@mail.gmail.com> <20210324160358.0f36aa1f8ea7098f66fe64bd@linux-foundation.org>
In-Reply-To: <20210324160358.0f36aa1f8ea7098f66fe64bd@linux-foundation.org>
From:   Marco Elver <elver@google.com>
Date:   Thu, 25 Mar 2021 00:11:44 +0100
Message-ID: <CANpmjNMBUjGL0cVqnAk7cLLHQkaP+YSNhmn+iMQjBo==4z9ryw@mail.gmail.com>
Subject: Re: [PATCH] kernel: kcov: fix a typo in comment
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     tl455047 <tl445047925@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Mar 2021 at 00:04, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Tue, 23 Mar 2021 23:32:57 +0100 Marco Elver <elver@google.com> wrote:
> > On Tue, 23 Mar 2021 at 07:45, 'Dmitry Vyukov' via kasan-dev
> > <kasan-dev@googlegroups.com> wrote:
> > > On Tue, Mar 23, 2021 at 7:24 AM tl455047 <tl445047925@gmail.com> wrote:
> > > >
> > > > Fixed a typo in comment.
> > > >
> > > > Signed-off-by: tl455047 <tl445047925@gmail.com>
> > >
> > > Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> > >
> > > +Andrew, linux-mm as KCOV patches are generally merged into mm.
> > >
> > > Thanks for the fix
> >
> > FYI, I believe this code may not be accepted due to this:
> >
> > "[...] It is imperative that all code contributed to the kernel be legitimately
> > free software.  For that reason, code from anonymous (or pseudonymous)
> > contributors will not be accepted."
> >
> > See Documentation/process/1.Intro.rst
>
> Correct.  I let this one pass because the patch is so minor.  But yes,
> a real name would be preferred, please.

I've just seen that the author sent
https://lkml.kernel.org/r/20210324071051.55229-1-tl445047925@gmail.com
