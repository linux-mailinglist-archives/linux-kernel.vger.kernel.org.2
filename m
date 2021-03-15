Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6961633B0F8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 12:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhCOLY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 07:24:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26007 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229519AbhCOLYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 07:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615807461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Djr40beaGeWrfSFbq8+OWk3jVJgTwdTUkjAhT7wUxI=;
        b=X/Lq2yrpDLQkMAzmhDdtkYLGtqny9Rb9R5Ee8gO4l9BJRzENjzIAOu5l7sAQNdPLRE5FxP
        6G8GHuryW28ORMtUXRV+u2l6Pqx7E4x7oSEfWKBjTpvhFIKu4GFxq1QE2slBpVflfKq2YN
        Air4lFIxYNYdkQ5eIDtV0RafUcfRPlY=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-H3ctR4toO229HYRHOgrdUw-1; Mon, 15 Mar 2021 07:24:19 -0400
X-MC-Unique: H3ctR4toO229HYRHOgrdUw-1
Received: by mail-pl1-f198.google.com with SMTP id u5so13602826plg.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 04:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7Djr40beaGeWrfSFbq8+OWk3jVJgTwdTUkjAhT7wUxI=;
        b=ATzDtmxDc64mFI1PXDb+kGy68valZSkY3onWeC98OTZxbG/UA1nvllkD21BorMfjge
         Z8I5AojlICexZMdNFDx46ci6Um4Mvosa8Fn1VBBrukmsoeYaxMeE2hJxvooiinv7k2cZ
         uk2srMxUNwAItcendnV/I4NwDz3pYOOmc2fAKGIzjHHcjYn5n/EB3awNxldrfpX46q39
         bW8cRSFjE2mqXsMzbyFdG9lrx75s0a4kRe2cQLBlD/n3GTHD+FmxaLDkBwuWf+9DEUQM
         5qkbO1+74UCMMIzeseQVHyNnVd0jPvPB6wptCHclezWUAa3d6fuc44mRLzkP0DkIFCuQ
         Nz+g==
X-Gm-Message-State: AOAM532A2L0QeHDb/G+n/r0aj89lueDKpMvAGQxCm+RvuQkT2dS9/Zlg
        Ti4m14KOYF5SQJ2NJ4fD2LEIW1Rn1wF9OGWES0KGHv+5k/OKkmhDBdTUPiNmVWphvNflE/7g8xr
        Xz4nJiKBQHAbQeiimXFDQJUwl
X-Received: by 2002:a17:902:ec91:b029:e6:90aa:24de with SMTP id x17-20020a170902ec91b02900e690aa24demr11008536plg.63.1615807458335;
        Mon, 15 Mar 2021 04:24:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIitvZrdUzlaIbOdZchSoaAuYKimnbJJQE6hRD5fYanFfh+YuwpjLDpPgkVCD9jVV6piqWQQ==
X-Received: by 2002:a17:902:ec91:b029:e6:90aa:24de with SMTP id x17-20020a170902ec91b02900e690aa24demr11008524plg.63.1615807458168;
        Mon, 15 Mar 2021 04:24:18 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id gk12sm10830473pjb.44.2021.03.15.04.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 04:24:17 -0700 (PDT)
Date:   Mon, 15 Mar 2021 19:24:07 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Huang Jianan <huangjianan@oppo.com>
Cc:     zhangshiming@oppo.com, guoweichao@oppo.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] erofs: avoid memory allocation failure during
 rolling decompression
Message-ID: <20210315112407.GA838000@xiangao.remote.csb>
References: <20210305062219.557128-1-huangjianan@oppo.com>
 <20210305095840.31025-1-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210305095840.31025-1-huangjianan@oppo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 05:58:39PM +0800, Huang Jianan via Linux-erofs wrote:
> Currently, err would be treated as io error. Therefore, it'd be
> better to ensure memory allocation during rolling decompression
> to avoid such io error.
> 
> In the long term, we might consider adding another !Uptodate case
> for such case.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>

Reviewed-by: Gao Xiang <hsiangkao@redhat.com>

Thanks,
Gao Xiang

