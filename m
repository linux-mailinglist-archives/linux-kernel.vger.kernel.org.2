Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D7A457A12
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 01:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236673AbhKTAT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 19:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236690AbhKTATw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 19:19:52 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C799FC061759
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 16:16:49 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id l8so11876912ilv.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 16:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QdcpYj8Ya7TgsiSo0zXQg+j2JxFNjYPDgCsajefoarg=;
        b=UYYN+tHet+ZKfdibSzAAAHNON8NxQt9HKNYbmdgsAoPXoyl+So8H+PwMoTuIUKes2Z
         yEh8KY4CWaEjM9Q8ke4Z4Qay/b5/oyuXrDpnvOfsni2F9vs/q0wgAiBqiWR+But/55vg
         C5sGMM9Ru7Lioy1g/XnJB5xf6VziACFbrJv60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QdcpYj8Ya7TgsiSo0zXQg+j2JxFNjYPDgCsajefoarg=;
        b=HqA80Yq2mUZX/kzf5SgYj9qeI71kH50rJ/aJCusqvEKD28ptvgV37mvvnT5SEtLNQk
         zv0DHWC7jnLACPO9kbxe2gvjmp+G0Q4iBAmONmx7FpKaAZz/mq/imWlQAzLa+sT/LYwo
         gplQskFG4t/xG9/lEvzImTeDnFlabcUvwYkQuEkcZuJrEK1bFDOwjyXfyJCwYWSyNRXF
         M1uw8UFLmTlrtTsdj0gp33JjY2Q36SJj3O4KthHm885PQLXo/MPiN3H3u5KFvsHxsRM1
         fLKzd+nD3kWdiRA9MHNbHHDKPpPMo/3yjrI9yem9feNAluu/9ta2L2nm+r8G4jMHG+Zy
         zjFQ==
X-Gm-Message-State: AOAM530IvWU2lmEOjxoaZhSZpdBIQPIX983pDFG7UElYw9G77h+Cc0iX
        IRCSGn4seJ1zv+pw/kPAqcbWWA==
X-Google-Smtp-Source: ABdhPJzIEM05T6Zpl3No9G9ZEmtv+51gqOm+8FZxnaSZjPVxnRAg5iyA7UylaFGvWOyS4KtnhCA+8w==
X-Received: by 2002:a05:6e02:156a:: with SMTP id k10mr7449888ilu.200.1637367408959;
        Fri, 19 Nov 2021 16:16:48 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id q13sm955457ilo.25.2021.11.19.16.16.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 16:16:48 -0800 (PST)
Subject: Re: [PATCH] selftests: vDSO: parse: warning: fix assignment as a
 condition
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Anders Roxell <anders.roxell@linaro.org>
Cc:     shuah@kernel.org, nathan@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20211105162756.3314148-1-anders.roxell@linaro.org>
 <CAKwvOd=dtb98Ue1xYz0gQmRGeQWdH6sBEkpXioevPQ94envK8A@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f4ba0730-d997-396e-29a6-157e05a04166@linuxfoundation.org>
Date:   Fri, 19 Nov 2021 17:16:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAKwvOd=dtb98Ue1xYz0gQmRGeQWdH6sBEkpXioevPQ94envK8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/21 2:17 PM, Nick Desaulniers wrote:
> On Fri, Nov 5, 2021 at 9:28 AM Anders Roxell <anders.roxell@linaro.org> wrote:
>>
>> When building selftests/vDSO with clang the following warning shows up:
>>
>> clang -std=gnu99 -Wno-pointer-sign    vdso_test_gettimeofday.c parse_vdso.c  -o /home/anders/.cache/tuxmake/builds/current/kselftest/vDSO/vdso_test_gettimeofday
>> parse_vdso.c:65:9: warning: using the result of an assignment as a condition without parentheses [-Wparentheses]
>>                  if (g = h & 0xf0000000)
>>                      ~~^~~~~~~~~~~~~~~~
>>
>> Rework to a parentheses before doing the check.
>>
>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> 
> Thanks for the patch!
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> 

My commit script failed due to checkpatch warns. Run checkpatchp.l --strict
to find the problems and send me the fixed version.

thanks,
-- Shuah
