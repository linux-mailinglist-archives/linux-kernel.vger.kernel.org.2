Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1F631B22B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 20:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhBNTIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 14:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhBNTIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 14:08:16 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBE4C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 11:07:36 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id h26so7102735lfm.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 11:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+iR6zFaRNY/fhsrzqmwn/JVZVFCvk6DBCPYDYIQyHfo=;
        b=RI+o6311ff6/KY2oB1MDn2aYFIZ37ZO7+ElRP2boyLDgrEezQY2kcJmhjWwQssySKS
         o3jxGgKHe3icceIXdUvRBS4zM10EMA0Sff4F62aHaU4ESBBDXYXw4cash1EmqdeDAWhj
         SSPqJrJI3i2beVLxhS1rUn455sMCpu97c6TWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+iR6zFaRNY/fhsrzqmwn/JVZVFCvk6DBCPYDYIQyHfo=;
        b=RTVGGKGxLSSYwRIcvY546b7R7NmikbORTqeQy9OehcWmTboxUWl2AtVjMU+ilxS3LP
         Ern/LQHoTnvBqHtYQGz1uSdCjvdgJ2txafTinVD7zr0mEbQZsmLFlUNgtxXOZuVc/l1j
         NlwamER4ownOt+z+2WESgERs9uZgA2Q+Fc9XEda5SFl3Qm+S+Ow6vcad94undVRsBIG3
         9hH3zXeqzkSRHmZqDIXl4k6wcocoCoCiRtuX8ujPEf27zwM8SD8m9jh2FwnVj5K9Rxet
         P1ih/siUiJu36KDqsF29p9Uqn7+BEk0HnGI0qcOO0wBswWbjjM60rwwmvvYBFeH1+5p/
         oIdQ==
X-Gm-Message-State: AOAM532fMrwPZW+Q9vpF0zOXND6qo5Ss7ev9p5+zy3ttLA4OLd+1YTq/
        A5U9UvNJvMeMj4KrCzGhwQJ9tbkmqtZYTw==
X-Google-Smtp-Source: ABdhPJw7n3wp5HWrLoq+MeCXkNMip7J4BSlP7eVGQaxcRu6uzMHNhvx1gorlQGPprrTPkQaYTpkrNQ==
X-Received: by 2002:a05:6512:358d:: with SMTP id m13mr7097554lfr.238.1613329654507;
        Sun, 14 Feb 2021 11:07:34 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id m10sm2309292ljj.127.2021.02.14.11.07.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Feb 2021 11:07:33 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id a22so5253379ljp.10
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 11:07:33 -0800 (PST)
X-Received: by 2002:a05:651c:112:: with SMTP id a18mr7593997ljb.465.1613329653401;
 Sun, 14 Feb 2021 11:07:33 -0800 (PST)
MIME-Version: 1.0
References: <651ac50b9ff6ed3db8cab9f176514900f6a02a0c.1613131413.git.agx@sigxcpu.org>
 <20210213031237.GP219708@shao2-debian> <YClYh7pqDlbXy8qh@bogon.m.sigxcpu.org>
 <6a8eb07f-16d5-f461-cf0b-6c4aaf93b014@ramsayjones.plus.com> <CAHk-=wjCAVj7J+KAC1pvtdeM-c76oXZq7k=v40-maKjTo6qfVw@mail.gmail.com>
In-Reply-To: <CAHk-=wjCAVj7J+KAC1pvtdeM-c76oXZq7k=v40-maKjTo6qfVw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Feb 2021 11:07:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjvoGNnqWQiz3js43fiXf9kcAfCbABaHdz98Q+3-3zg6A@mail.gmail.com>
Message-ID: <CAHk-=wjvoGNnqWQiz3js43fiXf9kcAfCbABaHdz98Q+3-3zg6A@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] usb: typec: tps6598x: Add trace event for status register
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org
Cc:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 14, 2021 at 11:00 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The C89 standard actually says that a string literal can be at most
> 509 characters to be portable. C99 increased it to 4095 characters.
>
> Sparse makes the limit higher, and the limit could easily be expanded
> way past 8kB - but the point is that large string literals are
> actually not guaranteed to be valid C.

Looking around, there's a couple of other similar cases:

  drivers/infiniband/hw/hfi1/./trace_tx.h:727:1: error: too long token expansion
  arch/x86/purgatory/kexec-purgatory.c:1340:9: warning: trying to
concatenate 21400-character string (8191 bytes max)
  drivers/scsi/constants.c:318:9: warning: trying to concatenate
26550-character string (8191 bytes max)
  kernel/trace/trace.c:5290:1: warning: trying to concatenate
10842-character string (8191 bytes max)

but those four are the only ones I see from a quick x86-64 allmodconfig build.

Please try to avoid it.

          Linus
