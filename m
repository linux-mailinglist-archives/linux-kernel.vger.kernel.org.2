Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9AF3FF7B7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 01:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347944AbhIBXTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 19:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbhIBXTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 19:19:16 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0289BC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 16:18:17 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id m28so7858336lfj.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 16:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lRwwSxpq1UQhRHJe2g++efLMW/6jas11c9qi20e9RaA=;
        b=HEDgS0iIyocY0pXYPPxRuZM31kTiCxGuBmZoeWzOrIQdWJItMaAOWh5g3AYJmZFGQ9
         GUU2PEsbrB5aDlLCbXU63/ncoOHPMmT3qqiLbLJtqwM0crfAXznWDKLaT3gMuUiNqyc5
         4KkA+DNF+Rj5li33sR0bVQiwtpg3VPcPrTbBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lRwwSxpq1UQhRHJe2g++efLMW/6jas11c9qi20e9RaA=;
        b=MeI1CobFmswED1kQBcvp37uWh/5CLG896/SQIO3ZZHVyrefQKmZ+M8dIsK0ARP6rdi
         Zytdur2NbVg0l06ef9zV+L4uDhCq/iShASka4ZdUV+tiTfp/3VBayCq9vbnqsPiXQRMx
         dgwW4O2Bc++912/qedbYIfWK1pfIutorA7qlD7GDB6RZingH4Px7Wh5KIWddj4R7+ab4
         oP+xuNijcn2YEqUwa9KcF2fbL3VZVrucjv2DPFhMGt23W8JLw5XZjiI5btF4ZEZB/0uu
         0KUiKWL8o4sejzDHDGPNXwGcw55xSYyhBUagYJwhEQDt8G5bg3YJT5cPuSrH6GM/TsRD
         xtbw==
X-Gm-Message-State: AOAM5333T1ZNOiAXR+TGOHPrGqB3pOBFvjopDPIEAUIfUUw28XZtWDvz
        gyZUG0Pg1cYrH2b/pZMNFXbg4CHseGFz1AWcqiM=
X-Google-Smtp-Source: ABdhPJxG6WAPD/nHKxKrolq+1XiW9OY0TuBX/rWLXB/nz3TkBWoaL+5aAdbBzDfAgnpIT3nQ+qFMsw==
X-Received: by 2002:a05:6512:b27:: with SMTP id w39mr412957lfu.129.1630624695150;
        Thu, 02 Sep 2021 16:18:15 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id h13sm321224lfv.62.2021.09.02.16.18.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 16:18:14 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id y6so6600769lje.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 16:18:14 -0700 (PDT)
X-Received: by 2002:a2e:3004:: with SMTP id w4mr537089ljw.465.1630624694481;
 Thu, 02 Sep 2021 16:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210819093910.55f96720@canb.auug.org.au> <20210903090307.48f05d83@canb.auug.org.au>
In-Reply-To: <20210903090307.48f05d83@canb.auug.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Sep 2021 16:17:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjjbA1tquWx_6S-TQqvf2hMbjuOysHk+J84xyx5nJM3tQ@mail.gmail.com>
Message-ID: <CAHk-=wjjbA1tquWx_6S-TQqvf2hMbjuOysHk+J84xyx5nJM3tQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the overlayfs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 2, 2021 at 4:03 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> This merge fix patch is now needed when the ntfs3 tree is merged with
> Linus' tree.

.. but again, DO NOT APPLY THAT MERGE FIX, because before it is merged
into my tree, it would be wrong and wouldn't even compile.

So just point out this semantic conflict in the pull request.

I'll see it myself when I do the test build, and I'd fix it up even
without that, but this is one of those "make sure everybody is on the
same page" things so that it doesn't fall through the cracks and
everybody knows what to expect.

            Linus
