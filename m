Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E234038F918
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 05:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhEYEAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 00:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhEYEAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 00:00:10 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AA8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 20:58:41 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id w15so36324980ljo.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 20:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8KoZfY47+etg0JP/Zz64TPz3Kh9vNJ9gmPx9fA+UJ1E=;
        b=MxlRbsAP5XolN9Xtt4upLjkysqnimbidG9E+iMvEmgCbftg63e/XEdqCpyuPZfrVUA
         QA2l3vhNcIFqj4HNE42ZEbL/uFGumbqsslVmEGXswlQ+rvDQsIOflEwBRDh7BDLmYYQx
         zqbNyDQhbXxbAdoaUdjkNxS2JYIOv3EKWmVPuly4UkJz9i69TS5it3svyDEaXZrdts7c
         hWJ5mp3SH+XRk67TJRT78qoIx+kuPhtjlMYuXoVYEAi918zQl2qEfXBmfI7gQxqJKcD2
         OzdwX9W2PxA52705hVgtJqEchVFRyJxfoCTx5JUQmR0Y/EPgTNUyt8vB89ZMG7/WFEe4
         YAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8KoZfY47+etg0JP/Zz64TPz3Kh9vNJ9gmPx9fA+UJ1E=;
        b=Mu8WA0o/QTlJKm7Ib/g8X+e+Ji424ZYLmwg8fovutTfS+SSyLpgicsyQRreqrYu1zj
         JzJOhAyOYAuuENjpdtTR23Sptx7qW6KlvThQiGvloutWxpkFOkXxWvWeZLVRBBEq4zB5
         dbcG0HD4AhbxW2W7mDZDdbV9h98wrHhEqxjj43QdKTD4XykilPv1bqaqKGb9otGUxh03
         lkQCEH8oF4TNEItG/piwmLtzOJiX+7XrsmguLvhHwRvd5LXG9Pfw7rXYioQ5MA8SKXB8
         OKDfAxrxDHzE1MJW5+1OzznqW+Y2r7oGM7MvPttBemCGqCEXACU6haQ7AuHhpqJCBNQM
         kjnQ==
X-Gm-Message-State: AOAM531JsqENNGiv6br3c6B5UolVr7MtsMekGWBKFGIJitWXIFYVP6sZ
        XXP8o5L8TTMSSjJzlfrlf9GUVU+bGlfZweOYr5FfqA==
X-Google-Smtp-Source: ABdhPJzgkqXi2jDaDd2wVgppJTYoSj+ULr9eNjF0ZZo/RbUD+tja8vY5AcD9358BV5ekoMFZhpKeYI/gIK9KtD+Cg4Y=
X-Received: by 2002:a2e:b601:: with SMTP id r1mr18761487ljn.203.1621915119234;
 Mon, 24 May 2021 20:58:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210414021201.2462114-1-lzye@google.com> <YKx0v9K/1TUZrlbD@google.com>
In-Reply-To: <YKx0v9K/1TUZrlbD@google.com>
From:   Chris Ye <lzye@google.com>
Date:   Mon, 24 May 2021 20:58:28 -0700
Message-ID: <CAFFudd+1+mOsZAc855jFeYkpbKh70Jt9iVYb0F0DQHrUDjbPBg@mail.gmail.com>
Subject: Re: [PATCH] [v5] Input: Add "Select" button to Microsoft Xbox One controller.
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     =?UTF-8?Q?=C5=81ukasz_Patron?= <priv.luk@gmail.com>,
        Benjamin Valentin <benpicco@googlemail.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Olivier_Cr=C3=AAte?= <olivier.crete@ocrete.ca>,
        Sanjay Govind <sanjay.govind9@gmail.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-input <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, trivial@kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot Dmitry!

Regards,
Chris


On Mon, May 24, 2021 at 8:53 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Wed, Apr 14, 2021 at 02:12:01AM +0000, Chris Ye wrote:
> > Add "Select" button input capability and input event mapping for
> > Microsoft Xbox One controller. From product site this is also referred as
> > "Share" button.
> > Fixed Microsoft Xbox One controller select button not working under USB
> > connection.
> >
> > Signed-off-by: Chris Ye <lzye@google.com>
>
> Applied, thank you.
>
> --
> Dmitry
