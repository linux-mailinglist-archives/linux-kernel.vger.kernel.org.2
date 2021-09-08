Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD68403CE0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 17:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349633AbhIHPxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 11:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235546AbhIHPxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 11:53:47 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A688FC061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 08:52:39 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l18-20020a05600c4f1200b002f8cf606262so2005361wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 08:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=q2NxKj9XsOje8Q6zNEUbuoFayLJ20hHyWL0fAt8sMJU=;
        b=Qh+NQNmAcfBOWuxB3Pn82d8ejOQIbMwzFJWuhSOABRoeq27XjvCSXo1UFD64EOa1Yv
         Eu7eCyUrbWq+0t9TqSqncNBJoSzMah3ZNef/pitdDZn9QFiAoP4oolVmitSrHg+KPU+m
         xZqAD3lXOhSimHig7kDJk6RUmdCqRxve6dvkj7OB+oPieipwKKjM1yHdi+T4gWDBLMpp
         i6X7xH92/blCpFypV/rDcjNOmP8Dn89/fdSSfYKV80atBWHIVHIPQsJOLPhd/c1dKJC6
         a7/5T1SyRG5XbgsX1rNozoMtf0OWYbe1srmn8zcR1TV54xUQzPlxIBV7pz9u7x9X9xks
         7sqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=q2NxKj9XsOje8Q6zNEUbuoFayLJ20hHyWL0fAt8sMJU=;
        b=qcu6dF0kIH2WiqMp481KLBvifd7AFiFFsw82rC9c1jdPHhtKbZQCmmwLfSzuCFj+2n
         tZYmaLnyGqdVYr71z6FHG5IKU46tsKd2ApBrLcYNntKvPOBBgoMAzN8HG2AwmfcWU2sd
         4QtSYwFEvOlB5oKrTimFaWyMEP88wu9BlmG0dKilO0+Cma+egK8R2ElIZN1Zu0O94xWg
         e3o5xtIqM7vq6xm+Z4pqkwGZoJ+4dHwEBIzeehCQGdchgciNB1u58b7O4TUgWM3D3ReR
         2+sx6ZU2PaY0NJt4JZODraZzdfp2lekT91sewSGW8GlIl4kuWVi9P3VNgHpjW7dinVkq
         8mgQ==
X-Gm-Message-State: AOAM532OzQz7t2aGB9rbf42FFqVe12eU28ZKHwW8wFHD0z64rTWx+dza
        k+F2Avs7XGDitOVhp95Gtgg=
X-Google-Smtp-Source: ABdhPJy/XGG+tmdIKXbx/8neDMGxDPTU67R4IK8lls44LWz2umk+cir8dSMzziddtwPcWu7pzwcArA==
X-Received: by 2002:a1c:2b04:: with SMTP id r4mr4282393wmr.168.1631116358346;
        Wed, 08 Sep 2021 08:52:38 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::dc38? ([2a02:8108:96c0:3b88::dc38])
        by smtp.gmail.com with ESMTPSA id g3sm2643531wrh.94.2021.09.08.08.52.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 08:52:37 -0700 (PDT)
Message-ID: <cfdf62cb-336c-5822-39ce-0ebc09f64ef8@gmail.com>
Date:   Wed, 8 Sep 2021 17:52:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH 0/3] three simple cleanups
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210908085747.32254-1-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20210908085747.32254-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/21 10:57, Martin Kaiser wrote:
> Remove unused definitions and a pointless loop.
> 
> Martin Kaiser (3):
>    staging: r8188eu: remove unused function prototype
>    staging: r8188eu: remove unused define
>    staging: r8188eu: this endless loop is executed only once
> 
>   drivers/staging/r8188eu/hal/rtl8188eu_xmit.c  | 34 ++++++++-----------
>   drivers/staging/r8188eu/include/rtw_io.h      |  2 --
>   .../staging/r8188eu/os_dep/osdep_service.c    |  2 --
>   3 files changed, 15 insertions(+), 23 deletions(-)
> 

Builds and looks good to me.

For all 3 patches

Acked-by: Michael Straube <straube.linux@gmail.com>

Thanks,
Michael

