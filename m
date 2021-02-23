Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1223223CC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 02:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhBWBnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 20:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbhBWBni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 20:43:38 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9902C061786
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 17:42:57 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id v17so177064ljj.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 17:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RDooO6fVmEytrmsO+OdxP0t5z+1dW14dWuhPYDbhrNw=;
        b=TOQ2+I+mHXr+E4ckMqzQngYTWUZIiJAMZ4kPqTle0k554YS65ZycN+V9HItvfQ50zr
         EZoT+MbgL+/zfMBRgcqu5UVoaIVwhD+SMKXUFtegjKSZY4TW2k7+/++d/M+F9xtNPSR4
         QNS7Z4Yl0m5J+4tzYKAjfLF5jYN/rQ/3C6zUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RDooO6fVmEytrmsO+OdxP0t5z+1dW14dWuhPYDbhrNw=;
        b=NwpXCDx7wM12/GiXwdZANsWtONl9rmvpvNqSgiMG0wkk19yuxg8P5KZjfZy9zDUQah
         WmmS9b/q/aHQv11AuBj8JaaTY8VeOedzuyqQOZXHWeeWc90ThD42DHUlWtbK/+YzYIy9
         8A1x+XS31P6tLfOpavX7d3CZMdfhGFnMkpj5GdMtoGq9qk/jOaLjFgpsYUAeeiCilGWd
         7NkKeAoPLcar9ACCCTS6bnrBj44Ph4WKLQMQNT1RsD67GqpPkabj/rrkuaMeS7n/N//a
         ia7ACtj5vIe++E7m7c9pmv67OC517xv72SEXLKolTHgHakili8tmtkciMksIrGlKCxzL
         orbg==
X-Gm-Message-State: AOAM530dTsAjyGEHWj11dNVXUhZ4JOtfHznO4uf5IZ1R5B2O5QFHdbYA
        CgENmEMXJ0jWrji+NyzEPXHZ6hKqPkT39w==
X-Google-Smtp-Source: ABdhPJwmiAGsoUG5jKw3JCe/SJiW8b8VxFaDPRKhx/TlMM2zZmMtYJZDrha26oTyMFZRA+rY7P6i8A==
X-Received: by 2002:a2e:5356:: with SMTP id t22mr15474679ljd.257.1614044575175;
        Mon, 22 Feb 2021 17:42:55 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id o24sm20779lfg.64.2021.02.22.17.42.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 17:42:54 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id v30so8843276lfq.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 17:42:54 -0800 (PST)
X-Received: by 2002:a19:6916:: with SMTP id e22mr14384009lfc.421.1614044573962;
 Mon, 22 Feb 2021 17:42:53 -0800 (PST)
MIME-Version: 1.0
References: <YDOGERvNuU3+2WWe@phenom.ffwll.local> <CAKMK7uHQ=6OJcRguCUtiB456RWdCfwSNEXV8pQsfsPodTJ6uxw@mail.gmail.com>
In-Reply-To: <CAKMK7uHQ=6OJcRguCUtiB456RWdCfwSNEXV8pQsfsPodTJ6uxw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 Feb 2021 17:42:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjNv9izaVO5+1n5zk01zP3mndqdd2zKsX_syq9ntgY2YQ@mail.gmail.com>
Message-ID: <CAHk-=wjNv9izaVO5+1n5zk01zP3mndqdd2zKsX_syq9ntgY2YQ@mail.gmail.com>
Subject: Re: [PULL] fixes around VM_PFNMAP and follow_pfn for 5.12 merge window
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux MM <linux-mm@kvack.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 2:25 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> Cc all the mailing lists ... my usual script crashed and I had to
> hand-roll the email and screwed it up ofc :-/

Oh, and my reply thus also became just a reply to you personally.

So repeating it here, in case somebody has comments about that
access_process_vm() issue.

On Mon, Feb 22, 2021 at 2:23 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> I've stumbled over this for my own learning and then realized there's a
> bunch of races around VM_PFNMAP mappings vs follow pfn.
>
> If you're happy with this [..]

Happy? No. But it seems an improvement.

I did react to some of this: commit 0fb1b1ed7dd9 ("/dev/mem: Only set
filp->f_mapping") talks about _what_ it does, but not so much _why_ it
does it. It doesn't seem to actually matter, and seems almost
incidental (because you've looked at f_mapping and i_mapping just
didn't matter but was adjacent.

And generic_access_phys() remains horrific. Does anything actually use
this outside of the odd magical access_remote_vm() code?

I'm wondering if that code shouldn't just be removed entirely. It's
quite old, I'm not sure it's really relevant. See commit 28b2ee20c7cb
("access_process_vm device memory infrastructure").

I guess you do debug the X server, but still.. Do you actually ever
look at device memory through the debugger? I'd hope that you'd use an
access function and make gdb call it in the context of the debuggee?

Whatever. I've pulled it, and I'm not _unhappy_ with it, but I'd also
not call myself overly giddy and over the moon happy about this code.

             Linus
