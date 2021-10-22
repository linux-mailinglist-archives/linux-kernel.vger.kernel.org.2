Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B186437082
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 05:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbhJVDjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 23:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbhJVDjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 23:39:04 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21461C061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 20:36:48 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id t184so2109529pgd.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 20:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yAz64XIhlQBZNBnGUwXLP3Q0o9guBMfXqZK7N1tafFQ=;
        b=MdcbHbmYFrZwidG4ivVcTal/AQkZHXTHmq39wjDnqhOXA9a4irdjRi+0YKTGjAzqRQ
         u88ajkl4rXfp16U+pZmvH58tI+gHU2ufrB1hMcGCs4RRLOLyU3Pc7QQ+drpxlTGk5vht
         Cyw/+2WAz05d/Pp6hyRdO9yL+7doqlPu3obwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yAz64XIhlQBZNBnGUwXLP3Q0o9guBMfXqZK7N1tafFQ=;
        b=494Ci3oVaNrDY9hlbQFVx6Y6Xw4sWcPJpzWBbq1iNrHaO3mZUMLR8e72RC69BP0DWv
         NVT22WO2rEvM2P3JvcHZElYACkrxoBFszx5ipAInMOZRVF3gmeWYLaLqBMLIH8zEvLrk
         okURgnvmGYwoGiNyEoAv7YPHQJ+dxp9GfuMKL1VjKylQdQ+4goyulAsajnAGUpmUNYSS
         lFbIHMZlCh22XnUvfY9RPRZ9z4+EOEbx6ITBSEMDcfKEBxrZ5MnbcCB5T357NCC3tD9F
         /2GyaPVuXoNzNhcDYySxC5ziUMyaLQK8KLEE0C7BYZn/UnRUY3o3X6/0SKqWs4LPSR+K
         CoNw==
X-Gm-Message-State: AOAM532vlEqmt4G9an+7IoVSCIxxC6lez7YlICgx/os3wqH/f6Z9A9Eg
        BCGN6pUFKKu1Pz+SloJahx4CqUZl3j0X4g==
X-Google-Smtp-Source: ABdhPJzvAhuE3DUhREpm/Zrpa8iVn6im6hk5pYhPMaTiWlKwZplgxU7VUGTCldspVS8nhSS8uV06aw==
X-Received: by 2002:a05:6a00:1592:b0:44d:25e9:759e with SMTP id u18-20020a056a00159200b0044d25e9759emr9727922pfk.19.1634873807658;
        Thu, 21 Oct 2021 20:36:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i13sm6681083pgf.77.2021.10.21.20.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 20:36:47 -0700 (PDT)
Date:   Thu, 21 Oct 2021 20:36:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Yang <davidcomponentone@gmail.com>
Cc:     Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH lkdtm] lkdtm: Fix reference preceded by free
Message-ID: <202110212035.1680E1E@keescook>
References: <20211022012832.10644-1-yang.guang5@zte.com.cn>
 <CA+E=9osPJSZDqHkd0j-JwL7Tufs3vG3tRtG94+Rsdo4kVgBjAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+E=9osPJSZDqHkd0j-JwL7Tufs3vG3tRtG94+Rsdo4kVgBjAg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 09:38:59AM +0800, David Yang wrote:
> From: Yang Guang <yang.guang5@zte.com.cn>
> >
> > The coccinelle check report:
> > ./drivers/misc/lkdtm/heap.c:115:7-11:
> > ERROR: reference preceded by free on line 112
> > Moving the "kfree(base)" after using place to fix it.
> >
> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
>
> Please ignore this patch. Thanks.

Heh, no worries. It's nice to know that the Coccinelle checks are
finding broken things, though! :) (It's just that LKDTM is intentionally
broken.) ;)

-- 
Kees Cook
