Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27312426F05
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 18:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhJHQdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 12:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbhJHQdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 12:33:49 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3230C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 09:31:53 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id i189so3645204ioa.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 09:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pznMwXxaNj5LbKCr9JpGSjNvFHuWrktXzE7YnpIRhnM=;
        b=EVYPt+6mjWERED7l2ADeX5CBgIgFEPb2OMc+7wQeMA17hdXQzGU0toaXJvvrjhJR+b
         +MBCDqV/W17M3lbb4O7tAur359mC29Jsvz4Q1x2FgXpMRyWlTQWPfbJuZfC4BdlNOpf2
         FbqACbxxZi9n0osrmqyLEW1fmPqlPwgaBNsaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pznMwXxaNj5LbKCr9JpGSjNvFHuWrktXzE7YnpIRhnM=;
        b=sXreP4FdxaPcKjeu9ebT8C1OsxnCEgTipv3txTa+7ABxmYSx1G3LwV/taVG2FrRUty
         ItD7ugzAfNH1Oqx36dW/ZxVuGCEDIAk6aA31UAmBaoYTq68C+MBFrBwlrbbaqGRcOGZA
         So4xzacCvZDteJWT2enSpvwHfZ3Ma/pCuQKvpk9lYYwGlxlpiEZNe0kUexzcmE6CC4KP
         7DNZaUNKeQyQWO6cb5ABeR06zqbrlGCOcyLMzQCnCUHbxEG7/d1XxmaSBZDyGX3l/Yfv
         xtJdaajZz+e43VgALuR9w4KxPsYT30KzSZtuEYTfPgZ/cYvzEUAEbCmNJ5lnP7LlM3k1
         XKJA==
X-Gm-Message-State: AOAM533tsxVYUxQgXUEr0eN/AYSJZynwmjAmKrWGwCgEvzqQ1oq5l69K
        Pk9gihdKezVHvBbAyQtAxqaVmg==
X-Google-Smtp-Source: ABdhPJzhHhHPD+EzyzIgN7W3x9fZgGYQAO4TRpVF5y64WjCzXsZILPbYSg6Af3clJCut/HXIAUcPeg==
X-Received: by 2002:a05:6638:148b:: with SMTP id j11mr8632436jak.79.1633710711995;
        Fri, 08 Oct 2021 09:31:51 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id d25sm1173766iod.41.2021.10.08.09.31.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 09:31:51 -0700 (PDT)
Subject: Re: linux-next: manual merge of the kunit-next tree with the
 kunit-fixes tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211008152930.03787395@canb.auug.org.au>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ba01fb13-e1a1-299e-9a7b-ccdeaeef267a@linuxfoundation.org>
Date:   Fri, 8 Oct 2021 10:31:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211008152930.03787395@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/21 10:29 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the kunit-next tree got a conflict in:
> 
>    tools/testing/kunit/kunit.py
> 
> between commit:
> 
>    d8c23ead708b ("kunit: tool: better handling of quasi-bool args (--json, --raw_output)")
> 
> from the kunit-fixes tree and commit:
> 
>    6710951ee039 ("kunit: tool: support running each suite/test separately")
> 
> from the kunit-next tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 

Thank you for the fixing it up. I will fix this up in the kunit-next once
the kunit-fixes pull request goes out.

thanks,
-- Shuah
