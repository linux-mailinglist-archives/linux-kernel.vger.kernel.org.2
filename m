Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103FA30D61E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 10:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbhBCJTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 04:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbhBCJTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 04:19:17 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CA0C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 01:18:31 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id i3so8093965uai.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 01:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HieUWQakppqVFKaj0BQObJQSQhAwBKtcNJ/Ujjq5bQs=;
        b=PH4qXvG65vp3rypsDQNApyOSIPvPqL9rwKkUnCB77vhRu0lVsRWwgKQymXzaug2qck
         TQkWRkF2abwn2GNKJgnoJZMSbzjZMTHd5ik+/CU5NHHRXIzb+zt4DI2ntCI1cRkM++oH
         O/xa1EmmkoQQBSW1SVVdgNp3ya/hXOmSJl6yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HieUWQakppqVFKaj0BQObJQSQhAwBKtcNJ/Ujjq5bQs=;
        b=H4Zqam++Y0Zwj2MaMppuGpAH2KY0Y7hK3WpThX9agRE5KTouKMgCYErM1XSZsGJQYX
         UvGWMYYeolZB3hbHAmM2KSfNrnTmB/WF3+geIyOczWLsQ+GPzrfvWu9ncv3z+b5HiIbD
         VGrKnk7kQ/Ls7VBoDigLnQ2e/LeYTv3+cXQ05P75IjT7NAaDacuYaYpbpn1jiMxmerVh
         tgoTx/V401h+b8DQQ5v5CBFHYfHG6C3foK+G4bE/eCmjC/HT9wKT1sJ9VKwXpEhMQw8w
         nGkppartvavwE1pU2SywUROHFE6j9x4ThBkvJqrX+hHsGDYHT3U/IabP7D4N/VQIb0Y0
         iXbQ==
X-Gm-Message-State: AOAM5306XBFVBn+ulCVFs04FFD3Fu6RpP3yE5+y2fZ+wI75oZXEu3mSS
        785RopVOsSKFIdG7Jx+tLJEJ2DjlD/poXKSiM6W0mmW8CslS2Q==
X-Google-Smtp-Source: ABdhPJxwf2sCD64/0oc0ps4lfPf69qGb0E31UhqLBApx5EmO4JRcuUAn+Q9eUMiQgdIIw3a433jG5M3OUN05Yqq9AZ0=
X-Received: by 2002:ab0:2bc3:: with SMTP id s3mr1098247uar.74.1612343910829;
 Wed, 03 Feb 2021 01:18:30 -0800 (PST)
MIME-Version: 1.0
References: <CANMq1KDZuxir2LM5jOTm0xx+BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com>
 <YBpnBUD+QoMW9NtL@kroah.com>
In-Reply-To: <YBpnBUD+QoMW9NtL@kroah.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 3 Feb 2021 17:18:19 +0800
Message-ID: <CANMq1KAPe8F2WVsxYnP46Zx7K_0YSpnAUgod1WjenhOcHRk2kA@mail.gmail.com>
Subject: Re: [BUG] copy_file_range with sysfs file as input
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        Luis Lozano <llozano@chromium.org>,
        Ian Lance Taylor <iant@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 3, 2021 at 5:04 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jan 25, 2021 at 03:54:31PM +0800, Nicolas Boichat wrote:
> > Hi copy_file_range experts,
> >
> > We hit this interesting issue when upgrading Go compiler from 1.13 to
> > 1.15 [1]. Basically we use Go's `io.Copy` to copy the content of
> > `/sys/kernel/debug/tracing/trace` to a temporary file.
>
> Nit, the above file is NOT a sysfs file.  Odds are it is either a
> debugfs, or a tracefs file, please check your mounts to determine which
> it is, as that matters a lot on the kernel backend side for trying to
> figure out what is going on here :)

Yes yes it's tracefs ,-) But, from the other thread
https://lkml.org/lkml/2021/1/26/2029 sysfs (and any other fs that
generates files dynamically like procfs) would likely hit issues as
well (but maybe in more rare circumstances).

Thanks!

>
> thanks,
>
> greg k-h
