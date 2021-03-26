Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C9034A17D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 07:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhCZGNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 02:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhCZGMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 02:12:49 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E43C0613AA
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 23:12:49 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id w11so405028ply.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 23:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=HVffRheGZvUm096i8rL3qZdYAPWZa2jcLg62qh4EMbg=;
        b=BN177VN4tIki5x7mq197cJpgGWmB/tDhiLj5PpVbW40dTDlstqyj7/uB0+ZhaiN21g
         I7v0gN6JcwN1MgwK2tedFC1HTPpxiphCtz8xY9bk2hM54Z6Ju8Z+Xe0Aty8lqcrtdrxK
         SgKSnZxr2DfpvYwnjTLteEdgC4wSmExC0ATxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=HVffRheGZvUm096i8rL3qZdYAPWZa2jcLg62qh4EMbg=;
        b=YdwTrW9yA6cFoef223vm5nBLmF7UiaVVVk1vZfxr/euUDTt7hZqTBAmX96fpUV2LHq
         G010vMGHzh+4GxIEFLbuERLIiQiEHuS4yk2lN6qnC2yvJwi4L82TG520prk7Z9rqm/Hz
         YfnYiII4U0F1Z1uDbV6LGXZMSUQrnXhFHR1LRxFvA7eLk7sEfN5+zEyvg0HVA0IJV/f4
         EeDkJMjQknxh4b3duZcWtjG/lVewoC7OIY3TzT5tApcxrBHUrsgxHW1tszBkig/dx6xy
         GN2R8RBMUUpTM6p8en2HvJ8Hsdu8XRtmSAnxjxOE6yMsjHlQYLDU1hLfATmcAmYtEiAX
         AOmQ==
X-Gm-Message-State: AOAM531YCyDd/kFGwho/Qlc6Ovagez13hlYdEs64TjBw3OhY/Z2j+9po
        1iokT7/4JbpoMIOPgdipxCfTGt8XGqVAAg==
X-Google-Smtp-Source: ABdhPJznKFGDHVIciDMw0fp2LT9xK3z4ixOcU51t08f2cxF1LZ/qGOqz6Ubsp1k9rldJ9Yal+YCtBQ==
X-Received: by 2002:a17:90b:307:: with SMTP id ay7mr12146056pjb.110.1616739168822;
        Thu, 25 Mar 2021 23:12:48 -0700 (PDT)
Received: from localhost (2001-44b8-111e-5c00-39c5-e677-fdb8-5d64.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:39c5:e677:fdb8:5d64])
        by smtp.gmail.com with ESMTPSA id m5sm8157716pfd.96.2021.03.25.23.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 23:12:48 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, mpe@ellerman.id.au
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/iommu/debug: Remove redundant NULL check
In-Reply-To: <87r1k2795x.fsf@linkitivity.dja.id.au>
References: <1616406217-94635-1-git-send-email-jiapeng.chong@linux.alibaba.com> <87r1k2795x.fsf@linkitivity.dja.id.au>
Date:   Fri, 26 Mar 2021 17:12:45 +1100
Message-ID: <87lfaa789u.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Axtens <dja@axtens.net> writes:

It looks like the kernel test robot also reported this:
"[PATCH] powerpc/iommu/debug: fix ifnullfree.cocci warnings"
Weirdly I don't see it in patchwork.

I'm not sure which one mpe will want to take but either would do.

>> Fix the following coccicheck warnings:
>>
>> ./fs/io_uring.c:5989:4-9: WARNING: NULL check before some freeing
>> functions is not needed.

(Also, while unimportant, that's technically not the error you fix here
as it's for a different file!)

>
> This looks correct to me, and matches the description of debugfs_remove
> in Documentation/filesystems/debugfs.rst.
>
> If you have a number of similar fixes it might be helpful to do them in
> a single bigger patch, but I'm not sure if coccicheck reports much else
> as I don't have coccinelle installed at the moment.
>
> Reviewed-by: Daniel Axtens <dja@axtens.net>
>
> Kind regards,
> Daniel
