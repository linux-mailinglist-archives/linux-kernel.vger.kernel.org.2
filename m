Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB54387A7A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 15:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244774AbhERN55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 09:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234985AbhERN54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 09:57:56 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07647C061756
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 06:56:38 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id d30so3244616uae.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 06:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0218MIjV6sDk3GtBhJUUBoqbpznvnThNvXyXAl2dRdo=;
        b=cRL2w3zHWlxCUzo28Q5gSGrJRv38mw6NXXdLPG2CP2eZHhN5159XlXpc4TnJ74kX/1
         kg8/NtknW1TWLEtB1XL9yfyrlnDrtBj3qRO4ARcBnSO+ZoHNNy6CUMo4J9451eOa3cY0
         jSJ/yB9Ld6UNrUHjv7GP5lWg33y8WbC5pVsAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0218MIjV6sDk3GtBhJUUBoqbpznvnThNvXyXAl2dRdo=;
        b=fdVUretBkmSfCx3BhaVoaLW57giVonGNOYAGpARQzDFnWVIcniAfs+QHR7Z0VWSuV1
         mweuDNvIdAnmf1SwCe7hxXbI8jfCm2IRDcyEhBOT8GIE/0scriMOvd7tzN3/uG/KHGGH
         A0kMbnXj2BBywW4nNL2CwLfG6Pz47Q4SP7dm9AfauKVgaOGb8CPyiNF+J6zUE2njmeAW
         vMfcoRMg9IHouraKsTrMfdESgRx5tuipITcA3k0IKSTRFQjECuqBsz3oiwHYM8L2yswF
         gEUyc682phuxE8O5QWQVn7Q6MpNvTsOLCFXXf4m1jKKAd44+lu5KOPdift2ni2vbs/jt
         SjVA==
X-Gm-Message-State: AOAM532GhwEl1ut5lHPHb1UgukVbIp7wnAdyw/BkH7f59Wa+3QV944fe
        sWMOFN+LanNtVpZxAxnrEQrPWCd3mvDd4VR2Xbhg4g==
X-Google-Smtp-Source: ABdhPJxte7giQP+HVI9f/B2gI531JC6jLeyS0GC1SRzloLPO6wRCAOAhyugLZlibpywStzpKhIzB6TLxKGXUlchCa8Y=
X-Received: by 2002:ab0:2690:: with SMTP id t16mr6459810uao.9.1621346197241;
 Tue, 18 May 2021 06:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210512161848.3513818-1-rjones@redhat.com> <20210512161848.3513818-2-rjones@redhat.com>
In-Reply-To: <20210512161848.3513818-2-rjones@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 18 May 2021 15:56:25 +0200
Message-ID: <CAJfpegv=C-tUwbAi+JMWrNb+pai=HiAU8YCDunE5yUZB7qMK1g@mail.gmail.com>
Subject: Re: [PATCH v4] fuse: Allow fallocate(FALLOC_FL_ZERO_RANGE)
To:     "Richard W.M. Jones" <rjones@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        eblake@redhat.com, libguestfs@redhat.com,
        Shachar Sharon <synarete@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2021 at 18:19, Richard W.M. Jones <rjones@redhat.com> wrote:
>
> The current fuse module filters out fallocate(FALLOC_FL_ZERO_RANGE)
> returning -EOPNOTSUPP.  libnbd's nbdfuse would like to translate
> FALLOC_FL_ZERO_RANGE requests into the NBD command
> NBD_CMD_WRITE_ZEROES which allows NBD servers that support it to do
> zeroing efficiently.
>
> This commit treats this flag exactly like FALLOC_FL_PUNCH_HOLE.

Thanks, applied.

Miklos
