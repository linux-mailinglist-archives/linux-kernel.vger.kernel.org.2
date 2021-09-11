Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF674079B6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 19:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhIKRGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 13:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhIKRGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 13:06:34 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7738C061574
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 10:05:21 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bq5so11072095lfb.9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 10:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nyaNa5jh7u4OrH4aT60jYwA/34rGKStvVyqkKWK4Gkg=;
        b=Xob4PFHNa8tZ1GDNjHJX5f6b7gNZu+EbwhD3b0fGvMBPIGOZr2rUsTbSEsh9InOUxs
         TTOYUWIuKPiD9z0fhWWjBnl+oUe6UI9fnZBkhfxTQ+zIYbjEjHhks9fQBPotpWyssRUB
         peWcciku5OOo5siPQRO5nFhOP853uQDyf3HiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nyaNa5jh7u4OrH4aT60jYwA/34rGKStvVyqkKWK4Gkg=;
        b=o6i0bqzZclz+EGO4XyMBHOHDXkC4n9ccOHuEAjCExqW20IEnG5E60/PIQ/wWtxmWNH
         J5z9cl6aNa++tkjp1it9NZf5sDTzCJTYFZS0K0u9Rqrzi2Jy/OynXwVtHy5GkUCrQcIw
         f+2letq/wHZ69FnAXTAwlaylg4TEl2IY1d9ejFibi3MVj+6ZOxwnUqKFyk5AScjMouPM
         yKjHAD+HxkUDqXxj/UPoCh++h34DeMaAM/Zq1Hz1w/tSoA/EDsFdR1UKCvOjwZqaxahr
         +yFEoJVVVZh0TUwIFO+tfokNmasWs3olGlQLY8ixfUpiT30UaQde/aFrl6O1/t2QY500
         LcNA==
X-Gm-Message-State: AOAM531oMvw7fDg4ysYQ+tMj3WeOOjSscJXInBiQagEK7Ta82JUnLTRa
        2Y2hDljWI7S2dV0MgtCp1cH5E3CPYz1820YAWDU=
X-Google-Smtp-Source: ABdhPJz631HENvIDBdnCb0P4yamdGupN9TXI8Fdp3ZPSOBwjKzoovn9cXE41LyXHtYlPLs/78stANA==
X-Received: by 2002:ac2:5ec2:: with SMTP id d2mr2639902lfq.250.1631379919941;
        Sat, 11 Sep 2021 10:05:19 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id a7sm254146lfs.309.2021.09.11.10.05.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Sep 2021 10:05:19 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id g14so8784142ljk.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 10:05:18 -0700 (PDT)
X-Received: by 2002:a2e:8185:: with SMTP id e5mr2798909ljg.31.1631379918659;
 Sat, 11 Sep 2021 10:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <YTzSVk5Scx/nRP7K@piout.net>
In-Reply-To: <YTzSVk5Scx/nRP7K@piout.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 Sep 2021 10:05:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPJrMhr1_62O2xwD1QbT9oxJJ_uXw2mm6sa0hNDrFuwQ@mail.gmail.com>
Message-ID: <CAHk-=wgPJrMhr1_62O2xwD1QbT9oxJJ_uXw2mm6sa0hNDrFuwQ@mail.gmail.com>
Subject: Re: [GIT PULL] RTC changes for 5.15
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2021 at 8:59 AM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> The broken down time conversion is similar to what is done
> in the time subsystem since v5.14.

By "similar" you mean "identical", no?

Why is the rtc subsystem not just using the generic time64_to_tm()?

Yes, yes, I realize that due to historical mistakes, there's a
duplicate 'struct rtc_time' struct, but it turns out that that is
_identical_ to 'struct tm' except it also has a 'int tm_isdst' at the
end.

So you could literally make a union of the two, pass the 'struct tm'
part down to the generic code, and just do

     rtc_tm->tm_isdst = 0;

at the end.

Rather than have a duplicate copy of that admittedly clever Neri and
Schneider algorithm.

Hmm?

             Linus
