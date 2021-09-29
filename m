Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEC141C500
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 14:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343951AbhI2M6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 08:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343919AbhI2M6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 08:58:03 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52A1C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 05:56:21 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id b192-20020a1c1bc9000000b0030cfaf18864so1677701wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 05:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mg6RB6XzRIgaMR9CfScmPcuVXy1LoHJbNrKAbn6MCsY=;
        b=MtVf2W8kwLE5Dz9Kf5OkM9iCCBei4ivfvf5La+0PZPrtKmbQuYCA1Dp44QAXDMojW4
         Qt4JJMsd7EDCWEpXVENve3dmOZD13QP1g3H3pPA9sPkxPXeO3ZExyYGA0OLM+uykZghb
         1Yg01Arq4dN4/q+pY0QWgTbqEALts1FHZdSxqDthtE84AncFWVDhNRIQlGaIbgussQ3w
         fXT0qBVwTll6Dt/jQKjEBXjIi35fjPBd+lsvb/34mzL10dHvZymQLoGbe02qyZ6JwT1i
         RtketO83OdzoBwHqMFwEWPLV5AjIoOzVQ+lI/owVQIfaDMefebXql/h7zyfJ3+3J3r40
         jA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mg6RB6XzRIgaMR9CfScmPcuVXy1LoHJbNrKAbn6MCsY=;
        b=cPpndb637DYAG5FNz6HkwOi10FCxknKQ/cc5gayelwZGBDbwVKgWbbbVaSnx1c0B/m
         NPAVH1V98hvuOI0XQPFFuipX9opBspmwtbSNiWO0xjPJUBC2lEJsummh0sR9cOLqMYVQ
         hG1KsTLWG2eN/JEWHkLaiBoo0Gd6elG81wOkWHAkGgiJYHC4P2oZUJ7/noG+TN+nW318
         GNMHdI1I59p30WiP1biDHUp5kHKgww+acIEX3r8w2j7N7z+/1Go+62U5m0I8leFy1le6
         xD3kVfYaHK7g0itZVV9aMQ4Tdz9t6jrFdHTAG+0Jqv8xS9yBcNIB8GHeIzkaAZ4X1iGC
         R9gw==
X-Gm-Message-State: AOAM5300bwhbKIypWu44K4JageJ4z3YJF1UJ+I5fYM+7hvIeOAeJiLmK
        e9YutMiAbTWI5TX8kMlqbE1wX/KLzzE=
X-Google-Smtp-Source: ABdhPJyxXw64vUsBC6VyXIlZjSl1yjAsifsos4VgKTenYweIS80dZ21biXOB7E+RZppcLXdwwgeKaQ==
X-Received: by 2002:a1c:4e16:: with SMTP id g22mr9744201wmh.171.1632920180560;
        Wed, 29 Sep 2021 05:56:20 -0700 (PDT)
Received: from tom-ThinkBook-14-G2-ARE ([89.42.6.254])
        by smtp.gmail.com with ESMTPSA id k11sm2197539wrn.84.2021.09.29.05.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 05:56:19 -0700 (PDT)
Date:   Wed, 29 Sep 2021 14:56:17 +0200
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Yujia Qiao <rapiz@foxmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        Aldas =?utf-8?B?VGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] staging: vt6655: fix camelcase in ldBmThreshold
Message-ID: <20210929125617.GA213077@tom-ThinkBook-14-G2-ARE>
References: <20210926162527.21462-1-tomm.merciai@gmail.com>
 <20210926162527.21462-3-tomm.merciai@gmail.com>
 <YVHirHixyOIgvqKB@kroah.com>
 <20210927214624.GB6953@tom-desktop>
 <YVKdJdTxlNJ55zCy@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVKdJdTxlNJ55zCy@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 06:42:13AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Sep 27, 2021 at 11:46:24PM +0200, Tommaso Merciai wrote:
> > On Mon, Sep 27, 2021 at 05:26:36PM +0200, Greg Kroah-Hartman wrote:
> > > On Sun, Sep 26, 2021 at 06:25:19PM +0200, Tommaso Merciai wrote:
> > > > Replace camel case variable ldBmThreshold with snake case
> > > > variable ld_bm_threshold.
> > > 
> > > Same here, what exactly does this name mean and why did you pick it?
> > >
> >   You are right the same here. What do you think about "bm_threshold"?
> 
> What does "bm" stand for?

  Got it, thank you.
  The right traslation could be "dbm_threshold"? In the original
  variable name "l_" is for long (hungarian notation), "dbm" is for 
  decibels relative to a milliwatt, signal_strenght.

  Tommaso
> 
> thanks,
> 
> greg k-h
