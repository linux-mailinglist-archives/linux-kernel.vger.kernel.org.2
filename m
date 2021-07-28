Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB2E3D956C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 20:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhG1SlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 14:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhG1SlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 14:41:20 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B70C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 11:41:17 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id x15so4901676oic.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 11:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=glQ1wSp0cqHy7TcgHs3y8Ye4M+8JjbKl4yrfu0vDk98=;
        b=BXTRIGdErhR30/8J7aP3ER+gW3crTezczXQH/X7Et2bOcGcCiEfBDANaMhFLBmhsVl
         bWY0qkXqjL/vVOnxgkT4VKdW678ANwb2epfWegGiXmCHLK0Nh68sKNTBSyxKQFPNL4Ii
         peWSuroAs3Lm3Rwt9DzeyyojmsZ9dzcTEQWfucdYVZkH/pMJZIRUS887h+GkHP6Q5BD0
         WU8N5wfrNwbe1BX3mkkxeA2c7Xj3u9ugw/lr4A6uyZD/KlitFQE6jMz9dAS+ohCcc5uN
         t26ZOoNj9fX0XlfEEMVw3IEOIdWZYVGaSlFgLCyRga7/w+F/eVBoRzmT02ZwEyehU0ta
         kN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=glQ1wSp0cqHy7TcgHs3y8Ye4M+8JjbKl4yrfu0vDk98=;
        b=E2HoWViXpgIzmOgT847AM+Hhn7z9iJMSb28ilOPcvlMD3/vtIE/nzlFfgvo4VceyXH
         yjVxjF4ci5aUIYX7HC1tAtKo7UYCPDnq4b0OKQxzxq+XM9uWlPW9Pjxxx3bs7UxFNqV9
         QcYd06ASHKMI4grLYvy/qiHaPW3rJ2e2Z3H6XmUBwXFH3tERl66HVbs8HoRqml6LXZwC
         fScoscdJzcfS5pmspvJjofrxIQ7rkWd1oWzYif+NlLW51R0mIq9KhR8UOj1jHdrHKAd7
         s4KeaFkyNgQmvGyavpa1c+Dq13DiPC2zSkEw5z1y0/xKpMFvGF6HWd86leuzXNF1aX0B
         BcbA==
X-Gm-Message-State: AOAM5300aTbouTiNiXW9NYRBsE3VJEQ5P+TUztLaya2rIOZvAcmQiVOZ
        +xKx5FR7Bj5walQeSXeiW7/7XNkT650=
X-Google-Smtp-Source: ABdhPJyA1xfKRdihoGoCb6mMui50beIhOOs5Dxw/NdBHH4FQsYgOvkbK0L9o1hQiX2h87B7unbATwA==
X-Received: by 2002:a05:6808:905:: with SMTP id w5mr570400oih.63.1627497677098;
        Wed, 28 Jul 2021 11:41:17 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id e144sm125904oob.5.2021.07.28.11.41.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 11:41:16 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [PATCH v4 0/6] staging: r8188eu: add newer/better RTL8188eu
 driver
To:     Greg KH <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     dan.carpenter@oracle.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, fabioaiuto83@gmail.com,
        martin@kaiser.cx
References: <20210727232219.2948-1-phil@philpotter.co.uk>
 <YQGenmf2m3Tu7FFg@kroah.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <9902deed-021c-ad37-7fc7-f4279886c683@lwfinger.net>
Date:   Wed, 28 Jul 2021 13:41:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQGenmf2m3Tu7FFg@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/21 1:14 PM, Greg KH wrote:
> Hm, I thought this would be in better shape than it is.
> 
> Right now we have 107 .c and .h files in drivers/staging/rtl8188eu/ that
> come to a total of 44597 lines.
> 
> So we are taking double the size here?
> 
> I'm all for putting a "better" driver in here, but this feels odd to
> me...  Is there major new functionality here that is not in the existing
> driver to justify this?
> 
> Ok, let's see how this goes, I'll give it a few weeks to see how much
> can easily be fixed up to hopefully get back to at least close the
> existing driver size...

The major new functionality is that the new one uses cfg80211, whereas the old 
one uses the WEXT calls.

It really is an improvement. It just needs a severe cleanup.

I warned you that this code was rough. It took me several weeks to get the old 
one "ready" for staging. I never devoted that effort to the new one, and you 
wanted it in a place where multiple authors could improve it.

Larry

