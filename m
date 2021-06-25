Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A6E3B478A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 18:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhFYQp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 12:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhFYQp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 12:45:27 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6611C061766
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 09:43:05 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id o5so13262568iob.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 09:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RHV+/zrIquX80RKbS0sbQ2gW9C8MVP+CZSH2W0wTqxk=;
        b=fbG5DaYduOlTHBsnWcMXQLC7RvVJFJ1HkGgi5w+3fi6LISbJOInGALiLBB8gCVag6P
         xXfJl8moi2u+4Apv0llQ0M9oqotypZ5l2IFehzNzrV2w56TmTiR3eOASqU9YyN2FXEW8
         0BhKvCWuNOFCNp4dLZ1mzZZcrb3lQ+3JEdIqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RHV+/zrIquX80RKbS0sbQ2gW9C8MVP+CZSH2W0wTqxk=;
        b=snitN7tIUk7kPXfccKCQnY6aFf/fMopAiqFiK7NFv3aPfrsC+ChaqUEFlxBWvA2YQu
         7NlzVLiEYNNTI57cjEv0nHqC0d5TlnJxVIRKUB/YhYNWkum3vlmV/6kj+FSfANYnfiX/
         AKb9pl43aYwR04VvBGouldbqBaUi07swuwcdi5QxXMQfBoCYPk3OiyZ2/AzUy6aXREn7
         9zTFdRJb6nIebI08w4CMtYL1dnVkH10PN2kpVeGjRX8BDHpn+7JgmZl5yYJc9OOAl69b
         xLVmFYrghfGQOYFeaK4B45dIbfUUuD3fo5kRjjnmi6Senxp1mVGmaXCk8mwDIcnjz14I
         5qPQ==
X-Gm-Message-State: AOAM53214IV4dZVy/eILBudlVHEKmmKCrgJbgk13TZNohURL/ze2VddD
        KD/LKfSwRKVqjyxV4pFqdkVMYQ==
X-Google-Smtp-Source: ABdhPJwHTW0LxtmcB+v4vjGRGZ8NSd+XqQtRktCpzzbDDZxKOzpUaqI3apAsX8itk1RPU27TMeLDaw==
X-Received: by 2002:a02:b19b:: with SMTP id t27mr10226820jah.29.1624639385063;
        Fri, 25 Jun 2021 09:43:05 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r7sm253214ilm.61.2021.06.25.09.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 09:43:04 -0700 (PDT)
Subject: Re: [PATCH kunit-fixes v5 1/4] kunit: Support skipped tests
To:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Marco Elver <elver@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210625065815.322131-1-davidgow@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <2521712b-fd96-04a8-dde1-30efe0fdfefb@linuxfoundation.org>
Date:   Fri, 25 Jun 2021 10:43:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210625065815.322131-1-davidgow@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/21 12:58 AM, David Gow wrote:
> The kunit_mark_skipped() macro marks the current test as "skipped", with
> the provided reason. The kunit_skip() macro will mark the test as
> skipped, and abort the test.
> 
> The TAP specification supports this "SKIP directive" as a comment after
> the "ok" / "not ok" for a test. See the "Directives" section of the TAP
> spec for details:
> https://testanything.org/tap-specification.html#directives
> 
> The 'success' field for KUnit tests is replaced with a kunit_status
> enum, which can be SUCCESS, FAILURE, or SKIPPED, combined with a
> 'status_comment' containing information on why a test was skipped.
> 
> A new 'kunit_status' test suite is added to test this.
> 
> Signed-off-by: David Gow <davidgow@google.com>
> Tested-by: Marco Elver <elver@google.com>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> ---
> 
> Changes since v4:
> https://lore.kernel.org/linux-kselftest/20210611070802.1318911-1-davidgow@google.com/
> - Rebase on top of kselftest/kunit-fixes as of 2021-06-25
>    - This is as of commit c1610aae49 ("kunit: tool: internal refactor of parser input handling")
> 

Thank you for the rebase. Applied to kunix-fixes

thanks,
-- Shuah
