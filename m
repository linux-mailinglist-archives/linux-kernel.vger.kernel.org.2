Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C82D3DA953
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 18:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhG2Qrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 12:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhG2Qrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 12:47:52 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20253C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 09:47:49 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id o20so9181060oiw.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 09:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WByKALSH2u96aeeXWsaLJQnIIah2Zq4+6oOOD+AQHTY=;
        b=CtY2tWmzEjc7d+wiaKiRgxdKYEf52ep9Zd4FBuhH46+795nlGmDqM50Do1fzXDz/t7
         KzEaCyuCdbsfjd/j+vDVVGy679kJmJ6tmyHZmx2SDHhKkfK34sf9yDtCaCKPhzUNgSRD
         jkzPxKYMyZAnG4lgXgUgTrCm/5wKaPDj3nVSGI1avUHFBkzFoLqQMF5+XmEV6HSSjaay
         SP/idGu4cZkr+9SCceIx929PTJpm3HJpsiHVZqgEzOrifU2gWIThnzMLAfI9Rt0Y60gM
         ehTbACjAIhVoqlaXzzPFvj0BrYPTUQi8SxSPAHqk7HsLjOSajebhqMwd3F/KztuZGpbz
         0LVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WByKALSH2u96aeeXWsaLJQnIIah2Zq4+6oOOD+AQHTY=;
        b=sFgfsN6Yo4p6a60jtUKfQV+e/EOkJq08qfEuA9vsVr0EtdWmLnydXVsmUPhVx1LigC
         nm3qsGSsRmFbvHo/Cp1lkm+cSxLS8sHtQxYB4emK8Wjdb8AVKjS/VO6i0XqZSM8E0U21
         nKPsnAJMiSQyZs2mOdDzr3+2zyZwHTEieVHU3jDgmo45k9Y5xWoEXv8iyJrSWWImtvIs
         n3CNsSweOXrw9ZzFH0aEqvzRX3ToNF4rOEdQVOQbEQQA9B/ppny/hgTCG8jclQoXieQO
         KPdDB5amYdhrkGyqVJ63Ldpo9W0PZj2uQy6jUDRr7GwcZ8ys2qG4AC/x7IrhxYZUFJAT
         OpEA==
X-Gm-Message-State: AOAM530DnLWfq+A+TK4dBqHBRPIroL3Aw6sZ/BFR+JLKJilYlZRrX8l0
        QrwBr/cmOU9ShIdBlDY9euA=
X-Google-Smtp-Source: ABdhPJxVv8ZSeD6e+G/dL4Y956ZzVqxMdEZwzp0FEWvy2r2sn06pb40kdU98XiDxuymXmY8cBJW9rA==
X-Received: by 2002:aca:3094:: with SMTP id w142mr3656047oiw.37.1627577268137;
        Thu, 29 Jul 2021 09:47:48 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id a24sm617069otq.72.2021.07.29.09.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 09:47:47 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [PATCH v4 0/6] staging: r8188eu: add newer/better RTL8188eu
 driver
To:     Martin Kaiser <martin@kaiser.cx>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev, Fabio Aiuto <fabioaiuto83@gmail.com>
References: <20210727232219.2948-1-phil@philpotter.co.uk>
 <20210728074605.pp5rs4c65tofnqot@viti.kaiser.cx>
 <CAA=Fs0mH9YAVhr24YeE3jpZrnuDGhOuhj=Sb9Ekkpb-xoC5LYg@mail.gmail.com>
 <20210729133730.lnxqzawnvksp4skg@viti.kaiser.cx>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <1d687d5f-d514-655a-f8bf-a5bac321affb@lwfinger.net>
Date:   Thu, 29 Jul 2021 11:47:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210729133730.lnxqzawnvksp4skg@viti.kaiser.cx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/21 8:37 AM, Martin Kaiser wrote:
> ok, understood. That's an important feature. I see that Greg accepted
> your patches, there's no point in arguing any more;-)
> 
> Greg and Larry: Would you mind sharing your ideas about getting
> rtl8188eu support mainline? Do you imagine that we clean up this driver
> until it can be moved out of staging? If so, we'd probably have to
> resolve name conflicts with other realtek drivers and rename lots of
> functions. Or would a cleanup of the new rtl8188eu driver be a
> preparation for adding bits and pieces of it to rtlwifi?

Martin,

I do see this driver being cleaned up to the point that it transitions to mainline.

It is not clear to me that it would fit into the rtlwifi framework. It probably 
could use the USB driver there, but unlikely to use a lot more of that code.

I will certainly be on the lookout for conflicts with the rtlwifi and rtl8xxxu, 
indeed the whole drivers/net/wireless/realtek/, code as the cleanup proceeds.

Thanks for your concerns and questions.

Larry

