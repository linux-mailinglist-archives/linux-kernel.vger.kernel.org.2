Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1CFC4274AF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 02:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243996AbhJIAbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 20:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbhJIAbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 20:31:42 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BA8C061755
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 17:29:46 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id y3so1387622wrl.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 17:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Sn+ay3w7XhYS/cW7EsEYXtsnzNUJKfJeytfY5AXlNw=;
        b=DQrYV071HwuJ4qlYfUdoEbaiPwF9VWcsVMR3sf204l60jHxe0+LPVxB9A/gRq+kBoM
         9BBswd+Y2c8M85U518SjjraF9Wl7LAK7JNIkGGqmzMwqElCa0F/9QogDB4i/+wi34AA/
         h1LPsXztvj171+0wg5CPSKB3qkRkhH+FJ7WY5cz/5OcsRxKNRdSAy/OOSqRPixMQcvJ5
         Y5ZkhjJ1liEerJI9nGoAgxtkDQU9fCCtCgGb4jlsU4+EuxRgAgtq5uilo15YcnxMhOoC
         PM5LtcrfmzAQz0SKjyw7uuqkomS++53ZgBm7+HZtkTfWkFuCoCl4b2caRL5ZXpzYtRI1
         NTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Sn+ay3w7XhYS/cW7EsEYXtsnzNUJKfJeytfY5AXlNw=;
        b=5/D8NEsbGyWIVfS2zaOYqgzmuyuD/BhfaZhKgUwXiyg1nuEEjIhitXAA4vqdoCAXCt
         TE7qlqatxFlMfUF+wlst2N4o/bz3zASG7o1Udc973AznDHtWQ+SGGf3DVroXBpYc684T
         H1stCHlD77+E9jtr8J7PEiL+I6NbeGYAbDDJpnmPZnOjAx3m/L7uc4mhSCbo62tqIim1
         t0r/aMeOIidJIIrEjA3855ZlbGD3Vd9fU9K7hCESxVez2g6QXgv4qLVISnJPTDL5moFd
         5Q5MAlkwYvrCOi0LSQ/EXqTcttnTBrCIdZFf8Ab94PLf3lDdvXPKldWKkDZg/XrqlaZH
         mK1w==
X-Gm-Message-State: AOAM5321IG2jE5rsLQM59OewU0tKeEeKjY9ac0A1OPsLxPAFyFJv82HR
        e39WldlRKXfReuNoYAe2Qh4OA3d5nkYR34n8io59oTmYh9pYtw==
X-Google-Smtp-Source: ABdhPJw2as5bmHxecz7/0JS4czddYtNYJSsVrXvAoFT7mivsXp/HLhL+2JtXv4Di72c0revJv3TErf9hqexvG9Ouwq4=
X-Received: by 2002:adf:a152:: with SMTP id r18mr7974165wrr.317.1633739384795;
 Fri, 08 Oct 2021 17:29:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211008232421.1264857-1-dlatypov@google.com>
In-Reply-To: <20211008232421.1264857-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 9 Oct 2021 08:29:33 +0800
Message-ID: <CABVgOS=GanpOft7jtKNtyjucE1aaLH8-n3PPmQNCzvdnLAZ1bA@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: fix --json output for skipped tests
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

On Sat, Oct 9, 2021 at 7:24 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Currently, KUnit will report SKIPPED tests as having failed if one uses
> --json.
>
> Add the missing if statement to set the appropriate status ("SKIP").
> See https://api.kernelci.org/schema-test-case.html:
>   "status": {
>       "type": "string",
>       "description": "The status of the execution of this test case",
>       "enum": ["PASS", "FAIL", "SKIP", "ERROR"],
>       "default": "PASS"
>   },
> with this, we now can properly produce all four of the statuses.
>
> Fixes: 5acaf6031f53 ("kunit: tool: Support skipped tests in kunit_tool")
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Ah: thanks! I totally missed this!

Reviewed-by: David Gow <davidgow@google.com>

-- David

>  tools/testing/kunit/kunit_json.py      | 2 ++
>  tools/testing/kunit/kunit_tool_test.py | 6 ++++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/tools/testing/kunit/kunit_json.py b/tools/testing/kunit/kunit_json.py
> index 746bec72b9ac..b6e66c5d64d1 100644
> --- a/tools/testing/kunit/kunit_json.py
> +++ b/tools/testing/kunit/kunit_json.py
> @@ -30,6 +30,8 @@ def _get_group_json(test: Test, def_config: str,
>                         test_case = {"name": subtest.name, "status": "FAIL"}
>                         if subtest.status == TestStatus.SUCCESS:
>                                 test_case["status"] = "PASS"
> +                       elif subtest.status == TestStatus.SKIPPED:
> +                               test_case["status"] = "SKIP"
>                         elif subtest.status == TestStatus.TEST_CRASHED:
>                                 test_case["status"] = "ERROR"
>                         test_cases.append(test_case)
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index 77e61b0a40e8..b3cc0227843c 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -426,6 +426,12 @@ class KUnitJsonTest(unittest.TestCase):
>                         {'name': 'example_simple_test', 'status': 'ERROR'},
>                         result["sub_groups"][1]["test_cases"][0])
>
> +       def test_skipped_test_json(self):
> +               result = self._json_for('test_skip_tests.log')
> +               self.assertEqual(
> +                       {'name': 'example_skip_test', 'status': 'SKIP'},
> +                       result["sub_groups"][1]["test_cases"][1])
> +
>         def test_no_tests_json(self):
>                 result = self._json_for('test_is_test_passed-no_tests_run_with_header.log')
>                 self.assertEqual(0, len(result['sub_groups']))
>
> base-commit: 4a86e2973c31902a2a72f4f25f99b2367188ec5d
> --
> 2.33.0.882.g93a45727a2-goog
>
