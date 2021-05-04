Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A17372D7E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 18:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbhEDQCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 12:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbhEDQCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 12:02:48 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44050C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 09:01:53 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 124so14074046lff.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 09:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=no60eDnpfNleIZIVM2PSWGEJXhTZf1BPjAHhf33fLWw=;
        b=WAtHHtFdlNK0dHhR7WnzAGrSC2T8+LbSppqHZk9dwSH91MQIfIl2zAmMz4k9EsIJAg
         HUh8r2P+JQ5esL4VsT5P1+K7HziSM/E5GS4AIlyAvcQ++alrUMCk3ZbsnmBrMQ0xSq0/
         OPToIUNgRx5UqBo1pub8p4h2Yhf0zTWh4/oac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=no60eDnpfNleIZIVM2PSWGEJXhTZf1BPjAHhf33fLWw=;
        b=LQB1a0+O+FsOKcyEF51kUIPWLY06W/pL0RlB+x5KwqWnrbzPt+AC8SywZ1KemTosQs
         7+ecCM/TWg74Tfq6tBN7wjZQs327OBD49D8c9Zk/6nwy++/cY9aXnBPTr8DNKgz29FaL
         QTpjSI6TJgWW4qL5NSXVNO1pxC9+7+Q9fLKVNR0j3pYl/EHtOuslwukDxIN9WMjwHvZX
         2I4TWbX2fJrGusWdkbNjged80PzZxp9gzhWEG77ABWz08WZrLiN49F8YjNdwgDA7/Iun
         hH7rub/J5/MHqjS44Pl8gcBhRHEZPU+jVZEi9NceOd97mLSzU03/Dr5mcSsKOLIGLZHQ
         2LSA==
X-Gm-Message-State: AOAM532mlrH66hbDYD6CCpC26SwvDm9a8a6LqdKspVfqy6ywd/G/2N99
        sfJ6OnKYbchG8gEGmD8CPR7STkXiA/ilctxr
X-Google-Smtp-Source: ABdhPJwVkbWP1l4MN7LrZHqLDXOPz/i+Rw/sRwltqV2oKvOsa/3Uw9JfaIoEt0i/5zKA6SP3+o3qHA==
X-Received: by 2002:a05:6512:3d02:: with SMTP id d2mr12553470lfv.535.1620144111534;
        Tue, 04 May 2021 09:01:51 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id b6sm301069lff.15.2021.05.04.09.01.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 09:01:50 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id e12so9488413ljn.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 09:01:50 -0700 (PDT)
X-Received: by 2002:a2e:954a:: with SMTP id t10mr17512244ljh.411.1620144109697;
 Tue, 04 May 2021 09:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <YIqFcHj3O2t+JJak@kroah.com> <20210504115358.20741-1-arek_koz@o2.pl>
In-Reply-To: <20210504115358.20741-1-arek_koz@o2.pl>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 May 2021 09:01:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=whEjY7eOqPg2Ndw=iM2Mih0BC9LVyX9c6Uc_W=wmwnkkA@mail.gmail.com>
Message-ID: <CAHk-=whEjY7eOqPg2Ndw=iM2Mih0BC9LVyX9c6Uc_W=wmwnkkA@mail.gmail.com>
Subject: Re: [PATCH v3] proc: Use seq_read_iter for /proc/*/maps
To:     "Arkadiusz Kozdra (Arusekk)" <arek_koz@o2.pl>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 4, 2021 at 4:56 AM Arkadiusz Kozdra (Arusekk)
<arek_koz@o2.pl> wrote:
>
> Some executable-inspecting tools (e.g. pwntools) rely on patching entry
> point instructions with minimal machine code that uses sendfile to read
> /proc/self/maps to stdout.  The sendfile call allows them to do it
> without excessive allocations, which would change the mappings, and
> therefore distort the information.

So this was kind of what I was expecting.

The only reason to do this is basically for nefarious purposes, and
it's one of the reasons I didn't feel like doing splice() on
everything should be encouraged.

Yes, yes, I'm sure pwntools can be used by white hats, but honestly,
that seems to be an almost secondary purpose.

Why should the kernel _encourage_ and make it easy to do things like
this? What are the actual advantages for us to do this?

                 Linus
