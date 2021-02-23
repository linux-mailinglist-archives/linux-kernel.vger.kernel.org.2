Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E4E322C94
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 15:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbhBWOlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 09:41:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31151 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231384AbhBWOlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 09:41:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614091210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6yTY/vPD19Elz7ZrYsYyd2okOff2AH6M76I4vHcyMx8=;
        b=fkX2eAurUqWyg+CWDhiL69GCpGpkWi3CsxPsRoEkEJKOIQAVVHu/Nz5/+exVTSf3qWvpCR
        b0dJA/g0IF8GEATGuMidlcajBB4dDQuiE0FpJjK8t9i+3Kbc3YRs9CD0SC5Pvtonzmn/DC
        BXf7hw7LIpRQt7dFG1i+g2ko+tYlPRo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-kmJqo5psM-el7Ng6Xc8QeQ-1; Tue, 23 Feb 2021 09:39:54 -0500
X-MC-Unique: kmJqo5psM-el7Ng6Xc8QeQ-1
Received: by mail-qk1-f198.google.com with SMTP id h21so4683990qkl.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 06:39:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6yTY/vPD19Elz7ZrYsYyd2okOff2AH6M76I4vHcyMx8=;
        b=AjfqBZgWm7br/4EVRfeeiEbVMDgyalO+L+ydTFcN7Kw5JZgolxrlNgDFmqMz3UwTvQ
         DRfwQ+3zvm11UVrXbOsh0muXVVS7gOmywDBAgQsNbfeVX0SJWsXqQc2X85SZkDIp7ad8
         Ud7TTRwWjjgsJ4ARWqEEzTmAFtB+wJLE0X9K2KMIOOmMh3+TiOAi8wQmkCJjvqlAwxE9
         k5wUDnQwXfQ6zvA5vs7MdCvkJ8iINojp+arxCSXgob4nkQCiTpy2MHW4U3pKjEibW5lW
         ZleRoHU6nAOFkII8m8MOo8pZjjesq7HOpCoTDMU6TNm6z0iLiDnD932Q1C3mPBaEIL/C
         ALUw==
X-Gm-Message-State: AOAM532Z+TzBBEBt4R1D5c6998i/U1b93PtVRckXS05xTQ/GtShsjHX4
        1pk6/telXBLS8HVfid57Bx3UU0T/oglpSzzSxeyibxejH/5Lg9Sgl7v8frO6l0vh+hr65I5uWX5
        UxYr9EQeiMQD1jNqNCPbVM9eP
X-Received: by 2002:ac8:70ce:: with SMTP id g14mr4859049qtp.297.1614091193701;
        Tue, 23 Feb 2021 06:39:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzv8bN6MNquo1jGL/fVslpXBJQiYoUqw9O5hOq8jrxc3Ssv2oGxE+KGcHa7ABf9JSxsK9FNyw==
X-Received: by 2002:ac8:70ce:: with SMTP id g14mr4859020qtp.297.1614091193399;
        Tue, 23 Feb 2021 06:39:53 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id d17sm15161843qkc.40.2021.02.23.06.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Feb 2021 06:39:53 -0800 (PST)
Subject: Re: [PATCHv3] firmware: stratix10-svc: reset
 COMMAND_RECONFIG_FLAG_PARTIAL to 0
To:     richard.gong@linux.intel.com, gregkh@linuxfoundation.org,
        "mdf@kernel.org" <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Richard Gong <richard.gong@intel.com>,
        "# 5 . 9+" <stable@vger.kernel.org>
References: <1614089759-12658-1-git-send-email-richard.gong@linux.intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <0993ec07-1424-256a-512d-3455c7a5db41@redhat.com>
Date:   Tue, 23 Feb 2021 06:39:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1614089759-12658-1-git-send-email-richard.gong@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Richard,

I see this is for stable.

Your mainline patchset looks ok with me, has it been accepted yet for mainline ?

Reviewed-by: Tom Rix <trix@redhat.com>


On 2/23/21 6:15 AM, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
>
> Clean up COMMAND_RECONFIG_FLAG_PARTIAL flag by resetting it to 0, which
> aligns with the firmware settings.
>
> Cc: <stable@vger.kernel.org> # 5.9+
> Fixes: 36847f9e3e56 ("firmware: stratix10-svc: correct reconfig flag and timeout values")
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
> v3: correct the missing item in the Fixes subject line
> v2: add tag Cc: <stable@vger.kernel.org> # 5.9+
>     add 'Fixes: ... ' line in the comment
> ---
>  include/linux/firmware/intel/stratix10-svc-client.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
> index a93d859..f843c6a 100644
> --- a/include/linux/firmware/intel/stratix10-svc-client.h
> +++ b/include/linux/firmware/intel/stratix10-svc-client.h
> @@ -56,7 +56,7 @@
>   * COMMAND_RECONFIG_FLAG_PARTIAL:
>   * Set to FPGA configuration type (full or partial).
>   */
> -#define COMMAND_RECONFIG_FLAG_PARTIAL	1
> +#define COMMAND_RECONFIG_FLAG_PARTIAL	0
>  
>  /**
>   * Timeout settings for service clients:

