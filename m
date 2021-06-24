Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534653B352D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 20:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhFXSGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 14:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbhFXSGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 14:06:31 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1184C061574;
        Thu, 24 Jun 2021 11:04:10 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id h17so9786430edw.11;
        Thu, 24 Jun 2021 11:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RwwTqy9WZmZQciKQh7A9H8bIJRJaZla64xhE8H4bFtQ=;
        b=baLYbSHdhLQ7dT6qyUtsUpHdvn3BMEqkmTKpRgcqyPPAvGdIgdR7x6HIEpR31P3jvQ
         WlecXxHrM0+wCrStLNePaxFjpF1JrdpHBg7eD2CSvZfSSWqMBHq2TX5MJ09yWuktpct1
         PITc65ekmSOg/nMRITmztBbJWeVyTAQCHX18frKKiTle2tXFMNjba370ZtMserCVSZv1
         RlbNxkh5o8SgNUC8xm6RkJDjePFh+QV8JDWFHm2RWvf/O9m/eFwkaw5wbompvxF8nCuw
         cImq6zIptgTzQa8xC1YyMaOQz1h8l3qcVYaK3/27zLLFnjEjeptcrtY0vw2yMv5jQBhK
         tbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RwwTqy9WZmZQciKQh7A9H8bIJRJaZla64xhE8H4bFtQ=;
        b=p08jt0IjjsrRpGTJjN7QEQu/GCAYLmIK623yMO+wWSc3fqHfgwaN5I4UfnjOy4l6dx
         oRfKUEOjWltFarVlxs25vPOUsvWjj3w0v/KeH3tY6Sa+I2NjD27FR7cmRMH6erpx31rH
         SdcEaf4oCt5gH3Lg76YP17sgunPPR0lk4N+SCJQjRBY432o+WAYtPvcb0bHtU9leWFXw
         20LX8KlH5AqvcRboqIeCJ6QN3BLCbBsoIHMQsmhWsMp6NWI7J5nXw2jy3dFt5fRFjYqj
         IBCfboXTns2PQHO45PV2S+3MzyX6qMa7cQPdkliZA1mAQVJ1L181KEDx70ydD7h79pep
         vL0A==
X-Gm-Message-State: AOAM530xyJmKmp8Ne6E4ZqjcOH7h+RqCuvV7EXme+/hELDt2lttOuNK6
        2hhqgrI2lScR2l8Fy1Jy1A0D9QMKZnearuzd+fk=
X-Google-Smtp-Source: ABdhPJzcZX+FNdcJUm/odJ2gXifj3k4KG/XAVh1P74YfZaVNbxJOPBADjiMwJPA4oD1Y6sXyo52v9OLbviz89i7v//U=
X-Received: by 2002:aa7:cb9a:: with SMTP id r26mr9176812edt.78.1624557849161;
 Thu, 24 Jun 2021 11:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <1624557664-17159-1-git-send-email-konishi.ryusuke@gmail.com>
In-Reply-To: <1624557664-17159-1-git-send-email-konishi.ryusuke@gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Fri, 25 Jun 2021 03:03:56 +0900
Message-ID: <CAKFNMomwWvymBdEwimc+6yN+5us_jzgG1jwL_O195Nb-rLy6Lw@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: remove redundant continue statement in a while-loop
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Please queue this for the next merge window.

Thank you,
Ryusuke Konishi

On Fri, Jun 25, 2021 at 3:01 AM Ryusuke Konishi
<konishi.ryusuke@gmail.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The continue statement at the end of the while-loop is redundant,
> remove it.
>
> Addresses-Coverity: ("Continue has no effect")
> Link: https://lkml.kernel.org/r/20210621100519.10257-1-colin.king@canonical.com
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> ---
>  fs/nilfs2/btree.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
> index f42ab57201e7..ab9ec073330f 100644
> --- a/fs/nilfs2/btree.c
> +++ b/fs/nilfs2/btree.c
> @@ -738,7 +738,6 @@ static int nilfs_btree_lookup_contig(const struct nilfs_bmap *btree,
>                         if (ptr2 != ptr + cnt || ++cnt == maxblocks)
>                                 goto end;
>                         index++;
> -                       continue;
>                 }
>                 if (level == maxlevel)
>                         break;
> --
> 1.8.3.1
>
