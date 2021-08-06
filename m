Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344043E2724
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 11:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244447AbhHFJWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 05:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243821AbhHFJWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 05:22:41 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AC0C061799
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 02:22:25 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ca5so15678486pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 02:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4e0e8RzJHNC8NMBSDrNb+O++Kfle4Og9kFyfQoKTp+Y=;
        b=tPMSFqN689ucOJGdfodJAUX/dWUYhOjpbSQcBsw6vVF45SJ4pKulia0I5G16s0U0Sz
         qz2IuEh7v8QBo+H6S1XLE9A9+d/TXDE/c1d0B0elSSP+St7keSGj6UFYdKmyJWlhjpG2
         ydyRRN7cbFlIHm010nv/ypG9aE9sE1pMjOVrAVg3NnuyjryEf0GmG74LMcFrknqWdelw
         bqPRwFvY3n0vlEw5bFynzJm/99MzXSxgxOW8x3gOlCdz0lvTGAqYsrh4CJSMYHVuogFp
         xmLa9psx+JbOcQJBxdDR9BfRw8DB2IYJnvN20vE5WN9i/bfpeo05FXQ/TOTdX8MNerRw
         kR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4e0e8RzJHNC8NMBSDrNb+O++Kfle4Og9kFyfQoKTp+Y=;
        b=HPwOYh4TPtGnGXh1L5BniMj8xv0Y6DYG2T4HWuoFjfDR6OOfgT82UlbePAbKmaBrnH
         PGKrs8Ez1HuakvKa77czs8KMzOhnnelXU8EkQoKsnJvOWLz6LYVHwP4aBswyH6SWj56k
         4cxcDiTG2UvGNnBNpKnDoRX5feks8p7Y5Wa6NoRU8lKPf5ZB3qBhyQEay5Tb9EDnT6jv
         l4Q9jCZEmrMThamSLdpLYr9AgHSNuvPipgEgeRbW50DMh5ppGKlvqprlIAMuZK9Dp0O9
         4qyJDL3etXwOaHobHl4nXWB4ZdO8Fff/RSQNO9BskE+cebHa4BXqyLEw4CK/iNaiwQeh
         yRCw==
X-Gm-Message-State: AOAM533gjOdF+WdT1zXJ+mcAKD+SX72taLGgq+1DQoASQpONSAUb5M2Q
        H6JQ8b7jYrtWoVU5cXqOVVTFAMaNZAOm7DEOeb5xxA==
X-Google-Smtp-Source: ABdhPJxtO9TQLjXBXT8b34CKFnwdZ8VY47y9UF1MPjqpnSRcDVModYWb7Ko1e3WykXeNwqXC1OCEWgHry60+UoKXx68=
X-Received: by 2002:a17:90a:5982:: with SMTP id l2mr9575814pji.18.1628241745166;
 Fri, 06 Aug 2021 02:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210806085413.61536-1-andriy.shevchenko@linux.intel.com> <20210806085413.61536-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210806085413.61536-2-andriy.shevchenko@linux.intel.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Fri, 6 Aug 2021 11:32:05 +0200
Message-ID: <CAMZdPi-OWJBwso=ZMA7E0VKck0wGt-RsbTMBSX+q118c=TSPsA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] wwan: core: Unshadow error code returned by ida_alloc_range))
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Aug 2021 at 11:00, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> ida_alloc_range)) may return other than -ENOMEM error code.
> Unshadow it in the wwan_create_port().
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
