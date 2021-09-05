Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB444011DA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 00:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238325AbhIEVlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 17:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238291AbhIEVln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 17:41:43 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F84C061575
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 14:40:40 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id m9so6865673wrb.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 14:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EI/tQ0853DgmlZpgUH6Sb8Mf92xDUUOdSCeoB3y9z5k=;
        b=XqQnR5svqFEfr69eWiEFC9YZH7l61Qz+vrz1V1/rLRWUbJHt1nppEErih7/Ct8P4DD
         ncVamoWfi4yVxVFM7yoiWHyp5c5fjc/mdGWmjvFcprreKSKhqSOFXWJccBeMJLQsol4r
         SP27LCoos1KmpINQTHqrvwHfGrc9KaFuRdhFMHmHhleEdZdjBwU8VtM9r0068hiavn7y
         x0pM7Xp1paK5Zs+AbUNHhieubdThc2wpLntFWDLlVRhdv4Jyf7UiODnuTlpSiEvsMAiJ
         Ve1N7hXnUI5cijwu9/PLLtIBH8ZwCSMLLnc/2I7M+YBj9wPToFTmXz0IZgGKZCVax0IC
         PsYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EI/tQ0853DgmlZpgUH6Sb8Mf92xDUUOdSCeoB3y9z5k=;
        b=QuqqxB70TTfjWjPBRRbogXpDbLcJj+1n5d7LTKa8VPnHmQSbAm/ZNfa5hn3RCUQMXf
         +EFF42bnOIGrHgPcw0Z6iSM2H67t57kW+3wWbsvRbQh+aAfYYM5484pGixWL3v1AFGCv
         82yy1VMRp8T7oIrvTxZmownADQI6Hm6Pnaldiy4exGUALCUopTA+T/p4HHK/7IVa1wP4
         Ix+tLvxbFyQV9cDtIqvzl2yNVDhiD0PGcY00//wWNao9rM6tMgrcf8UobQRIwzRhxTLO
         BSfd265dYGkhumM8YN9H44Dg9zgHc+fDET/hjT//G1GlcCHcp5sjOfElQTDNmp2GhNL9
         3z7g==
X-Gm-Message-State: AOAM532dF4mmypx8DXx7U/ngJKu9u3RGMsVdEbIS0dHSVRon7KlERJW/
        6gW5nPYkv311i/9m0a7Y9OI=
X-Google-Smtp-Source: ABdhPJxhzS7wcIoJV53OmR17rs/Sqs/epck5DWXDarSnkVXm8JvPqvAcOuQLKqLv2ELrPkgSzr/MWw==
X-Received: by 2002:adf:e788:: with SMTP id n8mr9755988wrm.214.1630878038888;
        Sun, 05 Sep 2021 14:40:38 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::8fe1? ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with UTF8SMTPSA id l21sm5390410wmh.31.2021.09.05.14.40.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Sep 2021 14:40:38 -0700 (PDT)
Message-ID: <94b3634f-f531-d4f1-2809-dc4de5b9b876@gmail.com>
Date:   Sun, 5 Sep 2021 23:40:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH] staging: r8188eu: fix type mismacth
Content-Language: en-US
To:     Pavel Skripkin <paskripkin@gmail.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        fmdefrancesco@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210905205216.24831-1-paskripkin@gmail.com>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20210905205216.24831-1-paskripkin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 9/5/21 22:52, Pavel Skripkin wrote:
> diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
> index fee4208dacba..afe6c7fa594d 100644
> --- a/drivers/staging/r8188eu/core/rtw_cmd.c
> +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
> @@ -1162,7 +1162,7 @@ u8 rtw_setassocsta_cmd(struct adapter  *padapter, u8 *mac_addr)
>   		goto exit;
>   	}
>   
> -	psetassocsta_rsp = kzalloc(sizeof(struct set_assocsta_rsp), GFP_ATOMIC);
> +	psetassocsta_rsp = kzalloc(sizeof(struct set_stakey_rsp), GFP_ATOMIC);

this should be

psetassocsta_rsp = kzalloc(sizeof(*psetassocsta_rsp), GFP_ATOMIC);


This way you get always the correct size, no matter what's the type of
psetassocsta_rsp. Checkpatch suggests this too. ;)

Best regards,
Michael
