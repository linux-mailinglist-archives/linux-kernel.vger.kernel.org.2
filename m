Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6CEC415F26
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 15:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241164AbhIWNFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 09:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241043AbhIWNFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:05:24 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F067C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 06:03:53 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id e16so5940562qte.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 06:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=HP04Hn8CepgatxLq+M5uPtre9hYCWS5PsizBd98RFZw=;
        b=GAyhELXoy0hcPaFe8f3uSdng5Li+hZat3C5MCMayexoMMYz2pQpR030G1v2FRrR06B
         XEX9pWjcUGaNgdQfSyxjV6rzcacZq2ueL+jkLvE7z55WKQfRRHQh0miGpBmGy8M7ihbA
         axQS96K8XzltEF9l38VkSW+zZewT7p2NDhPeidJ/zWT+RiWEVPQlq4HVDtYZXS3Gj5Mb
         M2UdcDU9WgkdbwEGxb4lVu0PKLj8yuG2ZI0KqQwCAbdW1xlVdqA2BPBuUMLytNCy6UJW
         jZ80S0Ly1Ma47ETmsRindzS53lebARfyU3vn5gnv/6+3hCCjCcI/SUR9m5yzeVpAmisz
         4WCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HP04Hn8CepgatxLq+M5uPtre9hYCWS5PsizBd98RFZw=;
        b=YauotQ8O+xpjPW8O0yY1jsfj+6VkzQwNnWH3WoBhfu8UkCImeoxDB+xKcSE8edDoTP
         YkZ7q8g/JyGXy8x1YOJFa/RJVy3hjbNKcX7T150UJvsPZuZMbTyryjySYKV5bR6c01ef
         LwDtUhB5s098NV2zSXUVA2s3Qkqf4XR+xYCWAfX+CQQ49dPR60hCltjozDom446pmegX
         3OZR6QQeSwT377Y4eWBU70yorM916f0l2pmjL3ylzukqthny/+UZvFu0Z7lRXrzc/buI
         2q0nZqK0JPSP5+0+0QTjgkzinAOGCax8XuS2URx3n5W8Krk1TePsHL8OU2tbL+2gSDaf
         gNGA==
X-Gm-Message-State: AOAM530vW/stjOm2N46tdTLx8a0VZiDBzw15toDyv8xbk1soP5AJRZX6
        Ql7VPpi5bOOXNFz/twrLxPhj57kx92g=
X-Google-Smtp-Source: ABdhPJzkOPU7EUK+L4vaCfKYnqKdpniBGlclXIqxP3nM385jdzCBiFUfHwI9dyDRfHkEC6mPe1jKZQ==
X-Received: by 2002:ac8:7756:: with SMTP id g22mr4630434qtu.160.1632402232312;
        Thu, 23 Sep 2021 06:03:52 -0700 (PDT)
Received: from [192.168.0.4] (d60-196-191.col.wideopenwest.com. [65.60.191.196])
        by smtp.gmail.com with ESMTPSA id a189sm4006864qkf.114.2021.09.23.06.03.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 06:03:51 -0700 (PDT)
Subject: Re: Boot opens CD tray
To:     linux-kernel@vger.kernel.org
References: <bbb0df1d-1e40-fbdf-d9aa-281ba77b4b6d@gmail.com>
 <20210923123407.GA19709@1wt.eu>
From:   Ken <kennethcelander@gmail.com>
Message-ID: <3e2fe30b-4c58-3164-2e2f-283f34ebe396@gmail.com>
Date:   Thu, 23 Sep 2021 08:03:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923123407.GA19709@1wt.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CD/DVD is a SATA ASUS; connected to a ASRock 970A-G/3.1 motherboard.

The changed "driver" has to be in the kernel, if it changed.

On 9/23/21 7:34 AM, Willy Tarreau wrote:
> On Thu, Sep 23, 2021 at 07:27:48AM -0500, Ken wrote:
>> Linux Mint 20.2.
>>
>> Near the end of the boot up process, the CD/DVD tray will open, and
>> immediately close.
>>
>> This started with the kernel update 5.4.0-84.94, and now also with
>> 5.4.0-86.97.
>>
>> Time shifted back to 5.4.0-81, with no CD tray opening problem.
> I guess you should at least provide more info such as how your CD drive
> is attached to the host (SATA/USB/IDE/SCSI/other?), and maybe compare
> the boot logs from the working and broken kernels just in case you'd
> find different messages possibly indicating a difference in a driver.
>
> Willy
