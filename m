Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C5F35AA89
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 05:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbhDJDg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 23:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhDJDgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 23:36:24 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B325C061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 20:36:11 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id z3so7944910ioc.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 20:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=daL6soG/LrpwywjD7Ye7mA6cNwbKbr4iQbT4lP+NwEM=;
        b=aZvZdzeLjBlNJV36cLN1bMrDa0dtnuPuH00CSidpIvUvux5G78RMK2a6LP1MwtUzpr
         SSjCH2hamMYYzQerdHjchdQMNOFL5PM8s7JYZS8/YZe0DXxBYQ8K6Ui8LFJks3fBDrNq
         e9fw1dCHlR1PlOboZRKN+OneaOtZDxF4AiTat0hy3ofg9r15o8sDlzezzYN5uBzolgYQ
         ubXwU4dGd0hR0GlLcujgDlz2dknGxW7cFfLgyxic+oaVEokFKE5DL3glYhZ0qTg6+OEA
         bKgAZHM3xeeDrsdSN1jIXX1QGAu5P1UX3WOqqLmmmXhXjOB3DHlKYaPXaq8xu3tQEJnD
         3F6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=daL6soG/LrpwywjD7Ye7mA6cNwbKbr4iQbT4lP+NwEM=;
        b=Y7ZSgu5Juo/JOcBsrNHYrYD60upISnCky/hbvLvCeBGKRHInFJ0KTi7kN/Vd60rfHm
         WnHn3yWmujJs9Clk+UNBCnfQ2hfHnIeF9B/IpRwTA4k5Pdto+abnWPtxedzbjX/mvvVQ
         ELG2s742UFogYrMekNFHMqzQ+8skHeArtl5kFxZMY44re2V35BZLuG5ezyi1jmchaowh
         9BErmJVaSnfYpMuerWcdJ9oZmFa8dITTYh3tNSQB+bKRn7GG5uCk06sH0UNcmGMniPqW
         AELc0SdLCkrBaUAXeO568PNuoW0Gi6vO31Qniq9iqQhbD39LvcqonXixTKtGkB8lUO9C
         APzA==
X-Gm-Message-State: AOAM532uOSGxhncOLGTGc2BX1/Vk+ykbCAlboG19dKKBLYeMQB2CM1Oe
        G6Pk2b1llCSGfIYAWEf+mhgD40Bf0s1pMvi011V1sQ==
X-Google-Smtp-Source: ABdhPJwv09+tYGUZsmPinlJUc4NnAl6vn5Qg9uNrthhS28+Wdbxeric036UalSMhJyiPbon46hBWD6HwcJGkRwQgq4I=
X-Received: by 2002:a6b:8ec2:: with SMTP id q185mr14109157iod.150.1618025770259;
 Fri, 09 Apr 2021 20:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210401183216.443C4443@viggo.jf.intel.com> <20210401183225.2EDC224F@viggo.jf.intel.com>
In-Reply-To: <20210401183225.2EDC224F@viggo.jf.intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Fri, 9 Apr 2021 20:35:59 -0700
Message-ID: <CAAPL-u_8wkxLbq6g0dRkhNni11+kTgjRkjUg6meXuGiS5wQtig@mail.gmail.com>
Subject: Re: [PATCH 05/10] mm/migrate: demote pages during reclaim
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static unsigned int demote_page_list(struct list_head *demote_pages,
> +                                    struct pglist_data *pgdat,
> +                                    struct scan_control *sc)

sc is not needed and can be removed from demote_page_list().

Reviewed-by: Wei Xu <weixugc@google.com>
