Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCB031E65B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 07:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhBRGbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 01:31:39 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:45376 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbhBRGOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 01:14:15 -0500
Received: by mail-lj1-f180.google.com with SMTP id c8so1886641ljd.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 22:13:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ku7YQtFhkBJUbVK7xDsoiVrZBy6WIabI7rYkriW0fdA=;
        b=C22ZMwY/WAIkbxwRFOgxMRI9RgHburtPwTiYaSQqiLv4B80UrmHRJqX1PBXtDswxfM
         azuWvyzwVvP8+N/XR8vDT3OAzcIufKJb/TpLKFSZ6k6FGR13dYZpjqlpsYipQL4Tt43x
         bKq+4G/qInujtOpCzEJH7PKdhYHAcV8M+Odlc6e5h11CBu58/etprPxu4hqpVPPrFEiu
         QR4rSahgxR4rJp08sW2imeXEiNJQOWmoPxy2aw4D59ldPm759zTRyoFIbAPUaogAtb5x
         lUXjDcymjtz5EapPhNPR/5CS0UXj5/dWU1NyyLatvEBJOXzGJry/rJPW7pPxu7KK5HGW
         cd3A==
X-Gm-Message-State: AOAM533xa+K3GKGPULLRP61etJ4b9YbdL0BWBcQM74z97GOc0K2gpfgo
        VoJLeyHgfVTAf2jNV1pxl4Vjn3OnHxom9g==
X-Google-Smtp-Source: ABdhPJxUVW2IRw2z9Gi3lWKXYoQWYM+us4+9nT5CePxE+YOKqdYfJVgFMzUhS4pRzwPZyqXqZMs1Hg==
X-Received: by 2002:a2e:8804:: with SMTP id x4mr1691482ljh.252.1613628808721;
        Wed, 17 Feb 2021 22:13:28 -0800 (PST)
Received: from [10.68.32.147] (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.gmail.com with ESMTPSA id j137sm493480lfj.55.2021.02.17.22.13.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Feb 2021 22:13:28 -0800 (PST)
Subject: Re: [PATCH] coccinelle: misc: add swap script
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
References: <20210216080133.455456-1-efremov@linux.com>
 <alpine.DEB.2.22.394.2102172224570.3081@hadrien>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <c2b60288-3e46-14e3-9be2-3f75366a4b47@linux.com>
Date:   Thu, 18 Feb 2021 09:13:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2102172224570.3081@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/18/21 12:31 AM, Julia Lawall wrote:
>> +@depends on patch@
>> +identifier tmp;
>> +expression a, b;
>> +type T;
>> +@@
>> +
>> +(
>> +- T tmp;
>> +|
>> +- T tmp = 0;
>> +|
>> +- T *tmp = NULL;
>> +)
>> +... when != tmp
>> +- tmp = a;
>> +- a = b;
>> +- b = tmp;
>> ++ swap(a, b);
>> +... when != tmp
> 
> In this rule and the next one, if you remove the final ; from the b = tmp
> line and from the swap line, and put it into context code afterwards, them
> the generated code looks better on cases like fs/xfs/xfs_inode.c in the
> function xfs_lock_two_inodes where two successive swap calls are
> generated.
> 
> There are also some cases such as drivers/net/wireless/ath/ath5k/phy.c in
> the function ath5k_hw_get_median_noise_floor where the swap code makes up
> a whole if branch. 

> In this cases it would be good to remove the {}.

How this can be handled?

If I use this pattern:
@depends on patch@
identifier tmp;
expression a, b;
@@

(
  if (...)
- {
-       tmp = a;
-       a = b;
-       b = tmp
+       swap(a, b)
        ;
- }
|
-       tmp = a;
-       a = b;
-       b = tmp
+       swap(a, b)
        ;
)

The tool fails with error:

EXN: Failure("rule starting on line 58: already tagged token:\nC code context\nFile \"drivers/net/wireless/ath/ath5k/phy.c\", line 1574, column 4, charpos = 41650\n  around = 'sort',\n  whole content = \t\t\t\tsort[j - 1] = tmp;") in drivers/net/wireless/ath/ath5k/phy.c

Thanks,
Denis
