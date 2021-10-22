Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3760C437B9C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 19:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbhJVROK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 13:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbhJVROI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 13:14:08 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA52C061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 10:11:51 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id t21so3182547plr.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 10:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mhWLNADUWPeTUsvnNwOnZvOtYJnJcXJAMA2KUo85xB4=;
        b=qUcXv8Ydicwcrh4c/lIM8AplWMjZS110zs9ZotW03eL6+4No5/hxNPoOzNzR3tvixb
         BaTfRvurkn+JUO3HPR5bYlkqdBl5ompKKw3NyOYu2bf6IonP01iVhZhGswLZ5J9Nn2od
         N4K0W5Pw0owiUnF0+Ey7FGBZmLd7yGDfDGWpvF0GEGNFOtgnfbmxUGFUaz0uOKzfWmIW
         6M96M66bu7e64FwyZ7TfNdpfcVoWKo8I8MKsiB/v5EbFjqBZy+dIMdo6CWar+Z3X3sS3
         2U6Q5cjZafZbB7qqPAAs5Wqsugr4NVKR/wn+Ptf5pYOTQjr+lkwnPQa2ITmrPu14Mzf8
         s+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mhWLNADUWPeTUsvnNwOnZvOtYJnJcXJAMA2KUo85xB4=;
        b=DS42+jS1967kxZLeVazAwY8Uwjkfz/JqOjOSAXpee3sSh5EEg4TFx/DHk416XbGG/T
         QLX6yhx3YrL1s7oNWbzKnpBPO5yig5tUi3LDLeqDe/zB7kCHfk8TOZZhgHvZDFee69Gi
         6NuWgA6VArTVB0mQuwgnAeLcVnidqBQuR3WpiYuJxSoV9QwifIoRJ0J5mhXgngFgZIpV
         nCufW3/dGE2Zw+h6gJNwByGgfopWdzKCUH6wm/Ku5pgd+o50MCY3m1SlG6OxF9T8SV0C
         RdW3KzfGD57xHlr0n6dy3Em1r2ihJTselLD7CC0tqzGtMh4mqvkUwnM/nrHAJQCZJ4qI
         poTg==
X-Gm-Message-State: AOAM532R3oJSBVjddgx2/kphS1PLuGfYhZcdQKFejYIVGhpjGjkmk5uk
        x0ReCWvLnTReX4Xnx01quFI=
X-Google-Smtp-Source: ABdhPJzZEJoDCwTFYD2bxloccoFEXmMVEKQCYyk4ppBAs+uY9HSLBJlTXS1BENxqdoTv3MEerqD5/g==
X-Received: by 2002:a17:902:c94e:b0:13f:1b02:e539 with SMTP id i14-20020a170902c94e00b0013f1b02e539mr689663pla.72.1634922710856;
        Fri, 22 Oct 2021 10:11:50 -0700 (PDT)
Received: from [192.168.1.4] ([59.95.89.188])
        by smtp.gmail.com with ESMTPSA id h19sm11944365pfv.81.2021.10.22.10.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 10:11:50 -0700 (PDT)
Message-ID: <5de75b10-b46d-d5da-e60d-0d2e10bca378@gmail.com>
Date:   Fri, 22 Oct 2021 22:41:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH v3] staging: rtl8723bs: os_dep: simplify the return
 statement
Content-Language: en-GB
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     fabioaiuto83@gmail.com, ross.schm.dev@gmail.com,
        marcocesati@gmail.com, insafonov@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
References: <YWhBQF4yUH0/r53A@Sauravs-MacBook-Air.local>
 <YWhDb5/ZDUUs9gb7@kroah.com>
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
In-Reply-To: <YWhDb5/ZDUUs9gb7@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/10/21 8:19 pm, Greg KH wrote:
> On Thu, Oct 14, 2021 at 08:10:00PM +0530, Saurav Girepunje wrote:
>> Remove goto statement where function simply return value without doing
>> any cleanup action.
>>
>> Simplify the return using goto label to avoid unneeded 'if' condition
>> check.
>>
>> Remove the unneeded and redundant check of variable on goto.
>>
>> Remove the assignment of NULL on local variable.
> 
> You are saying _what_ you are doing here, but not _why_ you are doing
> this.  For example, this last sentance does not make sense, why would
> you want to do such a thing (hint, I know, but you need to explain it in
> the changelog...)
> 
> It's getting better, but the changelog still needs work.  Often times
> that's the hardest part of writing a kernel patch.
> 
> thanks,
> 
> greg k-h
> 

Thanks Greg for review. I will work on changelog and will send v4.

Regards,
Saurav 
