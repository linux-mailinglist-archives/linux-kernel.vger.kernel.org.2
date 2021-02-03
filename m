Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D223330E59B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 23:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbhBCWFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 17:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbhBCWE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 17:04:57 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760EAC061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 14:04:17 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id q5so697338ilc.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 14:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TS3LrDoJycQjV29QvWKYiqYYnfjPrvlJnAgde44hakc=;
        b=JPfgN/cQckDAKBwY/QR67Thxr7yUmncDVdAEsxV3tW1GqAhZtNxf/7bZqZJVPEURM6
         gNf0epse2/nHHkPtKoQQWAnhZ3lTN5HVHAGrSumWmnDcgNuIZSHw05vo4N0d8nomOXBu
         KzI/w+18TtoWfFSVKCquRr94u7944j42U7Pv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TS3LrDoJycQjV29QvWKYiqYYnfjPrvlJnAgde44hakc=;
        b=Mj3EdVNkhh2qs920PskzYXWpVb80sobU56g6GzGHcdwDMw0/jc9wn4KrzuKr4+1Jkh
         IHZ3N9PbM4aELJ8mZLzDFzvviQlXzeu4aVVhKKF/QLLI0t08plOr+eTnL+CIMIAfXM9F
         r99mr674czaNaIKWwdHUb4fe6IUfSrZbZe4uePoOHz3RFXfYnRYFoU32UGS8NGHtWQSA
         LE0F1bvA3eOQm+9jN18W1P7HaAjqyDEGY+12M2K4fFgt1xSXjvEnnpKcabi1ArF+PXMY
         bLbngUCHAaycElE6PGXygo6NaUnje2rGBKJnSHwJSQgjeCGyX2H85lvsbq82ao03vDs7
         4VQw==
X-Gm-Message-State: AOAM530ppdqdyrV1gZLHupuf7SRipk43jSuoAALZfcxfMayllOQE5pg6
        G/Yh6iZ1eZZAt1NQaDrOoYAelw==
X-Google-Smtp-Source: ABdhPJyvZIEoiVKF4EWNvGXWyeEJte1usTtNJqqzhvl2jiJPmeCqXs4hHX0a7+80gvQ0IkJH1UvQjw==
X-Received: by 2002:a05:6e02:2189:: with SMTP id j9mr4197510ila.98.1612389856937;
        Wed, 03 Feb 2021 14:04:16 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x1sm1530260ilj.61.2021.02.03.14.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 14:04:16 -0800 (PST)
Subject: Re: Linux 5.11-rc6 compile error
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel@lists.xenproject.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <8a358ee4-56bc-8e64-3176-88fd0d66176f@linuxfoundation.org>
 <CAHk-=wg983RfAiSSo4zLMADEfzLEuoBi+rye30Zrq7Bor8zg_Q@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7e05fe6d-9bf3-7d8d-5cda-8f4745bb144d@linuxfoundation.org>
Date:   Wed, 3 Feb 2021 15:04:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wg983RfAiSSo4zLMADEfzLEuoBi+rye30Zrq7Bor8zg_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/21 1:06 PM, Linus Torvalds wrote:
> On Wed, Feb 3, 2021 at 11:58 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> ld: arch/x86/built-in.a: member arch/x86/kernel/pci-swiotlb.o in archive
>> is not an object
>> make: *** [Makefile:1170: vmlinux] Error 1
> 
> That honestly sounds like something went wrong earlier - things like
> doing a system upgrade in the middle of the build, or perhaps running
> out of disk space or similar.
> 
> I've not seen any other reports of the same, and google doesn't find
> anything like that either.
> 
> Does it keep happening if you do a "git clean -dqfx" to make sure you
> have no old corrupt object files sound and re-do the whole build?
> 
>              Linus
> 

My bad. I was playing with two test systems this morning and totally
lost track. All is well after a "make clean" and make.

Sorry for the noise.

thanks,
-- Shuah
