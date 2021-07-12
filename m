Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815873C63D7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 21:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbhGLTp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 15:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236414AbhGLTp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:45:26 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C53C0613E5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 12:42:36 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id o8so9991839ilf.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 12:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=miTV5hqnW4EPZWVXufx2n/PRXkTcJW4p7CWdR36CIew=;
        b=LMSzFCaiR4GD3YI1boTGrHQJHxKnm8Ougeao4dN2yHS0QKhB4xUL1ZCfjic3q2Lv2V
         w+OTnd6oxZJdqe0O+uu9DnqfLndb0oPX6nMefi/FkHZgthaj5lM1/w8YBCl5smhTu5hS
         fQEO2g4RSJNMfwMs90sdR2uFF+MEAAVoi+P48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=miTV5hqnW4EPZWVXufx2n/PRXkTcJW4p7CWdR36CIew=;
        b=Dy4gtxpSY3TmsUPVlxVIgZTdsJIyRBY8o6uhPT3ymw5OCq6IHoaEx+d447ZYwDB2mW
         Cnd4lPC+DbDu54Qb5LCkM5fnhqtfF4FRpUaNq+yN8EjoRLlQCHVUymTcTHPMkQeFWNrO
         +ykJ8rQ8SHZBoENXP11tRfTWBhWYvK9DAbiONMehpxunoHE4o8xiRCUdD1r5JAmQu2AK
         xf1cdpkjnzTyaEX3Ga3emFcBBOBQdYMP55LlF02Ds23Y9WssfADLhprAxGbiLi9xqJeu
         qFnZX1NXvhZz+HblZOxfjTKXpJ3l8BMICHQdLWoqA22fvlL+YRITnkjZDdpo7IROfd6E
         njmw==
X-Gm-Message-State: AOAM531HwycyHt+5I0696FuZnEW2xAgq8K5A2y9Q6ZEJKdP7Oh2VLDyN
        X41/iZwezoCVa9Dza0Rzl8ZMIA==
X-Google-Smtp-Source: ABdhPJw+D9Y0t0uSlGkP9VzCV9UbbIM3ffohaXASpJ/ygzivQ+RnraMTivofQpig2E8WneA/SSmY4A==
X-Received: by 2002:a92:360e:: with SMTP id d14mr361226ila.106.1626118955879;
        Mon, 12 Jul 2021 12:42:35 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e14sm8606044ile.2.2021.07.12.12.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 12:42:35 -0700 (PDT)
Subject: Re: [PATCH v2] kunit: tool: Assert the version requirement
To:     Brendan Higgins <brendanhiggins@google.com>,
        SeongJae Park <sj38.park@gmail.com>
Cc:     dlatypov@google.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210617073937.16281-1-sjpark@amazon.de>
 <20210617074638.16583-1-sjpark@amazon.de>
 <CAFd5g44Y0a6HneG+RA-brhJSG+S7GEJSuwGgHCkFssy9vbmuzg@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6fb4706b-ce58-a397-d777-10338c2a8d4e@linuxfoundation.org>
Date:   Mon, 12 Jul 2021 13:42:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g44Y0a6HneG+RA-brhJSG+S7GEJSuwGgHCkFssy9vbmuzg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/21 1:41 PM, Brendan Higgins wrote:
> On Thu, Jun 17, 2021 at 12:46 AM SeongJae Park <sj38.park@gmail.com> wrote:
>>
>> Commit 87c9c1631788 ("kunit: tool: add support for QEMU") on the 'next'
>> tree adds 'from __future__ import annotations' in 'kunit_kernel.py'.
>> Because it is supported on only >=3.7 Python, people using older Python
>> will get below error:
>>
>>      Traceback (most recent call last):
>>        File "./tools/testing/kunit/kunit.py", line 20, in <module>
>>          import kunit_kernel
>>        File "/home/sjpark/linux/tools/testing/kunit/kunit_kernel.py", line 9
>>          from __future__ import annotations
>>          ^
>>      SyntaxError: future feature annotations is not defined
>>
>> This commit adds a version assertion in 'kunit.py', so that people get
>> more explicit error message like below:
>>
>>      Traceback (most recent call last):
>>        File "./tools/testing/kunit/kunit.py", line 15, in <module>
>>          assert sys.version_info >= (3, 7), "Python version is too old"
>>      AssertionError: Python version is too old
>>
>> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Your from and Signed-off-by email addresses don't match.

Please resend the patch with the correction.

thanks,
-- Shuah
