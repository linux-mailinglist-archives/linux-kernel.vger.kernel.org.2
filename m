Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0A13F3F7B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 15:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbhHVNac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 09:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhHVNab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 09:30:31 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EDCC061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 06:29:49 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id j12-20020a05600c1c0c00b002e6d80c902dso8974591wms.4
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 06:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ghFVv5lV5qranQx6DSdZ1UaRirduo1mHlUCU2zO78CY=;
        b=bAGUSx0Ai/pwtfBG0lRxoK7bMH/28LVbtLfpyEWzCsFvcuQ3kk6z0g2PhDtUTxrl1F
         kv7W47y88jL4me4x4L773+hv9O6QX+BSNHKh+dJX7et+IkkQwlCOsBIrRWzvxzCh1pMc
         lIdvypeRL5g+x8lw+pGlNp/ppLjRNrldEzgjEtO9PKbfDiJMfG7GjxMOfcvd6jvLBIYC
         e4mct3F5M/Ux1hC/XH+Q342cpPkieZgM/f0QArM7xYHlWSc9YAvr2C4NmnerKJcJ22V1
         rzizX14xjH4EELKuYmNJKxawNAdvmlXbeJOHp3IqFsQyc7EzlgyCQutF1su9EL6ewLp/
         7Qlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ghFVv5lV5qranQx6DSdZ1UaRirduo1mHlUCU2zO78CY=;
        b=pR9UyCcj9xxpw1JYKZq5SHsFW3dFy73fhekG5aa9fNmMGlGjRuUT/E7w9o7XBQqNnx
         kCticlNiI9+5QJdY6L8yq2cUia3Z9mVxBR1mTQD+HH7RiofCU8fN6bEBY1RLKxI1yqgX
         H+VX0W19zduQh6P8vY8OHqJvaHklxUJADTs93rUS7/JqUqecQy+dQ1VIE9vK1v8Adk7D
         gVVOLusD4yGTf2C+UJ20BOrerdn5fqIrtJg42Ibpb1eUrIM3YlLbhEXt7KIjPV9+CWqf
         u/hGYuJvIJaQCDgcRKJU5kqSjzAHa429QXgDc34aM86zCZgcG7Pb9YdQJeVIJar++QHE
         Oi+g==
X-Gm-Message-State: AOAM531vqoAwmCMjiGgOETfhsf1lEhB0YZlW3hoZPfgX/uOSD7ApJRcg
        X/+kDnB362TUQmDQppm5ixMwbTrPq3k=
X-Google-Smtp-Source: ABdhPJxG9u4Ql7Z4irIJ+7rKnUTwSGszZC7cZov6YVCUiYVfU7xuzR4WjenIdZjA65EfcjxjdCAsVg==
X-Received: by 2002:a7b:ca45:: with SMTP id m5mr11970115wml.158.1629638988479;
        Sun, 22 Aug 2021 06:29:48 -0700 (PDT)
Received: from ?IPv6:2a02:8108:96c0:3b88::687e? ([2a02:8108:96c0:3b88::687e])
        by smtp.gmail.com with ESMTPSA id p9sm6800727wmq.40.2021.08.22.06.29.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 06:29:48 -0700 (PDT)
Subject: Re: [PATCH 09/10] staging: r8188eu: remove unused members of struct
 _io_ops
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210821164859.4351-1-martin@kaiser.cx>
 <20210821164859.4351-9-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <97ed44a4-fe93-fb1c-6ef9-01b2c287ef16@gmail.com>
Date:   Sun, 22 Aug 2021 15:28:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210821164859.4351-9-martin@kaiser.cx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/21 6:48 PM, Martin Kaiser wrote:
> Remove function pointers which are not used by the r8188eu driver.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/include/rtw_io.h | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
> index f1b3074fa075..4b41c7b03972 100644
> --- a/drivers/staging/r8188eu/include/rtw_io.h
> +++ b/drivers/staging/r8188eu/include/rtw_io.h
> @@ -100,13 +100,10 @@ struct _io_ops {
>   			  u8 *pmem);
>   	void (*_write_mem)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt,
>   			   u8 *pmem);
> -	void (*_sync_irp_protocol_rw)(struct io_queue *pio_q);
> -	u32 (*_read_interrupt)(struct intf_hdl *pintfhdl, u32 addr);
>   	u32 (*_read_port)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt,
>   			  u8 *pmem);
>   	u32 (*_write_port)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt,
>   			   u8 *pmem);
> -	u32 (*_write_scsi)(struct intf_hdl *pintfhdl,u32 cnt, u8 *pmem);
>   	void (*_read_port_cancel)(struct intf_hdl *pintfhdl);
>   	void (*_write_port_cancel)(struct intf_hdl *pintfhdl);
>   };
> 

Looks good to me.

Acked-by: Michael Straube <straube.linux@gmail.com>

Thanks,
Michael
