Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A8D429BAF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 04:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhJLDAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 23:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbhJLDAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 23:00:48 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EBBC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 19:58:47 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id o20so61921997wro.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 19:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Ec/hb1Y/9LCVoUftmh0qiQK8eNZx2rEOUkHSa/obH8=;
        b=dEijaRIgDhnCyjENpotMHu+8LX+4UZti7TOsXZisXk+ub5UMPjIQpB8y4lEDBKDOF6
         61U3cA592zpYaWpJEvfZhzyhXbole5q9gxoY+DkERAltHN5FZUFfbn0gRV4dGUeWeNnx
         2DQaBCfLRPu6X5AFfGvRN2PR7OA38QYnFAaQxGl6X1XE02ArPYR4uirLtSdYgi5sBYv8
         X8wsMjPZyNsbPFftQ4UltEWaSn73BvhVWiyYDH4KzKdMD4W99EfPQOy59ChnwvDCZpoL
         xBLRBT7UC00RMisE5jtWI2ws1FyYUeVpUxHFu6Ktjg+tSiddGy6UolPzV++Ac0F+aBB1
         xMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Ec/hb1Y/9LCVoUftmh0qiQK8eNZx2rEOUkHSa/obH8=;
        b=h5yRD1+0iWlr4rUX6FYn3Y+sagvVBs3VD3fs3/Yl8aVEXU20M9D7rOOGo2PIxHz51g
         cg6Hsx1eiNJ7rzZ+T/hAWhm1Ob9ri0BHSiCJZsoP/w06mHOZP+MPeiuq0Gd93HfXWFkQ
         Y1DIS7spVMr/1iTev/4Ag++7bJJVSrNm8Sk8ZQ6NNPicD31UKMzdb4n4ygf2Z2s88abu
         1Qo4cYqjqCm9/9dSa5ZKFHGwYkK5KufMfa15BzUdOcUUqxjyqqmIYLZgpECDgBUP0pmI
         TerXi+zCVpynjgaC7E1o04MfOCr/fP5nUHz+L8Y293S0HNSZ0EPUPRWSk0pbuS3gIIp7
         WU8w==
X-Gm-Message-State: AOAM532kDjK8eZdn5LV5pFjI1KhOIqfrgIuzbkEHpyFgCG106vY46qUP
        wy8mEj/+VvW0H079JweMJRj6jFagb2nD3HvgR60dqQ==
X-Google-Smtp-Source: ABdhPJyFQFwqcN2RSPHCu5qZPjvCTeSqTLHS4FBPAfWS26eg9QNYmX86ow8kwWCGOkNWVH0l1r8+OsqFDuisil7nxyU=
X-Received: by 2002:a05:600c:284b:: with SMTP id r11mr2882582wmb.179.1634007526109;
 Mon, 11 Oct 2021 19:58:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211011215037.1629208-1-dlatypov@google.com>
In-Reply-To: <20211011215037.1629208-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 12 Oct 2021 10:58:34 +0800
Message-ID: <CABVgOSn_27uKpu7FEHUWfFNrhRmmwf+5aS_vbRfa5OZDYJwepA@mail.gmail.com>
Subject: Re: [PATCH v8] kunit: tool: improve compatibility of kunit_parser
 with KTAP specification
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 5:50 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> From: Rae Moar <rmoar@google.com>
>
> Update to kunit_parser to improve compatibility with KTAP
> specification including arbitrarily nested tests. Patch accomplishes
> three major changes:
>
> - Use a general Test object to represent all tests rather than TestCase
> and TestSuite objects. This allows for easier implementation of arbitrary
> levels of nested tests and promotes the idea that both test suites and test
> cases are tests.
>
> - Print errors incrementally rather than all at once after the
> parsing finishes to maximize information given to the user in the
> case of the parser given invalid input and to increase the helpfulness
> of the timestamps given during printing. Note that kunit.py parse does
> not print incrementally yet. However, this fix brings us closer to
> this feature.
>
> - Increase compatibility for different formats of input. Arbitrary levels
> of nested tests supported. Also, test cases and test suites are now
> supported to be present on the same level of testing.
>
> This patch now implements the draft KTAP specification here:
> https://lore.kernel.org/linux-kselftest/CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com/
> We'll update the parser as the spec evolves.
>
> This patch adjusts the kunit_tool_test.py file to check for
> the correct outputs from the new parser and adds a new test to check
> the parsing for a KTAP result log with correct format for multiple nested
> subtests (test_is_test_passed-all_passed_nested.log).
>
> This patch also alters the kunit_json.py file to allow for arbitrarily
> nested tests.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>
> ---

Thanks -- this fixes the KASAN issues for me.

Cheers,
-- David
