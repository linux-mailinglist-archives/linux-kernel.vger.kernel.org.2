Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F473BF006
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 21:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhGGTIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 15:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhGGTIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 15:08:34 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02511C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 12:05:53 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id u18so6748939lff.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 12:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EXPbH/M4GYoZ6FhrrR5MYlyYSD6/NgfgonH38mq87Gc=;
        b=KU426vk0FJciJbxXpjIi+w7PbOZYM3CgwOJXR+Ek7FnEKtgID/4F2U161uPJT3xVVT
         lZ1ZxdgXTYAQYkqWO1y6TlgNYgmsQnvcVY+UCj3RJhKHOyU1CKfl1VYJslwJjECWB1xW
         BLYFXnOx82VFpwgKnloCd733FB6T6jcMY3lJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EXPbH/M4GYoZ6FhrrR5MYlyYSD6/NgfgonH38mq87Gc=;
        b=NpijqXN/4eyMU3MSjDaEAvHtYpSGt/1x0wA1mIBZasd9uk0z9CskCcY/wlO9U77K5d
         Tbjm+sa1Z2GOP2V8w2fa9rPoVC7s2bLCKTNJ8wLQMEqj7l55hPKyKCnskWalFGUbIKkQ
         dEBBkqUNW3ZGm5+DhYyuwhFsB8dYM8VJbHEF5q4WySeu9WljSG4selYKLS4AavFlORQL
         7URoDvkJdaFtS4F+2hTOJM3icx10OEVnoNZEhbopjEfrftQ2FQmjeqp7dQbAdlWuQH+P
         uv3q9hOpVSWDBodQeqwo+P1zn2Y1BOsDaTxlh1AMvFmcEIEglBFRYH/hCJarRsSsceut
         E2HA==
X-Gm-Message-State: AOAM530ZZNfCPCwSYYl8dwlUbYjvsIwT5kG6WhEwZ61OAZKZT0DQr1ux
        eIlORrhHd5U5WyEqdkRheqR/1aDkYGJFRXVdNVk=
X-Google-Smtp-Source: ABdhPJwMXMF2wptiqlMsi3ILL0s27VQKPGVaxj1nP+bAoKJbJjGbULMKbqn4MiLk8lo3VTti32xu2w==
X-Received: by 2002:a05:6512:c13:: with SMTP id z19mr18686090lfu.616.1625684751173;
        Wed, 07 Jul 2021 12:05:51 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id o7sm1786111lfo.196.2021.07.07.12.05.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 12:05:50 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id a18so6706601lfs.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 12:05:50 -0700 (PDT)
X-Received: by 2002:a2e:9f11:: with SMTP id u17mr19734994ljk.48.1625684750030;
 Wed, 07 Jul 2021 12:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210704150025.GC21572@xsang-OptiPlex-9020> <20210705125756.GA25141@lst.de>
 <CAHk-=wj_Gfqkdp+K3iCiqMjAZQK_BrRWDs2eOS_BAw=bB=CdRw@mail.gmail.com>
 <20210706143647.GA28289@lst.de> <CAHk-=wgPyx7tHFNaO2N6bsaB_E6gL+t1uDAmrD91jJw+hiTvrQ@mail.gmail.com>
 <20210707081220.GA31179@lst.de> <20210707083528.GA353@lst.de>
In-Reply-To: <20210707083528.GA353@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 7 Jul 2021 12:05:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgEM5VcCEtOyCqLnWAXdAumqnAR077Nv5Q_eG+ZDd+owA@mail.gmail.com>
Message-ID: <CAHk-=wgEM5VcCEtOyCqLnWAXdAumqnAR077Nv5Q_eG+ZDd+owA@mail.gmail.com>
Subject: Re: [ide] b7fb14d3ac: EIP:ioread32_rep
To:     Christoph Hellwig <hch@lst.de>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 7, 2021 at 1:35 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Actually, not it doesn't. Sorry.  So for a non-aligned large request
> this won't work.  So we'll need to actually loop here.
>
> This is probably better and fixes the issue as well (and ATAPI
> probably needs the same treatment):

Thanks, this looks sane and correct to me.

But please do add a comment (or perhaps even better - an actual check)
that the offset is at least 4-byte aligned. Because this splitting of
the buffer at page boundaries can only work if you still have at least
that 32-bit alignment.

At least that's the case for ata_sff_data_xfer32() (which was what
triggered that original oops). I did not really check the other
data_xfer functions, although I did look at a couple of them. At least
vlb32_data_xfer() has the exact same issue.

A couple of others would be ok with just 16-byte aligned splits. But I
*hope* nobody needs more than 32-bit alignment (and considering the
legacy status of this model, I'd be surprised if they need more, but
who knows..).

              Linus
