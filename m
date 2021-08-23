Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E8D3F48CE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 12:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbhHWKlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 06:41:18 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:50766 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbhHWKlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 06:41:15 -0400
Received: by mail-wm1-f49.google.com with SMTP id u1so10229303wmm.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 03:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eFSKVFGVhYPyJojSAbVLjo17tsdlkzw1MJ5OD5VUodw=;
        b=nwkfZVIQkSHodHBUOXUZQxb2Jku/mstKU927EwzQthHGdHBUyIWySnTtMCF+BzX5ik
         NNbRsm8y3UGOp8nJmaEhHBelgOuLs+pESfidRp2i7pd6ET8SThVvoETjUqyZnUDazueT
         YKbjkn30Y8NPYIJyVfh6bl6NEkaO5uFgr5SbM+F7xQ+1SFcG/ohMLpHT0XKUGyUt50C4
         ZiLtBRZX9iveB2cQM3TykwBQIkXW0Plr28EGQbuFsUb9mLhH8DUpg4nhMN2zca/HAmIb
         GfI2U+F6ARvPTbXQjp2UDNd+YGjW9HTlcwGDcUzRkJBYiWAAAq5c/yFOGXeaSoltNp5X
         LWtQ==
X-Gm-Message-State: AOAM530+cbZMpMscYju5lKrPPmoULNspyVms8gxVf++MKeENJZK+n8ps
        DUwFSfeg6nM56DZM+rR8WEI=
X-Google-Smtp-Source: ABdhPJwro+7cgwjI7oAFNVBZe+2+NTd1gcaLdPXs/YE9o4rLZM4afpDr3I8h3ZPNIbVRI0VWK+rAYA==
X-Received: by 2002:a05:600c:1c28:: with SMTP id j40mr15454406wms.104.1629715231662;
        Mon, 23 Aug 2021 03:40:31 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id z6sm12844094wmp.1.2021.08.23.03.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 03:40:31 -0700 (PDT)
Subject: Re: [PATCH linux-next] serial: drop unneeded assignment
To:     CGEL <cgel.zte@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20210821021727.27170-1-luo.penghao@zte.com.cn>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <16e64194-452f-bac8-c535-df9dd65048c7@kernel.org>
Date:   Mon, 23 Aug 2021 12:40:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210821021727.27170-1-luo.penghao@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One more hint:
$ git log --oneline  drivers/tty/nozomi.c|grep -i serial
<empty>

Please use some of already used "tty: nozomi:", "tty/nozomi:", or "tty: 
nozomi," prefixes for the subject.

On 21. 08. 21, 4:17, CGEL wrote:
> From: Luo penghao <luo.penghao@zte.com.cn>
> 
> The first assignment is not used. In order to keep the code style
> consistency of the whole file, the first 'offset' assignment should be
> deleted.
> 
> The clang_analyzer complains as follows:
> 
> drivers/tty/nozomi.c:520:6: warning:
> Although the value storedto 'offset' is used in the enclosing expression,
> the value is never actually read from 'offset'.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Luo penghao <luo.penghao@zte.com.cn>
> ---
>   drivers/tty/nozomi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
> index 0454c78..210a48f 100644
> --- a/drivers/tty/nozomi.c
> +++ b/drivers/tty/nozomi.c
> @@ -517,7 +517,7 @@ static void nozomi_setup_memory(struct nozomi *dc)
>   
>   	/* Ctrl dl configuration */
>   	dc->port[PORT_CTRL].dl_addr[CH_A] =
> -				(offset += dc->config_table.dl_app2_len);
> +				(offset + dc->config_table.dl_app2_len);
>   	dc->port[PORT_CTRL].dl_size[CH_A] =
>   				dc->config_table.dl_ctrl_len - buff_offset;
>   
> 


-- 
js
