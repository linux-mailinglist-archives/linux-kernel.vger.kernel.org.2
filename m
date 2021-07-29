Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845643D9DC6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 08:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbhG2GoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 02:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbhG2GoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 02:44:06 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16EAC061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 23:44:02 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id r17so8983463lfe.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 23:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aNHAvKzLnDE0l22szBAplJPRIyO7Fjn7sOyBfjv9ftM=;
        b=TzevBp24AUTpOKpCI+D8uvXeWR8ycXDOEPiiRHRAu2eZQWaaQ01ysFXZNwT8ggjIPk
         C3SCJXwd6aYveLIThgf85/uMLZ5F/nUnhMaL/l1ZprzFvh2V4Tm7non1BxmQS3LCZIJr
         OTdgxDIsijzxmTfNendVfIpRhAbNYLdOZg9x/T0+VbTlPHseCBx6Vdi8t9BMaLY7B8cZ
         cjCoYXxofDgvt/jM1GLxHvGHQAy9YLc+2hDbqyvlexV2HrL4k3njHJT44enyC0LSQYOp
         q4WSzXombeCZFc8oo36OQ2MoFQz53cmbQXnBBhm9tjmEzYPDmAnCzoQHZjwcWQfF9leb
         UyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aNHAvKzLnDE0l22szBAplJPRIyO7Fjn7sOyBfjv9ftM=;
        b=F1o5jUsUfW+BoBHFdPLW22+RQ+R7Qrp9kHDWuohpNrdJ9LBiTUhVfcHSwRFtjvwTcK
         Fdrff5Sn/T4P7CI+9OSlSljMgjHTfnE4YGWIXRyCow+W1QOvV73XiffafjcRDAx5J5Gm
         yx2E/Q5wQw/nJPEiFJcn+M7lDk2pjnTtHQWZ6xGdIAWpKCkuVKtJfq6qHBLcu4RKSi3S
         11fRrHwFuuuhKoN5lWwoVhP34vypPRpVWZq+HDAZJc30JTJJcJg5nS2Mei61Dl41Pd6o
         Aybhs3UaNRDnjYhENeB9ImjS6jDhcC794YTSbJiDHFcrEgE3mSIJRo5P3zQcCnGT3TGT
         5n2g==
X-Gm-Message-State: AOAM531jpWz9rTWiWpfikCdXMSujF0O3sjSmf9U7r4z9XnXhiHl8yvJ9
        0HXkoeVpWRbdXHKJoSi7PkKyQg==
X-Google-Smtp-Source: ABdhPJxpJbFaurYlEZcpIUIj9510NOv6ZQJA1ULcwdlk/07Q/oZhBgwaXewMrNtwLx5V//7MppqEjw==
X-Received: by 2002:a19:c707:: with SMTP id x7mr2679322lff.38.1627541041147;
        Wed, 28 Jul 2021 23:44:01 -0700 (PDT)
Received: from jade (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id i3sm90427ljd.57.2021.07.28.23.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 23:44:00 -0700 (PDT)
Date:   Thu, 29 Jul 2021 08:43:59 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jerome Forissier <jerome@forissier.org>,
        Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v3 2/5] optee: simplify optee_release()
Message-ID: <20210729064359.GA3316601@jade>
References: <20210722121757.1944658-1-jens.wiklander@linaro.org>
 <20210722121757.1944658-3-jens.wiklander@linaro.org>
 <CAFA6WYOJ6At7p21UuWNp8k4=Qwcb_2VFuV78Z9hksyW76p-fKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFA6WYOJ6At7p21UuWNp8k4=Qwcb_2VFuV78Z9hksyW76p-fKA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 02:15:47PM +0530, Sumit Garg wrote:
> On Thu, 22 Jul 2021 at 17:48, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > Simplifies optee_release() with a new helper function,
> > optee_close_session_helper() which has been factored out from
> > optee_close_session().
> >
> 
> Simplification looks good to me.
> 
> > A separate optee_release_supp() is added for the supplicant device.
> >
> 
> On similar terms, can we have separate optee_open_supp() for better
> understanding?

I'm not so keen on that. It wouldn't be much of a simplification since
we'd end up adding quite a few functions. optee_smc_open_supp(),
optee_ffa_open_supp(), optee_open_common(), and finally
optee_open_supp().

Thanks,
Jens
