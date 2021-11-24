Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E3E45CBD4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 19:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243814AbhKXSKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 13:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351267AbhKXSI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 13:08:56 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62676C061399
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 10:04:42 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id g14so14208696edb.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 10:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o4pcYLzRiFXgODRmqJpRApo0JQqGz6PeqKc5/Q3/c2Y=;
        b=NmEPfl2wDAhDoFRA7Rl3HPVjtun+4o2+Ufli0ATYaUg3efHOQDitlgMJqmgkznje/U
         1Ta2cgQtZesQxOMsoNSHMhw6isOA09i+536PIzDrtONWqDATLj55KdAGQFUamXnvSxI9
         zLT2q2xcLkdpeVYnfNoOP6NDMvcf3lpyEqs94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o4pcYLzRiFXgODRmqJpRApo0JQqGz6PeqKc5/Q3/c2Y=;
        b=SslFvA1acqcpm7wZ7ptqQ3cMil+MpJA1wd9wk5A9f6x/3EytU1Lb/u0FoUQ9yiKvEX
         YLvdr/Z0nQkPCgHKkziKtyfIzUYZtVc7gRn1A2cNWQuvod9t/0Mw5OPlqpRkQqLZautG
         Pt2N+sO0jovzBi1GcZ+DofO9harSD8tKhJtfNU2+NjNzmzR2bZU97aycGUhBOGctFhWv
         G260zXqDUw+8wfRSzgLRiXqcqyf3A6ow4SNZluOMG/ByJuxzdZc8ubyI+Dl/+jxY/Z26
         sZrfuYbxRzhfHWiacF80AFjKdP1OuQFj5VbHj6Dk3vEX6XDEG6JZQBM8UIkipe2RnwsL
         Yp5Q==
X-Gm-Message-State: AOAM531+Tdx51L/OxLi1TZO1i5l+tSITetQR/j17pqEmki1mlvHfqKQi
        JGzh3mzlt0e0KZ8t9UU55s6OsBOEKdevk7pj9n7bBp8R0KI=
X-Google-Smtp-Source: ABdhPJzpcafQIlNcLwu3OzPBZJUzh8rDyCni+prznPFIY3EHy28pXMGu4oXxA14zxwjFPMfFFBe0hn7gIEkQupjhBng=
X-Received: by 2002:a17:906:4e42:: with SMTP id g2mr22798958ejw.230.1637777078574;
 Wed, 24 Nov 2021 10:04:38 -0800 (PST)
MIME-Version: 1.0
References: <20211115165428.722074685@linuxfoundation.org> <20211115165430.669780058@linuxfoundation.org>
 <CAFxkdAqahwaN0u6u34d4CrMW7rYL=6TpWk1CcOn+uGQdEgkuTQ@mail.gmail.com>
 <CAOssrKd4gHrKNNttZZey9orZ=F+msx4Axa6Mi_XgZw-9M39h-Q@mail.gmail.com>
 <CAFxkdAqU0peBNm_SB3En99bU+o=a+05t-Bwyds0AUFb+2W=CFw@mail.gmail.com> <CAOssrKez1mnF4rWRvWgk4LJ2iDfX8xkpMKvgprFt+-ARs83=nA@mail.gmail.com>
In-Reply-To: <CAOssrKez1mnF4rWRvWgk4LJ2iDfX8xkpMKvgprFt+-ARs83=nA@mail.gmail.com>
From:   Justin Forbes <jmforbes@linuxtx.org>
Date:   Wed, 24 Nov 2021 12:04:26 -0600
Message-ID: <CAFxkdApnvRNRU6vZ6qxtuCW78RoLuOMqaxSv+BXj9dX5DXxQyw@mail.gmail.com>
Subject: Re: [PATCH 5.15 056/917] fuse: fix page stealing
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Frank Dinoff <fdinoff@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 3:23 AM Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> On Wed, Nov 24, 2021 at 1:40 AM Justin Forbes <jmforbes@linuxtx.org> wrote:
> > Thanks, did a scratch build for that and dropped it in the bug. Only
> > one user has reported back, but the report was that it did not fix the
> > issue.  I have also gotten confirmation now that the issue is occuring
> > with 5.16-rc2.
>
> Okay.
>
> Morning light brings clarity to the mind.  Here's a patch that should
> definitely fix this bug, as well as the very unlikely race of the page
> being truncated from the page cache before pipe_buf_release() is
> called.
>
> Please test.

Thanks, did a scratch build. and multiple users have reported back
saying that this patch does in fact fix the issue.

Justin
