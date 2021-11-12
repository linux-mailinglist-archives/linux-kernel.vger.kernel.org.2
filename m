Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43AA44EDFD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 21:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbhKLUoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 15:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbhKLUn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 15:43:59 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C3EC061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 12:41:08 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id x15so42580473edv.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 12:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JBexy6By+IDrzYml2cSyJQNCDSqFJvGVfsO9tJKX2J4=;
        b=QY4qjhwn6x99z5bLD7KOzzqVb482QKLVZEWjKWbjrjJ73xK2C7ymYChU64S/Vfp18k
         E1xju4Vpr2u35t3AKPcfSVAEEFcGXXJXQSFZxmVDcOymATTxpZi8WUji3/a/dmzEOpcW
         CPliAFfPd79penhQcta8OGxw76X9/4DtTttbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JBexy6By+IDrzYml2cSyJQNCDSqFJvGVfsO9tJKX2J4=;
        b=Ubx+KRu1EEDtlHiKV+xo6aKeioYCF5ktu8s1AAc5sD/sr/XvcIXLGajkKugUenIOBn
         t7vpjHmwlBQRyv+8voudIWBD9p47JUvtakJDsY+YdTvd0L9lhq96idPc7Q/FvBCNR/7h
         V8N1CSpsD5Ru0wKrkyC7oO292yuPFefsXZG3h5DLrzFgebVjq0+zF5CHELCILZq8pj6I
         cGJ2P8boWZocy06Uzf2q3p5OcpBcjFShYn+pS7WNPKQARBWtbydBIoB4qHFzSxmVUgSS
         +sjcaHRyLfPLS/PHtXcJrhMJs8++tyPqKHj00iwmgnc50j6/dr93eaCy8GuAIAMLKROI
         qyxQ==
X-Gm-Message-State: AOAM533xkJe9dGOSyXX4pvJZha3D4NY8iHijyXA6wlDtBnAOb5nEuSvA
        pZmaVKqawffX4qQi4sw5QtneK+1xBghk9ABKpTs=
X-Google-Smtp-Source: ABdhPJyg6Fh1tXLbUezdTmvVefh8DTi11XdK00zpGc6FAnXgZas5T7K4aajH4+/yN/e7x7DEOjX3+g==
X-Received: by 2002:a17:906:ece9:: with SMTP id qt9mr18572913ejb.362.1636749666503;
        Fri, 12 Nov 2021 12:41:06 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id jx2sm1888970ejc.122.2021.11.12.12.41.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 12:41:04 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id b12so17672163wrh.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 12:41:04 -0800 (PST)
X-Received: by 2002:a5d:50c6:: with SMTP id f6mr22240639wrt.131.1636749664027;
 Fri, 12 Nov 2021 12:41:04 -0800 (PST)
MIME-Version: 1.0
References: <87y26nmwkb.fsf@disp2133> <20211020174406.17889-9-ebiederm@xmission.com>
 <874k8htmb2.fsf@email.froward.int.ebiederm.org> <CAMzpN2jkK5sAv-Kg_kVnCEyVySiqeTdUORcC=AdG1gV6r8nUew@mail.gmail.com>
 <87ilwxrvu9.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87ilwxrvu9.fsf@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 Nov 2021 12:40:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=widK1vko2EN9PtV3jTo02u-expXxozui-fsK-0uKrcGHg@mail.gmail.com>
Message-ID: <CAHk-=widK1vko2EN9PtV3jTo02u-expXxozui-fsK-0uKrcGHg@mail.gmail.com>
Subject: Re: [PATCH 09/20] signal/vm86_32: Replace open coded BUG_ON with an
 actual BUG_ON
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Brian Gerst <brgerst@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 11:57 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Still user space would have had to have mapped address 0 to get that
> value set in do_sys_vm86.

You have to map address 0 anyway just to get vm86 mode to work.

vm86 mode fundamentally requires the low 1MB of virtual memory to be
mapped, since there is no virtual memory offset in the vm86 model.

             Linus
