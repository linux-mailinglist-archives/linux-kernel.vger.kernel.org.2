Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDDBD3DA667
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 16:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbhG2O3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 10:29:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28343 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234361AbhG2O3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 10:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627568954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8rprxl3FocOXbhXJPD5+gp5oklLSxk2ZLSSYEsUHTlc=;
        b=FgLCunXTXE7c24XOqCIic3p/zu5cUUS+gtzAiD5NFy+UZE8RTdCJO+K38Fwon9Z0TunQOH
        ovXje0vT56aKGa626XZA8RzOx5UijR7LpearDJcvQ9vHJNpZQq8vUBwxNxHmQdm6IVMKH/
        T0XnI33d7itEAcpfW2eebut8SNtDdEc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-XQXYweBrPfqhVoTGWAQe_g-1; Thu, 29 Jul 2021 10:29:13 -0400
X-MC-Unique: XQXYweBrPfqhVoTGWAQe_g-1
Received: by mail-qv1-f71.google.com with SMTP id a2-20020a0562141302b02903303839b843so4006771qvv.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 07:29:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8rprxl3FocOXbhXJPD5+gp5oklLSxk2ZLSSYEsUHTlc=;
        b=EPsNq2BjHmUJTru9pt7sG6oI4X2Lle0g/hRU0pMNkaO4AZ7E899+N+5dTgNcruqtiz
         X2vl1c+/eqY4AKpXkaU+bc4Xiya/qIO86sgyJQIkC/cEWdgsuSkQpeIl/tI9a7k47Oh1
         VRLo1hK0cTXz/qrh2Zpd5vuTelj8uv/SAbr94DC2XJTFH0ptN0Z05rVUxQrJs596MnzD
         0imf7T0U9Yf9+y69dR+r8NybW+rDE8loRia6Z2E0SYgwdEKRqGT5sqpRSx0kn6fk3Lij
         NzYOHAQQy9UX2DltgafIeM3F5qOM5OS5I3yRuHNk8KzEWWd3FYgxzSirh+zY78WhTXvf
         WUng==
X-Gm-Message-State: AOAM531kTGy74GNXTOl+SdT3eWifP5JIHZxgx6rMO5ckT3f1aBbVRJkT
        jWIp4Bokz6U8KKgsJGmwY56maPJxmnk5eBSOqujrJL2+GmDHgQDaYspUGzLUKeS5Tweu9PE9wNg
        TYdhuYliTWbJ0yacab8aWvXntihcycZ0fiRBLycC2
X-Received: by 2002:ae9:dcc6:: with SMTP id q189mr5451215qkf.390.1627568952829;
        Thu, 29 Jul 2021 07:29:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7GAxKW9wCI+aT6box4kBql7mgRZBjdR1yCI+w2rMZPZJFjbkNS0X/5I4dfmGXa+D7YqpbFHFfXuDvHA30Dpg=
X-Received: by 2002:ae9:dcc6:: with SMTP id q189mr5451198qkf.390.1627568952606;
 Thu, 29 Jul 2021 07:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210726153621.2658658-1-gregkh@linuxfoundation.org> <202107261049.DC0C9178@keescook>
In-Reply-To: <202107261049.DC0C9178@keescook>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Thu, 29 Jul 2021 16:29:01 +0200
Message-ID: <CAOssrKdjuUbyHmzwLJFtu-KibPgG3s=LoDq3fgzkv=kTG+mZiQ@mail.gmail.com>
Subject: Re: [PATCH net] af_unix: fix garbage collect vs. MSG_PEEK
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>, kuba@kernel.org,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 9:27 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Jul 26, 2021 at 05:36:21PM +0200, Greg Kroah-Hartman wrote:
> > From: Miklos Szeredi <mszeredi@redhat.com>
> >
> > Gc assumes that in-flight sockets that don't have an external ref can't
>
> I think this commit log could be expanded. I had to really study things
> to even beging to understand what was going on. I assume "Gc" here means
> specifically unix_gc()?

Yeah, the original description was not too good.  Commit cbcf01128d0a
("af_unix: fix garbage collect vs MSG_PEEK") now in Linus' tree has a
much expanded description.

> I note that unix_tot_inflight isn't an atomic but is read outside of
> locking by unix_release_sock() and wait_for_unix_gc(), which seems wrong
> (or at least inefficient).

I don't think it matters in practice.   Do you have specific worries?

> Doesn't this mean total_refs and inflight_refs can still get out of
> sync? What keeps an skb from being "visible" to unix_peek_fds() between
> the unix_gx() spin_unlock() and the unix_peek_fds() fget()?
>
> A: unix_gx():
>         spin_lock()
>         find "total_refs == inflight_refs", add to hitlist
>         spin_unlock()
> B: unix_peek_fds():
>         fget()
> A: unix_gc():
>         walk hitlist and free(skb)
> B: unix_peek_fds():
>         *use freed skb*
>
> I feel like I must be missing something since the above race would
> appear to exist even for unix_attach_fds()/unix_detach_fds():

What you are missing is that anything that could have been peeked must
not have been garbage collected.  I.e. the garbage collection
algorithm will find that there's an external in-flight reference to
the peeked socket and so it will not add it to the hitlist.

Thanks,
Miklos

