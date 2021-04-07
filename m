Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F423D357739
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 23:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbhDGV5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 17:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbhDGV46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 17:56:58 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B35C061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 14:56:48 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id j1so6483108qvp.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 14:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A4tTVq5QiH2Xb0EtjOJdc/qbW2Gofk9WYRP/7DRJHO0=;
        b=O7NDxYVuwAMnWgiVVttXejh4DLzj8sWFNSk+KEwa83NxE7eAytHpw7n2uNfa2AIXXz
         iPzhO2ui5k1LsxiT1nXtMYy8g7jL/VAjbdpmETMXeRlnFXGejoWFlcXzemUYc/BTeVPk
         ltGCiBL67Wna23PGYD+346N4FgkXHw5JYCXR1eMjLBIV+CPrgzx20p4F/Fot5ciG4h3P
         ac3m6O6t1xQ4gGWan3VHUsgbzqt+4cxP3tjVUaCJ9tRxya75Y+xnXAm/ReclZcNgotV8
         AJLRsbw2v8zZ+7ntTeFWD/jQvO0Pz+dXEX6I5+H0H/TI3U7DKdDDDkdTpmenJpPV9CwU
         STVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A4tTVq5QiH2Xb0EtjOJdc/qbW2Gofk9WYRP/7DRJHO0=;
        b=WKZ1UL9fqYPqSM0ppSHHfDagWBA4cqUnn5/O8caifuUDS5a9qQ5ZKjNJE92bBC6Hb+
         G7hFcsDGHAWISbxHi+87RJE414jTI0zdSExPu4V47ZE3Ri9tihIXxHbiuTbrHTK9mEp1
         SwdVKoGNP5m+UxTtoHcu+ntHTz8XKGsjLgCGP4JEdEBYUxSTAJ8Rg6+k4/jw5ZhrqDz7
         WqGEs01GzLG2VRbIVyt3tiGP19GRvRDfwN4DapTSYbjHFn1IpY30nK3T5dAPOi+Ju6FL
         5RfRf9KdYZwf2hmtsnvrtck8ZlmUaWVSLHnRIu+uPWN+SLamJF6QDjhNWsqi6oOd+miy
         qNOA==
X-Gm-Message-State: AOAM530BB+os5EsxqOJ9AKKa9Kqe9mXRqiHysdndGCI6AeqY7rhluOC9
        +nnjHBkb4Sjv/Ss9v5fvSXmmCCngLQauTz9gOk8=
X-Google-Smtp-Source: ABdhPJyM6dcr4EsiCFIevT/oXml3V5GAPPZm4YReJNO+oNZDPRbebmQA8yrgtrl+4VGXuh3c2EX4KM39RkJ+61drBLA=
X-Received: by 2002:ad4:57a5:: with SMTP id g5mr5804051qvx.60.1617832607707;
 Wed, 07 Apr 2021 14:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210316085214.25024-1-guochun.mao@mediatek.com> <20210316085214.25024-2-guochun.mao@mediatek.com>
In-Reply-To: <20210316085214.25024-2-guochun.mao@mediatek.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Wed, 7 Apr 2021 23:56:36 +0200
Message-ID: <CAFLxGvygphmHbhzHJmSO=NQFO_02oSamXVjC5Loj2nCcQWWYNg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ubifs: only check replay with inode type to judge
 if inode linked
To:     guochun.mao@mediatek.com
Cc:     Richard Weinberger <richard@nod.at>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 10:00 AM <guochun.mao@mediatek.com> wrote:
>
> From: Guochun Mao <guochun.mao@mediatek.com>
>
> Conside the following case, it just write a big file into flash,
> when complete writing, delete the file, and then power off promptly.
> Next time power on, we'll get a replay list like:
> ...
> LEB 1105:211344 len 4144 deletion 0 sqnum 428783 key type 1 inode 80
> LEB 15:233544 len 160 deletion 1 sqnum 428785 key type 0 inode 80
> LEB 1105:215488 len 4144 deletion 0 sqnum 428787 key type 1 inode 80
> ...
> In the replay list, data nodes' deletion are 0, and the inode node's
> deletion is 1. In current logic, the file's dentry will be removed,
> but inode and the flash space it occupied will be reserved.
> User will see that much free space been disappeared.
>
> We only need to check the deletion value of the following inode type
> node of the replay entry.
>
> Signed-off-by: Guochun Mao <guochun.mao@mediatek.com>
> ---
>  fs/ubifs/replay.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ubifs/replay.c b/fs/ubifs/replay.c
> index 0f8a6a16421b..1929ec63a0cb 100644
> --- a/fs/ubifs/replay.c
> +++ b/fs/ubifs/replay.c
> @@ -223,7 +223,8 @@ static bool inode_still_linked(struct ubifs_info *c, struct replay_entry *rino)
>          */
>         list_for_each_entry_reverse(r, &c->replay_list, list) {
>                 ubifs_assert(c, r->sqnum >= rino->sqnum);
> -               if (key_inum(c, &r->key) == key_inum(c, &rino->key))
> +               if (key_inum(c, &r->key) == key_inum(c, &rino->key) &&
> +                   key_type(c, &r->key) == UBIFS_INO_KEY)

This change makes sense. Thanks a lot for hunting this down.
It will be part of the merge window.

-- 
Thanks,
//richard
