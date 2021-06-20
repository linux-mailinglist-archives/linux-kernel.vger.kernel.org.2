Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2117F3ADD7C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 09:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhFTH6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 03:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhFTH6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 03:58:19 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3E0C061574;
        Sun, 20 Jun 2021 00:56:06 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id bb20so3942309pjb.3;
        Sun, 20 Jun 2021 00:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mBb+RU0gqel0E1yBhYTHwa8RFBIhcQsP0uK9Q/ciAQE=;
        b=AIKNEp0mKsNXK3iZftK2H+ZPDw8eVD2rhiEuk75d3J3Jx+9azfxfVwH96H0LpgcM4x
         gDzIa1gTPNV6I9mldGI6aDUfqTzEztIsXDHPc6Cm3Qw6zIYO9+N83aRvNCeHJ1tS9YUR
         LjGqGHYcaTFBxV+IIY5Eu1VShPqSOjE/OzC5lHD6gwu2t4IwVVTbvH457pnph5ADyUwA
         xlnAdnFdGaQHgRMBoz7kl7c+8uYT6Mlxoyp7Idpdl5a4XbIhvWtFdYvrLg+bC7n+cOhu
         cTIFlO4r6cgYKCJGanu/u75BKtLQKHIQoSvf4ZF1tUT1p9eeeQ1YWWbRsUSLGPx7ab69
         f3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mBb+RU0gqel0E1yBhYTHwa8RFBIhcQsP0uK9Q/ciAQE=;
        b=TkdISKsmQ/8EiU9O0dWTFLjMmw+xy7dNPXa4XaXsW6MReyOiqHTraIEKKFfrIeKEvU
         w63mNnlUazxhlYJER238gRoNw2UwNl2fFnY2mc5+YwvYY1weyGMxtUNVEt2+mMoHZTaW
         KT/ZfC0DU57HA0bcnlPwcLJYy2AfxtwGki0D62klL4oHelYOaXmiwzrGyHQL+9BuVMa1
         XykaFW7M7QHJ0MB/Cw+VSYTkvY+zwtx8xXANWJPQ0lGUdkS4Rs2y7n4Z7E3viBZ/XlOb
         BDNpFpbIIN8a48vwZu2io7tJu5uI+H4TyIEH1Xl8y6A0Kv0lJjah/MPjeElETFes9oit
         QTlw==
X-Gm-Message-State: AOAM531eeXRzRTO1rfuuia00tmmQgc6suSGep/Zd8dVuaxdUDhn5/nPO
        eqg0cEj/SewuSg26B2aZ9wrUBl22HRSJ0g==
X-Google-Smtp-Source: ABdhPJwRkI7s8IX5KPDlcnMh/6MZlljGLwPoHpbqa3xtD5XygKIcUuN7lDMP5R+bI+tP1rBQYLupPQ==
X-Received: by 2002:a17:902:d50a:b029:11e:a5f0:523e with SMTP id b10-20020a170902d50ab029011ea5f0523emr12582746plg.73.1624175765679;
        Sun, 20 Jun 2021 00:56:05 -0700 (PDT)
Received: from [172.28.99.179] ([119.28.155.243])
        by smtp.gmail.com with ESMTPSA id m4sm4361575pjv.41.2021.06.20.00.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jun 2021 00:56:05 -0700 (PDT)
Subject: Re: [PATCH v2] docs/zh_CN: add a missing space character
To:     Hu Haowen <src.res@email.cn>, alexs@kernel.org, corbet@lwn.net
Cc:     bobwxc@email.cn, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210620010733.25002-1-src.res@email.cn>
From:   Alex Shi <seakeel@gmail.com>
Message-ID: <45aab0e8-d0ab-396f-6c21-32cbb84e754f@gmail.com>
Date:   Sun, 20 Jun 2021 15:56:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210620010733.25002-1-src.res@email.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alex Shi <alexs@kernel.org>

BTW, it should be v3 as your posting history.


On 6/20/21 9:07 AM, Hu Haowen wrote:
> "LinusTorvalds" is not pretty. Replace it with "Linus Torvalds".
> 
> Signed-off-by: Hu Haowen <src.res@email.cn>
> ---
>  Documentation/translations/zh_CN/process/2.Process.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/translations/zh_CN/process/2.Process.rst b/Documentation/translations/zh_CN/process/2.Process.rst
> index 229629e305ca..636f74b11c65 100644
> --- a/Documentation/translations/zh_CN/process/2.Process.rst
> +++ b/Documentation/translations/zh_CN/process/2.Process.rst
> @@ -47,7 +47,7 @@
>  （顺便说一句，值得注意的是，合并窗口期间集成的更改并不是凭空产生的；它们是经
>  提前收集、测试和分级的。稍后将详细描述该过程的工作方式。）
>  
> -合并窗口持续大约两周。在这段时间结束时，LinusTorvalds将声明窗口已关闭，并
> +合并窗口持续大约两周。在这段时间结束时，Linus Torvalds将声明窗口已关闭，并
>  释放第一个“rc”内核。例如，对于目标为5.6的内核，在合并窗口结束时发生的释放
>  将被称为5.6-rc1。-rc1 版本是一个信号，表示合并新特性的时间已经过去，稳定下一
>  个内核的时间已经到来。
> @@ -152,7 +152,7 @@ Greg Kroah-Hartman领导。稳定团队将使用5.x.y编号方案不定期地发
>    驱动程序维护者接受，那么您应该坚持不懈地将补丁更新到当前内核使其可被正常
>    应用，并不断地发送它以供审查和合并。
>  
> -- 合并到主线。最终，一个成功的补丁将被合并到由LinusTorvalds管理的主线存储库
> +- 合并到主线。最终，一个成功的补丁将被合并到由Linus Torvalds管理的主线存储库
>    中。此时可能会出现更多的评论和/或问题；对开发人员来说应对这些问题并解决
>    出现的任何问题仍很重要。
>  
> @@ -168,7 +168,7 @@ Greg Kroah-Hartman领导。稳定团队将使用5.x.y编号方案不定期地发
>  补丁如何进入内核
>  ----------------
>  
> -只有一个人可以将补丁合并到主线内核存储库中：LinusTorvalds。但是，在进入
> +只有一个人可以将补丁合并到主线内核存储库中：Linus Torvalds。但是，在进入
>  2.6.38内核的9500多个补丁中，只有112个（大约1.3%）是由Linus自己直接选择的。
>  内核项目已经发展到一个没有一个开发人员可以在没有支持的情况下检查和选择每个
>  补丁的规模。内核开发人员处理这种增长的方式是使用围绕信任链构建的助理系统。
> 
