Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0A43A47F0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 19:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhFKRhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 13:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhFKRho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 13:37:44 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF52C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 10:35:46 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id w14so5916671ilv.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 10:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nfvuYmRSsrqKkyjyEJwVlbMYo9k7O1ojDR6LlSwhXjU=;
        b=XfOj3FwiQP8K/u3OJsZnizHlOFJfxR7Bd2wdLmqLUvqlqgrZvJaPzxA4nbAOh/LRXA
         +AAy3TtUD6/9mkfjBi8aXfYt1c1ZlTu5t0evVr5bNT900vs1SkvBBZ703Xd+DIH6qSe7
         bBkogkR7NRSQtJdE8ad0j27TtzS1+/ksNmO1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nfvuYmRSsrqKkyjyEJwVlbMYo9k7O1ojDR6LlSwhXjU=;
        b=IHK0mkXMBL3Wj9DOcTt3LyEYYBgtVwvKm+mT2UdZfAh1Y5PLHFViVD+b0GH0em0/IZ
         0V3DN8UcpUHkvcN8B2f0iUIc2hqSL0/WEZvpWHrOdo5O0bggMHMCEX0/kUBVgn8TbIrb
         0VGcg2DJMhrGIusuyU2MkbSble36i4C65raxw743Rr0c2QVImKAwGRyX6x2hQOQZjn+1
         uzNQZ2HnDlnPeaizJrAchcIJhrBlV0mJl5iSnsisgNDHI82FY8lfoDQtPS2scFwZtT3W
         9vb+42/5J828ZHxCNjq/0GbYqvHDujrVi8jM77kvZ7+6zz5wzT6jo50F2Nv+HQ8+K57N
         cc7g==
X-Gm-Message-State: AOAM532pggIzRl+QpuYlXW1JRTE87xz8CmeS/8EB/1SkxOPWEvOqVZJ8
        AvhryTW+OjBkYHYIYvqRpHL6mA==
X-Google-Smtp-Source: ABdhPJz2zS1moGpo4B3D+0PtoX9xhcuTLbzySQZz0s0BhV0VneF0Gb0XIcx3oyV4Aos51v9UFu1y2g==
X-Received: by 2002:a05:6e02:20c8:: with SMTP id 8mr3946175ilq.67.1623432945447;
        Fri, 11 Jun 2021 10:35:45 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id p10sm3980850ile.35.2021.06.11.10.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 10:35:44 -0700 (PDT)
Subject: Re: [PATCH v8 1/5] selftests/sgx: Rename 'eenter' and 'sgx_call_vdso'
To:     Dave Hansen <dave.hansen@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210610083021.392269-1-jarkko@kernel.org>
 <b5e06639-8bf4-c267-0aa7-b6c110767edc@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8d071d3f-604f-1876-05bb-91568dd3c563@linuxfoundation.org>
Date:   Fri, 11 Jun 2021 11:35:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <b5e06639-8bf4-c267-0aa7-b6c110767edc@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/21 9:45 AM, Dave Hansen wrote:
> On 6/10/21 1:30 AM, Jarkko Sakkinen wrote:
>> Rename symbols for better clarity:
>>
>> * 'eenter' might be confused for directly calling ENCLU[EENTER].  It does
>>    not.  It calls into the VDSO, which actually has the EENTER instruction.
>> * 'sgx_call_vdso' is *only* used for entering the enclave.  It's not some
>>    generic SGX call into the VDSO.
>>
>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> These all look fine to me.  Feel free to add my ack on them.
> 
> Since these are pure x86 selftests and the initial code went through the
> x86 maintainers, should these got through them as well?  Or, since this
> is only selftest code, should Shuah pick them up?
> 

I will queue these up for 5.14-rc1

thanks,
-- Shuah
