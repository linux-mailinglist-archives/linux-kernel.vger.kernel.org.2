Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9902734A12D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 06:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhCZFxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 01:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhCZFxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 01:53:34 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F01C0613B0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 22:53:34 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id e33so3850929pgm.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 22:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Y5ZjdJD9lzvGZs8O1aH02ljto+6/HMHLz2PN6E96Pug=;
        b=CaEdMjdPFsNQtsnqEoUfORzxLDuQRxtrsYrOLPFikD4kq50sV2x5oio9MhZoEoc5iG
         E0DqeYaqmycRLMslOfJS+tMMcH2XwClWM3P2iEKzn0sBU8i/KIHI35ZFLUYdbyvWPMww
         JI4jBgbJDInR8yZiOsMCKKkSIda15ScyLLBiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Y5ZjdJD9lzvGZs8O1aH02ljto+6/HMHLz2PN6E96Pug=;
        b=NfOCtqYlT1KOaYfofR88xzF0gx48p34AE90iNGSjokIKN3+kPn9wW+g7PejDGv6Z4Y
         lmmjqGiN6u2wQRKJOzrPGBxMjLCyxE0pNcJCXNV+zKkem4hO2SC6J+6YMubJQiEuW7B2
         oh0V71TnlR06FE1PU8h0JQ45JWFciEhK/ldTPMtSzJ6EIA9KtbDMTpGdo0tsm91lq/o/
         Jc64JEKqM/N2Kq8PtBeRJzENFsfGqryqwjBxWIoZUDaoLbxBIonJtlQx8BGKk01U/kPv
         E2ZyUeoQMOSI+hLfVPSzfG2GPNhNVbKWhQzOyUni4Fvm8fZhbIAiTELAQiPiADd9j/so
         6rGQ==
X-Gm-Message-State: AOAM530BcCUV4fdQW3yGrEksQAc1j33eURpihwEY4o8JZe8YcwJgSCmS
        i9qSA+nSv3bISijPOlrpzVnk5w==
X-Google-Smtp-Source: ABdhPJz9qBbGit+YZ97K9knhsbT2xS6mWEQY3kaqtF45tSGVY1j7Ee7CXeJ/NbWNykkL5JLWWMziow==
X-Received: by 2002:a05:6a00:72b:b029:218:6603:a6a9 with SMTP id 11-20020a056a00072bb02902186603a6a9mr11018722pfm.78.1616738013763;
        Thu, 25 Mar 2021 22:53:33 -0700 (PDT)
Received: from localhost (2001-44b8-111e-5c00-39c5-e677-fdb8-5d64.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:39c5:e677:fdb8:5d64])
        by smtp.gmail.com with ESMTPSA id l190sm7708477pfl.73.2021.03.25.22.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 22:53:33 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, mpe@ellerman.id.au
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/iommu/debug: Remove redundant NULL check
In-Reply-To: <1616406217-94635-1-git-send-email-jiapeng.chong@linux.alibaba.com>
References: <1616406217-94635-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Date:   Fri, 26 Mar 2021 16:53:30 +1100
Message-ID: <87r1k2795x.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiapeng Chong, <jiapeng.chong@linux.alibaba.com> writes:

> Fix the following coccicheck warnings:
>
> ./fs/io_uring.c:5989:4-9: WARNING: NULL check before some freeing
> functions is not needed.

This looks correct to me, and matches the description of debugfs_remove
in Documentation/filesystems/debugfs.rst.

If you have a number of similar fixes it might be helpful to do them in
a single bigger patch, but I'm not sure if coccicheck reports much else
as I don't have coccinelle installed at the moment.

Reviewed-by: Daniel Axtens <dja@axtens.net>

Kind regards,
Daniel
