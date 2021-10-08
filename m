Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D5C4271CA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 22:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242093AbhJHUFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 16:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbhJHUFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 16:05:36 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584DEC061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 13:03:41 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id h3so4111208pgb.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 13:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+S9WDoHB2ctsz8gJt0x5mA2ZJmsZ+eXZU78CjrUXBMo=;
        b=RVsXQbTV9pwVKNdOocVZrneAFAQRQBRzzkwCm7c0DFFnVR19u3z7rBJhHu8hASsGRe
         9bi6stVBMQCxs6aX+4+BM+y/FclkQ+AtRlok3aEaozwQ3sh+pXfa3yXrk6V9hT7zgsbD
         qsTYIMJurK3aPaGwBha3Xa7XkBgrLfH4Qm1HbxZG3IUWOv4Vdt5/pyPUMj6hAtlS1qVP
         bUDLhCi85Gplzne1WtvBKJEU8qM3Dw5fNDYKLsvZa9H8bYPFq0qzTvO15yWi5zNzW9+j
         I93N6JM8fALbhrcamBJJgA02oTBHIUXqA/mFA0kA0ON/3Eumtn9/wEtrQRqa/dkGcCBY
         9L3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+S9WDoHB2ctsz8gJt0x5mA2ZJmsZ+eXZU78CjrUXBMo=;
        b=WlKr/g5bZJK5Rc8sqrFuTDWlPxUsOfXhmStSiE5nB2tivyld9EwRZsfeWeD5JXRzkH
         538Gl6YDELmsizhSsPsGlIpakj9WrGBe9UCV1Tu//eXIHZoJ7jdXIxnzvy0bUq04Ax/q
         lg05n+qpdg+FiT6JxKtil0jnM3XZGumFMCP8B11loIwAovKeB5gDrHDHw2SDB2B/g+G2
         ayaNsHIWjKS1/aR87qMDZ05b3ZeUN0gt7nBALK9AeLz+ff9DzT17zkgnrYz/PAiHaYzI
         PDq1J7Blejfa93Bai1VkK9SOzQm/PTGNoHcG0pHHJBfs40HGo+ykJ4ZJixPvZdiU+Z57
         SpIA==
X-Gm-Message-State: AOAM5323fFEQitC5qHrcOHoLqS2PNNDHnQ/vbqTC4XjwfcZKW3RPPDOR
        haS7UWNBldZC5KNgdTTgii1Jim5ogQIHf6hIPGXVBg==
X-Google-Smtp-Source: ABdhPJzXkcaP9PLLmBjsn9tqqkyO3G/0oDwaUxOwFj7quPcPcrA9UpECQPVco+koRgT/SeIjcKwliFYe26XoKyTpcDw=
X-Received: by 2002:aa7:9517:0:b0:44c:7b4a:8073 with SMTP id
 b23-20020aa79517000000b0044c7b4a8073mr12069614pfp.24.1633723420416; Fri, 08
 Oct 2021 13:03:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211008152930.03787395@canb.auug.org.au> <ba01fb13-e1a1-299e-9a7b-ccdeaeef267a@linuxfoundation.org>
In-Reply-To: <ba01fb13-e1a1-299e-9a7b-ccdeaeef267a@linuxfoundation.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 8 Oct 2021 13:03:29 -0700
Message-ID: <CAFd5g45g91ZadTJrU3oE+VHxZ_2kgDnZm0uyTiaxR+bP=qg9fA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the kunit-next tree with the
 kunit-fixes tree
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 8, 2021 at 9:31 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 10/7/21 10:29 PM, Stephen Rothwell wrote:
> > Hi all,
> >
> > Today's linux-next merge of the kunit-next tree got a conflict in:
> >
> >    tools/testing/kunit/kunit.py
> >
> > between commit:
> >
> >    d8c23ead708b ("kunit: tool: better handling of quasi-bool args (--json, --raw_output)")
> >
> > from the kunit-fixes tree and commit:
> >
> >    6710951ee039 ("kunit: tool: support running each suite/test separately")
> >
> > from the kunit-next tree.
> >
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> >
>
> Thank you for the fixing it up. I will fix this up in the kunit-next once
> the kunit-fixes pull request goes out.

Thanks for taking care of this everyone.

Daniel, can you double check the merge conflict to make sure it is
done correctly?
