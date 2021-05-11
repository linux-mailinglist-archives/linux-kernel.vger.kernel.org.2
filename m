Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74FB937A33C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 11:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhEKJPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 05:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbhEKJPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 05:15:42 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C015C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 02:14:37 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id a5so8574325pfa.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 02:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MZUwMDrW7F3Evf0R1tEZ2lDuKX+8VHxWwXnTrZD59R8=;
        b=T8zKyHJx9zmjPSqLIJWhuqF45cUPT+P00ADi7Lln6UxcB9loknrd2nF9OfxXFh4nGu
         /PT0fTTMu+OR0Xo0OoZBYUIvfPMKjO7+kCXgk7AJwZ6kyVXVCG406XWeBXm+lKgY68J/
         Xa7rsWBR0V3nqFQRc0d0daVpQdsKnQ2cB49LfcDMQ49YETCUS6jiP0ocJYsYmdbI5Xdg
         GY1t2WbhjZ8FocvytJkz91Gt6RseejMOP/2UetawuWaOnxWQN95zZ60hVLhzDggERur+
         OxSEGyLu6bAXvs8LHMkXQlE19pk639BQtP1rMtl94GIbxAGyQ7VSp7PrFHt6TwZEWwHB
         sO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MZUwMDrW7F3Evf0R1tEZ2lDuKX+8VHxWwXnTrZD59R8=;
        b=nyJcDNmfwtNmz02C9pMnFFLI2TwjUzXha1HhWa71wzRiXQIj+lunrAN6EhddTcNPkk
         AdUYzgMX/jMmhwig8ZAt/fLV+W2rbWLFU9eJNGJ6XlT35+pAbFdVFDakAHZI4GLj0+/5
         GqCQp7cSDnksjQHU5gbB1ruoZ13jVNb/7LEEDLQQq1Z9s64pFwxjtsAgK9Eez9rTmerJ
         RnrVlKVOvRoPg0PP5jAbsy9idvNzPR/ykFT06e78Z4p5znoBl6Dj+jtg4aFXOB9Di2kK
         gl74j7bn56wluq4z9fwPcaWGNe2Kj6UtK2PTeVzQlkpPg4ynPHDZ5Xb/wM89sYLW1N73
         Dqcg==
X-Gm-Message-State: AOAM533qhUlzM35M63Bt+y+hg+m80S1ymE06cS4GwZ8wRB61XTJorwk4
        uTAoj+RjHmDns+IuMgM8Ozo=
X-Google-Smtp-Source: ABdhPJx7TPNlY884f+8LZnhFY1pwRaWZ4eYwlDWKx0PhjyHI56q3JM/v0lF76RCus/AbO4zvMmDDiA==
X-Received: by 2002:a65:464b:: with SMTP id k11mr30239145pgr.407.1620724476686;
        Tue, 11 May 2021 02:14:36 -0700 (PDT)
Received: from hyeyoo ([183.99.11.150])
        by smtp.gmail.com with ESMTPSA id t4sm13400088pfq.165.2021.05.11.02.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 02:14:36 -0700 (PDT)
Date:   Tue, 11 May 2021 18:14:31 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        42.hyeyoo@gmail.com
Subject: Re: [PATCH v2] mm: kmalloc_index: make compiler break when size is
 not supported
Message-ID: <20210511091431.GA144819@hyeyoo>
References: <YJccjBMBiwLqFrB8@casper.infradead.org>
 <CAB=+i9QyxOu_1QDfX5QA=pOxxnRURPnwd2Y0EbhoO1u0e=irBA@mail.gmail.com>
 <c305ec02-a7d6-dd0c-bfee-e5b571d9ca9a@suse.cz>
 <20210510135857.GA3594@hyeyoo>
 <9d0ffe49-a2e2-6c81-377b-4c8d2147dff8@suse.cz>
 <20210510150230.GA74915@hyeyoo>
 <90591d7e-41e4-9ae5-54ae-ded467c498cf@suse.cz>
 <20210510153846.GA77398@hyeyoo>
 <de465c4a-d99b-b9da-49c7-6c767918fe78@suse.cz>
 <38725980-4f69-a7d7-35c0-6c4ff2e01cfe@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38725980-4f69-a7d7-35c0-6c4ff2e01cfe@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 10:37:20AM +0200, Vlastimil Babka wrote:
> >
> > I think it would be best if you sent v3, the way you did with v1 - inline. With
> > v2 it looked like a mail body with you message and patch as attachment. We want
> > the testing bots to pick it up and they might work only with inline patch. Thanks.
>
> Ah, you already did. Good.
>

OK, I will not send patch as an attachment later. it's first time for me
to hear about 'testing bots'. is there a documentation about it?
