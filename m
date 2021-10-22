Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67C2437E92
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 21:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbhJVTZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 15:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbhJVTZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 15:25:28 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D655BC061767
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 12:23:10 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id x27so722066lfu.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 12:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uFe3exnauQJfbAcR6oE2bmw1C/eF9vF+KK5HN22tWIw=;
        b=G7pDqV8VN8hZpvK4ShVKrohXIKISJrYPVUch0yGnTNJ/yQQr1WklVxqzoqLeuTVXbT
         davM22TGW3G4HY8I0GbFkRL9H63cN5nz6G6wQg7OQZaRJKK+9NUu1iWCiHVpLovscaG2
         UHIKa1cUAxk8ozEhGO5Al08KVbT328By+HZlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uFe3exnauQJfbAcR6oE2bmw1C/eF9vF+KK5HN22tWIw=;
        b=Kfna0+gNusQiULL3/mknINfwccAAhINGcRYvLRP6wo0sb0RW3IcZr0DeOOln0qJELO
         7UmWDZXR4zry0uKkcFc9+TzFPm+SEbZgA/s9j521886/t6R+RvEi00ThI1/GcP7Idad0
         YJxvtgXCDMQWvAD050PE+MxatPaJSHwYxd7ldH9jbhM58RqFlDViMT4dEWxQ5r0ejf/Q
         rP0H01zlvUzkOSejelUYVbVBqHYctkVIi939KaBdRwOzAbNbgCFLg6+JlyKgzdaBVzY0
         EkHVfyV41VOAaPRXA8IbeK9VuqoV9f7RqI0Z+/1sKqiJff/zbQSCH+xAbFkhytHNgFGD
         HckA==
X-Gm-Message-State: AOAM532q1KKLcTfaEw/eGbt4W4mmI+s84B/j3/teuTS24odvUBlDfywz
        56yteldejaeuWa7VTdq8zYatt1q9HCsze170iu4=
X-Google-Smtp-Source: ABdhPJwqCbJRo+q7HyNQAj5ZMHbbntU3823etgwrgtWXt6sH6cHOBZfM9c+3Gf07Szhe8MD4bC834Q==
X-Received: by 2002:a05:6512:21c8:: with SMTP id d8mr1133003lft.7.1634930589011;
        Fri, 22 Oct 2021 12:23:09 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id s13sm879769lfp.70.2021.10.22.12.23.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 12:23:08 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id t9so2117783lfd.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 12:23:07 -0700 (PDT)
X-Received: by 2002:a05:6512:2245:: with SMTP id i5mr1384043lfu.655.1634930587026;
 Fri, 22 Oct 2021 12:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <20211019134204.3382645-1-agruenba@redhat.com> <CAHk-=wh0_3y5s7-G74U0Pcjm7Y_yHB608NYrQSvgogVNBxsWSQ@mail.gmail.com>
 <YXBFqD9WVuU8awIv@arm.com> <CAHk-=wgv=KPZBJGnx_O5-7hhST8CL9BN4wJwtVuycjhv_1MmvQ@mail.gmail.com>
 <YXCbv5gdfEEtAYo8@arm.com> <CAHk-=wgP058PNY8eoWW=5uRMox-PuesDMrLsrCWPS+xXhzbQxQ@mail.gmail.com>
 <YXL9tRher7QVmq6N@arm.com>
In-Reply-To: <YXL9tRher7QVmq6N@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Oct 2021 09:22:51 -1000
X-Gmail-Original-Message-ID: <CAHk-=wg4t2t1AaBDyMfOVhCCOiLLjCB5TFVgZcV4Pr8X2qptJw@mail.gmail.com>
Message-ID: <CAHk-=wg4t2t1AaBDyMfOVhCCOiLLjCB5TFVgZcV4Pr8X2qptJw@mail.gmail.com>
Subject: Re: [PATCH v8 00/17] gfs2: Fix mmap + page fault deadlocks
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, kvm-ppc@vger.kernel.org,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 8:06 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> Probing only the first byte(s) in fault_in() would be ideal, no need to
> go through all filesystems and try to change the uaccess/probing order.

Let's try that. Or rather: probing just the first page - since there
are users like that btrfs ioctl, and the direct-io path.

                  Linus
