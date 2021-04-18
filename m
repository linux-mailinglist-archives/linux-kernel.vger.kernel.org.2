Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC7C3632F7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 03:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236784AbhDRBj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 21:39:29 -0400
Received: from mx5.ucr.edu ([138.23.62.67]:60631 "EHLO mx5.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230339AbhDRBj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 21:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1618709941; x=1650245941;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc;
  bh=6CEFV76gW6g3N8oapt+HAqwgsAOXSLMXTf8g5Tcasak=;
  b=DmXBvYZrHfkypWIWQxPcn+UwBSCu/J4BQ2ZMdUJCt4fjJl28F1+47yq4
   Att5JgoldD6ZUs/cN17GBzIb1KpVg2V66ZZl7XjkUM/AFAH9fOxvZNVvm
   R6RXQM4ARzATItGiUtDC/ZqFk3P6JbXpg5ZehbizzvGDEZALgM4LQgJP4
   +dyO2NCMwKKQbUEuSdBgc9ZCAZQt7TY2cS3XJis3fFh50/ekO5FvMC6xG
   XBbukzbGdRXt16e8JGSNUjmtI025soqEQaTYZUqo3P7PZ9wuS77mB4In1
   IZ1ipNw/ELFYp5Xo+NVjKfkOQaJ+nWeoEjQsWQkuPZ4qOI4XsQLtM23nt
   A==;
IronPort-SDR: jHkvmK5CLxXFe4fQVdQKrW9FZOSp51iYC0wnTthtuPt3NZnp4OSIn99VPBCNLvtI/mJOYi4APf
 5KSLpc0cMd43Fxo/3Bh0WP4drLawli1qjoJoz67H4giEm8xiP3A6vftBz2S+nbCUSrZpboWskz
 Se95+JzoQWuAzDXgPokVG/UcOjKA5gqSCyrEPjCuiLrMWavhJKLsmFgAEby4rn7uAQkGXKsCW1
 P93x3fHHh8qb4TeIrQdBQar/8IhtjmUs5bfCioG3yvLOQirBFeh0eJcAnru7u9EpZ4jubZcKZC
 JFc=
X-IPAS-Result: =?us-ascii?q?A2ECAABZjXtgf0WmVdFaGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgT4EAQEBAQELAYN3a4RDiCSJTwOaa4F8AgkBAQEPN?=
 =?us-ascii?q?AQBAYRQAoF0AiU0CQ4CAwEBAQMCAwEBAQEBBgEBAQEBAQUEAQECEAEBboUXR?=
 =?us-ascii?q?oI4KQGDbAEBAQMSEVYQCwsDCgICJgICIhIBBQEcBhMbB4VXBZ1igQQ9izGBM?=
 =?us-ascii?q?oEBiBsBCQ2BRBJ+KgGHAoQogiongieBSYFsgQA+h1mCYQSBZX2BNgmBJEAtA?=
 =?us-ascii?q?YEYAQEBknUBimKcLAEGAoJ1GZ0MI6UCuHEQI4ExghQzGiVOMQZngUtQGQ5Wn?=
 =?us-ascii?q?DYkLzgCBgoBAQMJjQ8BAQ?=
IronPort-PHdr: A9a23:scn7LBF0wl+Uxr/JfidyVJ1GfzFMhN3EVjU92t8ck7tLN56b1NHcB
 iT32/xhgRfzUJnB7Loc0qyK6vGmAD1fqs/Z+Fk5M7V0HycfjssXmwFySOWkMmbcaMDQUiohA
 c5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFRrwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/I
 AiyoAnLq8UbhYlvJqksxhfVv3BFZ/lYyWR0KFyJgh3y/N2w/Jlt8yRRv/Iu6ctNWrjkcqo7U
 LJVEi0oP3g668P3uxbDSxCP5mYHXWUNjhVIGQnF4wrkUZr3ryD3q/By2CiePc3xULA0RTGv5
 LplRRP0lCsKMSMy/XrJgcJskq1UvBOhpwR+w4HKZoGVKOF+db7Zcd8DWGZNQtpdWylHD4ihb
 YUAEvABMP5XoInzpVQArRWwCwqxCu3x1jBFnWP20bEg3ug9DQ3KwA4tEtQTu3rUttX1M6ISX
 PiwwqbWzTTDcu5d1zDn54jObxsspvKMXbdqfsrX1UUjCx7Jg06NqYP5JTOZzPoCvHWG7+d5U
 ++klmEopR1rrDe12scslpfGhpgTyl3c6Ch03YU4KcOmREJnfdKqHphduiKVOodrQs0vX25lt
 ignx7EYp5O2cygHxIkkyhPQd/CKcpaE7Bz/WOqPPzt1gHRoc6+8iRaq6UWs1PHwW82u3FtJr
 idJiMTAu3EM2hDJ68WKTv1w9Vq71zmVzQDc8ORELFgxlarcNpEu3KY9loEWsUTfBi/2n1j2j
 LOOekUk5Oeo7+Pnb63jppCGNo90jhjyMqUpmsCiGOg4PAkDUmyB9eSz073j+kL5QLFUgfEsj
 qbZt5XaKdwapq6/HQBVzp4u5wijAzqiytgVnnkKIEhYdB+GjoXlIVDDLfTgAfe6mVuskTNrx
 /7cPr3mB5XANnvDkLL7crZ790JQ1Bc/wMtC551IELENOuz8VVLstNDAFB82LxS0w/r7CNV6z
 o4eXWOPAqmEMKLdqFOI5fwgI/OKZIALvDbwMOYl5/Hwgn8jg1Mdfrem3YERaH+mGvRqOUKZY
 WDjgoRJLWBfmwMiUKTBj0eLVTpULyK0Ur4w6y9+DIO9Ea/GT5yxi7ub1SO/GdtdYWUQWX6WF
 nK9VIiVRr8pYSTadsxkmzpcDeGJVoQ7kxyiqVmpmPJcMuPI93hA5trY399v6riWzElqnQE=
IronPort-HdrOrdr: A9a23:G3L3TaHHeWouq1/spLqETMeALOonbusQ8zAX/mp6ICYlC/Cwvc
 aogfgdyFvImC8cMUtQ4eyoFaGcTRrnhPtIyKYLO7PKZniFhEKJK8VY4ZLm03ncHUTFh41g/I
 NBV4Q7N9HqF1h9iq/BgTWQN9o72tGI/OSJqI7lvhNQZDpnYa1h8At1YzzzeiZLbTJLCpYjGJ
 2X6tAvnVqdUE4KZce2DGRtZZmlm/T3kvvdEHg7Li9ixg3LqT+z8rb1H1yjwx8CX1p0rIsKwC
 zqlQr246nmntOa7lvn12HV54lLg9eJ8LF+Lf3JpM4SJDDhzjyteZ0kYbufpzo4ydvB1H8a1O
 LBqRshIMh/gkm8EF2InQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.82,230,1613462400"; 
   d="scan'208";a="206742990"
Received: from mail-io1-f69.google.com ([209.85.166.69])
  by smtpmx5.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Apr 2021 18:39:00 -0700
Received: by mail-io1-f69.google.com with SMTP id y15-20020a5d9b0f0000b02903e840cb5f09so7040597ion.12
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 18:39:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6CEFV76gW6g3N8oapt+HAqwgsAOXSLMXTf8g5Tcasak=;
        b=PWSGz2fUhnPcV8JrSYE3LtWs5jXElkGtQ9wY9y9rfslGtDmRPONljsDCOnSfn2EjGI
         2FHIo53IGF3hXaj+/+K1e+Lm7MwItE1C/jjuRzz5y0ANBLaG5u+WnXuy8HhO4G26t6a2
         pkFj6y+VJqFyAVlDDa+HacDO65prnXBl4HdHBEAAqIq4MOb49Pro60nfIEviufPEnRHI
         /izSYjYb6M5d5Da2+iEvaYVBd0kRmAZkhQQn6VXe6PogI2cWBdEbDj9eeMOSEu7oJ/UJ
         +i3TmbCMcnmCCkkF7XdzEbah1SqJKOamTkhxFoIVzHqXrIPKTVhbdweaeHCCEQE3KtXi
         bXgQ==
X-Gm-Message-State: AOAM532yat/sLm6sJpYPgkY8qNsGGQ9BlMr9+DwKbXq9yMfgLNRZy+1G
        +5EjmtJYFPCmBIKsCuXrW3Zg1R4nTo/ynkAVfBQDUo/fxLVitP0W5ttrVVnmNQV1aKWG+xW58Ns
        sObYdc3Sng4pP6+Pzrnhrf3ZyvGWtxU1zHtMpk0pqSw==
X-Received: by 2002:a05:6e02:4d0:: with SMTP id f16mr12628134ils.80.1618709939437;
        Sat, 17 Apr 2021 18:38:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOhw3R6ftLLuz7G0wN5MrRyWOm92ed5tQMKUHJNJFIY2JII8+iXinEexXpHW/qP0iUtsWV5ytSuzxmYX2D/xM=
X-Received: by 2002:a05:6e02:4d0:: with SMTP id f16mr12628118ils.80.1618709939197;
 Sat, 17 Apr 2021 18:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <02917697-4CE2-4BBE-BF47-31F58BC89025@hxcore.ol>
 <52098fa9-2feb-08ae-c24f-1e696076c3b9@gmail.com> <CANn89iL_V0WbeA-Zr29cLSp9pCsthkX9ze4W46gx=8-UeK2qMg@mail.gmail.com>
 <20210417072744.GB14109@1wt.eu> <CAMqUL6bkp2Dy3AMFZeNLjE1f-sAwnuBWpXH_FSYTSh8=Ac3RKg@mail.gmail.com>
 <20210417075030.GA14265@1wt.eu> <c6467c1c-54f5-8681-6e7d-aa1d9fc2ff32@bluematt.me>
In-Reply-To: <c6467c1c-54f5-8681-6e7d-aa1d9fc2ff32@bluematt.me>
From:   Keyu Man <kman001@ucr.edu>
Date:   Sat, 17 Apr 2021 18:38:48 -0700
Message-ID: <CAMqUL6bAVE9p=XEnH4HdBmBfThaY3FDosqyr8yrQo6N_9+Jf3w@mail.gmail.com>
Subject: Re: PROBLEM: DoS Attack on Fragment Cache
To:     Matt Corallo <netdev-list@mattcorallo.com>
Cc:     Willy Tarreau <w@1wt.eu>, Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@gmail.com>,
        Florian Westphal <fw@strlen.de>, davem@davemloft.net,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhiyun Qian <zhiyunq@cs.ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Willy's words make sense to me and I agree that the existing fragments
should be evicted when the new one comes in and the cache is full.
Though the attacker can still leverage this to flush the victim's
cache, as mentioned previously, since fragments are likely to be
assembled in a very short time, it would be hard to launch the
attack(evicting the legit fragment before it's assembled requires a
large packet sending rate). And this seems better than the existing
solution (drop all incoming fragments when full).

Keyu

On Sat, Apr 17, 2021 at 6:30 PM Matt Corallo
<netdev-list@mattcorallo.com> wrote:
>
> See-also "[PATCH] Reduce IP_FRAG_TIME fragment-reassembly timeout to 1s, from 30s" (and the two resends of it) - given
> the size of the default cache (4MB) and the time that it takes before we flush the cache (30 seconds) you only need
> about 1Mbps of fragments to hit this issue. While DoS attacks are concerning, its also incredibly practical (and I do)
> hit this issue in normal non-adversarial conditions.
>
> Matt
>
> On 4/17/21 03:50, Willy Tarreau wrote:
> > On Sat, Apr 17, 2021 at 12:42:39AM -0700, Keyu Man wrote:
> >> How about at least allow the existing queue to finish? Currently a tiny new
> >> fragment would potentially invalid all previous fragments by letting them
> >> timeout without allowing the fragments to come in to finish the assembly.
> >
> > Because this is exactly the principle of how attacks are built: reserve
> > resources claiming that you'll send everything so that others can't make
> > use of the resources that are reserved to you. The best solution precisely
> > is *not* to wait for anyone to finish, hence *not* to reserve valuable
> > resources that are unusuable by others.
> >
> > Willy
> >
