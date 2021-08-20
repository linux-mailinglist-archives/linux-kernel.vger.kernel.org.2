Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C912D3F2AB7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 13:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238127AbhHTLG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 07:06:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239103AbhHTLGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 07:06:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 149066112E
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 11:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629457548;
        bh=93eDDVmo7/1PdbxeFVFln8RV7Masm60GWsbwTyJrWE4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l9mj867jcXGyl8YmI/JQalL2nqsKtf0VI1MCwO0kMoHFFdHTiEU0ZvUTNME0uZq4J
         UHORpiTc6WLTBXsX+Skfp/KAERiqhT8BPDBklUSpTBVr4uATlZK9XhdbnycsyEG9od
         jLJE2nY8XnjZxI50hk7djqhuTFN5SHihHrmRoyNOtCzCXl5EE38ytVPg+jcPeD1FuK
         2GW0XY/S3EIlH1OhvTLAdjU/qsSjjomHJSThemI9pu/2SEr1D3DV6gI73LuKJbHKYV
         8LwIqJsnJqXssqjrYN9/W1XJLEBd7KtYxIKVbdsKV8oNPr/OziX/npYzJJVtXynmoy
         4gCaoJVr/Ur1g==
Received: by mail-wm1-f54.google.com with SMTP id 79-20020a1c0452000000b002e6cf79e572so8847559wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 04:05:48 -0700 (PDT)
X-Gm-Message-State: AOAM531tiGBoe3+9CO6T2doTQvCXle7mosrmjK0Lz5EEKsA9zu79ukQ1
        8slbQQbf6NWTw8iYzHRgwh59I0hABY3xNov8aww=
X-Google-Smtp-Source: ABdhPJw/Fmdx4V5oM8TPAaI8lv4bPHVFz9Z8FqA6zeqy/S1H3h/SHE/F5YKwQN0xO3r6abulLxCEpmtDLhKzo7u+UC8=
X-Received: by 2002:a1c:6a18:: with SMTP id f24mr3321070wmc.142.1629457546734;
 Fri, 20 Aug 2021 04:05:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210709115311.3424912-1-hch@lst.de> <20210817052003.GA4595@lst.de>
In-Reply-To: <20210817052003.GA4595@lst.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 20 Aug 2021 13:05:30 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3rtL5t65GQOEP5XdfsaEOZP=PpiZM9hjYkO=jC6oOptA@mail.gmail.com>
Message-ID: <CAK8P3a3rtL5t65GQOEP5XdfsaEOZP=PpiZM9hjYkO=jC6oOptA@mail.gmail.com>
Subject: Re: remove set_fs() for h8300
To:     Christoph Hellwig <hch@lst.de>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 7:21 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Jul 09, 2021 at 01:53:09PM +0200, Christoph Hellwig wrote:
> > Hi all,
> >
> > this series removes support for the deprecated set_fs address space
> > override on h8300.  Because h8300 doesn't actually have different
> > address spaces to start with as a pure nommu port the changes are
> > pretty simple.
> >
> > Compile tested only.
>
> Any comments?

It took me a while to figure out that this works on architectures that
define CONFIG_UACCESS_MEMCPY, as they get the asm-generic
version of get_kernel_nofault(). Maybe add that to the changelog,
plus my

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Do you have more of these? I'm happy to take them through the
asm-generic tree, at least for architectures with no response from
the maintainers (not m68k, which looks too complex). I did partial
patches for sh and sparc at some point to remove the set_fs() callers,
but got stuck when I tried doing ia64 and didn't submit any of these.

      Arnd
