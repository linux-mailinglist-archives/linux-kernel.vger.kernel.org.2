Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837F3363D2C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 10:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbhDSIQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 04:16:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38708 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229473AbhDSIQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 04:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618820168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JnDEYEE9+/ffQbifunOsMpxHXhGv1BfNRAdL9IDBXjA=;
        b=DH8P8n4+evXWn9qUwE8Fe/VPbt46HKdesqI4d0EzhUlUFmau7s0Bs3IQ/+jkDlcMAmHuMT
        x9KzQ/AR3IAIpMHf3SjA8TYjAbCJrqhLIMfGNTzIuka+9FsjusG+8Be6zSr8YPMjp1zOmX
        rwihGZYeViZTmDGDYh92HbOkmSQtKrY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-hLP3DFI9PHW8YvYM1_4jgg-1; Mon, 19 Apr 2021 04:16:06 -0400
X-MC-Unique: hLP3DFI9PHW8YvYM1_4jgg-1
Received: by mail-ej1-f72.google.com with SMTP id n10-20020a1709061d0ab029037caa96b8c5so3376322ejh.23
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 01:16:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JnDEYEE9+/ffQbifunOsMpxHXhGv1BfNRAdL9IDBXjA=;
        b=c84ZB5n/18jlN+I0DTiLfDZqWiU385r8Bz+/BYekxvu25BabV0Zg93uk9YTxHlmwfX
         R5JoXzm6K+S68WAxjTnjEQ2lXcbPCAdONmssua9P3IeX+tOjI5PlupuhP5YMjwUHjqaf
         66K46AlYvNGQ7/c6y6jybIn1yPIR/ouT6TpqCQchoL0jIpvzV8nZR9B7C0g7HZuxycis
         SHMfC1pUtqWf/6Z0oTT1STiLkllFERhVzgtdUoc9Em55UFLT3OnDPDAs5gXAoizwIpOU
         lUuPwLRu/P1HaN/Y5T33n/mCfShmyJ3ISnZiIRqEYPJ1OcKYF7XmXaFXdNxOSW+SvQx3
         rYoA==
X-Gm-Message-State: AOAM530gfE48X73WNKRftMvI0xK6BxqTp3ImF14scnROWAHdPUTYCLPM
        s8ZDdh7I5PSNKFd3fzt6/qeHXUhJS72s8hVdwAW2QQJX0YEfsE409ZAuL7pmQ29IMjV5Su1GNAn
        NfpIyhFLqp3zTX0sHxMlWkWXappsLcN0iZB3AuqbIeo4/Ikl53ysg/lr1bvTihR0v8p0SJFJTJT
        e+
X-Received: by 2002:a17:906:11d8:: with SMTP id o24mr20324028eja.386.1618820165419;
        Mon, 19 Apr 2021 01:16:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYTflUgzSh88RBm+qsxBK0KZOzb/fxkTKVyINlURGTVqeg7DWTSFZipvH/iIcrSHdj2bcuZQ==
X-Received: by 2002:a17:906:11d8:: with SMTP id o24mr20324015eja.386.1618820165277;
        Mon, 19 Apr 2021 01:16:05 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id bu8sm8410081edb.77.2021.04.19.01.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 01:16:04 -0700 (PDT)
Subject: Re: [PATCH 0/2] Remove GA14/15 quirks to acpi/video_detect
To:     Luke Jones <luke@ljones.dev>
Cc:     corentin.chary@gmail.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210419074915.393433-1-luke@ljones.dev>
 <c16dcaa8-83a3-2027-6335-52689eee5622@redhat.com>
 <M0XSRQ.41V51K2O2UAK@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3e0af231-f835-bda6-ee43-87fcde6439e5@redhat.com>
Date:   Mon, 19 Apr 2021 10:16:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <M0XSRQ.41V51K2O2UAK@ljones.dev>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/19/21 10:02 AM, Luke Jones wrote:
> NP Hans, sorry about the length of time this took. Other duties etc.
> 
> I appreciated the wealth of insight you were able to provide to enable this.

BTW, I see that your drivers/acpi/video_detect.c patch is marked as [PATCH 1/3] I
guess these 2 patches are patch 2/3 and 3/3 ?  You may want to send a reply to
your own patch to make that clear and to explain that it is a standalone
patch.

Please Cc my on the reply.

Regards,

Hans

