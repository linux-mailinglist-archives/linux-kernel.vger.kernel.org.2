Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851BF34094B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbhCRPwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:52:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50267 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231737AbhCRPwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616082738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0P/Vrxzie1x3w476DReMGEIFvpcpGMDppxg7+CGwcHo=;
        b=CpCzlyrKrSEdA3ieDaQpZj0Oib1CArt5T8aebF1gJzTiBMRlxMFUO+tDEeRNo0NOFLHHuN
        z+72ndHMGGXZk7vippkIelQFZcVj6pZBXdVPoqQoXk9iP9kvliCPLP3kr4ryiJIJfZB1mD
        +nvsSvjVbOKQg6jDgmuqsEEs4oYS064=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-uiuFNySeOlaQljv3IfpljA-1; Thu, 18 Mar 2021 11:52:16 -0400
X-MC-Unique: uiuFNySeOlaQljv3IfpljA-1
Received: by mail-oo1-f71.google.com with SMTP id z140so21239532ooa.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0P/Vrxzie1x3w476DReMGEIFvpcpGMDppxg7+CGwcHo=;
        b=sK7LKCikZ30BHIS3GnAcjQD/+waDnz3u8Q9ipcLD5LPWwffIaxu+62vZIKgj/3FGOL
         6nkVR1Bi8JDYjsYquikKXUCHYtLi5Xw4DL9/R1CJUcZYmOurT9EAjfNTn6qMJhlQDxd4
         3WaASFHDFgFrpXypauA5eIAdkYJ/+rnhS1tCMJqN3EKlqvc+Uh90ZQuySrj1s9Lz/VYJ
         C2wq1fP1ZF1VdppxvDvIDh6Kiz+RcmlqFsGhtTQ7iUM76ScNqCSMRE3SPokNptxHODKK
         wm6pmxRzs31XO7QIuNj2UdacvHvJ6wYoFol6HsYmTs6f50AjwZ9kMVBvK67TDuHelZFq
         JpyA==
X-Gm-Message-State: AOAM530ur0HzDYjHf2XlH3WrgiCU/oLKzGCHsrPD2aXsMzxHJ+7CmObg
        +x0MYJGCzZgEw5NQIuyRiBR+R3h+Ti4DrH90/UgsJScHT5cYucamFUnmvvLM6rEi8t1WAghhAPs
        HNCzQYkkdG6Md8j/HiZzlq3ud
X-Received: by 2002:aca:4acd:: with SMTP id x196mr3437837oia.34.1616082735758;
        Thu, 18 Mar 2021 08:52:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhJHdKiaGXJ8MuzmCbjxjarByEJ4cWNP+nZ4GdhXLr78M+x82KwR6XdnJXbEdlP7tV/S/HxA==
X-Received: by 2002:aca:4acd:: with SMTP id x196mr3437833oia.34.1616082735653;
        Thu, 18 Mar 2021 08:52:15 -0700 (PDT)
Received: from [192.168.0.173] (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
        by smtp.gmail.com with ESMTPSA id n17sm596142oic.8.2021.03.18.08.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 08:52:15 -0700 (PDT)
Subject: Re: [PATCH 2/3] virtiofs: split requests that exceed virtqueue size
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     virtio-fs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, stefanha@redhat.com,
        vgoyal@redhat.com, jasowang@redhat.com, mst@redhat.com
References: <20210318135223.1342795-1-ckuehl@redhat.com>
 <20210318135223.1342795-3-ckuehl@redhat.com>
 <YFNvH8w4l7WyEMyr@miu.piliscsaba.redhat.com>
From:   Connor Kuehl <ckuehl@redhat.com>
Message-ID: <00c5dce8-fc2d-6e68-e3bc-a958ca5d2342@redhat.com>
Date:   Thu, 18 Mar 2021 10:52:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFNvH8w4l7WyEMyr@miu.piliscsaba.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/21 10:17 AM, Miklos Szeredi wrote:
> I removed the conditional compilation and renamed the limit.  Also made
> virtio_fs_get_tree() bail out if it hit the WARN_ON().  Updated patch below.

Thanks, Miklos. I think it looks better with those changes.

> The virtio_ring patch in this series should probably go through the respective
> subsystem tree.

Makes sense. I've CC'd everyone that ./scripts/get_maintainers.pl 
suggested for that patch on this entire series as well. Should I resend 
patch #1 through just that subsystem to avoid confusion or wait to see 
if it gets picked out of this series?

Thanks again,

Connor

