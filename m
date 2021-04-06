Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9E7355CC0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 22:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237478AbhDFUMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 16:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbhDFUMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 16:12:44 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090AFC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 13:12:36 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id x7so15510022wrw.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 13:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=uSk5LLkjyneeHdTYSr/KpbjFbr3l55wAk/Hm2oDaLtU=;
        b=n0Skk+TvZuKP5ODn1L/FhPkppv1VHaSNBzevhhwhjRj3FYDlWKWNszRL7ZD5mWQgZ1
         eGj00y/mGidx6f/3Aw6Bpea1n/3g6a7l6r3kLz+zMb16qWS+0jJcf+TsBF9GzJ+NH4+B
         hn8aHlwQykOUdbmCyOzi8JsvKnviYM7bwPbc0oC7+vezeepiZdLhpc266s7dEKq8ODkG
         UnJt6Hjk9SH0pub/dN9DhHrW368zxCgc9dFvx/qLWg+yNggz7rEXa7qtqFhp/Lvo3c9Z
         uZ+WURJO4fRq/GdsOd0p61vqWTir0LMl6HM7dZgJBHVbonbEqeexexq7JpF6XiBJqKYG
         3DWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=uSk5LLkjyneeHdTYSr/KpbjFbr3l55wAk/Hm2oDaLtU=;
        b=K4PQ4QXAIlGvapB8UUouag80N/oHhFzj7C2wU6yLHrc1t9BMeso5QHdqXWYyO/CBMv
         8ToXExuuIgmDjE0scEwFPim0XmilxAMZMfDGdEiChrcAAsEkVqFVb+In/FTf4lEGss96
         gUaSWn+iLmKM0Y+yyMTVwu6OunPqAawyV0LslEHqUxPSuMri6gzMFPk2hozWZUDrjoPH
         m/SrDpfN5O2NCg4lwrb3vYiXfCyEKoUg/jCkIg2IhEzV6i5uPCTv7Se/ANmxGOAkcSyB
         C/ClI17MKsPexHGAng0qiTFtUedvPbCx7LQP6OnXZRBpO9CTA0POqZp5MGoaA1c2tEov
         O9YQ==
X-Gm-Message-State: AOAM530ui1DD12cL5M15+sT9FY/uQli0UR1H7yj7V9AJ4F1/YDIDYb1r
        YMalGRt9bTasUz3xIw8ZDZdq/5g05FVHwA==
X-Google-Smtp-Source: ABdhPJx2MUM6OBF8YPKKL0KwYkb7KuBloUMnLifli+D0EVyv12tNjBMtk3FMsGXypKGOQUy8IXGSqQ==
X-Received: by 2002:adf:8b45:: with SMTP id v5mr36594981wra.398.1617739954848;
        Tue, 06 Apr 2021 13:12:34 -0700 (PDT)
Received: from ?IPv6:2001:818:de85:7e00:ef5c:3f2a:a646:d6ec? ([2001:818:de85:7e00:ef5c:3f2a:a646:d6ec])
        by smtp.gmail.com with ESMTPSA id k7sm24620902wrd.24.2021.04.06.13.12.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 13:12:34 -0700 (PDT)
Subject: Re: [Outreachy kernel] [RESEND PATCH] staging: emxx_udc: Ending line
 with argument
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org
References: <20210406193409.96428-1-martinsdecarvalhobeatriz@gmail.com>
 <20210406195621.GU2531743@casper.infradead.org>
From:   Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
Message-ID: <07ae6975-d4a0-dfec-8030-7ddbd90eedd5@gmail.com>
Date:   Tue, 6 Apr 2021 21:12:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210406195621.GU2531743@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Em 06/04/21 20:56, Matthew Wilcox escreveu:
> On Tue, Apr 06, 2021 at 08:34:09PM +0100, Beatriz Martins de Carvalho wrote:
>> Cleans up check of "Lines should not end with a '('"
>> with argument present in next line in file emxx_udc.c
> I appreciate that you've removed the checkpatch warning, but this is
> still harder to read than the original used to be.
Thank you for your review.
>> -				_nbu2ss_writel(
>> -					&preg->EP_REGS[ep->epnum - 1].EP_WRITE,
>> -					p_buf_32->dw);
>> +				_nbu2ss_writel(&preg->EP_REGS[ep->epnum - 1].EP_WRITE,
>> +					       p_buf_32->dw);
>> -		length = _nbu2ss_readl(
>> -			&ep->udc->p_regs->EP_REGS[ep->epnum - 1].EP_LEN_DCNT);
>> +		length = _nbu2ss_readl(&ep->udc->p_regs->EP_REGS[ep->epnum - 1].EP_LEN_DCNT);
>> -			regdata = _nbu2ss_readl(
>> -				&preg->EP_REGS[ep->epnum - 1].EP_STATUS);
>> +			regdata = _nbu2ss_readl(&preg->EP_REGS[ep->epnum - 1].EP_STATUS);
> The real problem with this driver is that their abstraction layer is
> wrong.  For example:
>
>          /* Interrupt Status */
>          status = _nbu2ss_readl(&udc->p_regs->EP_REGS[num].EP_STATUS);
>
>          /* Interrupt Clear */
>          _nbu2ss_writel(&udc->p_regs->EP_REGS[num].EP_STATUS, ~status);
>
> If instead this were:
>
> 	status = nbu2ss_read_ep_status(udc, num);
> 	nbu2ss_write_ep_status(udc, num, ~status);
>
> that would be a lot shorter and clearer.  Cleanups along these lines
> would be a lot more useful, and would fix the 80 column warning.

I can see what you mean and makes sense. Thank you.

Beatriz Martins de Carvalho

