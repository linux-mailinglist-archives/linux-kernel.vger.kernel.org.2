Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D419357CC0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 08:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhDHGrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 02:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhDHGre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 02:47:34 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2281EC061760;
        Wed,  7 Apr 2021 23:47:24 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id r9so1156531ejj.3;
        Wed, 07 Apr 2021 23:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nphmCcntRGma7inIbTUmWNDHxfjKITyrJ8Vf6cW0g1U=;
        b=lHsCNTqq0wjqAGuzBK0ezoBsFkOj0C2h4k8mqESzURrJy7j81Vw2SZW47yEOqpPMsy
         RxyQQwIvXRm1+QuuqkeWIoOpgxoTSRPSlk1WJnbGx0gVfftUhFA2BZqb1XrcGlN5UEFr
         7Zd31Ifcxe0Tg85PtbTR2dXYjnnrPMkM0BzntpsBMMPghQsIo5Kl5GT/RFYYTwJVQhsN
         dFGdrfmc3n/bz1qx2PKqWcWmZ7U6bx/+ULPOa/YulS2Xsb8KdP/umONq2DCC+rtiUiyS
         BbHd258esJRUUbNsfyJW5XNZVMitqo1aTcNABxEpsMxc5nxSPnh6o3sQ9/vPXJ4CoS2A
         B+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nphmCcntRGma7inIbTUmWNDHxfjKITyrJ8Vf6cW0g1U=;
        b=f4bPS6eeKpdN4giX3ZEEux8BTyhQ/KvtYaOxxu2ebWFQeZuzsyR8M/m3MjiIOjq/Rv
         SL6wJ1FsK3xE5bMtOPptEiy1Waz+ObF/S6Pg5Q3LMHscX5XfWBW/SqZfawgYf2VqoOnB
         FgFl8gWSSuSNzbpi27IXX09y8qwqjoouSWXboXORsMCI4FQELh3eW+8/8DDLLV2DPxgq
         XPKGRtODiegRxCkoF4v8CqPb36Zxl+Jb21mVFIy5JXwTsw8AqxYYd8SNVrw4lQKRTRC4
         TCTDPH8iZpkQBXT+Y15GJMDzCRrP429uL76yqeGs6xGBO+w0a/r+zmNNMPDYoN4qCF+f
         OjAA==
X-Gm-Message-State: AOAM530VM5zlzYmXp6me8k8j76ossclh1U+PZfsiFT3Fm4potDbLQ9F7
        OochL6PtyrtT7XCOEdBCCVBpfsWUsqbusrrA4cBVuNYe
X-Google-Smtp-Source: ABdhPJzTlKLguWfos9iQdgndAfDCSxqDOJX4S8bGRR3dUQDYfItbfuqPG10cAKnH80G1oMhmcgbHIgqtCfkTjO1TmJA=
X-Received: by 2002:a17:906:8a7a:: with SMTP id hy26mr5493015ejc.509.1617864442859;
 Wed, 07 Apr 2021 23:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <1617864087-8198-1-git-send-email-konishi.ryusuke@gmail.com>
In-Reply-To: <1617864087-8198-1-git-send-email-konishi.ryusuke@gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Thu, 8 Apr 2021 15:47:10 +0900
Message-ID: <CAKFNMo=Pd-fkOKrm3ZQgL6jA2iN2NJxwh5mo8nyTGiJq71U7UA@mail.gmail.com>
Subject: Re: [PATCH] fs/nilfs2: fix misspellings using codespell tool
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Please queue this typo fix for the next merge window.

Thank you,
Ryusuke Konishi

On Thu, Apr 8, 2021 at 3:41 PM Ryusuke Konishi
<konishi.ryusuke@gmail.com> wrote:
>
> From: Liu xuzhi <liu.xuzhi@zte.com.cn>
>
> Two typos are found out by codespell tool \
> in 2217th and 2254th lines of segment.c:
>
> $ codespell ./fs/nilfs2/
> ./segment.c:2217 :retured  ==> returned
> ./segment.c:2254: retured  ==> returned
>
> Fix two typos found by codespell.
>
> Signed-off-by: Liu xuzhi <liu.xuzhi@zte.com.cn>
> Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> ---
>  fs/nilfs2/segment.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
> index cd4da9535aed..686c8ee7b29c 100644
> --- a/fs/nilfs2/segment.c
> +++ b/fs/nilfs2/segment.c
> @@ -2214,7 +2214,7 @@ static void nilfs_segctor_wakeup(struct nilfs_sc_info *sci, int err)
>   * nilfs_construct_segment - construct a logical segment
>   * @sb: super block
>   *
> - * Return Value: On success, 0 is retured. On errors, one of the following
> + * Return Value: On success, 0 is returned. On errors, one of the following
>   * negative error code is returned.
>   *
>   * %-EROFS - Read only filesystem.
> @@ -2251,7 +2251,7 @@ int nilfs_construct_segment(struct super_block *sb)
>   * @start: start byte offset
>   * @end: end byte offset (inclusive)
>   *
> - * Return Value: On success, 0 is retured. On errors, one of the following
> + * Return Value: On success, 0 is returned. On errors, one of the following
>   * negative error code is returned.
>   *
>   * %-EROFS - Read only filesystem.
> --
> 1.8.3.1
>
