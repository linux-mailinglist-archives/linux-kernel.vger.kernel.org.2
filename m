Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C333E0247
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 15:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238121AbhHDNrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 09:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238139AbhHDNrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 09:47:36 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C03C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 06:47:22 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id v8-20020a0568301bc8b02904d5b4e5ca3aso1634813ota.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 06:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+AoFXgsKTP3ruB8NfNUz2FtlRkR+ZhDok1NEQZlDiiA=;
        b=RT/1HuaVluljWGOZGTF1ZYEw5QbLs+weqdbJrRWNabvzA9da8wWUZ4iIYOQhz4hwaW
         M11z0HsoUiMCmh8FRm/C/nd8JhZKSPNm7opsrWKSOez5saNiCO39/ujbxXhSaSTdUVQr
         lv6lAbG4EPz7swc1Hgd8Gvgoi1mXCQL6bntcmlWKpWXUo1i9MSg0K/FDqNau7Y4olnPj
         Y94ear22tULX+Ty4AjSiBjAV8gYfY8VDnIbHE0fQv0mWWwP5bVDCY3Dcd8yXYiVQDAaW
         +pCdZua0z3uD9957A4LB8WQGIrJmfEn4YtQvE3h+XxADlulJQmKS4hBxFn85/gpk6Z+1
         Abfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+AoFXgsKTP3ruB8NfNUz2FtlRkR+ZhDok1NEQZlDiiA=;
        b=nAzoq4oVcdixFMiAIBDC1ri58eVgeya8FfHOYCNHMcPhNAXjNfIgRd2F/9kpmvV4le
         FNr6aRqzfp7KWltdQ7LvoVUQW+GrUFPS/ptRg8ZDNpYZmHXMpWgnhZ5vers6kX7xmBqZ
         7TA8aOGaaiaYgbqtiOA/4I0rf2UuFZe/UYuhnmF+Rx3CHEz2dEitS+F2yIopyFY9KtqK
         5GFb/GKqN1zX3q5zjscmtk8x0vcYTSVi90VDiaNSgzxnM6CNa/2XcPlbmpZsGbB1CULI
         AvRjui0bjAzs/4ag/dLVr0v0zK7dZdgz2N7MweOyoexRU4fYC1cMANoSud5ADza7KFyj
         ljAA==
X-Gm-Message-State: AOAM532/SKQh1JINoVwyuZNK4upCkjZD7EIe7h9/gGjVTeZ0nCbVL5h+
        uPriReAq5G1HGkbp9HQqyGqpOCmmIzg=
X-Google-Smtp-Source: ABdhPJzzTI1WmHb/8kQMI+idfHOuCXtawVTq+2pv3ONB0t0RWqCtiNEaBZqjwP9k9RkHJy3ymHtNtA==
X-Received: by 2002:a9d:5c14:: with SMTP id o20mr789862otk.36.1628084841782;
        Wed, 04 Aug 2021 06:47:21 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id t27sm447990oij.34.2021.08.04.06.47.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 06:47:21 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [PATCH 1/6] staging: r8188eu: Remove wrappers for kalloc() and
 kzalloc()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210802151546.31797-1-Larry.Finger@lwfinger.net>
 <20210802151546.31797-2-Larry.Finger@lwfinger.net>
 <20210804131550.GL1931@kadam>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <3fd8841a-ff5a-154a-666c-66e9a773dfac@lwfinger.net>
Date:   Wed, 4 Aug 2021 08:47:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210804131550.GL1931@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/21 8:15 AM, Dan Carpenter wrote:
> On Mon, Aug 02, 2021 at 10:15:41AM -0500, Larry Finger wrote:
>> diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c.rej b/drivers/staging/r8188eu/core/rtw_br_ext.c.rej
>> new file mode 100644
>> index 000000000000..18113389acce
>> --- /dev/null
>> +++ b/drivers/staging/r8188eu/core/rtw_br_ext.c.rej
>        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> ;)  Something went wrong.

I submitted v2 with this problem fixed. Sorry for the confusion.

Larry


