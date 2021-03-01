Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F97329FBD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574471AbhCBDqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235732AbhCAVMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 16:12:39 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7491C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 13:11:58 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id k12so12211281ljg.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 13:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qdt0gqU+m2m41kfQ69esyOuYV2PB7RgXcFIpx4NsLpU=;
        b=iAVctwzodKN3uH7TwrdUFIdL0j7nUc7BxtcSr0QQ4BJcj7fF8dm5foDpsRQXPlWp0A
         ut1CsTC6ag31qv+Nf+OGWCx6ctVsJ5WKrjAx66K/g2+1z2VLIiBAqfdLmig7QRsfzP0i
         cXSjcRzs02UQ3URZFrW6aMQl6xuGRBEj5f4EKt2D3yH/AqZ14cuZ6N4/8RHyPXbVrWKw
         NhRmzAU9LIDE1gkYpgtxFECGew71iP1kvpPS8B/sUIR0G3SJCOC5IP6rj0iGERsYgo9D
         QRbqATJm0o3pi755XK8LpC2ZnvGDlvn9clSTsYa7tbU1cuKMbMXvbr3G9t1BUxLpwUi9
         MK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qdt0gqU+m2m41kfQ69esyOuYV2PB7RgXcFIpx4NsLpU=;
        b=BvhkEKfkaWA1VBX6UOqH0VuhKVJxO0av5ESnNUwaYclqeLZD8Wxjk03gI8OZAawasV
         oi1kInkXQias9MmIXrYJi6gWUjd+7pFhInqfegg5evv6Wfl/OVw1tFs4OJviBjnDFOdZ
         KHugvzREsoY3MGiz7Jr/I55Nz4rjZCzc5cT96+4u1j39nz80NMaGoD84itP/KhatYlAI
         GGZABmI/MiS74OeF/qNTcolQSMjuCn/ZfmwTT8gdKrfFydPVzOcQvofg0JWDTkcNFlHt
         v5q5GJ5Li8QhRNA+x2T5hul614+ixjhR9wEN5pqp8LehJ3u1aFCk1JdOfS4n+if6A2uT
         bGTQ==
X-Gm-Message-State: AOAM532QUgmTH+OuZP8phNGxCGII26PtA8Fzukeah1AzLibo+R9FhHVz
        BKpDdMSZc5LzMoTE4qNofBs=
X-Google-Smtp-Source: ABdhPJxTtpGU7CE2VU1H4tUweUSlnQUnHkPW9vSHNiN/Rp57OyFNjw8uAlVKbKoSotqs77lqnMlBuA==
X-Received: by 2002:a2e:b178:: with SMTP id a24mr10134671ljm.484.1614633117533;
        Mon, 01 Mar 2021 13:11:57 -0800 (PST)
Received: from rikard (h-98-128-229-129.NA.cust.bahnhof.se. [98.128.229.129])
        by smtp.gmail.com with ESMTPSA id f10sm784966lfm.194.2021.03.01.13.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 13:11:57 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
X-Google-Original-From: Rikard Falkeborn <rikard.falkeborn>
Date:   Mon, 1 Mar 2021 22:11:53 +0100
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Robert Jones <rjones@gateworks.com>,
        Tim Harvey <tharvey@gateworks.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mfd: gateworks-gsc: Constify static struct
 attribute_group
Message-ID: <YD1Ymbdxv0GCZchQ@rikard>
References: <20210131133644.8834-1-rikard.falkeborn@gmail.com>
 <20210131133644.8834-2-rikard.falkeborn@gmail.com>
 <20210301095645.GG641347@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301095645.GG641347@dell>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 09:56:45AM +0000, Lee Jones wrote:
> On Sun, 31 Jan 2021, Rikard Falkeborn wrote:
> 
> > The only usage of attr_group is to pass its address to
> > sysfs_create_group() and sysfs_remove_group(), both which takes pointers
> > to const attribute_group structs. Make it const to allow the compiler to
> > put it in read-only memory.
> > 
> > Done with the help of coccinelle.
> > 
> > Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> > ---
> >  drivers/mfd/gateworks-gsc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> These patches do not seem to be on LKML.
> 
> Do you know if they were rejected for some reason?
> 

I did not recieve any bounce or rejection emails. I have a vague memory
that I saw someone mentioning in another mail that there was some
problems with LKML and that patches were lost, but I can't find it now,
and I'm not sure if it was around the same time as these patches were
sent.

Should I resend the series?

/Rikard
