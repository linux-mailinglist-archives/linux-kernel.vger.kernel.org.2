Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B962D347A15
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 14:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbhCXN6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 09:58:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30733 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235838AbhCXN6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 09:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616594312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/C5hrHviblBlz6qOuCjmxQmp+MydE/HY6zib4cOG+CM=;
        b=T9zC9YfCgG4kwHAUFBAoK/QXaEgrr+LPoSusmkvtTP9i0hOcY9C7/kqgo6X+uxBpt+k1RD
        03YdDbCsvE5l3jpLtv5TDRzqb/NAkpFmCNzG3+ub8IMiWFLHvdJoz4h6D1D6XPn1mRXXj6
        04Ip7/KP0WJyCw9QvVDsP+LED8DRCI4=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-FZ5ARaN3P-GHy8z2E3Wp0Q-1; Wed, 24 Mar 2021 09:58:29 -0400
X-MC-Unique: FZ5ARaN3P-GHy8z2E3Wp0Q-1
Received: by mail-oo1-f70.google.com with SMTP id a8so1325014ooo.14
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 06:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/C5hrHviblBlz6qOuCjmxQmp+MydE/HY6zib4cOG+CM=;
        b=c+tgOHKR+KpJj7HHVSF6NO7etKpiy28VqNfAyxJ0Cvf/oP5lSCaYcVwUOCd9goJ+gD
         DWl0+zfhPGN2gutP3KQSwPvdUUXbDH01YrIZkYm+hI3pr6l0f7QIAfPxU+iSvYrJh8xi
         nOb4EBBw6pTpc+bVOipe0in3IRO9pKM7iHJ8B5wBQsyU5nCk+YvaI0gFp6jHH13lBCr0
         Dstbj/jX/GGD0PrzrTqTJ2YO+MFeHL0JIFoD+S1E9W34Spynh/L55AdnSgdY3aOpCCTR
         prL07RXV6u7SxuAV1RWpc+fZe9HEBN4Bee/O2EOhpadNsAmylvdfQwzQRYWAbhBrbi5x
         Nc5g==
X-Gm-Message-State: AOAM532pFzj6QZ8qrPUf+9b4juMM0CvdQpFBuR2SkidkYv304XOptNVa
        hwswNkfnP4oJFmcjXVYuRTKAzvrrAUM+WnXtx2AwN14KMi/JgA/sdvEI1M5xC+HG+tiDAqgw2Fp
        hZspqOo4GroOKRo3cI30aaGJCNTi21jDym7XqgcIo0awfVkfi0cB9lOMLMl66Rt9/2iZms+TcTA
        ==
X-Received: by 2002:aca:2418:: with SMTP id n24mr2426478oic.103.1616594308297;
        Wed, 24 Mar 2021 06:58:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUzpwRYGx/Gf/SW6R+ymtcIvEm7PSV63CIFAnOYbgbfamQmwZBNs2xw4TBchd0MKmqjjledg==
X-Received: by 2002:aca:2418:: with SMTP id n24mr2426458oic.103.1616594308072;
        Wed, 24 Mar 2021 06:58:28 -0700 (PDT)
Received: from [192.168.0.173] (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
        by smtp.gmail.com with ESMTPSA id a6sm400144oiw.44.2021.03.24.06.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 06:58:27 -0700 (PDT)
Subject: Re: [PATCH] fs/fuse/virtio_fs: Fix a potential memory allocation
 failure
To:     zhouchuangao <zhouchuangao@vivo.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1616589523-32024-1-git-send-email-zhouchuangao@vivo.com>
From:   Connor Kuehl <ckuehl@redhat.com>
Message-ID: <7dbe66b5-344b-2008-ca8f-559a271a061f@redhat.com>
Date:   Wed, 24 Mar 2021 08:58:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1616589523-32024-1-git-send-email-zhouchuangao@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/21 7:38 AM, zhouchuangao wrote:
> Allocate memory for struct fuse_conn may fail, we should not jump to
> out_err to kfree(fc).

Why not? If fc's allocation fails then it is NULL and calling kfree() on 
a NULL pointer is a noop[1].

Connor

[1] 
https://www.kernel.org/doc/html/latest/core-api/mm-api.html?highlight=kfree#c.kfree

