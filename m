Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5CF2428816
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 09:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbhJKHwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 03:52:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51823 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234622AbhJKHv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 03:51:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633938597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3qqrv9XMwmyzSCAT9HOBEBajfN1wyU+0aKu4BbhD+WY=;
        b=PrVUHj93IefNOnf5De+11wg4w7xrBl7L+DTB8o7RCmxF5DOuOJLeadrpQc4R75CoYIYf4R
        mxHQ4YHQQNnUZrPmhWoZqR42OvJhMFJN6/Mp/cet0tO9YW63KSPw/omvgqkAC2RRyapy94
        4l68D66Xqs/tURTiKrr1h5ToKlyXh20=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-z5iGsraZO6iU068PSC6nbQ-1; Mon, 11 Oct 2021 03:49:56 -0400
X-MC-Unique: z5iGsraZO6iU068PSC6nbQ-1
Received: by mail-ed1-f71.google.com with SMTP id f4-20020a50e084000000b003db585bc274so9500282edl.17
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 00:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3qqrv9XMwmyzSCAT9HOBEBajfN1wyU+0aKu4BbhD+WY=;
        b=zOrbruYRqnwfEwYwEEPCVdyFBv19C85wOjzuP/Uth7/Lcw8maHdRdmG52T1F6aTeCf
         g3f8i8Ok7GJxClZjWQj1u2Ow7DZL0EMlRZk2aJS5RAUDUgxoJKZMm/YKqtKoNiPQa93P
         WYcFJQ+sfKo0cjmz349nw44gzu5xwxrIJahsJ8CXN4sYUS5HjkioA0z3gK6yRRjIyPbK
         LQdsc+seamF5h/4Kv3CYu3I7ywvxX39QWkeWJSDM1WTPNB5jD7GFCR1GhiXCEeOuNLc1
         DTJlB+8I5gv2xsjYgFGUJKMYOMSQQUKwhdvxsI2kACl7pXZXQeYZx93DffbUP1PbnHOP
         frpg==
X-Gm-Message-State: AOAM5327r3yCjvgEqPCLgD4nYKzZcMjK6Cg/+QgwlApU2ko8UCUTU3uy
        YMZClWnPZ+657v+YjIgZSKrn5Z+ZrXY0+3Xm/dSRl259mVC3LjGfBNOF8RBAmx28+L+QzH45ow3
        fEg8P5RMdCqxae0Hv4qisZMQv2+L92u6QEY/IntmB
X-Received: by 2002:a17:906:712:: with SMTP id y18mr23264717ejb.408.1633938595521;
        Mon, 11 Oct 2021 00:49:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcsgmGkDj767ghqvU3WJZCfGbpa7roToTs6zdyTFywS44/zg0bJae92rBiiw0MC/WXlSU3j02FTgJK8XhuKx4=
X-Received: by 2002:a17:906:712:: with SMTP id y18mr23264703ejb.408.1633938595351;
 Mon, 11 Oct 2021 00:49:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211008032231.1143467-1-fengli@smartx.com> <CAPhsuW5+bdQwsyjBP=QDGRbtnF021291D_XrhNtV+v-geVouVg@mail.gmail.com>
In-Reply-To: <CAPhsuW5+bdQwsyjBP=QDGRbtnF021291D_XrhNtV+v-geVouVg@mail.gmail.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Mon, 11 Oct 2021 15:49:45 +0800
Message-ID: <CALTww28b0HGzSTTNGVzeZdRp0nGMDAyY8sQ+cBsSCuYJ4jMaqw@mail.gmail.com>
Subject: Re: [PATCH RESEND] md: allow to set the fail_fast on RAID1/RAID10
To:     Song Liu <song@kernel.org>
Cc:     Li Feng <fengli@smartx.com>,
        "open list:SOFTWARE RAID (Multiple Disks) SUPPORT" 
        <linux-raid@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

Now the per device sysfs interface file state can change failfast. Do
we need a new file for failfast?

I did a test. The steps are:

mdadm -CR /dev/md0 -l1 -n2 /dev/sdb /dev/sdc --assume-clean
cd /sys/block/md0/md/dev-sdb
echo failfast > state
cat state
in_sync,failfast

Best Regards
Xiao

On Sat, Oct 9, 2021 at 7:36 AM Song Liu <song@kernel.org> wrote:
>
> On Thu, Oct 7, 2021 at 8:22 PM Li Feng <fengli@smartx.com> wrote:
> >
> > When the running RAID1/RAID10 need to be set with the fail_fast flag,
> > we have to remove each device from RAID and re-add it again with the
> > --fail_fast flag.
> >
> > Export the fail_fast flag to the userspace to support the read and
> > write.
> >
> > Signed-off-by: Li Feng <fengli@smartx.com>
>
> Thanks for the patch! I applied it to md-next, with some changes in the
> commit log.
>
> Thanks,
> Song
>

