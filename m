Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B903A443F13
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 10:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhKCJQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 05:16:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48950 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231911AbhKCJQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 05:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635930808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kta5P9DjxGjLt1qFAr6O2JPQBf+Y2cA7ML/nwbYyoJQ=;
        b=actRe8kshAdjit0mZjjNNajJ35ftl2vfRHk6bQQ2il/HV1WdHg7go8XPzp6nFUclm3mr4+
        mPdCVrGEg/f5lFvYEmMiniRwOcV/vTpQ8kCgQ0L/KLz3VWHDV4dydGlFBReYrBSEEqJFF9
        CvMoid7cR0jSj7v5u1lzFAYvV3gu9HQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-xoMA9ut0Nfy1h_55WjRkrg-1; Wed, 03 Nov 2021 05:13:27 -0400
X-MC-Unique: xoMA9ut0Nfy1h_55WjRkrg-1
Received: by mail-ed1-f71.google.com with SMTP id s12-20020a50dacc000000b003dbf7a78e88so1889803edj.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 02:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kta5P9DjxGjLt1qFAr6O2JPQBf+Y2cA7ML/nwbYyoJQ=;
        b=qgUfzexmY0pd8gWNd67kWE9Rn3+UQOudXIKI4H5WyZPPigOgdS5CkX36QwU7G6/coe
         rs2ggKcH/vD8kD/qDNZgqyx05q+IevPp+tvYbwmSiX1AfMZSziJDXnQD85szqBOZBPo8
         LCkJ4MxW+/G9CwrqZ3d2ubSA/v1ss5bwuxTrk2JIHfjDGLOz6dZsyDNO9nJhqlrtT3Ng
         FkBa6y4stMYUlPiFkFZAFRkJehh3SDqgAkoJ2NQB633zGHfX1365Z+0+fZkM5P21dg6t
         dhEdjqPkPHa9rQbxvXUGWFpzucxj7IskVcr1H3hhwfq59/UPQXsgotTE2hGmlUZWAL8f
         zyMA==
X-Gm-Message-State: AOAM532Z9F5j+Uq2LREb4+rEJTb6NdS57OjeaH2HamapHG6x11YtdZKC
        /f3M/Ik8yOsW3raWdp0RTu8vVIU9LjV+jEKNCb+XapMhLBsOuONTXn5QXZYFxebc860FUgVYJ3+
        EcpHOjwkXgBQQCqAK0qm79Y9I
X-Received: by 2002:a17:907:6da4:: with SMTP id sb36mr53073175ejc.490.1635930806436;
        Wed, 03 Nov 2021 02:13:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw739SKKR+4NL6ztAIIe+dH5l2puSFk1b3CxXZPJrUtnlCgmtLXOOBAwRnEQds5uQkPUP7elw==
X-Received: by 2002:a17:907:6da4:: with SMTP id sb36mr53073148ejc.490.1635930806237;
        Wed, 03 Nov 2021 02:13:26 -0700 (PDT)
Received: from steredhat (host-87-10-72-39.retail.telecomitalia.it. [87.10.72.39])
        by smtp.gmail.com with ESMTPSA id hq33sm875288ejc.119.2021.11.03.02.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 02:13:25 -0700 (PDT)
Date:   Wed, 3 Nov 2021 10:13:23 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     andraprs@amazon.com, lexnv@amazon.com, alcioa@amazon.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nitro_enclaves: Fix implicit type conversion
Message-ID: <20211103091323.clvhuiaf7kwrbywy@steredhat>
References: <1635472126-1822073-1-git-send-email-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1635472126-1822073-1-git-send-email-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 01:48:46AM +0000, Jiasheng Jiang wrote:
>The variable 'cpu' and 'cpu_sibling' are defined as unsigned int.
>However in the for_each_cpu, their values are assigned to -1.
>That doesn't make sense and in the cpumask_next() they are implicitly
>type conversed to int.
>It is universally accepted that the implicit type conversion is
>terrible.
>Also, having the good programming custom will set an example for
>others.
>Thus, it might be better to change the definition of 'cpu' and
>'cpu_sibling' from unsigned int to int.
>
>Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
>---
> drivers/virt/nitro_enclaves/ne_misc_dev.c | 14 +++++++-------
> 1 file changed, 7 insertions(+), 7 deletions(-)


The for_each_cpu documentation explicitly says that unsigned is 
supported and -1 is commonly used to refer to the value before 0 even 
for unsigned.

However I have nothing against changing them to int.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

