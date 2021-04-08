Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6902D358718
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 16:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbhDHOXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 10:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbhDHOXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:23:21 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D97C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 07:23:10 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id n2so3360872ejy.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 07:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vwtK80T1DcvdQa1FAI2jtGEjdTtfVkLM2SIvSNWaLIk=;
        b=ACNfgd1QArqPlTQktYH1Ex1bCfKfu8UZXKId8OgiiQeobA5J1XUDpA19Ak3FHyE+d/
         pWruGOAtodhnbVZeFRykcWUlbYBAH5/YrralglWc3fn4yq49cApM+z4nur0dTHBPQ2iI
         Csx8LMKGC6ulwXz5wMufV1e1VZJB+0ardOxINsrcl0nlLyTXm4nMe/f3kudT8WJ0oSjv
         YZFAqeXIs9wjZkn11lvVmi1wnUR4GOjtfLXDh1SqjztwPVFHl7Nyupe6uKhZhKA1NeOL
         +KqqLIxNWfYOe3KEhs5UbM0Uod0S8LZB1VDzb54TJbr16x9l/b5XEUVZ90aWG7pyVjPx
         5WRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vwtK80T1DcvdQa1FAI2jtGEjdTtfVkLM2SIvSNWaLIk=;
        b=nvzh0gT100WWV9UDBwPLNqslTMqu9HjXYrNx3IE0ZpKtYpZoIj3tY8smZb6U7md8vF
         MCZXvJ8MM47L9ZIHaaotwSnYOjRYQFoYeRcPyZv8wHYvsjiaQNscro0ho5sfZkWg7Wij
         Pu4HovW3FJCdX8z05Boen81QnLfWdAN3OYCPvgwmQZDre8ZWCgG9raew3LJZoqt6YmXF
         LMJU/HApy+5d24WtQsHwTU5+favY0AwLEAvVK3EEHQo1S3NfUIGv+75cgXYnppA6JaJj
         qDYsy75HXIjSGY4Ih6KaGyx++L6aXzrvh4OWv+UoTqh2+Kcsg5XIx+AAbZ4OraZbxU0+
         8tuQ==
X-Gm-Message-State: AOAM5332REy2RkhVcbTRwsbtDC7EDRGZEJOxniDRp1Lt/A/UvYbyJFIO
        sdc8ab82ysGE41gxXeUBCAPwIj7CZzIBgxjLZw==
X-Google-Smtp-Source: ABdhPJxMq2t3j6t2QcS2dptIWdOfv1qy4Wta+x7KAGHEg0FEAvg7HWG8a1JiK/VOehoscBFHrKfJHN0Lf709gBcFqBI=
X-Received: by 2002:a17:907:935:: with SMTP id au21mr10494140ejc.362.1617891788931;
 Thu, 08 Apr 2021 07:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210405152935.148129-1-rsalvaterra@gmail.com> <CAFLxGvwhtRY-6kT-sN=AgjvyssHb5qdTS6WQHkhKu3YrPuTkdw@mail.gmail.com>
In-Reply-To: <CAFLxGvwhtRY-6kT-sN=AgjvyssHb5qdTS6WQHkhKu3YrPuTkdw@mail.gmail.com>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Thu, 8 Apr 2021 15:22:57 +0100
Message-ID: <CALjTZvZrn=yngbEcS8JCKaF_yW8Sn00vvy6cAODkr46UJvD7gA@mail.gmail.com>
Subject: Re: [PATCH] ubifs: default to zstd compression
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Richard,

On Thu, 8 Apr 2021 at 12:00, Richard Weinberger
<richard.weinberger@gmail.com> wrote:
>
> I was about to NACK this patch but by looking at the diff I realized
> that you change
> the default compressor only for the default filesystem as created by
> UBIFS itself.

Yes, that was the idea. :)

> Queued for the merge window. :-)

Thanks a lot!

Rui
