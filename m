Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB5C3DA6FD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 17:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237662AbhG2PBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 11:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhG2PBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 11:01:23 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A1FC061765;
        Thu, 29 Jul 2021 08:01:19 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u20so8007059ljo.0;
        Thu, 29 Jul 2021 08:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=R0UHRNrLka+a+buvqDDT6IGZvdUfKhb8O6hi8kQSoj0=;
        b=fLIfNtTcLN8ef/3QB/2FwUDhhAgRPsCyMVxc0JMjQX7cUVpDiThDkEOEo8EwPgpTz4
         cGXvef04xg6q11NV7TlgcaHMyNRI+fDWRi4jUPeUZEcJxQIqQaAVZJS73WqztczwQikV
         lN6wDYdYJ1CjcnB251VDwJQJrCVDWnv3Eq0dhHDREXvLiTgBmzTXps+300lul0tDAa4r
         ESazEIIq/tIm8DQuP+4ZAWOZAANDnAIAz6NWJmRHVQyv50bDS9wVvV0panqNclP1refJ
         l7XhnDjWNZ1ocX1xTfwzycfteqdVw6+XTsM+o1ogAwCNzvfZs21DXnUytQGkoO+w3Ccj
         ApKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=R0UHRNrLka+a+buvqDDT6IGZvdUfKhb8O6hi8kQSoj0=;
        b=OVU4vS9aicI6s9zBdYzqeqJ+0ePQd2vWpkjzn/rPcLH6cYVCzEEOVxhbp4SF7IAf5M
         Jn4hIH5W5xj0opYliy6NSQa3Tb48PzPpDYQz50p5rZUFSgNERnrVMrRXKrGxYwkMNdwI
         MRAeZiDVyGLZbHXdpOq6dDsCmmBBjiCuLEQ4zQHedCdL51RytjiG8wP0SPN4rhqogUHI
         qNT7N75VDtd5Mv7bVJmWrJnybpJdRk0g1bQ6gkR11MMxKvTI2ovSO8/sq77BS0p0v7Np
         rvKPyfCPGQI8Lu5DqN3Hw/gkUg1u+0XVqZVDgpfgY0OEfkh0OCHd+c78FG4oURxrzQSa
         dOsA==
X-Gm-Message-State: AOAM531X0tS7uT9Z267NvBhJBObc2e1qmwwhKElQHN/8ikDioAoa5IaU
        VLW4fFBImYAn+ew8xZsRCfQ4giiboXQIOOqa
X-Google-Smtp-Source: ABdhPJxjd7o0KVNL7mI4Bv07lQfIFDQfbDUZuJmHE5UpJWofTNabI8PAT90pO3/iaWOCWbU0rMwLwA==
X-Received: by 2002:a2e:b0d9:: with SMTP id g25mr3206610ljl.454.1627570877722;
        Thu, 29 Jul 2021 08:01:17 -0700 (PDT)
Received: from [0.0.0.0] ([2a00:b700:2::4:1d2])
        by smtp.gmail.com with ESMTPSA id h10sm327913lfp.151.2021.07.29.08.01.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 08:01:17 -0700 (PDT)
Subject: Re: [PATCH v6 3/3] MAINTAINERS: add entry for traditional Chinese
 documentation
To:     Hu Haowen <src.res@email.cn>, corbet@lwn.net
Cc:     linux-doc-tw@groups.io, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210727161501.13030-1-src.res@email.cn>
 <20210727161501.13030-3-src.res@email.cn>
From:   Pan Yunwang <panyunwang849@gmail.com>
Message-ID: <d5633d12-bd1f-c45f-2b98-d5953d074793@gmail.com>
Date:   Thu, 29 Jul 2021 23:01:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210727161501.13030-3-src.res@email.cn>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/7/28 ÉÏÎç12:15, Hu Haowen Ð´µÀ:
> Add maintainer information for traditional Chinese documentation.
>
> Signed-off-by: Hu Haowen <src.res@email.cn>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 66d047dc6880..de9370bcb226 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18829,6 +18829,14 @@ F:	arch/x86/mm/testmmiotrace.c
>  F:	include/linux/mmiotrace.h
>  F:	kernel/trace/trace_mmiotrace.c
>  
> +TRADITIONAL CHINESE DOCUMENTATION
> +M:	Hu Haowen <src.res@email.cn>
> +L:	linux-doc-tw@groups.io


The mailing list isn't working at the moment. Please replace it with
linux-doc-tw-discuss@lists.sourceforge.net.

Thanks,
Pan Yunwang


> +S:	Maintained
> +W:	https://github.com/srcres258/linux-doc
> +T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
> +F:	Documentation/translations/zh_TW/
> +
>  TRIVIAL PATCHES
>  M:	Jiri Kosina <trivial@kernel.org>
>  S:	Maintained
