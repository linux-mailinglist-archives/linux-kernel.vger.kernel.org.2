Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED61742C780
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 19:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbhJMRYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 13:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhJMRYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 13:24:00 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B367FC061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:21:56 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id a7so8170042yba.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yf2lvnswxZG12HrbiFNmFCi5hHNaSndx6XO9Nz3lj8c=;
        b=V7nr+D7wCnJEBfynTZO0PhEqS6UapnKxJOJkguZY+vMmdaQ17lCEEmzCLFyxylxuyz
         a20RweKYaPoaYuA1MMvZCOznohi1jI7zxG05ktw5kneqReGiFYT+e+yPHqWgjiT1o/qO
         FRnLV+4XByB9YvRGvdjH2kuvJmcQpkcjXJR23BApUtB1KwqTIq4ANjMn3j4viFgdhNk7
         Qsg6YxK3Bh2bx1T+lY8uhMoHhBr3K6XnHxjuTj6dimgkh+mDa3PPrunhZtNpP4iiM6e2
         F668m0e0rC9v/2s4rulsoEJOa2XeS39UdYrilj15pL3DFtRi+2wuCZ0/85QNsmcfQKpe
         apcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yf2lvnswxZG12HrbiFNmFCi5hHNaSndx6XO9Nz3lj8c=;
        b=IYrnOntqnAwDxJSdXzOS7pp5DFYmbRHS17NUyelN1ONRdRCfX09fCS+iMqBXNGWtZ9
         gTJXhdaG5A2xrUQyEkrOq52CRaD70eQxPHAPWdMGcmsIOnpBfE6JNfhY69XlYNaRtJx3
         SGvfs9N+LFPMhsBsqEH5qTSSTdb+QUJcSdACisM3pQb3zT8+DibxsAra3hW7Zxgo72NW
         lW23pKDZXpnrWMbl/+J4nj5l8w2ztVHyi1qk3p4FpT38ln7iOICKBmYn3X/9/uslomvG
         EbnIXNIcnyi2lWVSaK7KnSotPDsi7rUSDaZgDj60AkfhIrI1i28lQfmD9bFxxlv5VWtg
         gv3g==
X-Gm-Message-State: AOAM532jKWjtcDDLbirsqwOIaJkKAQkMYbepdT97/bQS5UsVOfU5oMPH
        XOWgfdDfdwW9YrsG7d+i2Jx0/CkXejSiwsXdlGOSX/l2NYa1eA==
X-Google-Smtp-Source: ABdhPJwnnMUc+Wua5vM0/raYMLpof8dp6c0NLJvcYQJ3SrpJn+DquLRh0Sa9lrkrSBiQf7zwIZQ3o77FRAQ2JAVDhOg=
X-Received: by 2002:a5b:783:: with SMTP id b3mr704817ybq.328.1634145715727;
 Wed, 13 Oct 2021 10:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211013143707.80222-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211013143707.80222-1-andriy.shevchenko@linux.intel.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 13 Oct 2021 10:21:19 -0700
Message-ID: <CAGETcx_mNWumqmYzytvKG+FvPLA=DWokbbtFv=EGet41G6cQeQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] device property: Add missed header in fwnode.h
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 7:37 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> When adding some stuff to the header file we must not rely on
> implicit dependencies that are happen by luck or bugs in other
> headers. Hence fwnode.h needs to use bits.h directly.
>
> Fixes: c2c724c868c4 ("driver core: Add fw_devlink_parse_fwtree()")
> Cc: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Saravana Kannan <saravanak@google.com>

-Saravana

> ---
>  include/linux/fwnode.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 9f4ad719bfe3..3a532ba66f6c 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -11,6 +11,7 @@
>
>  #include <linux/types.h>
>  #include <linux/list.h>
> +#include <linux/bits.h>
>  #include <linux/err.h>
>
>  struct fwnode_operations;
> --
> 2.33.0
>
