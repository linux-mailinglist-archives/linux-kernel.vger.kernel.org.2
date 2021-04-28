Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5461136D30B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 09:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236629AbhD1HZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 03:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236453AbhD1HZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 03:25:09 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F95C061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 00:24:25 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id lp8so2237682pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 00:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5LYTEtiy0oE5g1FSqUSMNy7xj6UIB0dhqsQ/+3S1wk4=;
        b=SM1AWmw9/8trQ3SQTV6NfuL94tmGNEIptbv5txAgGlF3ZYoDUjIC8lh2ePKnQt14yI
         7h8PE5HmubRqW11j6NhcX/6cxE8sP2jiw5oIIhiKJMfMMwftufJpLHjWKxIolmoWTDMH
         +cV2yWNrvyTBGfDS944AtQw4Gr0XdChhD/R6MrDQBSjsbDf44T6inkRuZq0J9DFScPwP
         24Nv8chpauIm9kd5g29y8Tf64ShJ/MFOr1T+ZPiUub/e6N7VMwR7wH+E4DkHAPkTRoIY
         /n2TGRaJmexM2IeA3LUwc5cx15bd3jzIyKXwFHOqETpjjFVjp0JjCnmUCKyyv+Grwdz9
         wxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5LYTEtiy0oE5g1FSqUSMNy7xj6UIB0dhqsQ/+3S1wk4=;
        b=bv40jqCkNboGuV/S6DwT50iOeToXf/huqhge5BM5YRE9Stw3sHqqHOWQVSfeMMLELr
         /D9wEN94UDx7IsrW4CYVwDztP2vWkL6o+rXeLbaJYIEg1M5KyQeSD8MR8OUhnuHlCfv3
         B5crhBcmN03UjVn43W6/OwCMG4bkL2EN8l/W9V3zUh/famhT1zD5vtDBXuaW6Ti4FSOY
         RumApIkwRTB3JxDiyP2qvhzB1iQyUmylKhigOYLeeLKOlirI0YKDTvilDJMUT8tEQsbp
         r3dOYZCODwA0hrEk7SXSmYseAdCMetEaodwlFkBWENrclti48M+FupBNJwUmAJ5MEq08
         /yvQ==
X-Gm-Message-State: AOAM530aeXwJaoFVReOE9VqVm4bNoAXkQtuxBkPyALk50+7TSY+i+ull
        tdWpeddatcm1fbdSHMHP/RmlOSCOnSaf5N72
X-Google-Smtp-Source: ABdhPJwZaQfdMWK2Qw0BqpI7CLvaQ0aeijie8x34QV+qe7QAlVs/qbx/2qKWa1EXSNRz7nRydjrUiw==
X-Received: by 2002:a17:90b:190d:: with SMTP id mp13mr9959682pjb.156.1619594664696;
        Wed, 28 Apr 2021 00:24:24 -0700 (PDT)
Received: from gmail.com ([103.52.209.34])
        by smtp.gmail.com with ESMTPSA id u69sm4377552pfc.76.2021.04.28.00.24.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Apr 2021 00:24:23 -0700 (PDT)
Date:   Wed, 28 Apr 2021 12:54:18 +0530
From:   Jitendra <jkhasdev@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: fix array of flexible structures
Message-ID: <20210428072418.GA1035@gmail.com>
References: <20210427174945.1323-1-jkhasdev@gmail.com>
 <YIhTjGpmLSYKuCi3@kroah.com>
 <20210427185844.GA1030@gmail.com>
 <YIj6MUO5+EDBzOwl@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YIj6MUO5+EDBzOwl@kroah.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 08:01:21AM +0200, Greg KH wrote:
>On Wed, Apr 28, 2021 at 12:28:44AM +0530, Jitendra wrote:
>> On Tue, Apr 27, 2021 at 08:10:20PM +0200, Greg KH wrote:
>> > On Tue, Apr 27, 2021 at 11:19:45PM +0530, Jitendra Khasdev wrote:
>> > > This patch fixes sparse warning "array of flexible structures"
>> > > for rtllib.h.
>> > >
>> > > eg. drivers/staging/rtl8192e/rtllib.h:832:48: warning: array of
>> > > flexible structures
>> > >
>> > > Signed-off-by: Jitendra Khasdev <jkhasdev@gmail.com>
>> > > ---
>> > >  drivers/staging/rtl8192e/rtllib.h | 10 +++++-----
>> > >  1 file changed, 5 insertions(+), 5 deletions(-)
>> > >
>> > > diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
>> > > index 4cabaf2..c7cb318 100644
>> > > --- a/drivers/staging/rtl8192e/rtllib.h
>> > > +++ b/drivers/staging/rtl8192e/rtllib.h
>> > > @@ -802,7 +802,7 @@ struct rtllib_authentication {
>> > >  	__le16 transaction;
>> > >  	__le16 status;
>> > >  	/*challenge*/
>> > > -	struct rtllib_info_element info_element[];
>> > > +	struct rtllib_info_element *info_element;
>> >
>> > You just changed the definition of this structure, and the other
>> > structures here.  Are you sure this is working properly?
>> >
>>
>> I have compiled the driver and install it on my vm, but I don't this specific
>> hardware, so couldn't test it.
>>
>> I fixed in context of sparse.
>
>Please verify that this change is correct by looking at how the
>structures are being created (i.e. is this being treated as a flexible
>array or a pointer?)
>
>I think we have been through this before and that sparse is not right,
>but I can't remember...
>
Yes, it is getting used as flexible array in code. hence, simply we can drop
this patch.

Also, looks to me, there is no more sparse warnings to fix in staging.

---
Jitendra
