Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6FE3A5CB4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 08:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbhFNGEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 02:04:06 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48]:43737 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhFNGED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 02:04:03 -0400
Received: by mail-ej1-f48.google.com with SMTP id ci15so14575835ejc.10
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 23:01:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hic8B8cFh7yZqOZHDJFPIf7SaDm2N6HEGrxwVofZzAU=;
        b=Wg5Aj/bQX7Bp0ZZp1y8uSeLHC1Ue25B4lJjayNokLQssC+kOEQIxydPqRZqLgQokuE
         UHSCMSbePozO8CWofF+smIKHRQJJmgpY34Rbbyh8d8AWQHjpW3PGeAWfI3XYbhAu07/X
         kl63z/+dBP6r1dktEpTXmFwTZjbPSA0yGo9F5xVB1BU3K74Pj6qgjNb1tFvuwYHU5l/n
         Vj4N2FQm3up2DYlXsevzFy8Q/8tGaVptBKw+LNftFkVocImTB7OiiiZ0SZl7Hu1El/WS
         Co3gRua2wDKtwHBdPz4g1Cdo7pC4MyhPxaWPeH9LIIvelzEFl351ze8YOfzaXe1GNK0y
         cdiw==
X-Gm-Message-State: AOAM531WCvihX6RQ0YlLBirvMCM/xkJlpDdf/Wi3SMoYB/JLw+A3zePq
        aepSAlWWqm3IOeTfvsPWFgVUx/OyfN0=
X-Google-Smtp-Source: ABdhPJzp/A3jbr//wUGyH0lpc/9yv/AoYhokHIwc74MTjGiyO37RWfk5qWA07nHafQ44ffyQS1Nv9A==
X-Received: by 2002:a17:906:914f:: with SMTP id y15mr14299691ejw.354.1623650505001;
        Sun, 13 Jun 2021 23:01:45 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id l11sm7493091edb.3.2021.06.13.23.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jun 2021 23:01:44 -0700 (PDT)
Subject: Re: [PATCH] accessibility: braille: braille_console: fix whitespace
 style issues
To:     Clayton Casciato <majortomtosourcecontrol@gmail.com>
Cc:     gregkh@linuxfoundation.org, gustavoars@kernel.org,
        linux-kernel@vger.kernel.org
References: <20210613203031.23721-1-majortomtosourcecontrol@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <0251af78-1c7c-a598-4156-982f35db79a7@kernel.org>
Date:   Mon, 14 Jun 2021 08:01:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210613203031.23721-1-majortomtosourcecontrol@gmail.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13. 06. 21, 22:30, Clayton Casciato wrote:
> Fixed a coding style issue.
> 
> Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>

FWIW:
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/accessibility/braille/braille_console.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/accessibility/braille/braille_console.c b/drivers/accessibility/braille/braille_console.c
> index 9861302cc7db..a0656c6b595f 100644
> --- a/drivers/accessibility/braille/braille_console.c
> +++ b/drivers/accessibility/braille/braille_console.c
> @@ -225,6 +225,7 @@ static int keyboard_notifier_call(struct notifier_block *blk,
>   	case KBD_POST_KEYSYM:
>   	{
>   		unsigned char type = KTYP(param->value) - 0xf0;
> +
>   		if (type == KT_SPEC) {
>   			unsigned char val = KVAL(param->value);
>   			int on_off = -1;
> @@ -264,6 +265,7 @@ static int vt_notifier_call(struct notifier_block *blk,
>   {
>   	struct vt_notifier_param *param = _param;
>   	struct vc_data *vc = param->vc;
> +
>   	switch (code) {
>   	case VT_ALLOCATE:
>   		break;
> @@ -272,6 +274,7 @@ static int vt_notifier_call(struct notifier_block *blk,
>   	case VT_WRITE:
>   	{
>   		unsigned char c = param->c;
> +
>   		if (vc->vc_num != fg_console)
>   			break;
>   		switch (c) {
> 


-- 
js
suse labs
