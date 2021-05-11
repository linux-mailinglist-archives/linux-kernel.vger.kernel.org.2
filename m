Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A938A379C47
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 03:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhEKBuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 21:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbhEKBun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 21:50:43 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFD3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 18:49:36 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y26so20944727eds.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 18:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GC+jcwYuSlGwJ2d485mepP4KelpwOyaTe94c08xajfQ=;
        b=xZeeTRD1Py3Ep5O8bkGrjjCbMORAPBblaI9SG5G7RNQvcwF81lU7VKMHEEx/RZbbis
         H+eTlm5BQh3XW4suI5xn6He5ui1geRSvdmxGw4kDXGHZMKzThcUNQBrc+QPsOjF7ecNi
         X3Ks+DVHKy+IDRyoi+WPFcJLy86hLZar9QnLg9lHmteELQIN38+03VEyGnZOpOfUBFEr
         iibOmzhCeqDu4tLZCsCNDGf622ynCiSOu+5B6xFKtD7kxriPKDFGNwFqs8a/FQOAV/PT
         eoJMf0C+Q7LrtUzVpQk4L8TK50IWSjEPOjPhbzqV2bBicMp2n2Ty6nLRMnISFyJfAxqm
         huCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GC+jcwYuSlGwJ2d485mepP4KelpwOyaTe94c08xajfQ=;
        b=YovvBN/1yTjVB3Ff9IvGgj+w1HNcmHzEf572fUKTbepJL7cr+Gsyl0b7fZNwz+r2Yf
         hgMAT/NGxJlsfFx8JBNGoRBwmLVKYoa2g4nK4NnvisQnwYBf6HOFLoBR7JMPYVc+lcV1
         mJN0MX4oWDkCzcBLbZgoVF+XmkLI+1hgBxPOPjOnXYlXoj7ITCaNVPCRGTWTNjyCl1Km
         Q5yThEfeBlTytTK0VKJToHYVydIGLB4iUN1efn9sp2nolFaHPyh0EEH7EXTcNiS8oY4r
         WcUvD5g95f1XigvGh1zK9SXasUukoFIdFffPDmfR8x5cjognUBmky1Url1t5UnswDlQA
         GMLQ==
X-Gm-Message-State: AOAM530Vbj86LF3xa8yOyEAlJdSqw+pS39BxAq3hGU/R+BdlGBdu0Qj4
        LSJTTypyNU8nF0Gl/+QfoPONgQVfUSyOQdUrvR8P
X-Google-Smtp-Source: ABdhPJwjVnamGG/jYjAW0Ym/j+pyybJ9iee8648B3crpa2HR6Of28omAtKhJZFw8AuC+pWNa7k/q/lNaLnMvtk51mew=
X-Received: by 2002:aa7:de9a:: with SMTP id j26mr10088284edv.269.1620697775288;
 Mon, 10 May 2021 18:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <1619604015-117734-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1619604015-117734-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 10 May 2021 21:49:24 -0400
Message-ID: <CAHC9VhSxDoxnKrw+bZQ18YVMm56ajza4wzFv=3L3SZf7qd5QgA@mail.gmail.com>
Subject: Re: [PATCH] selinux: Remove redundant assignment to rc
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 6:00 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Variable rc is set to '-EINVAL' but this value is never read as
> it is overwritten or not used later on, hence it is a redundant
> assignment and can be removed.
>
> Cleans up the following clang-analyzer warning:
>
> security/selinux/ss/services.c:2103:3: warning: Value stored to 'rc' is
> never read [clang-analyzer-deadcode.DeadStores].
>
> security/selinux/ss/services.c:2079:2: warning: Value stored to 'rc' is
> never read [clang-analyzer-deadcode.DeadStores].
>
> security/selinux/ss/services.c:2071:2: warning: Value stored to 'rc' is
> never read [clang-analyzer-deadcode.DeadStores].
>
> security/selinux/ss/services.c:2062:2: warning: Value stored to 'rc' is
> never read [clang-analyzer-deadcode.DeadStores].
>
> security/selinux/ss/policydb.c:2592:3: warning: Value stored to 'rc' is
> never read [clang-analyzer-deadcode.DeadStores].
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  security/selinux/ss/policydb.c | 1 -
>  security/selinux/ss/services.c | 4 ----
>  2 files changed, 5 deletions(-)

Merged into selinux/next, thanks.

-- 
paul moore
www.paul-moore.com
