Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3693F6EC2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 07:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbhHYFUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 01:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhHYFUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 01:20:51 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB10CC061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 22:20:05 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id r19so35077646eds.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 22:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jY+zZq2r8622JGPGrLQZJIpbL7Iz4oXWiLOi7adzQ3I=;
        b=d3VK8Dr+N1GcxePH0NDEA/LUKnGHqOzFVRvHyqvlvLRjdab0F5RBZSkaRcFP+u/K09
         uiH56ralxHS7LlBSnXE5P0ZxGg/2Uz4BVLuIybN3/zGGBLikmhz76wRbSgH+oiaalfHe
         pFgLD6HJpgIw9uAAduHl3AYor9LRSUcore814fan6T6HU5i3U9sZ1FTtncAySl9T9dOS
         YRME256okfHhxzUn5jkRUoWIdNn/m8QqwtjAMY6G7T40PgOwCG+BVZCv+cYbzUwvK6cI
         NIHWc6MDnC/YQl+A7HEUDEVIDjy3BY40GJHI9o7PvYhsheR1uzjWgUvbyfFT69wxy8zz
         QaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jY+zZq2r8622JGPGrLQZJIpbL7Iz4oXWiLOi7adzQ3I=;
        b=Exnh2vTfBrECeNcj3yPr1qoMIfwhsa7vl4h58dFwmVh3CS525G1YmlRop+LbNheFlq
         XG/L3NvB0DyVnaznF9Isu1CT8f6aV7AQvaCVldgbGTjqI7evjfE6+XplM//SnZCv9ZOv
         l2YhV/wK9rlOd+T8TfvtioralcwV6WzV5xmv8IGQG6kQdsXf62XmjH303gm7MNQ/Fr27
         Zg4Hrj+mIPLwW0BtgyKyypUDHrgErwCyvhpWpLPH5SQPL+TLTk6sZftMm1KKVwcQPZun
         GzYUtNj2AO7JD30ih3ZUwXQeqTmIPoQp8eXpGNr0XY3MRa2uUnMqpcyhq8TIW/HpQidl
         Iz6A==
X-Gm-Message-State: AOAM530Ibw6RCzu8ZFD4BV7mMMom0B1CvZ7Xv2l3mKAsqhGo+qMDSHc5
        ow83CQO3BiZAgvJgsO/DWJw=
X-Google-Smtp-Source: ABdhPJxSBd0ordI8c1npA88Ina6r+eyPMV31ugVml+px3ybGjsc5RHWR97LuxgY4kk2x4CJ0L41Q+g==
X-Received: by 2002:a05:6402:22d0:: with SMTP id dm16mr45386460edb.107.1629868804079;
        Tue, 24 Aug 2021 22:20:04 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id n15sm12854669edw.70.2021.08.24.22.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 22:20:03 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Alex Elder <elder@ieee.org>
Cc:     kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] staging: greybus: Convert uart.c from IDR to XArray
Date:   Wed, 25 Aug 2021 07:20:02 +0200
Message-ID: <1838037.Ul9q4Z07vA@localhost.localdomain>
In-Reply-To: <5541b638-db1e-26f2-2682-81f35504c9a3@ieee.org>
References: <20210814181130.21383-1-fmdefrancesco@gmail.com> <5541b638-db1e-26f2-2682-81f35504c9a3@ieee.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 16, 2021 4:46:08 PM CEST Alex Elder wrote:
> On 8/14/21 1:11 PM, Fabio M. De Francesco wrote:
> > Convert greybus/uart.c from IDR to XArray. The abstract data type XArray
> > is more memory-efficient, parallelisable, and cache friendly. It takes
> > advantage of RCU to perform lookups without locking. Furthermore, IDR is
> > deprecated because XArray has a better (cleaner and more consistent) API.
> 
> I haven't verified the use of the new API (yet) but I have a few
> comments on your patch, below.
> 
> 					-Alex

Dear Alex,

On August 16th I submitted the v3 of my patch ("staging: greybus: Convert uart.c 
from IDR to XArray"), with changes based on the comments you provided.

Could you please take a few minutes to review this too? I would really appreciate it.

The v3 patch is at https://lore.kernel.org/lkml/20210816195000.736-1-fmdefrancesco@gmail.com/

Thanks,

Fabio

P.S.: I'd also like to know if you think it's worth converting IDA to XArray in order 
to improve the Greybus driver in staging.

  


