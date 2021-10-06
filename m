Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED614237A0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 07:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhJFFx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 01:53:59 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:36609 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhJFFx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 01:53:58 -0400
Received: by mail-wr1-f51.google.com with SMTP id o20so5100446wro.3;
        Tue, 05 Oct 2021 22:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BkOpEzM1CX+eRiBhQMKA99SLtxDmiqOiqqpzJVLe8ik=;
        b=omRLnSBp7xq31CyrmycqdE/zMG0v6W3Vu8Q+qyqiKKZ6rMa7Z+mU+dNn96KYPHtyF2
         M4sRrXeA0hvZ8xu4jUmEKTLQ/84dKxUp78MZ9x9CQq6/Vq2jKhMSAhYxIxd3HXz0F0Ur
         eaZ7YoNSWeoIqwLKkMTS38ywT9AHssqpGaLkAJdYZzlsBOaFbK8WrAc98rK1t79eBHFu
         I8vEFAJ8MoOraKl0MgedW6jis45zEm1bgGtgsJfKAZg5ri8HYWvfX9TN2x7IMdsjhJzf
         Xu8yktfnJrzBj0pWIxWY6MOLBqY8nKLzhBy6dPGfbkSut1VhVE44BMMohUmmwImRHJHy
         kmeg==
X-Gm-Message-State: AOAM531xIiZHOz70OxnqbadWbs4nbClz3MZ7f/cvVHwm6C7R6zFpJf+Q
        gLkCOSDjVveAIlLd9BK+KbNUVXs3ags=
X-Google-Smtp-Source: ABdhPJwURq7nUgvaQAZ72eDz1WSMDCa3nyptszxwsCT9XQcKAm8DtZPP9lTqrwK2ImtE5pKYnXVz2g==
X-Received: by 2002:a5d:453b:: with SMTP id j27mr26785597wra.324.1633499525656;
        Tue, 05 Oct 2021 22:52:05 -0700 (PDT)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id i3sm4011149wrn.34.2021.10.05.22.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 22:52:05 -0700 (PDT)
Message-ID: <e614e753-5eec-225e-7437-f2ad650585ba@kernel.org>
Date:   Wed, 6 Oct 2021 07:52:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] tty: n_gsm: clean up indenting in gsm_queue()
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20211004104343.GF25015@kili>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20211004104343.GF25015@kili>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04. 10. 21, 12:43, Dan Carpenter wrote:
> These two lines need to be indented one more tab.

Right, the indentation is incorrect (and not the closing brace).

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>   drivers/tty/n_gsm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index 157b51ce9cc0..3bbfcccd79d3 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -1854,8 +1854,8 @@ static void gsm_queue(struct gsm_mux *gsm)
>   				if (address_tmp == address) {
>   					for (k = j; k < addr_cnt; k++)
>   						addr_open[k] = addr_open[k+1];
> -				addr_cnt--;
> -				break;
> +					addr_cnt--;
> +					break;
>   				}
>   			}
>   		}
> 


-- 
js
suse labs
