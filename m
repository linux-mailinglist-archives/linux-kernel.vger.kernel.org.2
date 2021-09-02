Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 489643FED49
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 13:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343940AbhIBL50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 07:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343994AbhIBL5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 07:57:09 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F20C0613C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 04:56:11 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id t190so1648740qke.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 04:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HmG+SzrqI25IfuOzYDDubE9mgxl445AA/VbS1PiElag=;
        b=mSo12sAwclW6At6xkB9mlrVJ+Tc5FkqDtEY9LlDtlFK+hxBuTNvTDbNpFL1xxTFNlF
         nwDxpSko/dvgY9CnDlh6ty1+2auJybtEU1Asz0VwepEiBdzfLWvQVHZaVUCFa1NcrIbP
         0756JE6st4fVmFOBe5pas+MDy6lTF+uMPvBbelLD09/zofzYLbhF3peAr0gh5TSdxgSj
         vGdJwUXHFGNSFIya472jKpvz/TmVROAC0XByV5AAea/3S8FYelU9Pmmx3T56kGSnwX6N
         YSYN+Tn2seNFplpmMvZouN1DaPkG8f1OHvjQ4TwMjA+uPq8+oQZZNPHcnG04B7q52o6H
         +9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HmG+SzrqI25IfuOzYDDubE9mgxl445AA/VbS1PiElag=;
        b=jC3aWrSQkB2nP6o5u5gO+kAIN3tqdejhz+1FlfXvo/9sS+ihJysk5go+p90VPcjl/n
         6ftytAKi4wb8iLN7VjW2KUvIfiZN3S7MCr4TY/ElLMMzN91Zwl0gUjW+zvSk2M7WtoBc
         kSWFfhFQise4SOMutpFXc9+SyC3N6Owy6dpvxphxoGPTN77eRy47asIobSyBBV7+0y6N
         PAgP/9mJ9vKt48p6UBkwluXQmoBgLhDdwrPrnHCri0a9sDUb7zDRtWLchxBrvLkBE4G9
         8ZlgZAD8sXh8rqpcr5DUjsHy0P5vSujly4fyyjdYsLoR0lt92h67RWX6oNhEXbKehS8X
         nXOg==
X-Gm-Message-State: AOAM533C7KKSKTpQUcOiGmQU4t2SZsQ/ydjExgtTlGa4YylPjV4fk19C
        QgjrCNfch9vf4gS3MwBOZ96oNmbxqgkoFg==
X-Google-Smtp-Source: ABdhPJzfScLfeuE+0zAzb7fUqVmoYa1Qsnj1IFjKnXefyb+6m30XuswOw0QGO3EbayUr06CRv/J2rQ==
X-Received: by 2002:ae9:ed53:: with SMTP id c80mr2846027qkg.402.1630583770159;
        Thu, 02 Sep 2021 04:56:10 -0700 (PDT)
Received: from [192.168.15.25] ([186.204.255.226])
        by smtp.gmail.com with ESMTPSA id v7sm1256373qkd.41.2021.09.02.04.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 04:56:09 -0700 (PDT)
Subject: Re: VKMS: New plane formats
To:     Simon Ser <contact@emersion.fr>
Cc:     rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <d1ceaa32-e143-8d3c-4bfb-7b31673cc76c@gmail.com>
 <Qkd7rIf9j9Y-IlDoCbF8VB8T5sIKykTIuTfZIc1pCFPfvnfwIBGOMTnFo8i5jAWqGitlGEBH865MLF3C2jdIVk7TbRRFb_KVlte_FI0hjgI=@emersion.fr>
From:   Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
Message-ID: <22b20ed0-f3d1-c70c-1f3d-ca897330f7c6@gmail.com>
Date:   Thu, 2 Sep 2021 08:56:06 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <Qkd7rIf9j9Y-IlDoCbF8VB8T5sIKykTIuTfZIc1pCFPfvnfwIBGOMTnFo8i5jAWqGitlGEBH865MLF3C2jdIVk7TbRRFb_KVlte_FI0hjgI=@emersion.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/21 5:24 PM, Simon Ser wrote:
> Ideally the final composition format would have enough precision for
> all of the planes. I think it'd make sense to use ARGB16161616 if the
> primary plane uses ARGB8888 and an overlay plane uses ARGB16161616.
> 
> To simplify the code, maybe it's fine to always use ARGB16161616 for
> the output, and add getters which fetch an ARGB16161616 row for each
> supported plane format.
> 

This makes sense to me. I will try to implement this way.

Thanks!
