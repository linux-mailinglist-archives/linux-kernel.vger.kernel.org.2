Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2A83DE76F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 09:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbhHCHq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 03:46:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54050 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234209AbhHCHq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 03:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627976775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GnfVPSk/HizDyO3JxuKbaXMtEKJY0iQR8Nsy47TDxzw=;
        b=TV+X/2+EPNlJqtuALnqcjwblykoEHAhXsqzjYi5xoN1+ANdvxV50Kv5c8CIEG4H5yVRv8+
        p7spVU9ZtYn/WSBTvQtZ+1mvFeX/FqOB3OKuiN0dUIwnaeO/Z7QGXFQyCcVZj8guGXP93s
        qXowOOvNpDJjJkXEe2Ciz9TSsFpwWQs=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-wS_TwrjPMzCUu1z9MQshXw-1; Tue, 03 Aug 2021 03:46:14 -0400
X-MC-Unique: wS_TwrjPMzCUu1z9MQshXw-1
Received: by mail-pl1-f198.google.com with SMTP id d19-20020a170902c193b029012c5a07a983so15892238pld.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 00:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GnfVPSk/HizDyO3JxuKbaXMtEKJY0iQR8Nsy47TDxzw=;
        b=dEvlihKJJBw6QHPKB9ooHJ3Q8uBQXh09y2oielBf/lH+oqwY6RPG9ToQBXURnRA5GS
         ys9aMLG1JzWs/QQvAy8ea8LDyrrh/EQEFP6y8wuHrToepdRbZy1IO0NN+CsnwSq1Ju98
         ZA4YVaZXQ5qluWE9AQsVdyU5FHUUaYePF64hPuIeCnFewaF5D/y0UFf9QhTk/APpnlrA
         7MBv9uwJkuOBCXOqVl/XBz8ZLL/3wYDPKAtQmb23iTihT7g2qwP/WZkZWRe60lYs44ue
         Gsbmnf1Z8DSjgUklz9YDlKZ7bnoUp2Fb9Kuab10di/Afph5CBSFnzeQCq2DbP4pJKKVm
         or8w==
X-Gm-Message-State: AOAM5317KJJuOg/PK2Hjav22CcIoglgwlO50zR7OUVDeoZbHPHWKAss/
        jtuJzKPDulNyg0m/3YQleG7xoJW5Hklxdteve9m1LhCYH0bDIGMg6MuocUhlTNXm13jrdaCdOwC
        DfJJUuJxh6Dr9nRva4xxYDCL1UrfjL5JRJUYYYJAFSU0IEqizg0N78gdUM/vsF7BJ9PLWCC+xfy
        L8
X-Received: by 2002:a17:90a:7065:: with SMTP id f92mr3190642pjk.16.1627976773368;
        Tue, 03 Aug 2021 00:46:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEvOW/oPitztnM44QtOEHatfCeA16JROutkQDb3a25VjV+JgBNuHrwDZ3buALcITz8Iapu0g==
X-Received: by 2002:a17:90a:7065:: with SMTP id f92mr3190595pjk.16.1627976773095;
        Tue, 03 Aug 2021 00:46:13 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f1sm7278948pfk.115.2021.08.03.00.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 00:46:12 -0700 (PDT)
Subject: Re: [PATCH v10 02/17] file: Export receive_fd() to modules
To:     Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
        stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
        hch@infradead.org, christian.brauner@canonical.com,
        rdunlap@infradead.org, willy@infradead.org,
        viro@zeniv.linux.org.uk, axboe@kernel.dk, bcrl@kvack.org,
        corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org,
        gregkh@linuxfoundation.org, zhe.he@windriver.com,
        xiaodong.liu@intel.com, joe@perches.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210729073503.187-1-xieyongji@bytedance.com>
 <20210729073503.187-3-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <a0ab081a-db06-6b7a-b22e-4ace96a5c7db@redhat.com>
Date:   Tue, 3 Aug 2021 15:45:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210729073503.187-3-xieyongji@bytedance.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/7/29 ÏÂÎç3:34, Xie Yongji Ð´µÀ:
> Export receive_fd() so that some modules can use
> it to pass file descriptor between processes without
> missing any security stuffs.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>   fs/file.c            | 6 ++++++
>   include/linux/file.h | 7 +++----
>   2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/fs/file.c b/fs/file.c
> index 86dc9956af32..210e540672aa 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -1134,6 +1134,12 @@ int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags)
>   	return new_fd;
>   }
>   
> +int receive_fd(struct file *file, unsigned int o_flags)
> +{
> +	return __receive_fd(file, NULL, o_flags);


Any reason that receive_fd_user() can live in the file.h?

Thanks


> +}
> +EXPORT_SYMBOL_GPL(receive_fd);
> +
>   static int ksys_dup3(unsigned int oldfd, unsigned int newfd, int flags)
>   {
>   	int err = -EBADF;
> diff --git a/include/linux/file.h b/include/linux/file.h
> index 2de2e4613d7b..51e830b4fe3a 100644
> --- a/include/linux/file.h
> +++ b/include/linux/file.h
> @@ -94,6 +94,9 @@ extern void fd_install(unsigned int fd, struct file *file);
>   
>   extern int __receive_fd(struct file *file, int __user *ufd,
>   			unsigned int o_flags);
> +
> +extern int receive_fd(struct file *file, unsigned int o_flags);
> +
>   static inline int receive_fd_user(struct file *file, int __user *ufd,
>   				  unsigned int o_flags)
>   {
> @@ -101,10 +104,6 @@ static inline int receive_fd_user(struct file *file, int __user *ufd,
>   		return -EFAULT;
>   	return __receive_fd(file, ufd, o_flags);
>   }
> -static inline int receive_fd(struct file *file, unsigned int o_flags)
> -{
> -	return __receive_fd(file, NULL, o_flags);
> -}
>   int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags);
>   
>   extern void flush_delayed_fput(void);

