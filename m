Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049163D934E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 18:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhG1Qhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 12:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhG1Qhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 12:37:42 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF1FC061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 09:37:40 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id u25so4453638oiv.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 09:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6FOAH42Q985G5izu2SG1lTzbohVF1CmwnnP39yPkHw0=;
        b=WYgquUVodyHB40ZpI3/eEjfOKGVMbOGQGXFl+IyNyxxAwLLIUs3hUOF6/4m2tWn0qe
         GuzqC+/OcMmWU301usVULGerA4Mo4CF5d5OmWbRlUDbIi4aQbQSXcD49+YaVD8oz+oB0
         hqaxPJNCwFDGj6fZSTLdbajfOwyWsRMpOGr4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6FOAH42Q985G5izu2SG1lTzbohVF1CmwnnP39yPkHw0=;
        b=Lp3QGFjSD5qzqk8rFtFjdDj6ojFnm9sYQ/a30kbtxhk61BH3jny0wPVjX4mR7eC+yV
         Ge+cPQf+vNPZqOOVjGLxvzDWjdda4h4Eae5eO5n/UIJhZ969tsqaflQR6RsQtbo3rq+t
         HBFXrECvg1ZLjas/E90ANFh1Xmxm0aEv5wX92ehdOt+Uy9FmRvYwMc4A2lKfKaqY8ycW
         J0RwmhvG5iPIKmsKd4l4ob2JozqehkPCIXf/lzfrBenrjJjk5O3l0XRdIKCL3ORJvw39
         M+FU6Qh+QIIJhsBCYFJ0WqyeCEc/Eu5h2bIjAji8nlm2xEiUYQ0LKWN7SYcxDuR2MIPU
         k1/A==
X-Gm-Message-State: AOAM5309wKpeTJxGv2FInLWgX2kRIzcjZd1tdnMihq7aH2yeUFDYFdep
        1PWx8qEHpAivZsl9wa/hxHItcA==
X-Google-Smtp-Source: ABdhPJz5uVhf0+XMeim195I9QZOe1alHKb0NpQmLCf9SdOKYIpwglq2m6DlSJoJLQVDNGVux3AjmxQ==
X-Received: by 2002:aca:4a8d:: with SMTP id x135mr264124oia.6.1627490259880;
        Wed, 28 Jul 2021 09:37:39 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i20sm64297ook.12.2021.07.28.09.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 09:37:39 -0700 (PDT)
Subject: Re: [PATCH v8 2/2] firmware_loader: fix use-after-free in
 firmware_fallback_sysfs
To:     Anirudh Rayabharam <mail@anirudhrb.com>, mcgrof@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+de271708674e2093097b@syzkaller.appspotmail.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210728085107.4141-1-mail@anirudhrb.com>
 <20210728085107.4141-3-mail@anirudhrb.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a3c433b2-3bda-67cc-1ec3-220e4530a12a@linuxfoundation.org>
Date:   Wed, 28 Jul 2021 10:37:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210728085107.4141-3-mail@anirudhrb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/21 2:51 AM, Anirudh Rayabharam wrote:
> This use-after-free happens when a fw_priv object has been freed but
> hasn't been removed from the pending list (pending_fw_head). The next
> time fw_load_sysfs_fallback tries to insert into the list, it ends up
> accessing the pending_list member of the previously freed fw_priv.
> 
> The root cause here is that all code paths that abort the fw load
> don't delete it from the pending list. For example:
> 
>          _request_firmware()
>            -> fw_abort_batch_reqs()
>                -> fw_state_aborted()
> 
> To fix this, delete the fw_priv from the list in __fw_set_state() if
> the new state is DONE or ABORTED. This way, all aborts will remove
> the fw_priv from the list. Accordingly, remove calls to list_del_init
> that were being made before calling fw_state_(aborted|done).
> 
> Also, in fw_load_sysfs_fallback, don't add the fw_priv to the pending
> list if it is already aborted. Instead, just jump out and return early.
> 
> Fixes: bcfbd3523f3c ("firmware: fix a double abort case with fw_load_sysfs_fallback")
> Reported-by: syzbot+de271708674e2093097b@syzkaller.appspotmail.com
> Tested-by: syzbot+de271708674e2093097b@syzkaller.appspotmail.com
> Acked-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> ---
>   drivers/base/firmware_loader/fallback.c | 12 ++++++++----
>   drivers/base/firmware_loader/firmware.h | 10 +++++++++-
>   drivers/base/firmware_loader/main.c     |  2 ++
>   3 files changed, 19 insertions(+), 5 deletions(-)
> 

Thank you. Looks good.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
