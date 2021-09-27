Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86AD41A168
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 23:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237373AbhI0VhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 17:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237362AbhI0Vg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 17:36:57 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320E2C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 14:35:19 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id dj4so75041028edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 14:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8fIXLZFZklwKHdl3exETI4xeMDjaDuEQ0orstMQkXZ8=;
        b=KFMkzIwwW9lciMmKWfm/MpAQJ6JqEt/ksgk2f/1SvIkeFMEIvhj60x/DWbYbwAfO/H
         idNDXi5BqH5uEPUnIalkGHyrLcfhSy+z/HzkFvMTPb4u3ePTjCOZelxEBqpS7I6zsLfj
         xacHCczi8D5TEbeakKFZAc2tpWZxan4TrPD9EKsn98hAIQZaKHWeWCYOo1x+tmySvpS9
         PQSDjQj39h3V2GYzvMA1JWGCNQ1H/AUmL5HbG54eTrL/MceB8C1shpvGCXzvy2OhGT80
         NkhcBg7QW/PfCir9zP3b4j01WFg8c6E7WyuoM0WnBeAfNZLsGAGUU7Sz1dsx2rrZhHr/
         26/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8fIXLZFZklwKHdl3exETI4xeMDjaDuEQ0orstMQkXZ8=;
        b=zBlYqf0DtWFaRbNcJFrC/LLXzBzKPdnLB5unJOfphEjZUGjxNCtypOjXapnXg3tVqM
         n/Xy8ZVI5MyKohAM/tUN2WPD0q0xNt8P9Veqz9b0n3TKiYCOL8v3jLx5e5ukRAAwc9PK
         45Xuur3FY7UC/hzFHv1V936974GB6DI4x37mylGKvH+SXeQhoFjooULMwxun4dAX40DE
         UahCs3HesuavRAuuYg++SIO88vrV/LGo8C+171KxblJ0Z58dYNZZIdDmqkSZiXRd45dz
         7y6KdCNgPJTxy3kAnbb44KK1dhnewEdUQ3p33rM8LHCDHuchbEmO5JaXg++yKLR7NtMp
         6MGA==
X-Gm-Message-State: AOAM530fVuBgIm5uPqEQcaUAH0AffpfWimWFhmke3T8qq1FJJ3Y3WEtH
        NL9pAMEaiDs2xarbM1WGJxg=
X-Google-Smtp-Source: ABdhPJyokOtj5LXsKCcHluXvkmPQJmOhWxMhYJg0G/H019iApTB5xDAZDVX0f8AgPrwz+OiMB+Oq/w==
X-Received: by 2002:a50:d8cf:: with SMTP id y15mr3014927edj.66.1632778517759;
        Mon, 27 Sep 2021 14:35:17 -0700 (PDT)
Received: from tom-desktop (net-93-71-218-228.cust.vodafonedsl.it. [93.71.218.228])
        by smtp.gmail.com with ESMTPSA id ck10sm11591740edb.43.2021.09.27.14.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 14:35:17 -0700 (PDT)
Date:   Mon, 27 Sep 2021 23:35:15 +0200
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Yujia Qiao <rapiz@foxmail.com>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        Aldas =?utf-8?B?VGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] staging: vt6655: fix camelcase in bShortSlotTime
Message-ID: <20210927213515.GA6953@tom-desktop>
References: <20210926162527.21462-1-tomm.merciai@gmail.com>
 <20210926162527.21462-2-tomm.merciai@gmail.com>
 <YVHilhCk3cgGhXrZ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVHilhCk3cgGhXrZ@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 05:26:14PM +0200, Greg Kroah-Hartman wrote:
> On Sun, Sep 26, 2021 at 06:25:18PM +0200, Tommaso Merciai wrote:
> > Replace camel case variable bShortSlotTime with snake case
> > variable b_short_slot_time.
> 
> That is a very odd variable name.  Why did you pick that one?
> 
> What deos it mean?
> 
> You do understand where the original naming format came from here, and
> what it was trying to represent, right?  If not, please go read up on
> it:
> 	https://en.wikipedia.org/wiki/Hungarian_notation
> 
> That style is not used in Linux, and so, when converting from it, do not
> attempt to keep the same style present here, that is kind of pointless,
> don't you agree?

  You are definitely right. What do you think about "short_slot_time"?
  
  Thanks,
  
  Tommaso
> 
> thanks,
> 
> greg k-h
