Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D812438B82
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 20:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbhJXSqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 14:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbhJXSqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 14:46:10 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520F9C061745
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 11:43:49 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id u13so9099754edy.10
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 11:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PLo2wPZ3sr8u/YMmfsE81ITzb2gWI/ZlBw1GMaku9Tc=;
        b=CFKJXauMo5jd0vAv6qp4CeyWsOcWCS8QQp71I5fmYmWbzCK45jxRLlYq1Xf6evAl/c
         pHwQgGhuHqf6BR9Jtn2EvGxnb7IyZULt3r417XlD/3NSCZofHfHy0RQRlR41sr/QXCxf
         xNeb0vtjaAaWkgID5qa8K0Gr14IQr3KZV1GfmBgRYoDlCTsssuFgwLKtM56SHHTa2eHo
         GD67keayVQDfnsCGmLwGJ9s0hDQcE/gS4SN6bbPL4CiHUC++9lTJhZxHOFUtZH8eWVrI
         uSrMOF3niuSlsPszGKIURwqH9W7UERmSC0XHreHo2SdDDsIN9VtfS7BL0Lo+/sy8DEqO
         I9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PLo2wPZ3sr8u/YMmfsE81ITzb2gWI/ZlBw1GMaku9Tc=;
        b=XtkJpti+L6+O7bKJBqlBZNgPzNsVzRfI8RZ1tT3cE2M0ue8atYxctAZUxA/8zVPSXa
         cpRU47MRKSwKhWCiBDAFFfTZJYq2qozB+PoTzqh/xWizs3ZSBEThVWsB3gF1xkcxR40I
         NpxMO2522DUk4lqhQaKwZ5loYSVIHllKOPY6reL4b/A5je/h9TnM3aS9+j9pU40ky56o
         xHuZBIetu4DBooIpIfe2UqvoW/9TWQPhMOmrLt4So+Z8w4vR37c7i9j6xdnm5xrYWB9M
         tQxyI7B3JXTGtTOZ8bidZVhI3XaVdR7z9hrhxoHaXoBDZfgKs8HaHUhNRdV7yL6k2/1Z
         8+yA==
X-Gm-Message-State: AOAM532HfXTaeGtbuS1AwmHLXtaUrDQYOz3u26AwNCadQTwJwaeAthYy
        ycuVbQ3rxtDCJZkaFEsjTsU=
X-Google-Smtp-Source: ABdhPJxMh0UwooY8Fhupl3FToFhxvOqdRLyjq0rnk44fZPEnTi9jNe8YhI0+AvhF9L6MdQDPZWrEdA==
X-Received: by 2002:a05:6402:1436:: with SMTP id c22mr19770675edx.153.1635101027553;
        Sun, 24 Oct 2021 11:43:47 -0700 (PDT)
Received: from tom-desktop (net-188-153-110-208.cust.vodafonedsl.it. [188.153.110.208])
        by smtp.gmail.com with ESMTPSA id qb15sm2106800ejc.108.2021.10.24.11.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 11:43:46 -0700 (PDT)
Date:   Sun, 24 Oct 2021 20:43:45 +0200
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: vt6655: fix camelcase byData in card.c
Message-ID: <20211024184345.GA7946@tom-desktop>
References: <20211018192124.8738-1-tomm.merciai@gmail.com>
 <YW5ceCLSIRl5zJIm@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW5ceCLSIRl5zJIm@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 07:49:44AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Oct 18, 2021 at 09:21:22PM +0200, Tommaso Merciai wrote:
> > Replace camelcase variable "byData" into linux kernel coding style
> > equivalent variable "data" in card.c.
> > "by" prefix in hungarian notation stands for byte or unsigned char
> > 
> > References:
> >  - https://www.cse.iitk.ac.in/users/dsrkg/cs245/html/Guide.htm
> 
> Don't provide web links in a changelog text, they might not endure.
> 
> >  - https://www.kernel.org/doc/html/v4.10/process/coding-style.html
> 
> Why the old and obsolete 4.10 kernel document?
> 
> thanks,
> 
> greg k-h

  Hi Greg,
  I'll update and resend.
  
  Thanks,
  Tommaso
