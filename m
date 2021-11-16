Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD976453541
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 16:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238226AbhKPPJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 10:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238049AbhKPPIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 10:08:18 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45C4C079787
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 07:03:18 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id f18so54071492lfv.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 07:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=x8Pb1HDChQ0vfcfqFJfrIYfJGgmQhlUPanGxtam9Nxo=;
        b=hkhpW8Qn2CwoAdqUYRxmConYIy1Qhpj3ZjtGflMaUH06gTJKfZGx5FyLfcbtLVv7Uj
         1dfMlUWpT34C5P5OZwK7pseUPsnSE0a7178dFPQgLSoM6bHm4BD0pX2APIS4BZFNPfke
         ReesSCjgm1N2/riiUpesljlmm/3Z+yMO1mlhIQ1qF9tHUHt6TiPq7/Z7/VfsTxoQmViD
         /iauVULHVgyhfIsfZerw1dvvMjUbsr6V/nQTYe83bjGiOcbvQpujzirQ4ND62xrj+1hd
         irdGSLG5Dh3uKBAq4yVJHIdD6e2TcBcnZ7e/7wqgOHiFT4nuBYehL4Al9xV0swHTVU7V
         ykJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=x8Pb1HDChQ0vfcfqFJfrIYfJGgmQhlUPanGxtam9Nxo=;
        b=uEMAwSa2bhitl3iGARCtzsyF7ND8FDX+B5T40gVM4cBQTqt2ULodgVL8lRGR1dfy6x
         pJavN29wvHVlkj99Oe14S+eJPI9mmb18/U44zZ87m6YHTQje0j471rtERy9a1Ng1na+4
         GP0lQhuJ0MX8q0aJieu2jDuUUM7rcKWm3lMKW5mZflx/2DYsq372sPqCfb9DCngSvXYJ
         E2YLmrXfMUhYwdsrTY5cfRCIohUPyPJivgrDE6QP453FAc3P5Epnk1WuyTSKYX9QUKbn
         p0hjeUMIuf8IwIghLjxkLtFPNoTMIXV6/IKPWP8BmYGzR8QTw+wp53OucJZmVnLDk0fM
         o5PA==
X-Gm-Message-State: AOAM532EtFkigZm86MQGib/uI+Y7dKz/HsN7atS2dzE58DVOGk/himgA
        RE7hghg6hFmkhkWbhdUBJHU=
X-Google-Smtp-Source: ABdhPJwzdKU03kzvBzu1kM7rBjmdOhyAr3Yjh/MCEDbeIh7ZWPwbUgj7rWgenPiag7fAneg8CY9ESQ==
X-Received: by 2002:a05:6512:3ba6:: with SMTP id g38mr7264286lfv.330.1637074997023;
        Tue, 16 Nov 2021 07:03:17 -0800 (PST)
Received: from [192.168.1.11] ([94.103.224.112])
        by smtp.gmail.com with ESMTPSA id b12sm1257799lfb.146.2021.11.16.07.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 07:03:16 -0800 (PST)
Message-ID: <b2a92947-7bb1-849a-e82c-3a505a66989e@gmail.com>
Date:   Tue, 16 Nov 2021 18:03:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] staging: r8188eu: remove unused defines in wifi.h
Content-Language: en-US
To:     Zameer Manji <zmanji@gmail.com>, gregkh@linuxfoundation.org
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211116011451.896714-1-zmanji@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20211116011451.896714-1-zmanji@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/21 04:14, Zameer Manji wrote:
> None of these defines in wifi.h are used so they
> can be safely removed.
> 
> Signed-off-by: Zameer Manji <zmanji@gmail.com>


Reviewed-by: Pavel Skripkin <paskripkin@gmail.com>




With regards,
Pavel Skripkin
