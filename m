Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8519D44FE26
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 06:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhKOFYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 00:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhKOFYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 00:24:18 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755F0C061746
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 21:21:23 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id m20so20503470edc.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 21:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OHzu1Tneee7dR1hnjl9EDILs5UXgndY6co+qRyPVb40=;
        b=DBC97X1afwSflc/Zjh8YZhj1ytC3Ebg2UOUcGaPFyCLiWAce3Sfmp04VQdLZ+70Yu1
         EAHyb83pPX6cVkmBpQgexTbaBf+cloUCBQnKI6kMjW+DBDnh0lUXVD+lw8FxAwednppz
         tO3XrTaFa2qt3w8h6J/a1sdjQEwgXjB2+dye0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OHzu1Tneee7dR1hnjl9EDILs5UXgndY6co+qRyPVb40=;
        b=7tSTV1gkY7vYvq3HpfeNpa1DkYuTtXcAKlQtePn1thlsw9fGkTeedA3v7OOqLtI/Pr
         f4XrZhjvoQIxWu2SxtN2xpFjUqno6rMBCpRrntvY2jRXA4nfY1CQnzBP9lbo+70G3cmh
         v4i2qwI6b6qDbaX7saSivfN1VX454WgwABVlPO3Wv0o5CEqbMgpbUA1pZSHlfMBy+9mD
         0foFmIiU62H1pp4v6FS6R3jNjB3ECfJwWoBYUv3DGvKpuatmrAg9I9JPeX7PIN/6b51j
         firLTUifmR83nTSm4hST4f0aEEr5AW85W2mvIGEYexrDSPJ7JzSXNou1teWHLDcICCyv
         kTLQ==
X-Gm-Message-State: AOAM530Iit8huoOIF/3Gi6FQ2tbm7dHKpuNajN+RjEDKA4TUiecuSAxA
        qbWLDMZrxpkQ/fgHG0fFeVuEyxi7/8SxynQf
X-Google-Smtp-Source: ABdhPJz2TzUY1Zr7YHEac3rrkJd6YMJCRS0qf6b2Y1yN5Jb71x2g65aVQzrPkOhEeu2pkaM0xzdQCQ==
X-Received: by 2002:a17:906:4791:: with SMTP id cw17mr46389719ejc.493.1636953681941;
        Sun, 14 Nov 2021 21:21:21 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id hu7sm3922074ejc.62.2021.11.14.21.21.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Nov 2021 21:21:21 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so11393160wme.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 21:21:21 -0800 (PST)
X-Received: by 2002:a05:600c:1d97:: with SMTP id p23mr39269532wms.144.1636953681323;
 Sun, 14 Nov 2021 21:21:21 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjF=JzLkCi2wV+G=f8OWa5rNjPsZd2RMFG5MHwKZPgYvw@mail.gmail.com>
 <20211115045616.GA1012538@roeck-us.net>
In-Reply-To: <20211115045616.GA1012538@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Nov 2021 21:21:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=whca4JrEExUZCf+iGhP+mV-_D2uyqiFHnaYqnfCOKyEVg@mail.gmail.com>
Message-ID: <CAHk-=whca4JrEExUZCf+iGhP+mV-_D2uyqiFHnaYqnfCOKyEVg@mail.gmail.com>
Subject: Re: Linux 5.16-rc1
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2021 at 8:56 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> With gcc 5.4, mips:mapta_defconfig
> mips-linux-gcc.br_real: error: unrecognized command line option =E2=80=98=
-Wimplicit-fallthrough=3D5=E2=80=99

This (and the gcc-6.x ones for sh4eb/sparc/xtensa) are already fixed
in my tree. They're all "old gcc didn't support that flag" things with
a trivial one-liner fix.

I was hoping you didn't have older gcc versions, but you clearly do ;^p

               Linus
