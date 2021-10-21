Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A114366C3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 17:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbhJUPwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 11:52:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33888 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230280AbhJUPwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 11:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634831420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wGNuVhi5Wfv6Y5HCVEAnOz4vrOFq78Ll27lC1Wx8arY=;
        b=gAn1elUnWB0y2YXFk+ZQQZEmG0R1Jvb5GkAKkkXPBqDWlrtdHmmXk9wzPDXkAhJTt5yY2Q
        DOofvb4nUk2jNK80ASi7FgTOkh5j41j4MXxK/uk7fVMsONSCp0n5W2I6MufmpVH+QgRzue
        AbGo7B9hwJL2xiE+x26443PDQGc0+x8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-rM6t4gPKMfCqMzDSWlvLyA-1; Thu, 21 Oct 2021 11:50:19 -0400
X-MC-Unique: rM6t4gPKMfCqMzDSWlvLyA-1
Received: by mail-wm1-f69.google.com with SMTP id c5-20020a05600c0ac500b0030dba7cafc9so47290wmr.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 08:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=wGNuVhi5Wfv6Y5HCVEAnOz4vrOFq78Ll27lC1Wx8arY=;
        b=rAo9HqpXUNEMjz8dWzZMwMSVb5CW6X5OoewPwMsKMHnMtk2aXxe/1ENT2WoQ3okXva
         IjyIhZvNw/FiyL9Ht64S93xEw2lcUHANQH48HTL3COB6UTUE2/427i9qtpAXJc47t63N
         i8hcpYBoHLlv+lg4C9SWY8Xg9owU97TVfOC9sGi1iQJBg2GWlYASVOmu9r2gwjDmPSGo
         mLpwWlqKwiyy4XBzNYHIntlKl4jzbvDS23EY3PXBCFQnPVCEOAvBk1g8VAZ4FhLCyLVx
         HCrdxFZazn3YVWgQ+SEEyErTqgKsewXdBRnwO2gqCZODCxH97J3y3th0Y82UZoPbR9hP
         gFKg==
X-Gm-Message-State: AOAM5314xqSE3inGUpOdIX+cbOyk83nEmB1p03FEYglPqZB5O/X72U9T
        3doyGNohIc4ApF42u9ObE+DYJOd0nZhrn1LQOarM4V7EQigMMzm2qOhFGE/c7AIfUiDJ38/lm5q
        pabor2MdULbVsqFoTuzYg4+b+
X-Received: by 2002:adf:bb08:: with SMTP id r8mr8428735wrg.247.1634831417841;
        Thu, 21 Oct 2021 08:50:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgRmpVw7GQoX5QS0ErkShGxQ4LBQKq9b//e8IAFwGPYgHiV4rJyKGUD+AIXN67lgBoTTfX1A==
X-Received: by 2002:adf:bb08:: with SMTP id r8mr8428696wrg.247.1634831417574;
        Thu, 21 Oct 2021 08:50:17 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23aba.dip0.t-ipconnect.de. [79.242.58.186])
        by smtp.gmail.com with ESMTPSA id r17sm6082878wmq.47.2021.10.21.08.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 08:50:17 -0700 (PDT)
Message-ID: <f0c1baad-b003-9a8e-48b4-14e7e5a1c4c6@redhat.com>
Date:   Thu, 21 Oct 2021 17:50:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] mm/secretmem: Avoid letting secretmem_users drop to zero
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Jordy Zomer <jordy@pwning.systems>, linux-mm@kvack.org,
        Dmitry Vyukov <dvyukov@google.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20211021154046.880251-1-keescook@chromium.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211021154046.880251-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.10.21 17:40, Kees Cook wrote:
> Quoting Dmitry: "refcount_inc() needs to be done before fd_install().
> After fd_install() finishes, the fd can be used by userspace and we can
> have secret data in memory before the refcount_inc().
> 
> A straightforward mis-use where a user will predict the returned fd
> in another thread before the syscall returns and will use it to store
> secret data is somewhat dubious because such a user just shoots themself
> in the foot.
> 
> But a more interesting mis-use would be to close the predicted fd and
> decrement the refcount before the corresponding refcount_inc, this way
> one can briefly drop the refcount to zero while there are other users
> of secretmem."
> 
> Move fd_install() after refcount_inc().
> 
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Jordy Zomer <jordy@pwning.systems>
> Cc: linux-mm@kvack.org
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Link: https://lore.kernel.org/lkml/CACT4Y+b1sW6-Hkn8HQYw_SsT7X3tp-CJNh2ci0wG3ZnQz9jjig@mail.gmail.com
> Fixes: 9a436f8ff631 ("PM: hibernate: disable when there are active secretmem users")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  mm/secretmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 1fea68b8d5a6..924d84ba481f 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -217,8 +217,8 @@ SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
>  
>  	file->f_flags |= O_LARGEFILE;
>  
> -	fd_install(fd, file);
>  	refcount_inc(&secretmem_users);
> +	fd_install(fd, file);
>  	return fd;
>  
>  err_put_fd:
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

