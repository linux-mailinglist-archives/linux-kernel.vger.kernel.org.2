Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4A93F6BE8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 00:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhHXWwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 18:52:38 -0400
Received: from mail-ej1-f46.google.com ([209.85.218.46]:39684 "EHLO
        mail-ej1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhHXWwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 18:52:37 -0400
Received: by mail-ej1-f46.google.com with SMTP id a25so20825395ejv.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 15:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hVI/j+d5bNeovTFLYwZefaFwmlRSPhdjz+bgEESnN58=;
        b=gWDnDwL/Ef7G0J+r+0A4qqg0gjgMV99rI0FHtrHRG9oR/gXFG3JbxeL+LvIhEDe1TU
         erC4dWFLmdR9Y5+le+yV5tcaZm12bATbdSILUNr5RIJ7aEvkg+vyr1TtbKfnIQkM0aHK
         4iuxwx0Blmq5gPMucWRAcIYk5ioTRtFsapsRKwsuFGIFBTvot2HFX23FCAmzk5uyhmcu
         56u9iRhZoe3SUU49/TM5huaMeZrEsr/AaXD53K3TjJpxRxjT43qZdQEIoFAkGhEQGgPY
         jZ8DSZ7vD7BO/C7Ho5FWrvfFmMQwJTWk1NQkD9yMpT7L9AX6GEKiOTrON2DuD8u9HGuW
         bM1w==
X-Gm-Message-State: AOAM530lGdDfKNPJHPg2ye46lSvBxN3nNiC+r5v0pbTVU6pOEPRzvwgV
        5/I+pXNrtMJVoCjwU9owlnnKxdplgRWRaJVOvUo=
X-Google-Smtp-Source: ABdhPJymfTzewbNLew04yLbIk4zKhj90mIvEgABcoXcnB+ZodTx/l4jhkK1XyTCBKors5JTXBL73Atg/mksZmkHrro0=
X-Received: by 2002:a17:906:31ca:: with SMTP id f10mr44465528ejf.73.1629845511996;
 Tue, 24 Aug 2021 15:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <3181031.RqgVF4sTRC@tjmaciei-mobl5> <YR1HYRRN0HMTxXrw@zn.tnic>
 <4493449.UzBjrsCbmA@tjmaciei-mobl5> <YR1NAvJW4w8bhEEu@zn.tnic>
In-Reply-To: <YR1NAvJW4w8bhEEu@zn.tnic>
From:   Len Brown <lenb@kernel.org>
Date:   Tue, 24 Aug 2021 18:51:40 -0400
Message-ID: <CAJvTdKnPMjY5iKaz+ch14Syc_=n2+xiTrBEK020XwkHGJQQWJw@mail.gmail.com>
Subject: Re: [PATCH v9 12/26] x86/fpu/xstate: Use feature disable (XFD) to
 protect dynamic user state
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thiago Macieira <thiago.macieira@intel.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 2:09 PM Borislav Petkov <bp@alien8.de> wrote:

> What relevance does the fact have for userspace whether the kernel
> supports XFD or not?

Right.
If user space needs to know that XFD exists, then we have done
something very wrong.

-- 
Len Brown, Intel Open Source Technology Center
