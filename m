Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFD93932E8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237159AbhE0PyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 11:54:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44696 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235184AbhE0PyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:54:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622130767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rG+92U6EckL/F6v/WvYk3IWApdqSpAz8CewV9YyMDAc=;
        b=SOedXimo9R7/rEyPrXr1yO9Uc90lYksfk/Cqvv5BW3USzotQQq+DYX2yw7Q/DJqddjImkf
        gO5fJSmuU0IykURnkkZlzBwTy2ec0TGf+a74eGHI+s5ErEcamPaVa5plcY9qYk5u/7V7+Q
        Qs4KBH+gE1bo4vv7KOZN7ix3fSTjFf4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-599-kxYmEhqJOTmiPh0t7eOxBA-1; Thu, 27 May 2021 11:52:43 -0400
X-MC-Unique: kxYmEhqJOTmiPh0t7eOxBA-1
Received: by mail-qt1-f200.google.com with SMTP id b8-20020ac812c80000b029023872d176eeso396965qtj.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rG+92U6EckL/F6v/WvYk3IWApdqSpAz8CewV9YyMDAc=;
        b=tBey3jOQITTsglXla9qHAOTWei+s10d4F21Xm7MsRMkU44Iv5o+9daQrNTGiRyEKEX
         MF+BxAioDc7nZwvxHoej7vwiIQEOchRFL3s0pSoi+NR7p2xdIsxa+hjmFcYOSwNbwXjv
         LqotiaU8vO9DfU0XkoSAzRCE6h2Tnd3PW7m2xOF5TUfoNwYqT39Zoh97kppbClFEOYuK
         fO+oFLv1bzhajiQWrJjU9JXfac2MhSqhWq1zN9RMYNyNC4i92rEf5TUQsHB5FGGfgPn4
         I+S6FSqPw4CR014YhVRlYYWUw1TPgKxoF+330Jy2GphcBhrKc8o6f5t43JdMeXY2kit6
         NDGQ==
X-Gm-Message-State: AOAM533lZkHsEyOvz9omfesIXEJ8GfzTRhd76p7fGd06qoruionjxBqt
        tsHNwAnOJw+6mXycSX6ZIOixOoD4+bwqJjGvV6SVZYe3O7dtNONDXXJ6bPt16+jRNLmq2Hjpf/6
        dDWcFLAoopRsU2NzQI3kKn0JM
X-Received: by 2002:a05:6214:226c:: with SMTP id gs12mr4269651qvb.38.1622130762964;
        Thu, 27 May 2021 08:52:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaxisEbtADMfLh/SxW50Zkf00ozokWziqLpECSi8sOxlDYDhqU1nXkujghal3Eaac1dNuHUg==
X-Received: by 2002:a05:6214:226c:: with SMTP id gs12mr4269643qvb.38.1622130762797;
        Thu, 27 May 2021 08:52:42 -0700 (PDT)
Received: from [192.168.1.10] (c-24-147-78-103.hsd1.nh.comcast.net. [24.147.78.103])
        by smtp.gmail.com with ESMTPSA id g85sm1563307qke.123.2021.05.27.08.52.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 08:52:42 -0700 (PDT)
From:   Nitesh Narayan Lal <nilal@redhat.com>
X-Google-Original-From: Nitesh Narayan Lal <nitesh@redhat.com>
Subject: Re: [PATCH] eventfd: Enlarge recursion limit to allow vhost to work
To:     He Zhe <zhe.he@windriver.com>, Juri Lelli <juri.lelli@redhat.com>,
        viro@zeniv.linux.org.uk, axboe@kernel.dk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        nilal@redhat.com
References: <20200410114720.24838-1-zhe.he@windriver.com>
 <20200703081209.GN9670@localhost.localdomain>
 <cbecaad6-48fc-3c52-d764-747ea91dc3fa@windriver.com>
 <20200706064557.GA26135@localhost.localdomain>
 <20200713132211.GB5564@localhost.localdomain>
 <20200722090132.GB14912@localhost.localdomain>
 <2af418ff-6859-3d42-4ab3-16464e1d98bf@windriver.com>
Message-ID: <beac2025-2e11-8ed0-61e2-9f6e633482e8@redhat.com>
Date:   Thu, 27 May 2021 11:52:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <2af418ff-6859-3d42-4ab3-16464e1d98bf@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/20/20 6:41 AM, He Zhe wrote:
>
> On 7/22/20 5:01 PM, Juri Lelli wrote:
>> On 13/07/20 15:22, Juri Lelli wrote:
>>
>> [...]
>>
>>> Gentle ping about this issue (mainly addressing relevant maintainers and
>>> potential reviewers). It's easily reproducible with PREEMPT_RT.
>> Ping. Any comment at all? :-)
> Hi Maintainer(s),
>
> It's been 4 months. Can this be considered this round?

Gentle ping, is there any update or comments here?

As Juri mentioned the issue is still easily reproducible with PREEMPT_RT.

--
Thanks
Nitesh

