Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB6039BEB7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 19:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhFDR3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 13:29:24 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:33689 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhFDR3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 13:29:23 -0400
Received: by mail-ed1-f53.google.com with SMTP id f5so7014724eds.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 10:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yQu4ZlSzEBr4vf2dWTW2YpYlkQS0idkpyI2C1hfoXug=;
        b=BFraaEIaKvQvAhBn08S1/i0KIziEiLFL1qJCYfHnBAaNRdGUyv3PPHBhk076NgNi0L
         HLwuqaBi3XdSp+YyjijaIqKGK2uegTOBlfU6GlE8TpiDgAIh4OzAe6SZbrki3HLf9Lv6
         fFPggfTWEL++TBHlhZyAU+6D3mcTUnAefNyEejNa71MP2JSXRrdOmPpG++0/LjfWjpqD
         rjXKsIo7nRzoRyToyrPYuW0/izoqFcAE8KMINv1iFY6ibeF9vA+1sn7fgdohxCML+Wtw
         0a/Yp/Y5gwCmw6DueEvSLbLsAvG70TGPSzREDuIPbHnACi6/DjG3pDS3023bt/HQkWQ0
         zcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yQu4ZlSzEBr4vf2dWTW2YpYlkQS0idkpyI2C1hfoXug=;
        b=mvfTMSMF9ITRJ3jXItveZUvrpgVJuLcQHhtqhchRGSpQi9kDY+/O5bmf7BD2Xs9s8A
         TNxjDmcnw3s0f9CNicrhk8ZA02HZcYL+8bFnC4w8FrgfWITZKn2IVBRf07q4+ggLUg2a
         qXI+xJRjDlv8dFNwWbuB6TOaV4lcxmvkjZueXvXlbDguvT5EBYUdjilVDsesxocbSbon
         hfS3BP44eSIO37ZENnXhu5gFN7d19GbsAQ9lGPf0mS1+yEkqMlO7eUmjNV2lFRrzdL/y
         jXdC6TqVifMVAp87q9xsYcGHDcdRxIKzUpov7dkeB9yxGRfKLPYi2eorkyD+M+A73wEV
         NfoA==
X-Gm-Message-State: AOAM533VQs33p/CBvjPcxLBCaXTXg/+DGnckWEGOJAEtknSXEEGqmPHx
        IVm03dp5nSvxkAEYu7kFDFw=
X-Google-Smtp-Source: ABdhPJxqm28tqKIRf3lvRa9hVIxcJ7lg+F4G1xZlfJG40omB+OUIg1fx6AHvl/B6vp64bs+C3rSh7Q==
X-Received: by 2002:aa7:da94:: with SMTP id q20mr5905874eds.310.1622827596449;
        Fri, 04 Jun 2021 10:26:36 -0700 (PDT)
Received: from agape.jhs ([5.171.80.153])
        by smtp.gmail.com with ESMTPSA id u17sm3478663edx.16.2021.06.04.10.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 10:26:36 -0700 (PDT)
Date:   Fri, 4 Jun 2021 19:26:33 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     gregkh@linuxfoundation.org, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Use list iterators and helpers
Message-ID: <20210604172632.GA1526@agape.jhs>
References: <20210428173301.149619-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428173301.149619-1-linux@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Guenter,

On Wed, Apr 28, 2021 at 10:33:01AM -0700, Guenter Roeck wrote:
> The rtl8723bs driver manually re-implements list helper functions
> and macros in various ways. Replace with existing list helpers.

I'm testing rtl8723bs on a baytrail tablet (Lenovo Ideapad MIIX 300-10IBY)
and applying the tag staging-5.13-rc4, loading r8723bs makes the whole
system freezing while trying to connect to local AP.

Only a power off is allowed.

I found that commit b3cd518c5abd42fbc747ef55a5fdc40bf7bf01c0
(staging: rtl8723bs: Use list iterators and helpers)
introduced the bug.

I'm trying to find out what's wrong with this patch, have you any suggestions?

thank you,

fabio
