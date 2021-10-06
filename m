Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABA4424545
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 19:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239083AbhJFRxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 13:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239158AbhJFRvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 13:51:35 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF37C061753
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 10:49:42 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so2969023pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 10:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BSEO6SLg5H8RZkrrLoY0SelFJ1hO+5cBI62v/ESgIpU=;
        b=SgTxqXJ69J1MJNL9dE5pwTzyaW+HG95CnUbz0sCChkCzI/3pCMzDmlt1R3ikUwU9ek
         i5pvVifXQSrUMLvTj7wjhJm2j8cISbu3VNaOsWcK4FkJhT/4Sm8bLN6eHDQ1fspYiPDE
         u5mjkIqkyiiY+jGBPZH+e76/XMkVvHAA8xNLsraCR483BikE82I9agpzmEqeVAi6r+Vp
         3IXpx/ox0jwEEufY9WYLZ9KAgP/oHCxquHMZu64AoDV3sZhIvHYnqxXz7N0Lj5RCvvTY
         5yAJZkKbLfB5tcBV45exAAZCBdoASiDtL0RpfsuBhSIVtpOp2YZu/bfoTDekSVjXmxsb
         56Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BSEO6SLg5H8RZkrrLoY0SelFJ1hO+5cBI62v/ESgIpU=;
        b=Bu/cTjYrHf4uDzHR3QNyIhLHNY63yBIaGsIPXsD69Q7+1dZsiUIKYN7ctBjpirHx8S
         2tqJ7O23Xu087x/MZhN9co75lp7KEf+NWFIGvFZZe0l40k3pHIvx20PcBPVQ4oN77ajZ
         eCDvCIcOZ14s8qc1JQYYfSREtU6xNu4WfYN1+PrG5I6H/FTfp28QvHK2brjVmSz/42Jt
         SwGIT4Exz0aYVJSJkRjq+Ry/ABpqCdGPRhlTjtDnWqKlacEFEn36gSeV1lWFyP4qK9X8
         CqAZrmj+pcVxfDcSQ3G+UOe8kp0OhI9b5KKp/QBOssYsCMkQxiIZywSM3zKNn5zkrWFF
         flKw==
X-Gm-Message-State: AOAM530H5CzcDl+FauNMSv0Tx/q7Hjv8rDGvw1MCWo0iLUS5VHlS4kai
        XYHNT1gHoUCNaNfKnHdT5tOTmG54O+BW5eB9wv2YeERj2cu4HQ==
X-Google-Smtp-Source: ABdhPJyNWMvwSzWU+KRjwbIpNloablcFluidmdSC6ypItnUMNKelanRCRJ7nAwDZXakZnQJ9XTDJ6o2UH9KE3nr410I=
X-Received: by 2002:a17:902:6f17:b0:139:eec4:867e with SMTP id
 w23-20020a1709026f1700b00139eec4867emr12228038plk.77.1633542581985; Wed, 06
 Oct 2021 10:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211005011340.2826268-1-dlatypov@google.com>
In-Reply-To: <20211005011340.2826268-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 6 Oct 2021 10:49:30 -0700
Message-ID: <CAFd5g445HFVd0e=r7y3JELCPkD=_T7QUq2K0BgKEeyG2Hi2qgw@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: tool: yield output from run_kernel in real time
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 4, 2021 at 6:13 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Currently, `run_kernel()` dumps all the kernel output to a file
> (.kunit/test.log) and then opens the file and yields it to callers.
> This made it easier to respect the requested timeout, if any.
>
> But it means that we can't yield the results in real time, either to the
> parser or to stdout (if --raw_output is set).
>
> This change spins up a background thread to enforce the timeout, which
> allows us to yield the kernel output in real time, while also copying it
> to the .kunit/test.log file.
> It's also careful to ensure that the .kunit/test.log file is complete,
> even in the kunit_parser throws an exception/otherwise doesn't consume
> every line, see the new `finally` block and unit test.
>
> For example:
>
> $ ./tools/testing/kunit/kunit.py run --arch=x86_64 --raw_output
> <configure + build steps>
> ...
> <can now see output from QEMU in real time>
>
> This does not currently have a visible effect when --raw_output is not
> passed, as kunit_parser.py currently only outputs everything at the end.
> But that could change, and this patch is a necessary step towards
> showing parsed test results in real time.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Awesome! Thanks for finally fixing this!

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
