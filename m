Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEFE3B690E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 21:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236561AbhF1TaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 15:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbhF1TaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 15:30:10 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AF4C061760
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 12:27:43 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id d16so34564310lfn.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 12:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xwr2D89QU7E+0IXi4VU3X3MD6EsCQWd7tnEnNMHxJlo=;
        b=LvUAnTsGW5X/crAwv/8tMFrYE7g+lmwHbXnj3MVQ/4mCivYnfcOUpcmFcB9YhrqosN
         nh2vU24qY524pzifVlJLe3Y+eHtVxPt01xRum8Sf48OyNsX3+6BpUULxQiTciMny7yvH
         T7aiXmusLjRHYGqPfD0+tS6utaBlCzlgNtxfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xwr2D89QU7E+0IXi4VU3X3MD6EsCQWd7tnEnNMHxJlo=;
        b=QSHDN8YX06c8mJiwZjR5zzhWRljBgTJ0uZLT2xBUP5iYYIniUhV+UexhHX5Vw30cGh
         DJhCIJSvW9JoJLCdvnAOXAbd6E6chSOomyVoCRBXQfJTltaCcoB8zV2Ir/WDfBZsuA6v
         dGkU+YA5heKJMQ7ZfkwsFbpif9r4fRiDDQROujLR9fkFp81YTWLolW2TNI7ePIiBUstI
         qWATdf1j+bKhu9BcrFUawTKhGysjz0QfVTAlnoMekMpb3gQB/1StOMl0hg2w1m8bjVDw
         qj/p9bW3+9p+npgH8DtBq3aubz6AUu+rv/DWMJkmacugnS0ca89AOsSu96KCMbo7h0h9
         qO0Q==
X-Gm-Message-State: AOAM530R4TyAXbLIorfUAHfgvnYzSexlUqJflHJwNTw9UtmnE58vGspN
        bF/tyR7WH0uZPg39KtHm45C/Xj1MgBLTN6S0
X-Google-Smtp-Source: ABdhPJxQ7MrZBEKweuf2d2MgGXTB+8Zc5f7LPiKBPIx3+HIf/KNRuQ5SLZKHZEKFdk7ULaT/NPF+8w==
X-Received: by 2002:a19:7d04:: with SMTP id y4mr19386503lfc.201.1624908460783;
        Mon, 28 Jun 2021 12:27:40 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id t19sm1396433lfl.301.2021.06.28.12.27.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 12:27:40 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id h6so11118031ljl.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 12:27:40 -0700 (PDT)
X-Received: by 2002:a05:651c:32e:: with SMTP id b14mr718622ljp.251.1624908459910;
 Mon, 28 Jun 2021 12:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210623135600.n343aglmvu272fsg@kernel.org> <CAHk-=whhEf=xJz=rdcLWNnRU1uR6Ft-mn6xNrOg3OcQ=5cX6BQ@mail.gmail.com>
 <8de9d45e-4389-8316-b0d0-e9a43be9fade@linux.ibm.com> <CAHk-=wibQ3ahmo0m3BynA3bw2Fkhv0OfMJuV0+wEMwg93Fbj0g@mail.gmail.com>
 <d3fd4b64-be6a-2210-5cfa-fc1947aea293@linux.ibm.com>
In-Reply-To: <d3fd4b64-be6a-2210-5cfa-fc1947aea293@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Jun 2021 12:27:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgQJESJ-q-4FNgwpTJTZrEr033gzpXM2gWWviVOHJNnaQ@mail.gmail.com>
Message-ID: <CAHk-=wgQJESJ-q-4FNgwpTJTZrEr033gzpXM2gWWviVOHJNnaQ@mail.gmail.com>
Subject: Re: [GIT PULL] TPM DEVICE DRIVER changes for v5.14
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        James Morris James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 12:21 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
>
> Correct, and the code (certs/Makefile) is surrounded by the check for
> this particular file here, so it won't touch anything else:

Ahh, I missed that part.

Can we just make it really really obvious, and not use
CONFIG_MODULE_SIG_KEY at all, then?

IOW, make these literally be about "certs/signing_key.pem" and nothing
else, so that when people grep for this, or look at the Makefile, they
don't fall into that trap I fell into?

That also would make it obvious that there are no pathname quoting issues etc.

             Linus
