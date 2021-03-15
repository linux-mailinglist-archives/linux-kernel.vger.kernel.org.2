Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8EA33AB8F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 07:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhCOGX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 02:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhCOGXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 02:23:04 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64404C061574;
        Sun, 14 Mar 2021 23:23:04 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 16so13431997pgo.13;
        Sun, 14 Mar 2021 23:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=bAUk4veAZcLgzYEMIYI27fwdQvDriq0KpbEV9tpXgPU=;
        b=ng9KdyPFwzpR5+YlAQpGaMMFLu2O0ClH+b2XzyFQwbr8iyHdIBlJYOmY5osnxW4jCw
         ZM/BcD/5Uw4GKy7xr1hbca/cfgBYzAj3PumLKH1CP3D6GfdfYLd7R68fpognybWY5yHP
         wM5vnwlNYli+6sOlHZpW8IbPw+T88H9jAlRR3MQ9tH9v6zjH/BPDDckHxYQvHZmBDEhl
         /9CYI8I1A+2pTZ2pm/C6HwAdkZMhplgm8bf/6pToB06FFdrRtYmTKNfuulikW5Gg91a0
         mYS4k9Fq5cgIcEm/XF9weyPdFwZFQ3IXX++KhE89Ymlb+1NFHNILtDetH7V2IMWFojAq
         Nsig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=bAUk4veAZcLgzYEMIYI27fwdQvDriq0KpbEV9tpXgPU=;
        b=unP+CYePCChSoIi10yz96ALXViZ/i1WBrcV0l5CspOHNt2nwXNi1QJOhRANOcKJnZ9
         5QVdyM9bsXIarRqXobRUpEUJXQoCxEKWuWIhoxInhj/Xc9EdQ2WQY/UCdtyknAB71P8n
         ZVU1gzgq2ShsdGIMf/3WI4SHaKyiHKey4fLWndqCfnnEYOO1SMBqVG+Cr91qcNnMrHy8
         STs5Ku8fOn4XnGplCt5dxfvZ6a5SCzFUlrkaOMu1rgCYb4Gc5zZ17l2N9JedJsDwc+yk
         kbDtF3cKweeGjLt6UNxjevzm2SSiZe4ILkPHBBPckpNVE/HV+IsQbhbc8SNNpBFtp6uy
         aV3A==
X-Gm-Message-State: AOAM5333wCyOukhnjtAENUnbVkFTdNgfYZ64RAbrjtLhuQRihLfq0H+N
        ny2rus1Yj7fUkkrwaaWQ4L/ZLqOkjJdzZZHo
X-Google-Smtp-Source: ABdhPJze+X7DAgWi+E0sxKmufrkfx8eSs19TqjRFkR+VMhWPqB8aCMbbrvt1nW+1sDJSJ/l8jYT0CA==
X-Received: by 2002:a63:5b52:: with SMTP id l18mr22318855pgm.304.1615789383607;
        Sun, 14 Mar 2021 23:23:03 -0700 (PDT)
Received: from [172.24.61.73] ([103.114.158.1])
        by smtp.gmail.com with ESMTPSA id v35sm11680611pga.3.2021.03.14.23.23.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Mar 2021 23:23:03 -0700 (PDT)
Subject: Re: [PATCH] security/loadpin: Update the changing interface in the
 source code.
To:     keescook@chromium.org, corbet@lwn.net
References: <20210308020358.102836-1-unclexiaole@gmail.com>
From:   Jiele Zhao <unclexiaole@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <ce4d6069-b678-737f-a768-5a18b7764086@gmail.com>
Date:   Mon, 15 Mar 2021 14:22:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210308020358.102836-1-unclexiaole@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/8 10:03, Jiele zhao wrote:
> Loadpin cmdline interface "enabled" has been renamed to "enforce"
> for a long time, but the User Description Document was not updated.
> (Meaning unchanged)
>
> And kernel_read_file* were moved from linux/fs.h to its own
> linux/kernel_read_file.h include file. So update that change here.
>
> Signed-off-by: Jiele zhao <unclexiaole@gmail.com>
> ---
>   Documentation/admin-guide/LSM/LoadPin.rst | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/admin-guide/LSM/LoadPin.rst b/Documentation/admin-guide/LSM/LoadPin.rst
> index 716ad9b23c9a..dd3ca68b5df1 100644
> --- a/Documentation/admin-guide/LSM/LoadPin.rst
> +++ b/Documentation/admin-guide/LSM/LoadPin.rst
> @@ -11,8 +11,8 @@ restrictions without needing to sign the files individually.
>   
>   The LSM is selectable at build-time with ``CONFIG_SECURITY_LOADPIN``, and
>   can be controlled at boot-time with the kernel command line option
> -"``loadpin.enabled``". By default, it is enabled, but can be disabled at
> -boot ("``loadpin.enabled=0``").
> +"``loadpin.enforce``". By default, it is enabled, but can be disabled at
> +boot ("``loadpin.enforce=0``").
>   
>   LoadPin starts pinning when it sees the first file loaded. If the
>   block device backing the filesystem is not read-only, a sysctl is
> @@ -28,4 +28,4 @@ different mechanisms such as ``CONFIG_MODULE_SIG`` and
>   ``CONFIG_KEXEC_VERIFY_SIG`` to verify kernel module and kernel image while
>   still use LoadPin to protect the integrity of other files kernel loads. The
>   full list of valid file types can be found in ``kernel_read_file_str``
> -defined in ``include/linux/fs.h``.
> +defined in ``include/linux/kernel_read_file.h``.

Ping. It's been almost one week now, can someone respond this patch?
Kees? Jonathan?

