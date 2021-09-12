Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5D3407FC6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 21:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbhILTpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 15:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235890AbhILTph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 15:45:37 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14875C061574
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 12:44:23 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id lb1-20020a17090b4a4100b001993f863df2so4166635pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 12:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cjrGfbCCXgj4Wc/G1fowZlZbCSmG0mcMrQQoZTcITfs=;
        b=ByLnh54QzarpxH/tZXgIp0WopoT2YvZImZpxLlO2DvffPPCwPZaHkabXsuD+rQCR/c
         tWnczCn0nj3xRLill5rZg+Q/uJZ17EryrI+vVpM2vmwZGltq2qfRK46smIAZK8PfA2NE
         WI9AYWzEXyuAgX9fvV1fH/2IdN/zu7uu32FDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cjrGfbCCXgj4Wc/G1fowZlZbCSmG0mcMrQQoZTcITfs=;
        b=6pT2ML5FNvuGecKmYJ0PyhHGUCduBTH/TzmI6efcdEbnlem5WDpe037/dsZnXIH8Mn
         ODNRwTs/+/MAyuHIjJktxLwim4itnd2BKWzr1NneOTk6EIL+wyBaLkQwRQ93F95g9Eph
         jdrG+d2+II+AbGo2aHcgXe2iN/wfuxe2fNsBRMx7IXE33y9rrM1zkboucNXOmo3wSIvH
         RZckneRviD6BSG7fAl24sFEpIFmu75STvMKaHVDo2aXu+sogwdk+ix486Ym/cTP6wdSV
         z5RMCltscliAbmdU41P/wiA1o57+F6/ELW/SZFWR85o6Sevjho6WidXMX7/URW/laBfF
         o8ew==
X-Gm-Message-State: AOAM532tOs290hfE6UTNZWJdoJppXa1kRJ0RIaZboKJvmoZgKueqsVs3
        a8IvAaNy/sa3GCAjsjGPA1NNoA==
X-Google-Smtp-Source: ABdhPJzJmalT7AzuucS3CYjH5wUeO5HR0YInRZco5YhxbVillxfttpBMnaHLRER0snif8fKAWtsx6g==
X-Received: by 2002:a17:90a:da02:: with SMTP id e2mr9063549pjv.89.1631475862585;
        Sun, 12 Sep 2021 12:44:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h5sm4659263pfr.134.2021.09.12.12.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 12:44:21 -0700 (PDT)
Date:   Sun, 12 Sep 2021 12:44:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Misc driver fix for 5.15-rc1
Message-ID: <202109121236.4C17E6B00B@keescook>
References: <YT4IvKLQHm9mfpR+@kroah.com>
 <CAHk-=wh7FYyewcJkozsjA95yj0AYvmpMDoZd0RxQ3ZbMMdXUdQ@mail.gmail.com>
 <202109121213.A47D575@keescook>
 <CAHk-=wiVEEzLPLTkb9U6YB-2qXpbuqP3a1q=gRx8Nkg-dpLeqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiVEEzLPLTkb9U6YB-2qXpbuqP3a1q=gRx8Nkg-dpLeqw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2021 at 12:22:39PM -0700, Linus Torvalds wrote:
> On Sun, Sep 12, 2021 at 12:17 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > This was done to deal with the various mangling of reports (i.e.
> > "summaries") I've been getting from CI systems that run LKDTM.
> 
> .. and what makes LKDTM so special?
> 
> IOW, what about ALL THE OTHER REPORTS?

I'm not sure I consider it "special", but since it reports hints about the
build/test configuration combinations (i.e. "this test failed probably
because CONFIG_FOO is missing"), it seemed trivial to also include the
specifics of the version and arch.

> And no, my argument is most definitely not "ok, everything should do this".

Right, I completely understand that. If you really want it gone, I
will rip it out; it'll just make it more time consuming to analyze some
CI reports.

> It's the reverse. The CI systems should be the ones that are fixed,
> not random messages from random places in the kernel have version
> information added.

Completely agreed, and I've been _also_ been spending my time sending
patches[1] to CI tooling too, trying to solve this from both sides. But
not all CIs have the source for their machinery open for patching. :(

-Kees

[1] https://github.com/Linaro/test-definitions/commit/8bd338bbcfa5a03efcf1d12e25b5d341d5a29cbc

-- 
Kees Cook
