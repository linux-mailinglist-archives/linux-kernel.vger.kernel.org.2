Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF6B37655D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 14:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237012AbhEGMmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 08:42:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45383 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236866AbhEGMmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 08:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620391293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+pizb5T4wXio4s+BKjaVq1oW2LlYLV5RKkN72d3SlPY=;
        b=cckZ1Ib//ahxUVuQY9soR+faNHz1L7JCA6Yt6hUss0V0u34i+scOiCCQtLsgUWN347O2pP
        tu84pjcIRX2uF0q9chCLm17V8u10jHuPIuKuhF2/6W4RMkBAoJZrIini6KFou4Y9WIFwWz
        UfQLwxAMGQcR7zwBFBp0cKySiXiqoOA=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-LSXvocD9Nx6LA7KH5IoJiA-1; Fri, 07 May 2021 08:41:30 -0400
X-MC-Unique: LSXvocD9Nx6LA7KH5IoJiA-1
Received: by mail-yb1-f200.google.com with SMTP id g27-20020a25b11b0000b02904f8641ec14cso4016616ybj.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 05:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+pizb5T4wXio4s+BKjaVq1oW2LlYLV5RKkN72d3SlPY=;
        b=d0PxEqso26HXoFS0rpKzHEb7a18hD2HtK8HMX1cM5AFq5gYwujxP2BmKNBay7XeSS2
         CDeYVp8R0IsYGGHWtv2klf+cc1naTgZqXNqtZYEoF/C01/Y3P3R41Wpii5kiZbSJNEFj
         cNc/oLVKNjvCKDXd3SaCZE/z/hdC6TFP87GrqdVaDqumH/lH+X9Vx1hG668faLMniLsP
         3+7X87u0YycRqtGBeqBWkL9T0tflXrTqkKK+apK2YWFPe5JFyMA6aWxyi15dMv6QbxZ8
         P+rbz/rJKW5KQdqIPZHHAilFFHgfRlMOx9aKd7ROlsrlte7BUFLGFtquxVM7uIQk+91D
         ou+A==
X-Gm-Message-State: AOAM533feLE8DF8eKoukPr+SSFHmpK6+YCfEdmJ9PFT08jfLmDMbqi3v
        xxq3puNwWddY3puaKN1z8IF7PFQpmHHmImHzvLu5oy6NjZSbHLYqyHLWzcwNEg8JXbTzk3NZH9B
        9pyS0CCB+bcvchhIS/PYIwK2qp3pyxIozz/prLE4U
X-Received: by 2002:a25:640f:: with SMTP id y15mr13170138ybb.436.1620391290264;
        Fri, 07 May 2021 05:41:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy22p09PEHUGb5fAA49wspHdow+4OHN0qicl6JIPF5XwcGlunbrNF+orAljsopKKKqw1oReB57xfDS4LkuZvuE=
X-Received: by 2002:a25:640f:: with SMTP id y15mr13170115ybb.436.1620391290086;
 Fri, 07 May 2021 05:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210507114150.139102-1-omosnace@redhat.com> <YJUseJLHBdvKYEOK@kroah.com>
 <YJUuoiKFjM8Jdx6U@casper.infradead.org> <YJUvhGV5EW0tsIpP@kroah.com>
In-Reply-To: <YJUvhGV5EW0tsIpP@kroah.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 7 May 2021 14:41:16 +0200
Message-ID: <CAFqZXNv_WWQZPHVhN5oqHVYanxKcXFqu6r=S9=ZTHKf7UNsiKA@mail.gmail.com>
Subject: Re: [PATCH] debugfs: fix security_locked_down() call for SELinux
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 7, 2021 at 2:16 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Fri, May 07, 2021 at 01:12:18PM +0100, Matthew Wilcox wrote:
> > On Fri, May 07, 2021 at 02:03:04PM +0200, Greg Kroah-Hartman wrote:
> > > On Fri, May 07, 2021 at 01:41:50PM +0200, Ondrej Mosnacek wrote:
> > > > Make sure that security_locked_down() is checked last so that a bogus
> > > > denial is not reported by SELinux when (ia->ia_valid & (ATTR_MODE |
> > > > ATTR_UID | ATTR_GID)) is zero.
> > >
> > > Why would this be "bogus"?
> >
> > I presume selinux is logging a denial ... but we don't then actually
> > deny the operation.
>
> That would be nice to note here...

Granted, I didn't do a good job of describing the issue in the patch
description... I'll send a v2 with hopefully a better description.

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

