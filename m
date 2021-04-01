Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7266B35103E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 09:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbhDAHlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 03:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbhDAHlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 03:41:05 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD6BC0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 00:41:04 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so1354391otn.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 00:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D/ulkwguw7+8k5/tAEJnWieZv2I5VNSiJKBdc0AK5cQ=;
        b=QXMzJnX9o7ltI8gwhP/juDSXcuSSWP8jUVZ+4XCWXpU11sD04A/iqibPLpXZGCjigH
         jGcIpduX80123m3QFZ4yKzMtIyy+rc8Ywp6mmgd/umoBQf2A+Kqak55shjtB7S4hEBrC
         4abCMSSb5OwbT9LulAymHbL2MLDMVQuc3juL8fnjzGK3cR+QwWlxk8qqJFPX2BCeJIRu
         9wJ/F9BPiMSDVlYcCBsgnHnmra9k7Iy9Zl5jmfUSHAOttJeQGDs1ncdqKskSO+9QtYlq
         A704XoWYMrxr8s4gRZn+up8yrMsShSSG1cIlmZJCntj31dWtpSxb+69MbwUJMW90NcbS
         9mNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D/ulkwguw7+8k5/tAEJnWieZv2I5VNSiJKBdc0AK5cQ=;
        b=NSKKcH7HrI/EeEAFLiz3puPhvMSM7B7MWbhcNCP1tNGG3toL2VjSxAV3c7D6elcWnu
         +xImaSjQr7qn2z3PKUFrnCUbCzV4yT5vmYVY6F+RHSubPn9j6xKvf0Kz1Su36KL9I4Y9
         Pr4kPApN5FaN0r47RNF+095VouwCtIYnZf3ldJAB4JIkMbGMkvf+NmcOzrgd7FOjLfn9
         29AlPpiQ/5axmJCgecxk2ILiiBFCVOuSBhU7r3WrL16bARuTnnsqY3WYGDr5hzCfZRVJ
         2QYXzHE8GgXhjQd7+wo/LasjDz1n6vt8gkr+JdaIVQ+VR8ROFVDDoHmwG2C++m7OyrSs
         8plQ==
X-Gm-Message-State: AOAM533PUP3AeLsJsiptoF+a1yfjFC5OEk+U8xwiZ9ZmJlau1G+vAZU4
        XFnjWT7PLRpdauw7cxA85tYOLoDmrtdUpOc6D5wy2g==
X-Google-Smtp-Source: ABdhPJyzEPbGKYrpWTzMGCrp+pxhaMUghQXcT/ersJ9IEUY4peFT3S2PF5HnHEWT0SEIElMaN88hIDOGqKyjAAalAv4=
X-Received: by 2002:a05:6830:1b7a:: with SMTP id d26mr5850595ote.324.1617262863644;
 Thu, 01 Apr 2021 00:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1616409291.git.jerome@forissier.org> <010001785986e9be-63aa88ce-3cf8-425f-87da-b2e3f84f6ef5-000000@email.amazonses.com>
 <CAFA6WYPryB+9W6EGXvea07=JH8_cfHKF8a4BDEyPeqPVkzvutw@mail.gmail.com>
In-Reply-To: <CAFA6WYPryB+9W6EGXvea07=JH8_cfHKF8a4BDEyPeqPVkzvutw@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 1 Apr 2021 09:40:52 +0200
Message-ID: <CAHUa44HYkxMZpGx=iVKPqTSyTVhLm9L+_OkcNoAqGMmVjU7gxA@mail.gmail.com>
Subject: Re: [PATCH 1/1] tee: optee: do not check memref size on return from
 Secure World
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Jerome Forissier <jerome@forissier.org>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 3:18 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Mon, 22 Mar 2021 at 16:11, Jerome Forissier via OP-TEE
> <op-tee@lists.trustedfirmware.org> wrote:
> >
> > When Secure World returns, it may have changed the size attribute of the
> > memory references passed as [in/out] parameters. The GlobalPlatform TEE
> > Internal Core API specification does not restrict the values that this
> > size can take. In particular, Secure World may increase the value to be
> > larger than the size of the input buffer to indicate that it needs more.
> >
> > Therefore, the size check in optee_from_msg_param() is incorrect and
> > needs to be removed. This fixes a number of failed test cases in the
> > GlobalPlatform TEE Initial Configuratiom Test Suite v2_0_0_0-2017_06_09
> > when OP-TEE is compiled without dynamic shared memory support
> > (CFG_CORE_DYN_SHM=n).
> >
> > Suggested-by: Jens Wiklander <jens.wiklander@linaro.org>
> > Signed-off-by: Jerome Forissier <jerome@forissier.org>
> > ---
> >  drivers/tee/optee/core.c | 10 ----------
> >  1 file changed, 10 deletions(-)
> >
>
> Looks good to me.
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

Thanks, I'm picking this up.

Cheers,
Jens
