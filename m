Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C5337125C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 10:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbhECISP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 04:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbhECISO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 04:18:14 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35ACC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 01:17:21 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id f24so6581456ejc.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 01:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=77KhqXo0QBF6RGlrN2kWUFurTxeMNqFSVmZ+axu4LH4=;
        b=XWUyiZ/d1bfkT4UVXLKP0F6Bzhkk1iNKw4YzflzImtzvlFX0MVaV3BCoIgm31oTVtR
         QXhrgbukVy7OOpCX+IFhYn88Gk/XphHok0cHLs3lPqo34LfvYfA5WiLRyJ93m1EG+Aov
         LF/V8mYCKzS4fQqM5bnDKcX8lQoRnpAPfMQ0eDhTzOTxyOnMMNA2Vjx7/yNGrszLMtP7
         +hI/WiddkeU5SOmJWzCl7QbHwwjI4BANabbk6MrrKZWwBBJF36UsbXAjq1BjwJm0Yd0k
         QXWAtpUUCZAQettHCAaU5dHj4CNVBU6OyezKEewIFrzq66yZCga3Rn9pbq2bbnTiMJPE
         0/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=77KhqXo0QBF6RGlrN2kWUFurTxeMNqFSVmZ+axu4LH4=;
        b=Rq5gdFqwwdz4F9hNrI8xsnO6WPmNlvHF+atLst1Vwn7SQUwyE4goOAN9a+HED58deO
         knm7yz70GrXtdrZaIJb729zZT5YDlEev5HCjoBTjNHe2JG8KMwd84PVPBled+qIBvM19
         DsaQTCyZ2JuoF/pugRZ2nQRz6IiJfTceHXvFp/43auBCtnLud5gp0lGoVKgf4M+mwZFx
         LlBn+O+rgfNwookfYFjqXdhlqqLkLcNw0gDlN7gFK4XmST3FTD9As5Bsi6FV7I2U9eIm
         g7aQ3kxpk9Xrza543pyTdTXgNdVMN72g3gcGRakxca32KwxVE+SP7D/xK01L2CxRtKrG
         vdUA==
X-Gm-Message-State: AOAM530gj4S3cXh6kf0Hn1kBJq3s6F3sJKpte/qwd+e8VvL+5ZhqnLaT
        qtcpEdcJ2fXIls6z5JRuZUM=
X-Google-Smtp-Source: ABdhPJxOwXppQuGqR19R1WbSVbXwft+mGphzpQfBtxabOL+mXgAWCEcHN5YC2U6VdycUTGeCH0aCgg==
X-Received: by 2002:a17:907:3e06:: with SMTP id hp6mr15539540ejc.273.1620029840676;
        Mon, 03 May 2021 01:17:20 -0700 (PDT)
Received: from agape.jhs ([5.171.72.252])
        by smtp.gmail.com with ESMTPSA id r10sm10829843ejd.112.2021.05.03.01.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 01:17:20 -0700 (PDT)
Date:   Mon, 3 May 2021 10:17:18 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/43] staging: rtl8723bs: clean up driver from
 private debug facilities
Message-ID: <20210503081717.GA8953@agape.jhs>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
 <20210503075201.GN1981@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503075201.GN1981@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2021 at 10:52:01AM +0300, Dan Carpenter wrote:
> Looks good.
> 
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> regards,
> dan carpenter
> 

thanks Dan,

when a tag is offered this way, am I supposed to resend the patchset with
the offered tag added on or it's just a tag which Greg is going to add when
accept all in his tree?

thank you in advance,

fabio
