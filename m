Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA5E363D23
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 10:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238044AbhDSIGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 04:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhDSIFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 04:05:54 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D7AC06174A;
        Mon, 19 Apr 2021 01:05:23 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id r186so6844777oif.8;
        Mon, 19 Apr 2021 01:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I6ETiJ3wsBXNPuemCnAH/ZRYp/GfduiDc1+bwALCeEc=;
        b=kqu7z/NER7PJLGEtZYNAg42xhJqhRipSESRvauhdIMq7PauggZbdhrf49OezPtpE/z
         /g16pzArSzHBqUIPr9PfeASVTZ/UBp4jH50BP7crxra+8KBzIT/vac9lL2si1LsIF+r4
         +w7LLFwaYQbN7k184Uc0x0PgvziN168nlNNlBBtXHxQIFpS4ZE676lG4AGZejrbhHa03
         zpENFXtUTqCcHAp52mfLhaclDEhbvXEzTD6KlpodUhH/g1djwyJY1BLMp+IJ+uBw6VQC
         UPb0y8xWlf3J858mbf9Q5gP3Qqtn7i/XefLbvXSzVNUOW2NIyTmrEoVb8ED7kcMcZEbo
         4dVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I6ETiJ3wsBXNPuemCnAH/ZRYp/GfduiDc1+bwALCeEc=;
        b=cQljw+H02+sw76LfwTFXPOt8pHmnB2fA4wwDOJ3+YD/yqbywi5L4ySfSj4TN67IspN
         822yHh/9TRgoP4GUxPUmEeLSws2bioJHwyrW1oj6EwvIf0kzJbqIX9KYUdrvcB4CbjWj
         jMtTOzGOyT1kjJEyiU9sVNyxokzBos1nxgzOrcHSHh0hvWeL8FGEbbu+Vv6PauoS6NCc
         Gn486WxsX0kobVhNgcrtB7QPD5o2lvvcM5Zgc7jlF/GN/23qmtiQpRpuGV06xGpKSyv4
         u7LYuyt4ZBE4yEwvOyqwi05AWwdY1IxbAVvUCM9Kv5S7nP5HIXwEYpx7YZoS3InOJWOC
         mNMA==
X-Gm-Message-State: AOAM5332kE7Yl9ph2OngfEtVHgYkhEHVuEEeF2Sda3kmEc4kfcljbhF8
        83Oh7zi44s3jm13Vg3wAw4mlxkBDgQk+5i5XuEM=
X-Google-Smtp-Source: ABdhPJzHBoV5bZT5fqKBQyWrPkOvrbOg2DYf7jUkxgoA0aS0Fim5RuV0lEdOi9AYwT5lx4EGOFcgIffC7SHNsF7jdf0=
X-Received: by 2002:aca:4fc8:: with SMTP id d191mr812798oib.139.1618819522797;
 Mon, 19 Apr 2021 01:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <1618763386-29562-1-git-send-email-zhoul110@chinatelecom.cn> <20210418165953.GA1206@zn.tnic>
In-Reply-To: <20210418165953.GA1206@zn.tnic>
From:   Steven Zhou <lullaby2005@gmail.com>
Date:   Mon, 19 Apr 2021 16:05:12 +0800
Message-ID: <CAEtkB+7CsTJYHNTEYotrJ4qEXSBTU4S8OJ+0zc5F0cMy1sk51w@mail.gmail.com>
Subject: Re: [PATCH] docs: fix the invalid vt-d spec location
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        hpa@zytor.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Liang Zhou <zhoul110@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

Thank you for your comments.

The vt-d spec PDF is around 11M size and after be zipped it's still
around 10M size which cannot be uploaded to "bugzilla.kernel.org"
because this site limits 5M file size to be uploaded.
Seems currently I cannot use the similar way as what you suggested to
specify the bugzilla attachment link in intel-iommu.rst .

Do you have any other suggestion about the link location please ?

Thanks.

On Mon, Apr 19, 2021 at 12:59 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Sun, Apr 18, 2021 at 09:29:46AM -0700, Liang Zhou wrote:
> > This patch fixes the invalid vt-d spec location.
>
> Avoid having "This patch" or "This commit" in the commit message. It is
> tautologically useless.
>
> Also, do
>
> $ git grep 'This patch' Documentation/process
>
> for more details.
>
> > Signed-off-by: Liang Zhou <zhoul110@chinatelecom.cn>
> > ---
> >  Documentation/x86/intel-iommu.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/x86/intel-iommu.rst b/Documentation/x86/intel-iommu.rst
> > index 099f13d..e95ee34 100644
> > --- a/Documentation/x86/intel-iommu.rst
> > +++ b/Documentation/x86/intel-iommu.rst
> > @@ -4,7 +4,7 @@ Linux IOMMU Support
> >
> >  The architecture spec can be obtained from the below location.
> >
> > -http://www.intel.com/content/dam/www/public/us/en/documents/product-specifications/vt-directed-io-spec.pdf
> > +https://software.intel.com/content/dam/develop/external/us/en/documents-tps/vt-directed-io-spec.pdf
>
> Those links are never stable.
>
> Please open a bugzilla at bugzilla.kernel.org, upload that document
> there, like this, for example:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=206537
>
> and then add the *bugzilla* link to intel-iommu.rst so that it doesn't
> get invalid again.
>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette



-- 
Best Regards.
Liang
