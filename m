Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3B23F8542
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 12:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241417AbhHZKYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 06:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241317AbhHZKYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 06:24:54 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EEDC061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 03:24:07 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id c12so4182091ljr.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 03:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MArJc2UXM01InVIrz+q5g7FDMglJPPlUa7D94D3Y6j0=;
        b=gqKkxyWVckmwgoU51zfz1KfobvSXFXbmtHA6oozBzHxtNBQGm+xHPnJ6F+tugH28kE
         TKsKKsQNycQVR6n5lh/bswbEyiDoBD38CY4W81mXjPEUFQtgTNZpMbljf5wEqk3f8VBt
         l5dmd3kE3N9yMLOc2n6gOYXMdWJBHLCn0znO0rj0n5PEQw2UG07aPG7t+7fKkQNiJvz6
         jKNENwjkm7hgco5RW8metbszsKAiklTX+TWpZFjfulVRud7k5d2Ung9kfDEoIhSj8Na1
         QnCKe+rI8zumvtSJJxCT+K2cJFFmRMWEDsL0R9FNiTrSi70TBjG2yel7Ef+GVj52BNem
         IT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MArJc2UXM01InVIrz+q5g7FDMglJPPlUa7D94D3Y6j0=;
        b=jDbkF028fPNdoz8OdZVNjiLLYdTq4dGHwUCHuohD/XLbX6gFyY4imeV5HkjysASvSd
         xujb51sHMhnc7qurif/rw0cTG9XwjtaP0EUFmiI654+wjHa2ofSufrJNMe7L54B6ABPf
         TareY5Ae4ZDK0wZr1SQBfojiJf48efzOTIG88/4JvTfvc35zij0Ee6Tta46Ly2nj0khs
         zepSG8RprbBckQWJR1kzVvVJe+IElinslsnn32HPxCWLuGzbGZI1xbqg2A8/9ZCzt2H8
         FO1BI2yoHeuabB5SZ9ldxbLg/Ykr87NXUNsaTWD+RVGmIpFkblnewkj7MIA8ZXUSqzms
         PZDQ==
X-Gm-Message-State: AOAM532GhF2dfVSs8nnZzxkuLrOQnTTSdslOhGOZ74kUK+ns83Q70i1h
        ZjOYiBSvZgaJ5XWWQA4zTIsv2fON36uYy/ZOVSBpiQ==
X-Google-Smtp-Source: ABdhPJyoZqOiUX9Yihg0SFHx17SqsaQCPKfg5SiCXkVUhxYBLl5wdm3f3DcPjIqtScWuLLC3cHlj5FIgS05CZ3FECX4=
X-Received: by 2002:a2e:8795:: with SMTP id n21mr2435379lji.474.1629973445418;
 Thu, 26 Aug 2021 03:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210826092854.58694-1-woodylin@google.com> <YSdjgnUwt76cknQ6@kroah.com>
In-Reply-To: <YSdjgnUwt76cknQ6@kroah.com>
From:   Woody Lin <woodylin@google.com>
Date:   Thu, 26 Aug 2021 18:23:53 +0800
Message-ID: <CAHn4Deczc6gSSsxys6UeAMB99p1jHMZmLFj+KwZ2QhH7dx8E8w@mail.gmail.com>
Subject: Re: [PATCH] ANDROID: staging: add userpanic-dev driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Todd Kjos <tkjos@android.com>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 5:48 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Aug 26, 2021 at 05:28:54PM +0800, Woody Lin wrote:
> > Add char device driver 'userpanic-dev' that exposes an interface to
> > userspace processes to request a system panic with customized panic
> > message.
> >
> > Signed-off-by: Woody Lin <woodylin@google.com>
> > ---
> >  drivers/staging/android/Kconfig         |  12 +++
> >  drivers/staging/android/Makefile        |   1 +
> >  drivers/staging/android/userpanic-dev.c | 110 ++++++++++++++++++++++++
>
> Why is this in staging?  What is wrong with it that it can not just go
> into the real part of the kernel?  A TODO file is needed explaining what
> needs to be done here in order for it to be accepted.

Got it. No more TODO for this driver and I will move it to drivers/android/.

>
> But why is this really needed at all?  Why would userspace want to panic
> the kernel in yet-another-way?

The idea is to panic the kernel with a panic message specified by the userspace
process requesting the panic. Without this the panic handler can only collect
panic message "sysrq triggered crash" for a panic triggered by user processes.
Using this driver, user processes can put an informative description -
process name,
reason ...etc. - to the panic message.

>
> thanks,
>
> greg k-h

Regards,
Woody
