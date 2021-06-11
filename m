Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5273A4764
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 19:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbhFKREk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 13:04:40 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48]:37874 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbhFKREe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 13:04:34 -0400
Received: by mail-ej1-f48.google.com with SMTP id ce15so5562136ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 10:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rF3RW+vRTBdayrkEmU143aymaoHBMTIDi13FY84zy6k=;
        b=fNCIy4gcV+jUjxgmOzD8+ule7JxCtIt9PlXXjCK/F5siLoXPXuKRveEXNmmAyyi2kp
         Aa/Y1cOXgLGrmKSCs5TjzoQgx9OoRxhmez/7qIZ0M2gu8IoIV2SH/mEMObTWa20aiNTG
         UTjBUuQt/pW9UXnxcZFlDnWeQFf9oBAnC+KCqrGgI03xpR+BWXJzkobcLWyXfWmkirip
         PZlS9weU5Ou9WPDMeXhh9ljNAHqSVyQ3SMp/tbNmSSczT4B9oXFrIuGdmQY572uOsqiy
         UAG6+Yi2MG9BQCUS/Kh+CLe9vMwwObrYg2/CKtE5oFhZQhivA3gC25RWfWrTaeD9XLDZ
         GMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rF3RW+vRTBdayrkEmU143aymaoHBMTIDi13FY84zy6k=;
        b=rcckFwA+k+NkC7RRtGVvBbJl4XVOO+zRR3Y1EOph9DX5SGYXn/SPF9N8G9UQG36oLL
         t10iVHKXsdJMenlqORd6kbBMZmFTtQU2SM4MAUWs30K5UuUwb23mCfrMJ+XiuFcFpkLn
         a/1wSVLUCa5RdvRbsRlMbceq6FT8nSjbYbWzyiXPrFTDA2fI7UZJF1CgxNCyzZzufVlX
         G1V8wBM1c//DlX5ij5py3OMep3OJtc1PgeAilE5AHdOQRU6A9QEV8NG6zkN4uT3sn9P4
         vzVEn5WrYuhQkOE6yuDy16mZGQa27Mgr/EEwcFUVE1gj003PKh5o4cilkuPS4zZvqwnu
         DDqQ==
X-Gm-Message-State: AOAM531qwUv/vDCjh54dNFjJu998Vj6fqMmn/U/jKqiXDRVGmeRHeEeB
        32h2N1/4GCSJ25f1Ezx0r7QiQUUR6+P5Rjc35DUz
X-Google-Smtp-Source: ABdhPJwmTNWPO4JGLsdadACYta6CeOAq/UXMknSjqgw0d3bEuEX+uGxP6oYimSVp5XzRcQC4L7uXqr5Q+aU9AobwCl4=
X-Received: by 2002:a17:907:3d8e:: with SMTP id he14mr4663408ejc.178.1623430895727;
 Fri, 11 Jun 2021 10:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <1623406567-51427-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1623406567-51427-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 11 Jun 2021 13:01:24 -0400
Message-ID: <CAHC9VhT2mmgL8Vnrb35BEJkq+Wo2fT3Fc-HD51PwMyNGmsAWJQ@mail.gmail.com>
Subject: Re: [PATCH -next v2] selinux: Fix kernel-doc
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, nathan@kernel.org,
        ndesaulniers@google.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 6:16 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Fix function name and add comment for parameter state in ss/services.c
> kernel-doc to remove some warnings found by running make W=1 LLVM=1.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>
> Change in v2
> --Add comment for parameter state
>
>  security/selinux/ss/services.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)

Merged into selinux/next - thanks!

-- 
paul moore
www.paul-moore.com
