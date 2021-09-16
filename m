Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC97540EBAB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 22:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbhIPU1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 16:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhIPU1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 16:27:12 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAEFC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 13:25:51 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id i4so23350259lfv.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 13:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ndSLOBCyHr0CqKUTyXcxV7ueR+cLp8PrHz0AxU0LIug=;
        b=MushEZjyEhrjXlWoUV3Uqjb83CmhFXrZC4Nc+jwBRJFxxDdB8bMGjuyGmT68YyaCCu
         gjfyKlppV4mHDNlpXDh6ku01URAfSUmIod+EpYHIgBNun2WFP27ZPY17qVCMoFShjlmU
         SncI6jirQrSTS3yeyqP+cM+/8T7/q5A+dsVvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ndSLOBCyHr0CqKUTyXcxV7ueR+cLp8PrHz0AxU0LIug=;
        b=sI5EH5VCpY8p0XqPzQ4TwzwurHxkKN2d+2asxDXhzWlIu7a7gfCobd9rG+FsGySbQD
         WmowDUjeu54GhhWxkBblhpuWM7QWVKQTQ/dHTrSOvd3AcZkE4+7i3j+P4yreaLAc3V67
         0QP3+NUNUe1YyUdvROB1gC6GB8kxYhXT+yrhM9W/D4TMj8l1oCkhT7B1ktxNs13X2uJB
         WpPTqOm6ZGdGfP+AZfvEmSkf9MxQOE34Je/FOP3wqFWGT0vOp3Uq+zKyZqNFi1tVd7kH
         hCubQpgwNf+29kcMzqzJyfZ7+88jzs+RxcrQLR31TIAaos8uEwVKhNpHPpJhf3GE2Y/F
         6YMg==
X-Gm-Message-State: AOAM533ZqU7NIUOrtqg4ytsqG4Gmmk91IR79cJLo0jYJtY+/E7sEm+CT
        hIEb7ZaluOXPzQqrACrulnVwAj78PAShXMb0QQU=
X-Google-Smtp-Source: ABdhPJzXD8SBNQJxT3jQuAFHGheXaZI7lu29voJrM+++Pzbc/DJDe6xhN5YR9t4Odhod02PPVA+iSQ==
X-Received: by 2002:a05:6512:3d94:: with SMTP id k20mr5303444lfv.633.1631823949297;
        Thu, 16 Sep 2021 13:25:49 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id d20sm346213lfv.117.2021.09.16.13.25.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 13:25:48 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id c8so23574600lfi.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 13:25:48 -0700 (PDT)
X-Received: by 2002:a2e:8107:: with SMTP id d7mr6761409ljg.68.1631823948194;
 Thu, 16 Sep 2021 13:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <YUNi6hTcS8nUrrpF@ls3530> <b3d13e4f-c9cd-495b-5df2-1080ca4d3aa3@roeck-us.net>
 <f3713fe6-2806-9d65-618b-a9d210193e60@infradead.org> <26cfe07e-98b0-ec46-9665-01d2f8761c40@roeck-us.net>
In-Reply-To: <26cfe07e-98b0-ec46-9665-01d2f8761c40@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Sep 2021 13:25:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh82AyhEQmNoWzqoFQjmwaQ8XiNL3u=knmr844LKkJQTg@mail.gmail.com>
Message-ID: <CAHk-=wh82AyhEQmNoWzqoFQjmwaQ8XiNL3u=knmr844LKkJQTg@mail.gmail.com>
Subject: Re: [GIT PULL] parisc architecture warning fix for kernel v5.15-rc2
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, Helge Deller <deller@gmx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 1:10 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 9/16/21 1:03 PM, Randy Dunlap wrote:
> >
> > Already merged in the net tree.
>
> Ah, ok. Sorry for the noise (I already sent that patch).

Well, I _just_ got the networking pull, so now that particular problem
is solved in my tree too.

There's a few more from your list, but I _think_ they are at least
mostly pending in other trees and patch queues, so I'll ignore them
unless told otherwise.

But I've literally set aside this week to just get this mess sorted out.

Not only do I think it's time to just *fix* these damn warning issues,
but usually the week after rc1 is somewhat quiet since it takes a
while for people to find regressions.

So I have actually spent more time than I would normally consider
healthy on code that I in any normal situation wouldn't care about at
all.

(I realize that Arnd and Guenther are now scoffing at my "normally
consider healthy" since they have put even more time into this, but
hey, I usually actively try to avoid reading grotty code in areas I
don't actually care for).

So if somebody is aware of some warning situation that still remains
and doesn't seem to have any movement, please point me at all. Maybe
we can't force-enable -Wall, but I want us to be really really close.

            Linus
