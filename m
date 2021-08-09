Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFDF3E4F4C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 00:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236725AbhHIWdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 18:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbhHIWdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 18:33:31 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B89C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 15:33:10 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id bo18so8205396pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 15:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TefWK4ORv5P76L9T9bq6hCS6/Opnu30hSduPptTq2Cc=;
        b=Lf/FcPwAfsKoGxb6xMYqdDvpmQv/nKX36o4A2N86l2vEOlpwwtg1aML4qw/m2ohMNx
         ZW+IpkUOSue/FLgSQ6NGBuJ7k8jKKEFDGb7B7UkgQjTyUZ3dQm588hxMIIlgQ+0UUK2z
         rywhKrvMBCvLIZPXrUYvAqkVwXzx3fWDmE5Jpiq7nssTQGc3aMkpUSaXX5Bb1wVwoZg3
         BYoeO/LKUTLGKcKKBxSGII8cnX1FQgIp+3/4kw6rrLJIpfWEuOn3r6j75qvMkJitPdSZ
         1ENBDnDS9PBLpsxwlLw+B2nFCglv/pcyJr8uRhT68YQw77XgNW1CJmC9DrhldiYp1zxR
         aaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=TefWK4ORv5P76L9T9bq6hCS6/Opnu30hSduPptTq2Cc=;
        b=f+xlyh7mlXygTrGsQ+x6qRcCWQpZV+AaYnsgD09dePe78WTZ2W22LZU0Yc6mQ22aTy
         eqGrljhCww7Vnf8uGvxB/pl643Q1za5Wo627XhXUdmXEIEitFkq/qgAM5NdLqe+zGDZP
         JnLL/lZbz+un5t+TDGuukDoMiGEim7c6CanBpuyZmLfsn4n7VeIclMBGTQxCq0WNN21n
         jN+pwNuxrQ0CSZol1ZP0KyeERTK2wA9DcJ1lro4VKf6rbpx2YwjTciPXmfTR6cKnY138
         dP6etXqzQYg/NnPIZMpibKeg3y2CMs0wj21/RDoRNIT5CTgtkQVtAe0UmDB0h47Nmtsg
         bkQg==
X-Gm-Message-State: AOAM5309HyKBL78qfKvnKebJzzgjTcNyWqbgskcFaVFRKcnXyxnmKw6w
        wDOTu9IV7hdDAIGEF68Rrfk=
X-Google-Smtp-Source: ABdhPJyZuEo+mw3sjlLpGzkgHLnPNgznU1yw3+XjcQhVuVzwmX3D6RbYDE7zscbulhLBZgySxyraLA==
X-Received: by 2002:a17:902:d2c8:b029:12b:84f8:d916 with SMTP id n8-20020a170902d2c8b029012b84f8d916mr22568454plc.75.1628548390186;
        Mon, 09 Aug 2021 15:33:10 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:df1c])
        by smtp.gmail.com with ESMTPSA id l185sm13840888pfd.62.2021.08.09.15.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 15:33:09 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 9 Aug 2021 12:33:05 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Replace deprecated ida_simple_*() with
 ida_alloc()/ida_free()
Message-ID: <YRGtIXyY68M92gcT@mtj.duckdns.org>
References: <20210804035036.2211-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804035036.2211-1-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 11:50:36AM +0800, Zhen Lei wrote:
> Replace ida_simple_get() with ida_alloc() and ida_simple_remove() with
> ida_free(), the latter is more concise and intuitive.
> 
> In addition, if ida_alloc() fails, NULL is returned directly. This
> eliminates unnecessary initialization of two local variables and an 'if'
> judgment.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Applied to wq/for-5.15.

Thanks.

-- 
tejun
