Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214F9431124
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 09:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhJRHLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 03:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbhJRHLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 03:11:03 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD27CC0613E9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 00:08:35 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id n8so65151567lfk.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 00:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fNAkq0YDdD7q+tHfpIbHA58EcHj23BbqYj88+Dz6qx8=;
        b=fhLZXNgIwTTnaENtWrNZVlOfhE3aqQuXgVi+Cfpzu7gZYjh6OxRe5pkch1ZOuiytSw
         j1S58JmU4Fv35nVLrlj7ObjorqUz6lqYaMn06ZANzeqwj8jmyTP/2jvYMytHw6uViSEn
         ZTTt0NU6QERusCFwU4836t4TR3bu/VA4jNPD9M3Ta9tHXw4d7dE3x2Bv2a14T5YdmImP
         Logne7QKaetbnbAZ9B2uqKZ32HX2gJkSw7Es6GpWl1ytgA58snD0SdNTxs39ovIAx00H
         kScVuTorWpMDCoaeFiXoWns1nDMt3baCgVfqcOpw815nYtQc5UwO4i4yytG9WlNXtF/s
         8WcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fNAkq0YDdD7q+tHfpIbHA58EcHj23BbqYj88+Dz6qx8=;
        b=S8eEoCakYffV5Y/QTqqosLscL05sMPrsFYhSBrIgTh7CbjZrgbILA7UMLVeFsijpAW
         WDmkVOaxsGgqUYmnckCirL4xID+O7fM9kiXUie2j9utJ/VunSb3aMTVsTJLUYYwOgWY5
         1wvgvyccUQd3jE0DMKFclDL4iEbt0LeYahfsKJEpJqbhu2p1T9rLSaz5kjcibxyJxJo4
         ZPSiSvZkzPfTQjhEcJYWYCA0cYTErFNQWlvOZZpSiYcsSgScouvVjBfW6KuMpnHrTW17
         ++MEM93OVpleDZPuuTgurN9Cl1Kv7xAEmhqvgLTpEgENxyX0zB/QAkVHWc7AhMPHYErh
         Xxnw==
X-Gm-Message-State: AOAM532S8ZFUkS/854v5FPBI4gVcMfcfs4UKquf8loGAixnd//Ix+Yzm
        onGUDR5VsL+kcaHtCdUvualhk48pLMM=
X-Google-Smtp-Source: ABdhPJyxBBIyaQ/2yp4lUDKDSoZtcKnd+rKnDgJ+ckw0ZvP8y/HJRL/OKezx0gCl8jaEL9kt3HIcLw==
X-Received: by 2002:a05:6512:1188:: with SMTP id g8mr27581516lfr.436.1634540914086;
        Mon, 18 Oct 2021 00:08:34 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.235.181])
        by smtp.gmail.com with ESMTPSA id u15sm1532664ljo.132.2021.10.18.00.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 00:08:33 -0700 (PDT)
Message-ID: <bd6cc56f-f5dd-31cf-cc0b-6fea123b7563@gmail.com>
Date:   Mon, 18 Oct 2021 10:08:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: Any tracing mechanism can track the executed instructions of a
 user process in the kernel?
Content-Language: en-US
To:     Dongliang Mu <mudongliangabcd@gmail.com>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <CAD-N9QWd6Orm8d9AMk7mybByAKZod=GJ-HSNPOfhFDStSPwSUA@mail.gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <CAD-N9QWd6Orm8d9AMk7mybByAKZod=GJ-HSNPOfhFDStSPwSUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/21 05:45, Dongliang Mu wrote:
> Hi all,
> 
> I am writing to kindly ask one question: is there any tracing
> mechanism in Linux kernel that can trace all the executed instructions
> of a user process? If this user process is run on different
> processors, traces of this process on different processors should be
> also recorded.
> 
>

I think, kernel is not supposed to do that kind of things. I mean, there 
is no such wrapper in the kernel to do this task, AFAIK.

You have an access to all system calls, so you can implement your own 
gdb in the kernel via ptrace() :)


If you need only report about instructions, you can call `perf record` + 
`perf report` via call_usermodehelper() and somehow parse the output of 
these helpers.


> Any comment is welcome.
> 


With regards,
Pavel Skripkin
