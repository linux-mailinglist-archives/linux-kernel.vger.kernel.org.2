Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363E839C286
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 23:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhFDVgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 17:36:02 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:45672 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhFDVgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 17:36:01 -0400
Received: by mail-oi1-f179.google.com with SMTP id w127so11092718oig.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 14:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=26qfIffr86s4CSx7aIeetFiHkRJ+glhHxzWGfwTGLAA=;
        b=YowtD1Oz+2avuyj9t2u/Nc5zkHV1OLwMPRVYhMsEHWudqRKyR4U2MdpJ6u2a2cPl36
         ZOLls3XfcRLeIb5SnMf4QPboprBKXMhV1QeKwzu2VsQJ88v67+PG3sTLlh+sAjlm0M6A
         XHp8cG0k5bN4gJQciZ3Jj/LgPIl1BAohIAAq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=26qfIffr86s4CSx7aIeetFiHkRJ+glhHxzWGfwTGLAA=;
        b=HLB/1872Efq6HIg+MI69dI9OPomX4v3gDD5GS2nIU5tXOv+OD6CbSNEZWL0SqMd/rf
         F+o/P2r3NEzqgxKUwimQNMGIRTNQfrydnYVRNhQyWEz/FgaCrDblBoHp6hJ0dTAi7jf2
         Dt2P6GOmsHJsvdeU8eRDrkx1lNfs3+EoYgp9hipKT5tFNDLhaTMFYZSqH66p//Ei8XKj
         auCFSduDbZj+ynWnvsj4YgHYrXMltJvOzB10kC5WE9iZ3z5+KkS5LRWa0vvP/jC/Du+Y
         8pyVr0xEzNyNavFBEluc8nkrmHUil/aBAz/c6pAiNlYWEAW4PoywVRVKxhWW2KGnMKXD
         IdTg==
X-Gm-Message-State: AOAM530/Mzvz3uxWJfxmJ2EaANDSVkOujot5pbsErBBnMZH73rqSEDBB
        x4YtjN6oc8kQA4xLc1MjDPsrog==
X-Google-Smtp-Source: ABdhPJxtMs37Tt5c2q7sz8sRDm/dVdIgrxzsqhKbaUQGuWslfv7/PkAd/2Wf8nLaDSxYV7UfT4Xb6Q==
X-Received: by 2002:aca:4a4b:: with SMTP id x72mr3786591oia.18.1622842394563;
        Fri, 04 Jun 2021 14:33:14 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s15sm111743oih.15.2021.06.04.14.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 14:33:14 -0700 (PDT)
Subject: Re: [PATCH][RESEND] selftests: splice: Adjust for handler fallback
 removal
To:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-kselftest@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210527032537.3730425-1-keescook@chromium.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <db164ec1-6819-58cc-2ec0-8c6ff7bf0770@linuxfoundation.org>
Date:   Fri, 4 Jun 2021 15:33:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210527032537.3730425-1-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/21 9:25 PM, Kees Cook wrote:
> Some pseudo-filesystems do not have an explicit splice fops since adding
> commit 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops"),
> and now will reject attempts to use splice() in those filesystem paths.
> 
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Link: https://lore.kernel.org/lkml/202009181443.C2179FB@keescook/
> Fixes: 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Resend of https://lore.kernel.org/linux-kselftest/20201005204517.2652730-1-keescook@chromium.org/
> ---
>   .../selftests/splice/short_splice_read.sh     | 119 ++++++++++++++----
>   1 file changed, 98 insertions(+), 21 deletions(-)

Will pick this up for 5.14

thanks,
-- Shuah
