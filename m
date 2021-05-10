Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC3D37943A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 18:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhEJQjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 12:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbhEJQje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 12:39:34 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A898C061574;
        Mon, 10 May 2021 09:38:28 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so14971990otp.11;
        Mon, 10 May 2021 09:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0xhZ81Mu+Dii62ySfi8EoTDORPoeeiPBjShy1dHMvUE=;
        b=HrewtCBh95j/pkw1TX8Kc3U8atuMts1t1hTObhLpF5G7xfAM1AGtXugnItyyQqtovx
         YoKwqkMZ16yQ/ClSPRB7e6C38PWPsz6muT26aVgKPsidNdMjPAf+ty6fX5OHe55B7ftB
         p3EEVuqjIMpqjNFX66Sa4yjp3mtPC6oO7A3enlUL/0js9PkhD6qIrWZ07ogz1/eDZpYE
         CGZY5pyrzVXv1pGpjU5m7yt4anAlncYo5v7+P4Ro4owRJCQSKPKJpktdxuV+KzyIEfMn
         YttahR0BW5+onkPI545ebhjgCGTEcIdqkUQUovXgUIA0+wiS8e4zxIXDuoe+zPvF2lAj
         Halg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=0xhZ81Mu+Dii62ySfi8EoTDORPoeeiPBjShy1dHMvUE=;
        b=YpAvXdEut6K0oxQ10QVJIzjwgJQmaCpZQHjNLHJs3pbiixVeUYnn5OTpzQ0InsazaK
         JIVasXdGikVrqTfzbZccePAsJn2XBQw/wLHvlIITikoxfG4qjApnCFb00/1lQg7ljyni
         aG7DILxJksFsOeFr+psMCct9cYu4CwOgliMmrTkq2ooGXlwG96d4ZDBtw1G8YuJUHDwa
         KMqk5A4p+lPxcV6wnqnWHXvlqNIzTX06H9ds5tMsXUJFWH07ZdidU2ywNrIY5C7AkH2m
         XADURuoZBP//MJ6WtrSz4IhITamGlIls6kuYBT8w4dj0RA9NEp7giL0yo0psLi2fqR1P
         kk8A==
X-Gm-Message-State: AOAM531CxXwF+KH1q3llwOFpBJkplfNg4+/QhynrOLlLQP8KG+DEdAyb
        pYL0rOINEx5+KqY6qciA1seS5LA+Wuw=
X-Google-Smtp-Source: ABdhPJy2uuILpJQNU+3pb10TlqnJZmtDCQjB7ohuBSRP4ijy80TkPUgZKm8p5mro5jDuTM83OfX87A==
X-Received: by 2002:a05:6830:2449:: with SMTP id x9mr3409624otr.250.1620664707719;
        Mon, 10 May 2021 09:38:27 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v19sm3233423otq.35.2021.05.10.09.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 09:38:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 10 May 2021 09:38:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Erik Rosen <erik.rosen@metormote.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] hwmon: (pmbus) Add support for additional Flex
 BMR converters to the pmbus driver
Message-ID: <20210510163825.GA838760@roeck-us.net>
References: <20210507194023.61138-1-erik.rosen@metormote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507194023.61138-1-erik.rosen@metormote.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2021 at 09:40:20PM +0200, Erik Rosen wrote:
> Some Flex pmbus converters (BMR310, BMR458, BMR80, BMR490 and BMR491)
> end up in an undefined state when trying to read a register that does
> not exist in the chip. This causes the following chip access to also
> fail even if it is a valid register read or write. This will mess up the
> pmbus driver auto-detection process.
> 
> One way to reset the pmbus state machine to a known state is to read
> a register that is known to exist. This read will fail but will also
> reset the chip into a known state.
> 
> For such chips we suggest adding a new pmbus flag:
> PMBUS_READ_STATUS_AFTER_FAILED_CHECK
> By setting this flag the driver will try to read the STATUS register
> after each failed register check. This read may fail, but it will put
> the chip into a known state so that the auto-detection process can
> proceed correctly.
> 
> Add support for Flex BMR310, BMR456, BMR457, BMR458, BMR480, BMR490,
> BMR491 and BMR492 to the pmbus driver
> 
> This patch has been tested with Flex BMR310, BMR456, BMR457, BMR458,
> BMR480, BMR490, BMR491 and BMR492 converter modules
> 
> v2
> -Copy all flags to pmbus_platform_data struct instead of one by one
> -Fix code formatting in pmbus_core documentation
> -Add documentation for flag NO_CAPABILITY
> -Fix sorting of chip names and prefix in pmbus documentation
> 
Series applied, with minor whitespace fixes in documentation.

Guenter
