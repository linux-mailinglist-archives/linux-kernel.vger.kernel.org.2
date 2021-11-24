Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A8C45B8C0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 12:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241657AbhKXLFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 06:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236994AbhKXLFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 06:05:32 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B33C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 03:02:22 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id p23so2613810iod.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 03:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4YuxwKlQWoZpddYdm2bwIN5Tlu6ClNwG8RaW/drUlV0=;
        b=FIQ20ev7+PG+IQ+bt/j4dBG3q4A2RFqO6/tR5EP1PY7jt28ehmHKwmWZy6SoGvtqfw
         GOgjDxPGknnvo+3WSeRepYBojxNRgtxW2FUb6hFbZUK7SssHl+mwzutNr8YEUJ0h8MTm
         p6oPf0xEpidhEuBckA9Zv6YpIDfvUc3BVeMDMsvLNCJZbknuAUxMw48rktJkj/sJg6B5
         M/srBuGzIH91Vr5a2EKOM2dHzGnK1SyhsLIMgPi8hBWvinmEuCnNq3nwBHf6+9QyXUzS
         XKs+wQKWgRxKW8bULGKbNyg8ZZp4Tw0g+IoH/mQQmON+404149BCL7q6Cu9Cct5dTfgL
         NDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4YuxwKlQWoZpddYdm2bwIN5Tlu6ClNwG8RaW/drUlV0=;
        b=4+B5MDYCR5IBP6KCSnuhzuBv22NE9O63akR4LRKRmj4Qs4qwW4SwMVLgNZHVqrUyNp
         2sLAkm2xC2Mzwavsmb1jjraroUbOvR77huAMCu7SkSrRHTkHqeQCYJWEGYL8CTfZXiQW
         /x+ZaNHuwrLrudb81GNzZNSKmVqulGhWEz0jUrTonGf1rSYAk7PyJ8z44Mo3wWjTb3sV
         mbZxml2thLwzRYiMEamgPEw/PAvhVna6NB5x5EB6YkFOYgzoMxwPQEYSk/QjfpZ9rwjQ
         29w9u+POxj2i3Ii3aKi7uJo9Dz4lHV7EGlV3MTINFLwtqSjSZLzIxUEyKahERlU85R3S
         7eYw==
X-Gm-Message-State: AOAM531mvNdTA204epI6tWjvGwHco3QnaJ2MsMkswqUerXpD43ULVuqj
        Y4vJ9QriF8mE+cLNiPLXOWkJFJTjG0QY8ZQRZEU=
X-Google-Smtp-Source: ABdhPJyVLyI+aBni4HcA2pCZqESIk+6JeILtiUmGGZVgcvxK6IitfSUBwfrEKZFi/F0ysrkFeNQKSzqauC2Z5VsirCI=
X-Received: by 2002:a05:6602:2e11:: with SMTP id o17mr13498558iow.172.1637751742104;
 Wed, 24 Nov 2021 03:02:22 -0800 (PST)
MIME-Version: 1.0
References: <CANiq72kgm-5CidoN8VRLnWokiDSWsQcMFbaUd4WKOnbPsON9RQ@mail.gmail.com>
 <20211109220732.7973-1-sampaio.ime@gmail.com> <20211109220732.7973-2-sampaio.ime@gmail.com>
In-Reply-To: <20211109220732.7973-2-sampaio.ime@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 24 Nov 2021 12:02:11 +0100
Message-ID: <CANiq72mbBKyuzFpi5k2Gfzptbz7MT4vnW5A9J+E+XyG-80E3Zg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] auxdisplay: charlcd: fixing coding style issue
To:     Luiz Sampaio <sampaio.ime@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 9, 2021 at 11:07 PM Luiz Sampaio <sampaio.ime@gmail.com> wrote:
>
> Removing 'int' from 'unsigned long int' declaration, which is unnecessary.
>
> Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>

Queued up, thanks!

Cheers,
Miguel
