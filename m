Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327803D926B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 17:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235685AbhG1P4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 11:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237142AbhG1P4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 11:56:47 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4BFC061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 08:56:45 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id j2so3867068edp.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 08:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/KJBia7ATQ1PTUNjJu6JBkn1Mi7yqgxyK+/WDg/bTwg=;
        b=w70ktT0sUm4x5/f26NtVnnrUk4m04hSQhSs4kv5uGRm+4aZ3jc+xsnXtcdLBLG4NFd
         4ffVZN6ro+DEuvceEZPdZ3gfhQdGlEYgFk+OWPUYCi3H2S88nBvByOu2uCBxuK1I9A8f
         cu8U/dG3Oul2ze2IIG2AVchUM771Ffb14PHfrIQSZPTVIJyXgNeCmPcvG3Ezp6dwnCfg
         zT6cw/Nh6Si03kHIVK0vRkOspja7ykHPRO5n1OVpQqsjdbaqLXGSVXXbxUuYv6mdhax5
         VNzsBnP/7LOB2OzRDm7+zS3onc945fAzihKL5zZhsBfOcQwjc5Go8qZ/ZGN8RfBBGUSI
         mD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/KJBia7ATQ1PTUNjJu6JBkn1Mi7yqgxyK+/WDg/bTwg=;
        b=DVyWAnRcbbs6Co6CM7D8XC41xDwH865M/sPYP3twnccTUiGhewjNtN7Tff189EJm3v
         +9cJOBVn0Z948KAUp0GP8SWtREL6L4iD67E9MGkcja74oMkxiZieUeqJCXB2t6lKHKgN
         XHwMol6AqIibEi+jgYJzXb2Ze7VpzqgFwfcqMq2Bvg3ZdVaAt5JAl0NX/TIiqKXl/MBt
         xsps71br9ZZ4eUZy4V1tdephXnWYk+nUlfqgiLKxBkAZa2kF9RIOuXej2Ze/QVi6vDGH
         BT0khNg7DsGLegwgwIaYxH+zSLxY2faEqR6w1BMRiPDcQFYvp2W5DGpB/7NEQQCTmxaQ
         nvnw==
X-Gm-Message-State: AOAM533cYLaUsh6AhdLHCHjty1eM3jjmru8YwbXOJB/028/s/SbIfGT1
        pBgrXNLKI+5Wbjc31NscAFdK0jjWoQ45dCcvNfkI
X-Google-Smtp-Source: ABdhPJxiK0XAEkUiIv7RelCrxIMbjSS4L19AbQRcvGDWUU+n/7vGxBMFwi2QKmgyT13BXEMeqYLZCyjH0jqsDIEDQoo=
X-Received: by 2002:aa7:c792:: with SMTP id n18mr581349eds.269.1627487803897;
 Wed, 28 Jul 2021 08:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210728063110.3652-1-xiujianfeng@huawei.com>
In-Reply-To: <20210728063110.3652-1-xiujianfeng@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 28 Jul 2021 11:56:32 -0400
Message-ID: <CAHC9VhSAA5KmeG9-0t=A6wRyxuHZPLpZ4H=HE0FbT1fwcUeFnA@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: correct the return value when loads
 initial sids
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangweiyang2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 2:30 AM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
>
> It should not return 0 when SID 0 is assigned to isids.
> This patch fixes it.
>
> Fixes: e3e0b582c321a ("selinux: remove unused initial SIDs and improve handling")
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  security/selinux/ss/policydb.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index defc5ef35c66..ad1183e18ce0 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -884,6 +884,7 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
>
>                 if (sid == SECSID_NULL) {
>                         pr_err("SELinux:  SID 0 was assigned a context.\n");
> +                       rc = -EINVAL;
>                         sidtab_destroy(s);
>                         goto out;
>                 }

Hi Xiu Jianfeng,

Thanks for the patch, but since you are fixing the error handling in
policydb_load_isids(), would you mind respinning this patch to get rid
of the "out" label and just have all of the associated callers return
directly instead?  I generally dislike jump targets that do nothing
else other than return a value; those 'goto X;' statements can easily
be converted into 'return Y;' statements.

Thanks.

-- 
paul moore
www.paul-moore.com
