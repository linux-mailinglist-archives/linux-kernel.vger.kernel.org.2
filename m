Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415D6369B8B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 22:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243930AbhDWUu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 16:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhDWUuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 16:50:24 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B88C061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 13:49:46 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id g17so58162678edm.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 13:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fm0PKuYIAac9ltnrpGnQKG+HA7pEHPssT5UYNO5GgT8=;
        b=pLbnPslxXLs5tizh+7TJazxxRde79HZ1ATziMVDbUDxK4lvVO62Ke0IW7N5pPhtVbC
         K6h3wqplK47FgfQTYrj8JKCyqIR59w1FgbgaveJXD5pZHFKZyUYM+6o6pZKk321NgNkF
         XmrjP0UdPmm/EQFrdyAAGn0EGnT2MhrcUFYtphKi3GFReZO2nOe0s3aqLi6ghqM3xjVR
         b0rl6UezVH/3RQtn9ug1WTlHmzg/C+/kd2q5HTd89dP24n6CXUv1DIv1t/+oVTVDeQCf
         ysKnVikQabwsbcNGH9kG3LJOALsutqKjaQU/pMcA+Jvmo2qGUEo4jIdhU45s60l4f6Io
         fvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fm0PKuYIAac9ltnrpGnQKG+HA7pEHPssT5UYNO5GgT8=;
        b=gMbd+7IQ+V07jk2pyt/l8gTc8qDaD7kqOHGfFrxhTzTT1YeBP+BJcb5TY9CFIGqP5f
         FZJ+LewFfgoYgT5bD2KM1b/euRoOKn6jb5rcXR7oMdXB06Ls2VZVaKkal6sbBTPnTV2+
         a40KWrZy0jmA5AZkcMQvwXXhjUtGQIxNTS8kwUHmXNkqT5qdpw1ZTmi1SSln/zqW/d2X
         K/OQUfsEixqqvQorPwXugUth5pAHPn2VXPh97zNvjN4mUfJsL1uP33tlcGbmRB1magOR
         CMcq2LATFo+qaNtNtwzrvfjDILqTp7RVjyM1JMScduwQTFDYoNzsALwppGVTPFcGSBdP
         lzWQ==
X-Gm-Message-State: AOAM531FD40ts4ZcjdmkYb0Ahyybr6Hl/b2dlTfF/F/yiF+f2l8DQWS0
        qHAoYghGUNk/2C/2hAg71t7xu3oUHzaOAwcSE9fWkQ==
X-Google-Smtp-Source: ABdhPJzRwNb0e8bboKJyuenTHOg4eGazzicBvClp1MoWljlZWQKPFjpWorap071VWY6qwvlBnf4WpcErhJhCbXYzah4=
X-Received: by 2002:a50:e607:: with SMTP id y7mr6781566edm.18.1619210985439;
 Fri, 23 Apr 2021 13:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org> <20210421130105.1226686-106-gregkh@linuxfoundation.org>
In-Reply-To: <20210421130105.1226686-106-gregkh@linuxfoundation.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 23 Apr 2021 13:49:39 -0700
Message-ID: <CAPcyv4h6SrYg39NN5WzhiXyD3_FjVW4XVXsK=HUVjWOSPcBaAw@mail.gmail.com>
Subject: Re: [PATCH 105/190] Revert "libnvdimm/btt: Fix a kmemdup failure check"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aditya Pakki <pakki001@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 6:08 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This reverts commit 486fa92df4707b5df58d6508728bdb9321a59766.
>
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
>
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
>
> Cc: Aditya Pakki <pakki001@umn.edu>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Upon re-review, this fix still looks good to me, revert is not necessary.

> ---
>  drivers/nvdimm/btt_devs.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/nvdimm/btt_devs.c b/drivers/nvdimm/btt_devs.c
> index 05feb97e11ce..995573905dfb 100644
> --- a/drivers/nvdimm/btt_devs.c
> +++ b/drivers/nvdimm/btt_devs.c
> @@ -191,15 +191,14 @@ static struct device *__nd_btt_create(struct nd_region *nd_region,
>                 return NULL;
>
>         nd_btt->id = ida_simple_get(&nd_region->btt_ida, 0, 0, GFP_KERNEL);
> -       if (nd_btt->id < 0)
> -               goto out_nd_btt;
> +       if (nd_btt->id < 0) {
> +               kfree(nd_btt);
> +               return NULL;
> +       }
>
>         nd_btt->lbasize = lbasize;
> -       if (uuid) {
> +       if (uuid)
>                 uuid = kmemdup(uuid, 16, GFP_KERNEL);
> -               if (!uuid)
> -                       goto out_put_id;
> -       }
>         nd_btt->uuid = uuid;
>         dev = &nd_btt->dev;
>         dev_set_name(dev, "btt%d.%d", nd_region->id, nd_btt->id);
> @@ -213,13 +212,6 @@ static struct device *__nd_btt_create(struct nd_region *nd_region,
>                 return NULL;
>         }
>         return dev;
> -
> -out_put_id:
> -       ida_simple_remove(&nd_region->btt_ida, nd_btt->id);
> -
> -out_nd_btt:
> -       kfree(nd_btt);
> -       return NULL;
>  }
>
>  struct device *nd_btt_create(struct nd_region *nd_region)
> --
> 2.31.1
>
