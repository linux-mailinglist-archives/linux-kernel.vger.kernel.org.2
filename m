Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74E839C2DD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 23:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhFDVtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 17:49:24 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:34460 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbhFDVtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 17:49:21 -0400
Received: by mail-ot1-f44.google.com with SMTP id v27-20020a056830091bb02903cd67d40070so7399512ott.1;
        Fri, 04 Jun 2021 14:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a59inILICOBzct66fXJr59tUQJdnmp6D6I444QNjgWY=;
        b=Pk5fNcthUJq+4GQ9b5XpoJqQAWoXyRGOnSEp42KJLv1vDstj20UB+aX+7dajwtBcFj
         lDyq1UGKu8sNTs2AG+Y1OLEqJCl+SdCpITLLg+QE96KVC8He2jICNbDBdoflsEuP1oYu
         xpIjppKrDvAoO9tkXaN+uA8UW/p8HmKOOKfVA14wpHxywQKyj6BkJLst5LTg4zE/eh4s
         VM6ZrpIYsvI5sltLbOGzm/nm1Vnr1JNL7IlvgZ9iE17EmgpKtQUn122jJa826pnoKPYl
         MmHFlYGNTHEUO6v25X3sZgFi4TCUtfgrhjfcLjF+p8f83bEmY18h7/awyPDGx5i2V1oo
         ZVZg==
X-Gm-Message-State: AOAM532Og0q7q6Qic0F0oqYi3x19LNpjqDawEi7D7fpxG/tyHt3OvK0F
        p7yL74juJ+sMHD3Blr4PI0wuqgsxJA==
X-Google-Smtp-Source: ABdhPJz/qMxhkBvpaJIm9vWrbCcREDE49SOTdKRiPP6AYR4lAtQuVOoRIkZo67fv4atmxYFUmkDRvA==
X-Received: by 2002:a9d:6f93:: with SMTP id h19mr5303533otq.292.1622843254297;
        Fri, 04 Jun 2021 14:47:34 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j26sm735171otp.15.2021.06.04.14.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 14:47:33 -0700 (PDT)
Received: (nullmailer pid 3981417 invoked by uid 1000);
        Fri, 04 Jun 2021 21:47:32 -0000
Date:   Fri, 4 Jun 2021 16:47:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] of: unittest: Use DEFINE_RES_MEM() to simplify code
Message-ID: <20210604214732.GA3981358@robh.at.kernel.org>
References: <20210601062223.9724-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601062223.9724-1-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Jun 2021 14:22:23 +0800, Zhen Lei wrote:
> No functional change.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/of/unittest.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 

Applied, thanks!
