Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C883AE5B7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 11:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhFUJO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 05:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbhFUJO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 05:14:57 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D4EC06175F;
        Mon, 21 Jun 2021 02:12:43 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id n12so4898274pgs.13;
        Mon, 21 Jun 2021 02:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vNahs62Fmfx/BFehZDtgJGwFkVF24WzuhgTfY7ZDHBM=;
        b=AxxQmzgqY38wRE8BMMgQrfHQ8Z8niCLeBXhdpVzeQ9HgZlCnNTTJ/HZbmyRN3S+2uj
         WzpxnjokByOx1OLKi2Nm6wk3u1atDMyrdeWXcu4WxQRAW2630tLc6PJC6xmt74/dC0XP
         jecQhlFDlEgt3X4z8JVduYlVRNHikJkSOraSf0nRO9vbf83omv5YZwoR9+eGYc1DpwnK
         o27sRhAxOz+JZaLRZn4a/+o3HOOQZ3Vr4vzM1/1O32p3fjAUyl9v8Y86JDe+fv46WAos
         uQRNrZX2+1lduaA8k1PpN/zjRIuPS2fNE/OnWb86FVBQr6ly1s0hycB+Z39CqEFEDvia
         4fxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vNahs62Fmfx/BFehZDtgJGwFkVF24WzuhgTfY7ZDHBM=;
        b=FhIK1DcihmFsQzSnk4LEz5JDGqWc4M1WoNe0UalR81a0uZnjnbIQryYbQ2RIEB9Gps
         aStg/iM9EuhGKT2/i76UMUeXlaYoBPnPBxRLrERdAsetWUh8Jujsco7tMPTf1SSjtEEB
         tqqC1I0Wo+WO0KCcvSa+EnaI81oWnQczZKydfAUQSoX0XXKwhAleWFwS90dUIelotORs
         FyGW2jh4zitcl/MqcB/0bzujojGKAhFYuS1JCRMxyC0GKFkd7Vqkt6QkNqGWV1bfvsxQ
         uQLB/Bk4lH21VQhJ7PeKI+239cy3pH/GuYgFz0+RjMwtQEXyG0Y0sDhgECXauW1TijyU
         KyLg==
X-Gm-Message-State: AOAM530ctIPWCbe/APphMkHQIqPtN3HlxInmZkvPnPTw4BJAtU37/eAH
        gtZuRAqhjBdsZJ4ymL62EW7S3feGqqtuGA==
X-Google-Smtp-Source: ABdhPJySs0uYjwsomNdKtMjK07pIvmWmaGGZVRKqBy1Unvp5XR7gZNPq/3oyl0m7t54m0YVi1Pyesw==
X-Received: by 2002:a63:1c0a:: with SMTP id c10mr22799984pgc.306.1624266762738;
        Mon, 21 Jun 2021 02:12:42 -0700 (PDT)
Received: from [172.28.99.179] ([119.28.155.243])
        by smtp.gmail.com with ESMTPSA id v14sm16450326pgo.89.2021.06.21.02.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 02:12:42 -0700 (PDT)
Subject: Re: [PATCH] Doc: correct the url of linux-next.
To:     Zhou Yuheng <zzjzxq33@yeah.net>, alexs@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <4b28d69.493.17a2934b77b.Coremail.zzjzxq33@yeah.net>
From:   Alex Shi <seakeel@gmail.com>
Message-ID: <8d838343-1bcd-15e3-7033-8fa4c2768125@gmail.com>
Date:   Mon, 21 Jun 2021 17:12:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <4b28d69.493.17a2934b77b.Coremail.zzjzxq33@yeah.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alex Shi <alexs@kernel.org>

On 6/20/21 7:35 PM, Zhou Yuheng wrote:
> There was a full angle query in the url of linux-next.
> Signed-off-by: Zhou Yuheng <zzjzxq33@yeah.net>
> ---
>  Documentation/translations/zh_CN/process/howto.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/translations/zh_CN/process/howto.rst b/Documentation/translations/zh_CN/process/howto.rst
> index ee3dee476..52c66461f 100644
> --- a/Documentation/translations/zh_CN/process/howto.rst
> +++ b/Documentation/translations/zh_CN/process/howto.rst
> @@ -252,7 +252,7 @@ Linux-next 集成测试树
>  在将子系统树的更新合并到主线树之前，需要对它们进行集成测试。为此，存在一个
>  特殊的测试存储库，其中几乎每天都会提取所有子系统树：
>  
> -        https://git.kernel.org/？p=linux/kernel/git/next/linux-next.git
> +        https://git.kernel.org/?p=linux/kernel/git/next/linux-next.git
>  
>  通过这种方式，Linux-next 对下一个合并阶段将进入主线内核的内容给出了一个概要
>  展望。非常欢冒险的测试者运行测试Linux-next。
> 
