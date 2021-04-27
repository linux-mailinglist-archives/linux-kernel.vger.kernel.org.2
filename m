Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79C936CBC3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 21:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238722AbhD0Tif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 15:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235661AbhD0Tie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 15:38:34 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942B6C061574;
        Tue, 27 Apr 2021 12:37:49 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so7725284pjh.1;
        Tue, 27 Apr 2021 12:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MKJIJ4UnZNAA5NLPoDiMpenC7DJEVyWZfyv+PILCaYE=;
        b=IxDEPmTh9hCkoSDGfresNaHk/35pZeD4OqbPjzLIP5DK9SwNKkYEoHiyYdhLLf5dU2
         NznW20H8LmirJM0yl5xTVWdjdq0ajq0tSlb5aAr+fl7wNRv6wJNVlQwl3lofdfwgfEhY
         D9eFopWOCKar98FzCOs9xmEIyAN0Nv6mLcyLQNtbzBXqv8A58cclqdA6f7up94Au6mfV
         005EztjqYL8L4lmJretwJ4odZ02U3hdBhGGOue6hnoZv8KIHJYimx1BgJ0iyCgRbkPjY
         NLb8I04zjRF/PzjKjbCVz6k5tmCElDQFetis5UvoK3YAtPOdSlgFw5CTQYJbf/egKdVU
         QanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MKJIJ4UnZNAA5NLPoDiMpenC7DJEVyWZfyv+PILCaYE=;
        b=Rcvlrogdy12tvc3SOS9rsPbOijMqwLidPapTeXmrSMQtTvFi4aYCzQUy4P+AmXWRbg
         76B/UNzZ+ApzD6JQFvRdTbb2OSF7l6DbTv5X+RO5DF6eqko5FgOWNq3KuxGqyCe50G8c
         KWaIOQSQAHfk/KHx6r3UN9qGBxGGDVSPbLMjQvyzpK2EXcAcoH+fkU1dg8jc9/g+k0p0
         oHd1tUyd/AMlm6X3FHHXrI4DahJTq8uZtUV9aoK528v3V7SeN5fwKxFpSu47jThKHUqz
         AJSHDqrbsxJrtvj+iyhpeNt6K2TFC8nyGyZ4N1xNqkZojGuFeQ2EQwn2ht8Vs92VhEEm
         Xjww==
X-Gm-Message-State: AOAM533pGGnKxP2LjBfvsimuomI+B6uF7KmQ1wqmd8wN8t2DTwJ/eeUp
        BAFuVdLAS0XGrjsGhv+Wsxg=
X-Google-Smtp-Source: ABdhPJwVTXB/tsK8yfn1xpiO2FN3teVQL4LYWXkZk2HPL8eG2qtA+U6Z793DYZsWcU416PXlXjngUw==
X-Received: by 2002:a17:902:da85:b029:eb:8794:7078 with SMTP id j5-20020a170902da85b02900eb87947078mr26273046plx.25.1619552269040;
        Tue, 27 Apr 2021 12:37:49 -0700 (PDT)
Received: from user ([2001:4490:4409:fe15:9fd0:fa2c:4efc:28b5])
        by smtp.gmail.com with ESMTPSA id n18sm2961055pjo.19.2021.04.27.12.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 12:37:48 -0700 (PDT)
Date:   Wed, 28 Apr 2021 01:07:40 +0530
From:   SAURAV GIREPUNJE <saurav.girepunje@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     b-liu@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, saurav.girepunje@hotmail.com
Subject: Re: [PATCH] usb: musb: davinci: change the variable type
Message-ID: <20210427193740.GB11046@user>
References: <20210418183618.GA69452@user>
 <YIE4hh5NOJMT7QqK@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIE4hh5NOJMT7QqK@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 10:49:10AM +0200, Greg KH wrote:
> On Mon, Apr 19, 2021 at 12:06:18AM +0530, Saurav Girepunje wrote:
> > vbus_state is define as bool but on davinci.c assigning a value
> > '-1' to the bool variable.
> 
> Does it also test that value?
> 
> If so, shouldn't that logic error be fixed instead of working around it
> by changing the variable type?
> 
> This feels wrong...
> 
> thanks,
> 
> greg k-h

vbus_state is assign with the value of "-1" in davinci.c file.
However it check value whether it is zero or a non-zero.

This value pass On gpio lib function.Which need this value to bool only.

On below "glue->vbus_state" should be 1.

	glue->vbus = devm_gpiod_get_optional(&pdev->dev, NULL, GPIOD_OUT_LOW);
	if (IS_ERR(glue->vbus)) {
                ret = PTR_ERR(glue->vbus);
                goto err0;
        } else {
                glue->vbus_state = -1;
                INIT_WORK(&glue->vbus_work, evm_deferred_drvvbus);
        }

