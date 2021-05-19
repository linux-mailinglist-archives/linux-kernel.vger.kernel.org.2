Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9EB5389714
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 21:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhESTyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 15:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbhESTyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 15:54:31 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA54C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 12:53:11 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id h6so13242620ila.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 12:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xnd1I+ZG+p2xZfCRtzpcp/ESI8qGAqiQnNJLNfwMGAw=;
        b=FOAstcFqxm5gMlrrmJeGQxNCe9+od1LRKLR8F7/t4K0pcuuzTJuMpORb2SqN7HryaA
         lRLKvsxIcHLPzZYLXOFgzxaU+zdms5iH9FIVR84dtjZofnHRR27OmU684HkJIzUc0uTs
         807ofQUcHjysLchT48CYfb+M87AWNoZxVqkH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xnd1I+ZG+p2xZfCRtzpcp/ESI8qGAqiQnNJLNfwMGAw=;
        b=j0n64izo2VzED7Jan7Iv9LaGvDyQq3oMJFYq1asyYyZjKtpho1pC25uaSX2iD2qI5A
         I0Bl0mVBl7DZ6kPYpzZRmKjRzLFfdA5/D/oIfWW0wLPDSzIsHou+woVn5CKL+PCVZ0aE
         olsCFS94pqNpxKfw1xLdVLjRHOrZqc285rs+URUzBZXK2GTFYJPbRZCgg9o6SXOXF9Tx
         Rk+ZDB/D+0GvXqIdwk3S1+lhnaNHgejSijvxF93eyIO0V2h+6C8zieSp32Awf6A50Vdh
         yYj+ln6LKxbUEWP8hTkyqKA8x6o4avMl8YRXWvmrq/OIUY4WyXk6G2s1I4cL1sZZAZ+T
         y2gA==
X-Gm-Message-State: AOAM532Fl/SrLXg4K1giKET2+b4sASYPwtup6LwhdsLWw+hSY5Ka5IYp
        S63rzghpuDBuD0FBdUplPqJRH+cw9fLnaDcK
X-Google-Smtp-Source: ABdhPJzySBp1/n9I0djhR7BYsNQdwVhF3x0meWR8KHdioxICxxPdj/J739UNVX45BP0D7DOUAhfZzg==
X-Received: by 2002:a92:6b02:: with SMTP id g2mr720527ilc.23.1621453990981;
        Wed, 19 May 2021 12:53:10 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id f10sm542923ioc.10.2021.05.19.12.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 12:53:10 -0700 (PDT)
Subject: Re: [PATCH] staging: greybus: spi: add blank line after variable
 declaration
To:     Philippe Dixon <philippesdixon@gmail.com>, vireshk@kernel.org
Cc:     rmfrfs@gmail.com, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210519193938.GA7131@ubuntu>
From:   Alex Elder <elder@ieee.org>
Message-ID: <7694715e-41b9-08e2-68f5-0fd57223a3ab@ieee.org>
Date:   Wed, 19 May 2021 14:53:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210519193938.GA7131@ubuntu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/21 2:39 PM, Philippe Dixon wrote:
> This patch fixes the following checkpatch.pl warning:
> 
> WARNING: Missing a blank line after declarations
> 
> Signed-off-by: Philippe Dixon <philippesdixon@gmail.com>

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/staging/greybus/spilib.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/greybus/spilib.c b/drivers/staging/greybus/spilib.c
> index 30655153df6a..ad0700a0bb81 100644
> --- a/drivers/staging/greybus/spilib.c
> +++ b/drivers/staging/greybus/spilib.c
> @@ -246,6 +246,7 @@ static struct gb_operation *gb_spi_operation_create(struct gb_spilib *spi,
>   	xfer = spi->first_xfer;
>   	while (msg->state != GB_SPI_STATE_OP_DONE) {
>   		int xfer_delay;
> +
>   		if (xfer == spi->last_xfer)
>   			xfer_len = spi->last_xfer_size;
>   		else
> 

