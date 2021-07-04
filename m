Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7CE23BB46C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 01:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhGDXh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 19:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhGDXhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 19:37:54 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2EEC061762
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 16:35:17 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id p21so7439306lfj.13
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 16:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lwMcQsym/BEPzMP2lbVzmNvoE0udGzyI6q7NPfbPtIc=;
        b=WEsJAbGMCTNJpCXKUPPJBHuRCQPKS8NO5qmQnMl1WajTYa84eaq41xkNqXX3etfh/b
         Ad1SmEp+4xqdqX8kmTQkSQk3fy9ekNTShj/T+viMDjMcxoebUpSs4Kk8d4k3eROTOp6y
         TkDUqyCsRYFcQxf+vSZY2Xgwu0j/rhgh+GFrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lwMcQsym/BEPzMP2lbVzmNvoE0udGzyI6q7NPfbPtIc=;
        b=JS6CGfLTX0sGN65PehTHnILo0XBr3lnMfaOJ3fRwIVYGJBHG4CaCSIJLqqVfaRAJSH
         g3s1vfqefW274mzEVQm6vnT3ctSp23VAJDZwXGTGEotJPCj7LV+qotsIIHGOqylzymA2
         KI7JqeY2w0Oh+9K4RzeoVyiNAP2qYsqc1Seq9UiIvTSMcF/BNlNpakof/WJ4c6kPm0sb
         ucNINN4T/RbofacrSd1G06UXaDMN3ejKqJFfrj+g74Bl4rJ41tz+EutRBjBQL9s6rbxx
         59QWUTQBStzKRsyPANIUowafgmA0r/nwHBX/uJD97/eig1MNMmFonm/hsSKibgJyBQ+4
         m12A==
X-Gm-Message-State: AOAM530hPB2uA9O9M/i728We2WpaS5x++Y4g7LJ9/ph8o6w4r1PTj3ma
        rJguwAzjwuYlXYe9v0nr6vvsgcS7i6NsC+CC
X-Google-Smtp-Source: ABdhPJwn9vJGJClp5F8ObAz1z6Q+m5A56HHjVAgVlMUMbGcWAFiixRcivrC0A5xWQixf7DE38RxsDQ==
X-Received: by 2002:a05:6512:228a:: with SMTP id f10mr8204744lfu.222.1625441715715;
        Sun, 04 Jul 2021 16:35:15 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id s5sm1277852ljj.18.2021.07.04.16.35.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jul 2021 16:35:15 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id u25so22096205ljj.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 16:35:14 -0700 (PDT)
X-Received: by 2002:a2e:50b:: with SMTP id 11mr9098341ljf.220.1625441714149;
 Sun, 04 Jul 2021 16:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210704172948.GA1730187@roeck-us.net> <CAHk-=wheBFiejruhRqByt0ey1J8eU=ZUo9XBbm-ct8_xE_+B9A@mail.gmail.com>
 <676ae33e-4e46-870f-5e22-462fc97959ed@roeck-us.net> <CAHk-=wj_AROgVZQ1=8mmYCXyu9JujGbNbxp+emGr5i3FagDayw@mail.gmail.com>
 <19689998-9dfe-76a8-30d4-162648e04480@roeck-us.net> <CAHk-=wj0Q8R_3AxZO-34Gp2sEQAGUKhw7t6g4QtsnSxJTxb7WA@mail.gmail.com>
 <03a15dbd-bdb9-1c72-a5cd-2e6a6d49af2b@roeck-us.net> <CAHk-=whD38FwDPc=gemuS6wNMDxO-PyVbtvcta3qXyO1ROc4EQ@mail.gmail.com>
 <YOI6cES6C0vTS/DU@casper.infradead.org> <CAHk-=wjFOoSvSXfm0N_y0eHRM_C-Ki+-9Y7QzfLdJ9B8h1QFuw@mail.gmail.com>
In-Reply-To: <CAHk-=wjFOoSvSXfm0N_y0eHRM_C-Ki+-9Y7QzfLdJ9B8h1QFuw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 4 Jul 2021 16:34:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_L071F_-jRBLs--_0_g5Hmnr+Gt36kYqDdP_5j_UxMg@mail.gmail.com>
Message-ID: <CAHk-=wh_L071F_-jRBLs--_0_g5Hmnr+Gt36kYqDdP_5j_UxMg@mail.gmail.com>
Subject: Re: [PATCH] iov_iter: separate direction from flavour
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 4, 2021 at 3:53 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> If it had been easy to fix I'd have kept it, but this amount of pain
> isn't worth it - I just don't want to add extra code for architectures
> that do things wrong and don't really matter any more.

Ok, removed:

   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a180bd1d7e16173d965b263c5a536aa40afa2a2a

where 99% of the work was writing that commit message ;)

              Linus
