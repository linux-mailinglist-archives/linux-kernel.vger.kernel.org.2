Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2097D442EB5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 14:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhKBNEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 09:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbhKBNEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 09:04:00 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17F9C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 06:01:25 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id o8so3868614edc.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 06:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=crOdWIptmZf8pxuA44UGy8HjdRzPcXaL0S7+PbsVXCw=;
        b=uM2/yEc3wJOV43Ww8NFzmRxkBvSIKHAodWe/j0cVfcMazlov7BrhSaTlO/49sD4yem
         eQkVMV2iqd81HkR+dR91e+wbft5u1Oksg7m0GOaaiMVgKVVTfWz9Ho2zoUj4nUPNqh6l
         /o3Bh4iRPaiWHi3NXXHYltpmRK0u6NXlntsCzeuLynZFYIKRGU4XXq3MqKiAYQYadSww
         sYS2wGNvTgum4l56kQD7OpFKYfkYuUtW8Gl/G8cZAlBSrgwbgQndAvxNIZcvfykNZkiA
         jik5G0bPKcmN+HWY1G0aALtVo4lOnE7EB1tNxYPOwUw/uQiMOfzJ+qW/VWM/Dx9i9jqK
         1FsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=crOdWIptmZf8pxuA44UGy8HjdRzPcXaL0S7+PbsVXCw=;
        b=JHvtNXAq5nIunnNvz/UBSAAerFDLQHQo0bb1opzTGSqXA30PAGQ4UlS4TTar25zMWn
         sLI39ZVAiGYPI0a9vYxnhLb6oqR/EvXwHzh/E4n/SXvJDUnzOtdxHWMemaStsbD5+QR8
         axyZ6Nm1loQjwnSiutdsl9zcNpK/K1q0+GogD3Hr+1Yd905g4aMkOKryBuMD5APcwNIx
         mSJiCjeVTtV40L4dSVI6jXfVv1ScD92UzmVt+mIF8ZQde2av4WbE4BiacxTmwVUNQS7S
         nknp9LhbxNOuXge3TI0zs9zYLUVv7JEJSlTr1UgC1I3KNUu30eOsMJ6qAS8lEqsx+PMU
         xgOA==
X-Gm-Message-State: AOAM530uJsPUlKsWxnXVrDLWJHiMZ0NN6L6K8jZz+kw7HvhFBewHNdzz
        maeofbCHfhtqEcr4hQbO9dEzHy1TLbEyu7sqzJop
X-Google-Smtp-Source: ABdhPJwfePdaN+I1n/+fDRDVgSB4FkutIKTWIUcdi6y3Q8YAR349Lg21C8y1bXwdN/SMsY4c2WJKDKTVM3X2GC4+iXg=
X-Received: by 2002:a17:906:f90c:: with SMTP id lc12mr35950408ejb.104.1635858079376;
 Tue, 02 Nov 2021 06:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <a4b3951d1191d4183d92a07a6097566bde60d00a.1629812058.git.christophe.leroy@csgroup.eu>
 <163584790624.1845480.1785827913484538939.b4-ty@ellerman.id.au>
In-Reply-To: <163584790624.1845480.1785827913484538939.b4-ty@ellerman.id.au>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 2 Nov 2021 09:01:08 -0400
Message-ID: <CAHC9VhROvSQHVQ6Wo8zHND1rGm+r6dGJur69B65sJ9JwNvMDpQ@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] powerpc/audit: Convert powerpc to AUDIT_ARCH_COMPAT_GENERIC
To:     patch-notifications@ellerman.id.au
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        linuxppc-dev@lists.ozlabs.org, Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 2, 2021 at 7:38 AM Michael Ellerman
<patch-notifications@ellerman.id.au> wrote:
>
> On Tue, 24 Aug 2021 13:36:13 +0000 (UTC), Christophe Leroy wrote:
> > Commit e65e1fc2d24b ("[PATCH] syscall class hookup for all normal
> > targets") added generic support for AUDIT but that didn't include
> > support for bi-arch like powerpc.
> >
> > Commit 4b58841149dc ("audit: Add generic compat syscall support")
> > added generic support for bi-arch.
> >
> > [...]
>
> Applied to powerpc/next.
>
> [1/1] powerpc/audit: Convert powerpc to AUDIT_ARCH_COMPAT_GENERIC
>       https://git.kernel.org/powerpc/c/566af8cda399c088763d07464463dc871c943b54

Did the test failure discussed earlier in this thread ever get
resolved?  If not, this really shouldn't be in linux-next IMO.

-- 
paul moore
www.paul-moore.com
