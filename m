Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106803066F4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 23:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236338AbhA0WBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 17:01:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31789 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236146AbhA0WBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 17:01:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611784810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p4VE4i005fmSkN7FUkRXe149zpnTX6G+W+Gv7VWMSaQ=;
        b=FllceS32au9YgdRB/GJQCDrAGqh49hzpr5Cf/H58ojtXuX7wGm115V2L0lom9ghnXCtia4
        TZ3hSiEhwOTR4vEfyXTpOZaPD29JEqHrPqeU2xo9rPPD+C9QnkXW9YQTPQoYJQBKjB1cYG
        ru1tlvRh+qxUug7n8MC4bpTDbgK3lS0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-3HKDAZqZP_-wCZKigHzjRQ-1; Wed, 27 Jan 2021 17:00:08 -0500
X-MC-Unique: 3HKDAZqZP_-wCZKigHzjRQ-1
Received: by mail-qk1-f199.google.com with SMTP id i11so2627336qkn.21
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 14:00:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=p4VE4i005fmSkN7FUkRXe149zpnTX6G+W+Gv7VWMSaQ=;
        b=hXi7FYWp7m+7QSgVOgfmUvgMq739i/GSbYthscLl+mtvqNTAaU8OR7++myqZWV7QY0
         5yaB77zKC3MZnCcBACD+PpH2tlH8KbIwAaEMrKZ6GLh+UPoOPmG5bLWlwKoge0sRkpAN
         8nearv7Yf6iXZlzLyVkUTsCTbP8x0BqTqtrJ6X4ltuRQidYXmV2tYvPqFgEkvHdOSL4K
         o2WVB+k1BU/xCC2N6u54yaHzDWxLbEmKhXSHUuVOzFpNypJsU3ENYAe+v1wWqBDEvWAN
         KaRkO73InUWJ+xRfSdYLHoNuhgBo5ZrKokLDAolQFlj1YgQfqn8peBrVFj6kIBnrLwXK
         l5vA==
X-Gm-Message-State: AOAM531B1iv40L3JKMqZZdRR20xaUIlPRzdAirvxox8G7UQFfQ9mXYte
        zfBK2SP8xYzJEGsNEbSwEh9SfkwV3+WyGhh4MLDuAP9IQ48vGXvhdKiFtcFJrvmP7j/QgDgyvJL
        kq3hDo8RVl4XwENh9p7dGL4Nf
X-Received: by 2002:a37:4b05:: with SMTP id y5mr13161441qka.348.1611784808393;
        Wed, 27 Jan 2021 14:00:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw9DPl/DRVe1xsF3WCtgWdbwE1uj901tijfPs0BxxNyxnX1IrEBYtdGGAwW0qhGA5F4+gidmg==
X-Received: by 2002:a37:4b05:: with SMTP id y5mr13161425qka.348.1611784808160;
        Wed, 27 Jan 2021 14:00:08 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id o56sm2301056qtb.0.2021.01.27.14.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 14:00:07 -0800 (PST)
Subject: Re: [PATCHv1] firmware: stratix10-svc: reset
 COMMAND_RECONFIG_FLAG_PARTIAL to 0
To:     richard.gong@linux.intel.com, gregkh@linuxfoundation.org
Cc:     mdf@kernel.org, linux-kernel@vger.kernel.org,
        Richard Gong <richard.gong@intel.com>
References: <1611783801-30766-1-git-send-email-richard.gong@linux.intel.com>
 <1611783801-30766-2-git-send-email-richard.gong@linux.intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <0c4ec1b0-120e-5704-4b4f-d4255f2e84c0@redhat.com>
Date:   Wed, 27 Jan 2021 14:00:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1611783801-30766-2-git-send-email-richard.gong@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/27/21 1:43 PM, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
>
> Clean up COMMAND_RECONFIG_FLAG_PARTIAL flag by resetting it to 0, which
> aligns with the firmware settings.

For fixes, you need to have a 'Fixes: ... ' line in the comment.

This lets folks doing the stable branch know how far back to apply the fix.

For this case, this is likely

Fixes: 36847f9e3e56 ("firmware: stratix10-svc: correct reconfig flag and timeout values")

This should go right above your signoff.


By stand alone patch, this change should be split out from your current 

[PATCHv3 1/6] firmware: stratix10-svc: add COMMAND_AUTHENTICATE_BITSTREAM flag

So the next rev out your patch set will have 7 patches, because 1/6 is being split into two patches.

I would recommend the fix be 1/7, to minimize chance of conflicts merging it with stable.

or

submit the split out fix first.

Tom

>
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
>  include/linux/firmware/intel/stratix10-svc-client.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
> index ebc2956..1ffb982 100644
> --- a/include/linux/firmware/intel/stratix10-svc-client.h
> +++ b/include/linux/firmware/intel/stratix10-svc-client.h
> @@ -51,12 +51,12 @@
>  #define SVC_STATUS_NO_SUPPORT		6
>  
>  /*
> - * Flag bit for COMMAND_RECONFIG
> + * Flag for COMMAND_RECONFIG, in bit number
>   *
>   * COMMAND_RECONFIG_FLAG_PARTIAL:
> - * Set to FPGA configuration type (full or partial).
> + * Set for partial configuration.
>   */
> -#define COMMAND_RECONFIG_FLAG_PARTIAL	1
> +#define COMMAND_RECONFIG_FLAG_PARTIAL	0
>  
>  /*
>   * Timeout settings for service clients:

