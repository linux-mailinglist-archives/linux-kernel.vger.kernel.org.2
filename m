Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEA934CCFA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 11:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbhC2JYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 05:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbhC2JYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 05:24:41 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AFAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 02:24:41 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id r12so2428368vsj.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 02:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nUqVYbOsgzJvFaHO534MA1Tdm9chX2nN9+FCc/y44XE=;
        b=Guw+BOMais6EakAu9RohwYoxmmtYPJnwLs/4rXBB+5UKeB5Yk2UrYiXEwnNnkllavH
         gR+Ayxy4vd3HWHJa9R982DXzyD662Iha+wtjn3IWiK37BiidxzCx7+ACDI+z1HXLucj4
         ajJUXlLUtrwguVPFucQuJIwHsRtyodYMdnz88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nUqVYbOsgzJvFaHO534MA1Tdm9chX2nN9+FCc/y44XE=;
        b=AXNxrRxWFc/WiSF8eugJzXJhsib+jphdAACm/iReKxJOJ9AhreJ2WrCd+wwwbFXbzc
         Cppwiz6O1irLiqDV4M9hZ9gkpL/9vlHkR8Hgh8sNNj/+zf0Ud1Clr1h0+VnND5wJMVYh
         CoDqO5vyUE6rJYYFUY0LoHAsR789J95nB2tMhWt7D503LR97Njm69L89aFNHjrK4WFyD
         uIertphZo9foR/gxY1mfXmq5HyHjFyo5gFiosTdc0y7N5AnYHBsEQ0kS9Tgp3s3kEWDr
         VFOEkgxZkx83xIqwUo8CIqp3rYfYTwaqPahfvojgo0KorQ/E9MR5VgYkIGsc1Jo6t7Sg
         Rf3w==
X-Gm-Message-State: AOAM530AA3BG2ZieTyrepwGLHzIqw/99HbC8/2kVShRNEEDwWZWpPwbQ
        0qsnlxpf3YMhvfWdJ1+oJJRpyDtOhNCrett94XxLbA==
X-Google-Smtp-Source: ABdhPJyZxxztIJkv/XIaxwQ8J2HG8Af2Yj5L8n64NOybPY5kHyelQ8Yf6zkuJ1gUrjuqCaWQkxiofplCj62NVVMbq+g=
X-Received: by 2002:a67:63c5:: with SMTP id x188mr1682420vsb.9.1617009880930;
 Mon, 29 Mar 2021 02:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210325193755.294925-1-mszeredi@redhat.com> <20210325193755.294925-4-mszeredi@redhat.com>
 <YGDGICWI6o+1zhPI@zeniv-ca.linux.org.uk>
In-Reply-To: <YGDGICWI6o+1zhPI@zeniv-ca.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 29 Mar 2021 11:24:30 +0200
Message-ID: <CAJfpegun3LHMZ9uVxbf5knZB6w1CnUHHXeYpn_ReCTdXKaFX0w@mail.gmail.com>
Subject: Re: [PATCH v3 03/18] ovl: stack fileattr ops
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2021 at 8:09 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, Mar 25, 2021 at 08:37:40PM +0100, Miklos Szeredi wrote:
> > Add stacking for the fileattr operations.
> >
> > Add hack for calling security_file_ioctl() for now.  Probably better to
> > have a pair of specific hooks for these operations.
>
> Umm...  Shouldn't you remove the old code from their ->ioctl() instance?

Will do, once fuse gets converted.

And fuse will get converted, when I manage to decide on the best way to do it:

1) keep a list of open files for each inode, pick random one for doing
the ioctl (really shouldn't matter which one)

2) do a sequence of open - [sg]et attr - release for each invocation

Thanks,
Miklos
