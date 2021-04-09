Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC00E35A68B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 21:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbhDITCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 15:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234825AbhDITCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 15:02:10 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053A8C061764
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 12:01:56 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a4so6610492wrr.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 12:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TYvRNFEFPSE+z1sa0+NnEaU3aTLadE1XBWABqAHCDrA=;
        b=GL4glA+XfI+5dwISOImLfOVy6KK+9uj1FRRoMsBevZYzhKlZpRZikRe6Vz15h6lIRi
         AsWw6s6hUsYirZvn9j8E1Ks3iDWD8nfNNUfiQEgz+9IDxFDEc1Cz0ZON7NHl12rPuNKW
         ITdHML6/UjWfEsx/yuBr6ms+lS/2R0wZ9BwOIFXcrcLBsV6mL8qBDovdGayG8FaV6Wf8
         5JeSLeR6XQ2LRo3hYh99ocPD5WbM/PWG+bKMua9G2iXwl8Cvy3+vxpDDd78+ObFlVRPq
         EAj/+etfj+QVDBb9lZEUNyDVYieq4ROlHennZ5lNUAiKASB575jd5G3Fg0OLCNEB2SwN
         LA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TYvRNFEFPSE+z1sa0+NnEaU3aTLadE1XBWABqAHCDrA=;
        b=mN2PeveWgAhhJlFP12a1A41lsEwgiIN0FV/3+ohg0YTeD1kg//s1D41BlpVdfwDO5H
         rXTmN9vkp1kq/LNyIcMkG/1pBqHd6gvYT36QNeX/EUtXXg4fI208vPd26tbdJ6HuDg15
         iIL/ZmGeDMj0Ieztpe7xJUcHZBnivcGUAWIjej79IcYEVb3t2Hipl/WKmwtcG+F/hGn3
         mGNg1qea0tpyGFmh4ekVFvZN43LogWI/OsGzk//imKmKE7eJFjTupasZ7kv+M+yx6o7i
         WQTKnI7HD5E/+S/iPyT1ZAspwIl4J7yTfjGyH49PAPN7gZTZigZIkOBkACj7yL/osFRO
         JXNg==
X-Gm-Message-State: AOAM533uLZ44YPPmo6MQeGcB7XUyAxToVQtV1esMq/UKjcZWE22ZT+mO
        6TVQ+rCKlLrOS7tbiLfkg8V43g==
X-Google-Smtp-Source: ABdhPJzN4HISy8kMoayr1DePmSSMkapwFKAgfUjwl2MkrEZzrXlNlNiAKOUqbBMnV5/tRTsMJc4PGQ==
X-Received: by 2002:adf:f405:: with SMTP id g5mr18414472wro.279.1617994914782;
        Fri, 09 Apr 2021 12:01:54 -0700 (PDT)
Received: from apalos.home (ppp-94-65-225-75.home.otenet.gr. [94.65.225.75])
        by smtp.gmail.com with ESMTPSA id s8sm5745590wrn.97.2021.04.09.12.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 12:01:54 -0700 (PDT)
Date:   Fri, 9 Apr 2021 22:01:51 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Matteo Croce <mcroce@linux.microsoft.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
        David Ahern <dsahern@gmail.com>,
        Saeed Mahameed <saeed@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v2 3/5] page_pool: Allow drivers to hint on SKB
 recycling
Message-ID: <YHCknwlzJHPFXm2j@apalos.home>
References: <20210402181733.32250-1-mcroce@linux.microsoft.com>
 <20210402181733.32250-4-mcroce@linux.microsoft.com>
 <20210409115648.169523fd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409115648.169523fd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 11:56:48AM -0700, Jakub Kicinski wrote:
> On Fri,  2 Apr 2021 20:17:31 +0200 Matteo Croce wrote:
> > Co-developed-by: Jesper Dangaard Brouer <brouer@redhat.com>
> > Co-developed-by: Matteo Croce <mcroce@microsoft.com>
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> 
> Checkpatch says we need sign-offs from all authors.
> Especially you since you're posting.

Yes it does, we forgot that.  Let me take a chance on this one. 
The patch is changing the default skb return path and while we've done enough
testing, I would really prefer this going in on a future -rc1 (assuming we even
consider merging it), allowing enough time to have wider tests.

Regards
/Ilias
