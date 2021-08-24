Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41BDE3F60A2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 16:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237846AbhHXOkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 10:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237701AbhHXOki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:40:38 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD57C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:39:54 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id c12so38135173ljr.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=re6lK/BP08XNQ6PSp6D93sz/YFIqzRCqeE2m1nUD7G8=;
        b=LVNcDkVCUlLh59P7dmrsVLCxUgSd2XP+QT5UM8O45zlyF4SBhVEprBFhI2Sz7vHbjB
         89n1zWnTbKK2YglQscfg0g2SLjvMT8i0AHgupKhz4TC65lQd52Dw7EKAlnwfZCu/mAak
         VSeFpZ0jHUr2YsuV5d1whQHOTxeR9Uey1KyH5QJKbeNk58at4SkrCDoGR7xcA9fypHho
         PsrhGo47eiwaz/oZafjlxtt3P2nUs3QinGoopeMzjt4XAFhy1NB6hlRw4jeLw8rUne3W
         tmUe90P80fbE9UzQ/h0yMG9pe28HmQAM8fV2iAGMYdlb1wqWK0OxAfHlbCVPPsEpJ31a
         lQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=re6lK/BP08XNQ6PSp6D93sz/YFIqzRCqeE2m1nUD7G8=;
        b=bTEiqkTKtQDrVovYFNZnSOABoGwOa/1CnZXWJfJiss5KqyD6wNeHOIUHIG0Lhs9Qzo
         OVGdZcpN2WwunIkNdDvOS+Wj5iVo8344QcZjN2Z8i7UIQa8eNZNuNF8reAA+36u9FXHn
         dEuTHagSseESptWVLaeKKQCL6tU6je+RM5/Uh2HUxg85CZ58xM3kYOuilK1q6zVrt/l0
         QLlB8JY4WSZfzb+erV0ka+lpHpLeWLWtYbuwZDG/i+KdgInVTNnQKeN6wHBNd+3HWVHa
         HhX0eqErLR0ldIguSzMibmVFCf6JkK0ad3x7wAxCSzvo41+7kDBToxuhPm/catGz1gpM
         I8eA==
X-Gm-Message-State: AOAM5327WYKAMSwtm1q6dku5jaZ9BNRJeh5Bim9D2w67WaAPVoGqwcYC
        HnO6finHN2+d9HWdVPxeiuM=
X-Google-Smtp-Source: ABdhPJxhoEVInXFt0CDNX0OaTxp32rAF2ntzq6G/vNmdhnRIftD9BrlVvKF/U9/BI2IpTKiPCT/NyA==
X-Received: by 2002:a2e:a811:: with SMTP id l17mr30650238ljq.456.1629815992620;
        Tue, 24 Aug 2021 07:39:52 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id v2sm1778139lfg.112.2021.08.24.07.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 07:39:52 -0700 (PDT)
Subject: Re: [PATCH 2/2] staging: r8188eu: Make some clean-ups in
 usbctrl_vendorreq()
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <20210824142823.16845-1-fmdefrancesco@gmail.com>
 <20210824142823.16845-3-fmdefrancesco@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <27c7e4ef-06a8-2f0c-d388-1a64e7d4a735@gmail.com>
Date:   Tue, 24 Aug 2021 17:39:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210824142823.16845-3-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/21 5:28 PM, Fabio M. De Francesco wrote:
> After replacing usb_control_msg() with the new usb_control_msg_recv() and
> usb_control_msg_send() API of USB Core, remove camelcase from the pIo_buf
> variable that is passed as argument to the new API and remove the initial
> 'p' (that probably stands for "pointer") from the same pIo_buf and from
> the pintfhdl and pdata arguments of usbctrl_vendorreq().
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>   drivers/staging/r8188eu/hal/usb_ops_linux.c | 22 ++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 

I cannot apply this one on top of the first one:

error: patch failed: drivers/staging/r8188eu/hal/usb_ops_linux.c:33
error: drivers/staging/r8188eu/hal/usb_ops_linux.c: patch does not apply




With regards,
Pavel Skripkin
