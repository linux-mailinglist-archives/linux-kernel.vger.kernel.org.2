Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94863403077
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 23:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbhIGVwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 17:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbhIGVwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 17:52:30 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15B3C061757
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 14:51:23 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y17so138086pfl.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 14:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nH3SqLmAKa3QWhENQjm7ZyMx9P53ELeJFuPULFmwmYg=;
        b=H7ZXRbXJljXrnm7cpoNZs5C+c9wExgUpPuj/CYPEnCc1wRRAv2naufSWcsOXTrVW/d
         vnYpWgfBT7XaQfPQVMOQbw7+HpeneZa8iUHvLjoZMHvMVG5/CM82nDayw5bXVpgV4OZP
         yO15Fbf1e4bfySK68wfNbxw5iI7V5XmQd/o048kGQhlurWUzYO1Zo5YhhnTh1NUiw3LD
         nTKT7BHPGtyh+X1NzOQXOnjqKOhg5uUOg9q3Jw09KT9tq8xcjLahK0MAC4FkNwTrliqJ
         z/UqHB4cFNopNo0FrV1oBUo05bViYzkGxmajLwj/lu18YCL8uKeujSVBMJSDXQrJv9C9
         /0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nH3SqLmAKa3QWhENQjm7ZyMx9P53ELeJFuPULFmwmYg=;
        b=ahTMuf1GgP/wTJGV7ag3qhgQiBn2HpnynwqXYKDjuPSTXUzNILd3StYQw6jHcBMhr7
         k48n9HJmEHk7x5wzAhwWzYdegDdoXJXP/4JgBS7nvgmvVmdICaRWPo2zypQUjwBlVPac
         /Y2tyRQwtMnmQdPH/MKFSkpzXX+b/Rvb0d7k9K8Z8uZCHvxzjgmPJAmPG/AcNjNWbkQ1
         mWM8L8zp+sRsij2uOx7NRY0Z9I/fxjuklKiXgks3GbMbtgWPBB6y3fsj+B2PiThOLmGX
         Ar4OAijmldByw4DjOliMEg3q8tA+3RkYOmWPQqgZC0Px1qxYvaL5X7G4kFg1dcVn0FsS
         UT3g==
X-Gm-Message-State: AOAM5303sX0rFMenMaBRriQrHhmZ3T/dTyVXNOtwR8kOhZicAk+5rcJQ
        i7gN/s2Iyt+iYonKa3Yhd0H5EPVx6nBcm67bi5gm8A==
X-Google-Smtp-Source: ABdhPJzQticURzEC6ZLKZtTPD54GWwOq15jx9XDgxfpkM7tKK6zddBBBLCDi1Ojta7RO11Q1OpJhX/OU8U5AxHAKFfM=
X-Received: by 2002:a63:1a65:: with SMTP id a37mr430496pgm.338.1631051483193;
 Tue, 07 Sep 2021 14:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210906215745.1992-1-phil@philpotter.co.uk> <YTb7f+P/HzeAJDek@infradead.org>
In-Reply-To: <YTb7f+P/HzeAJDek@infradead.org>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Tue, 7 Sep 2021 22:51:12 +0100
Message-ID: <CAA=Fs0n27T5UF2PdhZjrw1wLx_ym6MwA=fNmU9v9gDk9NwtaXQ@mail.gmail.com>
Subject: Re: [PATCH] cdrom: add linux-block list to uniform CD-ROM entry in
 MAINTAINERS file
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Sept 2021 at 06:41, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Sep 06, 2021 at 10:57:45PM +0100, Phillip Potter wrote:
> > Add linux-block mailing list line to the uniform CD-ROM entry in the
> > MAINTAINERS file, as this will help submitted patches to be seen on a
> > list that is more focused without the level of traffic of the overall
> > lkml list.
> >
> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
>
> Looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thank you Christoph.

Regards,
Phil
