Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7245441D2F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 16:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbhKAPOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 11:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhKAPOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 11:14:03 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13673C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 08:11:30 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id q124so25315939oig.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 08:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7ywhAg6xLoCp/gjGMKiRoOsRGE2B1fYG2i3QTqd0P5I=;
        b=W4LXTCoGM/Ls/G2UBWC2HVcS2wU7sGQs3xZAUvr4RG2iHstedbtp0Ze5mIfERCtcYj
         AejZEbBZIPt5LgFEncLVnxG1aSzQys4czWsu1w+J+tAmj4f0/ZRstjrueQKg3xdS82r6
         pioQM117fveIbCddpUAJlIk5fJc186EvCiIC7voiVco5miWibhgQ37zTape0HhW+CakD
         hsu7KrV1XH6b3pOFFtM2TOwMAYyNAsjZCFly3sVn0wCZOuM/DDWx7fGe0PYUrqseb+xU
         pkjCWyOUtPf+xj+mBxukjGySofBMuw2SP7qP4rrSAcAVm3qhzIhGq5aG3bKZibjoCqsQ
         IKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7ywhAg6xLoCp/gjGMKiRoOsRGE2B1fYG2i3QTqd0P5I=;
        b=fKlLCnBu8fM+l3mwBiviSo1GBtHn0EA9Q2M9L0c7U1e61EhK6KxajbcWGEpQ14Zb0B
         /3sPaMZrGHeG2I3YIKtcogKXI/P/AAKsp+tBv8/6u7ds4X1ZjgHfyPIwDnGnzZzdJz7C
         EkSl3CxrbzflgKgcEo/aZYReGsCMpvs78B4W+4T2XIiAL6YhMX7S4Wo+WVBxmzAJyVq0
         88VyPiJ+Ag3J9USPn3rrAh1HO2BW/78aR4ovLm/jQll9N89+4dIL21sSrE5f2Sa3ILpM
         r24YeBOxNl17ocIIvnJYRAPzXWHTuq1Vy+AmwJXMn9rtup+xJnA0InzU10ZhNuk+lVdH
         py/A==
X-Gm-Message-State: AOAM532+oqZnQxAmudk0UyT9q80XvGQJGCWyhy7JY62i/HHpo/hvfeqD
        Lebw+xJ148gTKl0qQlgp2fNM8Tn9nRKkmMr9
X-Google-Smtp-Source: ABdhPJxVHi6I+/6D+rCXSiSdFyKljSuLlvKrmnSgzFDwhPrufj+DezwWztEJVr/MujbmEuYaNXK7OA==
X-Received: by 2002:a54:4186:: with SMTP id 6mr20376189oiy.152.1635779489491;
        Mon, 01 Nov 2021 08:11:29 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::101e? (2603-8090-2005-39b3-0000-0000-0000-101e.res6.spectrum.com. [2603:8090:2005:39b3::101e])
        by smtp.gmail.com with ESMTPSA id bi40sm353818oib.51.2021.11.01.08.11.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 08:11:28 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <d1a8eb91-adb9-2163-dc3d-9f86ebdc45e3@lwfinger.net>
Date:   Mon, 1 Nov 2021 10:11:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2] staging: r8188eu: Use kzalloc() with GFP_ATOMIC in
 atomic context
Content-Language: en-US
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211101142732.5638-1-fmdefrancesco@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20211101142732.5638-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/21 09:27, Fabio M. De Francesco wrote:
> Use the GFP_ATOMIC flag of kzalloc() with two memory allocation in
> report_del_sta_event(). This function is called while holding spinlocks,
> therefore it is not allowed to sleep. With the GFP_ATOMIC type flag, the
> allocation is high priority and must not sleep.
> 
> This issue is detected by Smatch which emits the following warning:
> "drivers/staging/r8188eu/core/rtw_mlme_ext.c:6848 report_del_sta_event()
> warn: sleeping in atomic context".
> 
> After the change, the post-commit hook output the following message:
> "CHECK: Prefer kzalloc(sizeof(*pcmd_obj)...) over
> kzalloc(sizeof(struct cmd_obj)...)".
> 
> According to the above "CHECK", use the preferred style in the first
> kzalloc().
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> v1->v2: Fix an overlooked error due to an incorrect copy-paste
> 	of the sizeof() operator.

I am happy that you caught the error before it destroyed every instance of 
r8188eu. Incidentally, I disagree with checkpatch in that I think that 
sizeof(struct foo) is more descriptive than sizeof(*bar). If I wanted to check 
the resulting value of the sizeof(), the second form requires an additional 
step. It probably does not matter much to the compiler, but when I have to do it 
manually, the extra effort is not negligible.

Even though I disagree with the philosophy,

Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

> 
>   drivers/staging/r8188eu/core/rtw_mlme_ext.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> index 55c3d4a6faeb..315902682292 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> @@ -6845,12 +6845,12 @@ void report_del_sta_event(struct adapter *padapter, unsigned char *MacAddr, unsi
>   	struct mlme_ext_priv		*pmlmeext = &padapter->mlmeextpriv;
>   	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
>   
> -	pcmd_obj = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
> +	pcmd_obj = kzalloc(sizeof(*pcmd_obj), GFP_ATOMIC);
>   	if (!pcmd_obj)
>   		return;
>   
>   	cmdsz = (sizeof(struct stadel_event) + sizeof(struct C2HEvent_Header));
> -	pevtcmd = kzalloc(cmdsz, GFP_KERNEL);
> +	pevtcmd = kzalloc(cmdsz, GFP_ATOMIC);
>   	if (!pevtcmd) {
>   		kfree(pcmd_obj);
>   		return;
> 

