Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E993E40CF60
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 00:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbhIOWgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 18:36:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24126 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232465AbhIOWgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 18:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631745296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2aVR2KW9hCZ2kkHP6ld7LFEUvut6M4OyuO1clchMrMg=;
        b=R4hInkYOkv27DXBqKb5zPSMmnfjTy1+rHOIiu90q2JiMKtqNHFezYwBHzXCOPyhp4wN3vC
        wR6JWGbMzTzmPJ6OGYsVJrPqkM0/8w1pWwKBxWkffN8w5LFvQQR7EPgMb05WyJerQ2hP9T
        tb6fHZDe7uAEjIpuykSEv/pxj2iQ+p8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-iBIS3gvDMiCAhvqKe5RHqQ-1; Wed, 15 Sep 2021 18:34:55 -0400
X-MC-Unique: iBIS3gvDMiCAhvqKe5RHqQ-1
Received: by mail-ed1-f72.google.com with SMTP id j6-20020aa7de86000000b003d4ddaf2bf9so3151421edv.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 15:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2aVR2KW9hCZ2kkHP6ld7LFEUvut6M4OyuO1clchMrMg=;
        b=wb+gdoY4b8pcPEZkHydgGVlGuP83slXY/13SOiXsQoRQyX4NT4ddl5oEZ/k0dnR/Zs
         s+1lGpX9dbjYYeeSdlyTFFuvvjI6irau6XfXl56QAo2tzT7nxtUi7fQymQKHBmEUkIoj
         YI+uofmmnzw2W3p1OFGJs4tycZ6SAmujFBNfdklDiTm0wmVH3aKTV9pCWz0fda7JiRzD
         3+6pGrzNZW8s3BeFtUydXHppShtIpU3nEmlCAQ//ILeXtjwsCmXiEd7piAgdKn/CK4sH
         mciT6wmTRqyP7yOjoQf4qYs2b02/zemYsN5Y9MD247iqFtR6nkvgmEmVquCuQfvVBjC9
         /aQA==
X-Gm-Message-State: AOAM531OJQhTUNhFfmDCOatzHeUoqdFeRBplB77gFsM7IZJEM185AIQk
        kRKHlRRONgnHhLzHgP8WJxlwv9k+YuTKoyW2F+NHxBZG8oeIXbW8uwdc0ZI626yLbtFBvRQ/xU6
        8HytPNjYrt4H8PminR6HOLLW19yEBkQ+nnBDk6wJj14vPaw7OCiyLovuZMlOUsTJhOjsgqMsR1E
        Rt
X-Received: by 2002:a17:906:4310:: with SMTP id j16mr2605723ejm.48.1631745294029;
        Wed, 15 Sep 2021 15:34:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZJrGZSlvJZDeNAgWKaufqGkjNdb1v/zNXE2aHdxS0gwiV/n++x4BlcgEyz1CR3FsYSoKbVw==
X-Received: by 2002:a17:906:4310:: with SMTP id j16mr2605695ejm.48.1631745293810;
        Wed, 15 Sep 2021 15:34:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id dn28sm573547edb.76.2021.09.15.15.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 15:34:53 -0700 (PDT)
Subject: Re: [PATCH 0/4] selftests: kvm: fscanf warn fixes and cleanups
To:     Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1631737524.git.skhan@linuxfoundation.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <56178039-ab72-fca3-38fa-a1d422e4d3ef@redhat.com>
Date:   Thu, 16 Sep 2021 00:34:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <cover.1631737524.git.skhan@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/21 23:28, Shuah Khan wrote:
> This patch series fixes fscanf() ignoring return value warnings.
> Consolidates get_run_delay() duplicate defines moving it to
> common library.
> 
> Shuah Khan (4):
>    selftests:kvm: fix get_warnings_count() ignoring fscanf() return warn
>    selftests:kvm: fix get_trans_hugepagesz() ignoring fscanf() return
>      warn
>    selftests: kvm: move get_run_delay() into lib/test_util
>    selftests: kvm: fix get_run_delay() ignoring fscanf() return warn
> 
>   .../testing/selftests/kvm/include/test_util.h |  3 +++
>   tools/testing/selftests/kvm/lib/test_util.c   | 22 ++++++++++++++++++-
>   tools/testing/selftests/kvm/steal_time.c      | 16 --------------
>   .../selftests/kvm/x86_64/mmio_warning_test.c  |  3 ++-
>   .../selftests/kvm/x86_64/xen_shinfo_test.c    | 15 -------------
>   5 files changed, 26 insertions(+), 33 deletions(-)
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks Shuah!

Paolo

