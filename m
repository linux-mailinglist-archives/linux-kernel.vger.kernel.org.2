Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F263AA5D1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 22:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbhFPVBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 17:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbhFPVBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 17:01:35 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E857C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 13:59:29 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id t9so3047923pgn.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 13:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NxTx9dcN8kshXBEYUvRxmk5CMBPREQ9LTGjLkVS+6m8=;
        b=XSRKjVo8Azlog98paZINOAdn6bOlODpJpRI653o306QtfNPOx4l2/WQSfD5y9wR2BH
         SQHhuwknCv8x8CcTKk4CDzgYlKoguOL9XSk67LHxzMHxBHgSdolWSYCIPGSeHX2ZhncL
         8sWtQHwjHJc4Idj7Yktb8SbVHCB3LtBMDvHTLPAFJQOxTUqH3If1mEDCBSIxKtyf4TWx
         et6uc8yGbCb7939Xa/7yup5CBc5cPmehbEmh+jH1HOWp7LYBIdAgyPm3I4s118lnbVVF
         mK/rmKWoV1GzT1l49/B9/rAve3E658CnS0Q9c1sbilmZkKC70QxWUwlcIaotqBtlfaLw
         j51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NxTx9dcN8kshXBEYUvRxmk5CMBPREQ9LTGjLkVS+6m8=;
        b=lwEFJicU+NXN2s+M7r5rhnwn349E+dhfv3zFM46j937Ox2hxdSXqfz1aCUCqeRCu6M
         a5MRwTkhxyBf+X1HmL1n/1MI17pcN7e+8OkcI4q0vWdMni/coZMjHDBs1aymekV4Q0IX
         fVof59nN5QqWwyJoClNoJXkCFfDAhFtAk0aoz9ikLl7KOKdrYiCQZIfv7uqX2xxYhTCO
         E0Dz4zSpnnhexTgTngWp7djDw4kvK/hf2sxdnUDI+V/6r0JmI2tkjT61uDuRUBDGcnKD
         dmO6rddO33uBAbwaR0RJG5HatQB/DX+MOrXrRKZyisnqcObwWqbbTUaVhreEFNsag8ge
         2ztw==
X-Gm-Message-State: AOAM532eGENJ/2GoE1faDR/l8LjdKUSJmZIupawTSjJprH/W5lyNr7RE
        EsqFlHp6PfVkgnbHVYivy6E+89TACYP+G7Xs42kkdg==
X-Google-Smtp-Source: ABdhPJwSThC+/qok3aXEqXStN1VNr+fxljFRSu7PHdimacng7JYiDo3UBp9kQp5ePEZKUkVoJ8AIVWdeWxnySfHZQOI=
X-Received: by 2002:a63:d0d:: with SMTP id c13mr1570973pgl.384.1623877168348;
 Wed, 16 Jun 2021 13:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210526082217.333194-1-dlatypov@google.com>
In-Reply-To: <20210526082217.333194-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 16 Jun 2021 13:59:17 -0700
Message-ID: <CAFd5g47WXzmhxsySFmykVQ=XHe2jx0svqcAXpMgYhR5fpTPNPw@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: tool: internal refactor of parser input handling
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 1:22 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Note: this does not change the parser behavior at all (except for making
> one error message more useful). This is just an internal refactor.
>
> The TAP output parser currently operates over a List[str].
> This works, but we only ever need to be able to "peek" at the current
> line and the ability to "pop" it off.
>
> Also, using a List means we need to wait for all the output before we
> can start parsing. While this is not an issue for most tests which are
> really lightweight, we do have some longer (~5 minutes) tests.
>
> This patch introduces an LineStream wrapper class that
> * Exposes a peek()/pop() interface instead of manipulating an array
>   * this allows us to more easily add debugging code [1]
> * Can consume an input from a generator
>   * we can now parse results as tests are running (the parser code
>   currently doesn't print until the end, so no impact yet).
> * Tracks the current line number to print better error messages
> * Would allow us to add additional features more easily, e.g. storing
>   N previous lines so we can print out invalid lines in context, etc.
>
> [1] The parsing logic is currently quite fragile.
> E.g. it'll often say the kernel "CRASHED" if there's something slightly
> wrong with the output format. When debugging a test that had some memory
> corruption issues, it resulted in very misleading errors from the parser.
>
> Now we could easily add this to trace all the lines consumed and why
> +import inspect
> ...
>         def pop(self) -> str:
>                 n = self._next
> +               print(f'popping {n[0]}: {n[1].ljust(40, " ")}| caller={inspect.stack()[1].function}')
>
> Example output:
> popping 77: TAP version 14                          | caller=parse_tap_header
> popping 78: 1..1                                    | caller=parse_test_plan
> popping 79:     # Subtest: kunit_executor_test      | caller=parse_subtest_header
> popping 80:     1..2                                | caller=parse_subtest_plan
> popping 81:     ok 1 - parse_filter_test            | caller=parse_ok_not_ok_test_case
> popping 82:     ok 2 - filter_subsuite_test         | caller=parse_ok_not_ok_test_case
> popping 83: ok 1 - kunit_executor_test              | caller=parse_ok_not_ok_test_suite
>
> If we introduce an invalid line, we can see the parser go down the wrong path:
> popping 77: TAP version 14                          | caller=parse_tap_header
> popping 78: 1..1                                    | caller=parse_test_plan
> popping 79:     # Subtest: kunit_executor_test      | caller=parse_subtest_header
> popping 80:     1..2                                | caller=parse_subtest_plan
> popping 81:     1..2 # this is invalid!             | caller=parse_ok_not_ok_test_case
> popping 82:     ok 1 - parse_filter_test            | caller=parse_ok_not_ok_test_case
> popping 83:     ok 2 - filter_subsuite_test         | caller=parse_ok_not_ok_test_case
> popping 84: ok 1 - kunit_executor_test              | caller=parse_ok_not_ok_test_case
> [ERROR] ran out of lines before end token
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>

Acked-by: Brendan Higgins <brendanhiggins@google.com>
