Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDC6446244
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 11:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbhKEKjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 06:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhKEKjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 06:39:02 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF563C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 03:36:22 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id j5so14228428lja.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 03:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hOtYGAstQBZM1HTeKAOZH5NrcEzxemdgOcTinWbxn2M=;
        b=pc9fJctElMG5cqMh61CF50Deg2JNAQh7FPXXFFN8Nrf+TrFFJL2YVL8232VPVRTaLL
         85ElTCMXvvPAIM8IB/A2nD0i98TO219O7arR6jf8eMMd4KD3ZPxa/mP1ChYW83yNcxNp
         18ywIYyxua9ghOFsby7+90mHI62gnykfQFrpSYcjeT4RVatPs9K5FwUe22lBCIuc527r
         uglE/XEMtkL/FaPKVr/RmooMzvAH9EThHW+eK4qRf5rAGF63jTUGxAwk0iNlrTfu34Zp
         8UBoapdJZgyndP31a9JDDDRqoyzYJjWqZEA1t8MTUFqJsYopy7QaVTU3eQPq35nAjsAU
         U+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hOtYGAstQBZM1HTeKAOZH5NrcEzxemdgOcTinWbxn2M=;
        b=1hA9QO4cbl9GNZEpDZbjBxHaluJouNOP4eYVnCHehu105NjUghZXvXa1vHL5nbw6bv
         J5Ztc2F+Oz5ViveczBq1IyC9+b6el9DoAEW8+Lo9UpOdWSglVldfX40ks5Onlivagj0W
         UoTfuy5xVH++aCoYt0s+xZt4ViR87iB2jJ6CDgaiQ2zPkSVk5JxgFDZR77+7+8CfD6w/
         CckeD26RWoeAj5C72MQKz3nkByo1uEnLZIC0WIFhK2IV7DgI1FKtuEbPRATj45rPe5Lp
         n04H43On8OC/XB5eA4GG8raV61ZTSuXcD9Vocpoi7xB54mlSDzySX/uFMAhd5vlOtuB9
         iNYQ==
X-Gm-Message-State: AOAM533d8wVwszJG+dPLVcnFAxU0t8KysZ5sAyffjqZ+kzrSMINCe7PY
        b1iu17E0dBkKKBe6A5ghkum/35uMXC0=
X-Google-Smtp-Source: ABdhPJwhepuWJLnqDEh0NejsKAUrFCgXVoX9OJ+XjsEQnwUsZw42uUCZ4AeDrBqcOTOR6kYf6RApSw==
X-Received: by 2002:a2e:9a47:: with SMTP id k7mr22070931ljj.100.1636108581373;
        Fri, 05 Nov 2021 03:36:21 -0700 (PDT)
Received: from [192.168.1.11] ([217.117.245.207])
        by smtp.gmail.com with ESMTPSA id q13sm42923ljp.115.2021.11.05.03.36.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 03:36:20 -0700 (PDT)
Message-ID: <ecf6ba8e-8273-0d77-5ceb-3ad44179d3a3@gmail.com>
Date:   Fri, 5 Nov 2021 13:36:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2] staging: r8188eu: os_dep: remove the goto statement
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
References: <YYKvWeyqd71pYSqM@Sauravs-MacBook-Air.local>
 <YYT/LibxFzssNUJN@kroah.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <YYT/LibxFzssNUJN@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/21 12:53, Greg KH wrote:
> Right after this, ret8 is set, but never checked, which looks like a bug
> to me.  Can you work on fixing that after I take this patch?
> 
> thanks,
> 
> greg k-h
> 

ret8 is returned from this function, but as I said [1] it can be just 
removed. It will be always set to _SUCCESS.



[1] 
https://lore.kernel.org/linux-staging/f26b4aec-c0a1-8c93-b34e-8b1a36ac81b3@gmail.com/


With regards,
Pavel Skripkin
