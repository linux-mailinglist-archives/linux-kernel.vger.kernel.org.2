Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22805421866
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 22:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236256AbhJDUbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 16:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbhJDUbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 16:31:09 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B87AC061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 13:29:20 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id p80so21812456iod.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 13:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=fqt0R3ab4RICuxa4ODPGwNmcIJm7UomeSBzbdkfrJwQ=;
        b=zGFiLbF13Wvr0ZYPxyHjKy+b00mZ+1tdRCHD3MzZZFiWdxPpAFGyeXMZf0XGXDSOCh
         PNVYItKbd1WgDb3DvcqFO/P+EtcQ/unAPiQUQl+V3x0F/pbXSaCKf3kpCzYIYq/fkbw6
         v3uKPvJsTxc7cHMFUFQrKrebIzkMNnuOuFsusb2z+y06rPu+vH4FZtvz5FUZuzM6bqyU
         OaklmW7hNerGBvQXEBD2yF7oonWu0s5XcU330Qio6DL5iwr39xIhUFKKXAdr1o9ZYdZf
         W7bA1oBclcf68z72CejKFI2yA6Ov06HNG1/NhEeOUeo87miimfg4Ng3WiLa19kDlkhE6
         0lOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fqt0R3ab4RICuxa4ODPGwNmcIJm7UomeSBzbdkfrJwQ=;
        b=BAKst+MYzul2qHREMc+AaPT0Jl2Tys1X49jENjtJe2YLuo/qrupkfGoXT0TLgtweni
         mVK/wYNufmveKwvM6OYEZAW4JufAJpfIXglrp+gOCM0eSUPamhWAUhZOK8ItxK3Ck73q
         SpeZWFtlEEDcaJw3IzgfkIdrqKvtrBRSnHxIL3ZckAYtJlaNhbVRpb2pdqpW6Gnk4AkZ
         AhfSOoOZo6ksCmQg5sKs1M399KCRJW3SkP4LonLge87nYYI/kvRrPfmrwVwjVmuwYw3R
         rncE1+KRiTAIEm6g2jG+3yIEwKqu53Yhk/xNR7Y4QZTTe4x3gQLHP+anck0DsgRkkx7H
         Nk8A==
X-Gm-Message-State: AOAM533aPk8BWwtovTncpVaOVjZzCDtRVJWGtzptrPeAIpDP4WzbVIjY
        5EIj4zWU3iwCvi0kfPyJLTg664QhwxriIqdB+VY=
X-Google-Smtp-Source: ABdhPJyPTjmI//dciledyOBW48hvMFJtaRjG1c+eLQlQ5CKMxoOJMZgJlVNxWwiXIph/uB3ee7rIqw==
X-Received: by 2002:a02:c6d6:: with SMTP id r22mr12598230jan.120.1633379359274;
        Mon, 04 Oct 2021 13:29:19 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a3sm6958600ilr.29.2021.10.04.13.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 13:29:18 -0700 (PDT)
Subject: Re: [PATCH V3 5/9] fork: add helper to clone a process
To:     Mike Christie <michael.christie@oracle.com>, geert@linux-m68k.org,
        vverma@digitalocean.com, hdanton@sina.com, hch@infradead.org,
        stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, linux-kernel@vger.kernel.org
References: <20211004192128.381453-1-michael.christie@oracle.com>
 <20211004192128.381453-6-michael.christie@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c7b09a03-a438-c75f-4332-d0ea744aa68f@kernel.dk>
Date:   Mon, 4 Oct 2021 14:29:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211004192128.381453-6-michael.christie@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/21 1:21 PM, Mike Christie wrote:
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index e165cc67fd3c..ba0499b6627c 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -87,7 +87,11 @@ extern void exit_files(struct task_struct *);
>  extern void exit_itimers(struct signal_struct *);
>  
>  extern pid_t kernel_clone(struct kernel_clone_args *kargs);
> -struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node);
> +struct task_struct *create_io_thread(int (*fn)(void *i), void *arg, int node);

Looks like an extra 'i' snuck in here, causing unrelated changes.

-- 
Jens Axboe

