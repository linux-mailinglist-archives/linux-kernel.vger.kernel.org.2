Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B40839FC9C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 18:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbhFHQe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 12:34:56 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54]:41479 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbhFHQez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 12:34:55 -0400
Received: by mail-ej1-f54.google.com with SMTP id ho18so22634680ejc.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 09:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=hWkOGoUtVtV8FzZIYvtLihscdJc/AoYQpTw6WbnU7Nw=;
        b=fXgLcXa2w87ln2btJbQraQXHXiGELYbP5LupPcB7myYKqcu6NVlx4DY99oXDbTa0iJ
         xWS2p9E5JbYbO8VcykZ6r5bOys01zOkyw5TWrisdw9B+B/9yY16jsPg9GSUholD4VE+w
         j3foV8rY7hKomZwvqzakSYHrSXFMOILGi7nzcJ2jk2y/DP12hy2khy1msJhwgJxtRmFG
         k6a6Pwa4QHgkqW8RBS6lIM4t0BtwgcNiIbcqS89dlX6cSOa4NerRNw7ansyBa4Vs6g5w
         9wbNQNn1IbwvEWZvEdhbZzrL4Uu1BCSW+d5BexKdhPEPPc841OL4G/30MX8q/+T0r1ke
         L4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=hWkOGoUtVtV8FzZIYvtLihscdJc/AoYQpTw6WbnU7Nw=;
        b=HWxISAMxtixug9APnQq9XhAKHEtNY5MRnBpG+GmhN5KIHyez+UH19G9B22s/xgP7uB
         VGzN8o75ikV5phicxQMV+pafFr2B3MwB8jx1ehoQjB80634c9nG5hrA9+LN3rDu1XWoB
         J31uGJ1u6eZmSJN9aYHhvbhr4/FHbHJ/WOxHUjDscgYJsYblQoZEcGyC8aKwREkR5a1E
         mnYkyWXgYXpvO+86UXZtCz+yWU05hMgTtvd0rnJZpbPtZX+fAEhvPGIJ6Zz+p2oauCZu
         wwx0s2ILR7XpEf6OuT+kVOeV9YXw8kM4lLJQXZmSYygKh51h9M8urADZtidTgSAGjx3f
         Ly3Q==
X-Gm-Message-State: AOAM531I9qLsPiF90z7mkT7ePWO+TeO5yOUiMwALT9Gw5qINSni/zyrq
        60E0v6IaiQI/qciEjqxlRmBYsHrv13n/0g==
X-Google-Smtp-Source: ABdhPJyCZUGjO10/Bh4SU9DcJaQK7Cdfy2yI2+cY/S03tVpAXjPIk8DZNa2Xy1DPy2Uof56jdAKN9g==
X-Received: by 2002:a17:906:1704:: with SMTP id c4mr11389765eje.182.1623169921329;
        Tue, 08 Jun 2021 09:32:01 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id s18sm94847ejh.12.2021.06.08.09.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 09:32:00 -0700 (PDT)
References: <20210429083823.59546-1-jbrunet@baylibre.com>
 <162008674673.40672.14279142646066453043.b4-ty@baylibre.com>
 <CAMuHMdVhrMNzuXkD9BQxPaiwS41bsOyJU_kwGYwk5ftto-AGBQ@mail.gmail.com>
User-agent: mu4e 1.4.15; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH RESEND] arm64: meson: select COMMON_CLK
In-reply-to: <CAMuHMdVhrMNzuXkD9BQxPaiwS41bsOyJU_kwGYwk5ftto-AGBQ@mail.gmail.com>
Message-ID: <1jczsw1fnj.fsf@starbuckisacylon.baylibre.com>
Date:   Tue, 08 Jun 2021 18:32:00 +0200
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 08 Jun 2021 at 11:52, Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Jerome,
>
> On Tue, May 4, 2021 at 2:06 AM Kevin Hilman <khilman@baylibre.com> wrote:
>> On Thu, 29 Apr 2021 10:38:23 +0200, Jerome Brunet wrote:
>> > This fix the recent removal of clock drivers selection.
>> > While it is not necessary to select the clock drivers themselves, we need
>> > to select a proper implementation of the clock API, which for the meson, is
>> > CCF
>>
>> Applied, thanks!
>>
>> [1/1] arm64: meson: select COMMON_CLK
>>       commit: aea7a80ad5effd48f44a7a08c3903168be038a43
>>
>> Best regards,
>> --
>> Kevin Hilman <khilman@baylibre.com>
>
> Why is this needed, and why would this make any difference?
> COMMON_CLK is always enabled on arm64, as the main ARM64 symbol in
> arch/arm64/Kconfig selects it.

Ah indeed. Shortly after commit ba66a25536dd was merged I remember I had
problem with COMMON_CLK (or any other clock implementation) being
selected. TBH, I don't remember it exactly ...

For sure this was a mistake.
Neil, can you still drop it and do you need a revert ?

>
> Gr{oetje,eeting}s,
>
>                         Geert

