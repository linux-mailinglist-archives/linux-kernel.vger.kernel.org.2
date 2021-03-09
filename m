Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456353330DA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 22:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbhCIVZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 16:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbhCIVYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 16:24:49 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CED8C06174A;
        Tue,  9 Mar 2021 13:24:49 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d8so7271415plg.10;
        Tue, 09 Mar 2021 13:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BR5Ek/R5Dd/XRMzwcsXowOty2MUW4TUsL+d29eNBB58=;
        b=piG/uxx71QaIxlCrSq38FBWqirNb5Zp67e9dl2kZKWbqtCeSyjaWf9tjLGIev0DPp9
         oC+i2I6M1CjUQd8l0F53Ut//1e5YiVF1QAIPLT8uf7bi+YhNqt3CfX4ZOVZGzsB7iZ7k
         MhMN8xO0UepyTKt1NOUTi2FzyqhP2IlTQLlCbviQge6SMYL2lNSFfNkMqMgx97gHFGho
         K0yOMyEXZSIl35adqWzmYMVTRcYZXE6pn1Fj2k3T4FdKzMwnvjwV1uMHGQC4WEMA3HGC
         pRiSLde5g2bLSa8M2rmMaU0HG4msloAZjK4/zCJnN+Bhw4DZmilzvGtQifNM3ldJbJ0V
         ghgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BR5Ek/R5Dd/XRMzwcsXowOty2MUW4TUsL+d29eNBB58=;
        b=h66jUNwqjvrsOqxzOQg4GGrvLqXCaeMtm2VMKlYEUI0afAQrJmBrgu3vFbn9uaDRS8
         8hAGziu+RnLjdrzrGK8JD01gmipI51195eoq7kMPbYh0q4qZQou1ni1zWJKS9zf318Pg
         +g9N96lzhlOMbuXw+Fw57QVWq/GNC5iQP9wOHs2JyUKoHqaOoUlS+XhwAgcN017N/UA9
         Z/G9cm0t+S3OIeZNdq/xgMikjNnSnAK4G8QXcMcEcTcMir2LRzndnZDVS5By0GEhqMUx
         xDJlxNiEGKbizfoagfsx4rik+GCGqVFnj1BJ8Rs8eZYTQzDotes5J9PsrDG0jaaRwr2V
         HPaw==
X-Gm-Message-State: AOAM532gYDXjD4lxHBA/b+gsA0xwZh43kaGcelTGZwB2jiychC+f0Ksw
        6eXYv4CtVaJ/o4R2Y6esqoc=
X-Google-Smtp-Source: ABdhPJx4L3iEXsc72kQEmwtAuXe3qhkT3zUqZpNp4Va7CnvlTB8xtt6baJoruhAiFUAe6dHFmFVxBQ==
X-Received: by 2002:a17:90a:bf15:: with SMTP id c21mr6675007pjs.160.1615325089097;
        Tue, 09 Mar 2021 13:24:49 -0800 (PST)
Received: from ?IPv6:2405:201:600d:a089:89e4:587b:cd60:65bd? ([2405:201:600d:a089:89e4:587b:cd60:65bd])
        by smtp.gmail.com with ESMTPSA id r16sm7628103pfq.211.2021.03.09.13.24.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 13:24:48 -0800 (PST)
Subject: Re: [RFC] scripts: kernel-doc: avoid warnings due to initial
 commented lines in file
To:     Markus Heiser <markus.heiser@darmarit.de>, corbet@lwn.net
Cc:     lukas.bulwahn@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20210309125324.4456-1-yashsri421@gmail.com>
 <8959bf29-9ee1-6a1d-da18-f440232864f3@darmarit.de>
From:   Aditya <yashsri421@gmail.com>
Message-ID: <c673e76f-72db-bbee-39d6-f5428e765173@gmail.com>
Date:   Wed, 10 Mar 2021 02:54:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8959bf29-9ee1-6a1d-da18-f440232864f3@darmarit.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/21 7:00 pm, Markus Heiser wrote:
> 
> Am 09.03.21 um 13:53 schrieb Aditya Srivastava:
>> Starting commented lines in a file mostly contains comments describing
>> license, copyright or general information about the file.
>>
>> E.g., in sound/pci/ctxfi/ctresource.c, initial comment lines describe
>> its copyright and other related file informations.
> 
> The opening comment mark /** is used for kernel-doc comments [1]
> 
> [1]
> https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#how-to-format-kernel-doc-comments
> 

Hi Markus!
That's true. But the content inside the comment does not follow
kernel-doc format.
For e.g., try running kernel-doc -none/man/rst on the above file in
the example("sound/pci/ctxfi/ctresource.c").
The starting 2-3 lines in files generally do not contain any
struct/enum/function, etc. declaration.

Thanks
Aditya
