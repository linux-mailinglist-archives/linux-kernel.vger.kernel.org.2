Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718E6379D61
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 05:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhEKDKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 23:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhEKDKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 23:10:15 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E815C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 20:09:09 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id j12so8688666pgh.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 20:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vDycCYZUMZTRqclL05OsIOu92QLf1/h6CaOCTWyUtQo=;
        b=Dhn/BhszXa2kmPxmeAjJZYOD5Q7FN+5J43AnvUof7WBdQWttlGaEwkvQQgWAjXaE9u
         qJOZ/yX1ulX4HuW7ajZ6GdoCulDHmG8cQswpAnl3+iJL8DOgHsVLW1YyYB4LYdGJZNwM
         AcMlHdcxwlaDuwr0hSzgL6r2fUoWKQ/77/FmOpBUh49HQv/HDBJmTIoO5nqiqGYhn9zb
         ywTZkmiylk4imwnye5wkH+Sp5f92j9gZCLkOTO97qVPSmpbMp8Ei60l4a+1k+LDg+b9T
         Ki3KkwIZB6ZLy124T1rtAfmH9ZUwN7k1Uj6aql+DKdQae9U7Q0dML4K8qQvKwamwtO78
         Cf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vDycCYZUMZTRqclL05OsIOu92QLf1/h6CaOCTWyUtQo=;
        b=kgXzl90uTUcHDAqPkvswT7PA5QX7akpLVP89VqrcDAjE2526GS76d7LPSiixyNquVH
         xXDeEIeSFNBNDkHqyZBI8x3IYosQ35oAkzdI3aghOQxkPrEYtym/Y3l6Z1WH0W9w/d+x
         q3FpSBNV8Dx5BjzOszPO0uOFqudfHGmBxn1XxWo8xOTLRbfpwp808ue+SxCQXu1oGDuC
         49ZoKq7UvogCZVa5uth6blrEP7usxFxBZ8AZgt3PpM19S8Cn4I4E45YUCNWxwuEfnF0d
         dnCPp+DH7aTPw9uQZc05aSN2ghpa5XkFDA/OYt2/NRNomtfxzm2iVpDRkkhS1U2NNLgg
         f8Aw==
X-Gm-Message-State: AOAM53066/zY3zgBBvJ7MnWZQ5h32/WkmIzK/Ympqjb6qRRQ79cpRcNE
        YdakQyXy20OhY/y/n5yW5oY=
X-Google-Smtp-Source: ABdhPJxISlNL5PKuFc7Rg+E15Siv9zOgzobxSxMwxXxHlu7yfVRnn/rquLYu7UIk06fA7eJDL9CrNw==
X-Received: by 2002:a62:1c0c:0:b029:2b7:6dd2:adb3 with SMTP id c12-20020a621c0c0000b02902b76dd2adb3mr12703106pfc.44.1620702548963;
        Mon, 10 May 2021 20:09:08 -0700 (PDT)
Received: from hyeyoo ([183.99.11.150])
        by smtp.gmail.com with ESMTPSA id 33sm12156742pgq.21.2021.05.10.20.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 20:09:08 -0700 (PDT)
Date:   Tue, 11 May 2021 12:09:03 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: kmalloc_index: make compiler break when size is
 not supported
Message-ID: <20210511030903.GA105690@hyeyoo>
References: <20210508221328.7338-1-42.hyeyoo@gmail.com>
 <YJccjBMBiwLqFrB8@casper.infradead.org>
 <CAB=+i9QyxOu_1QDfX5QA=pOxxnRURPnwd2Y0EbhoO1u0e=irBA@mail.gmail.com>
 <c305ec02-a7d6-dd0c-bfee-e5b571d9ca9a@suse.cz>
 <20210510135857.GA3594@hyeyoo>
 <9d0ffe49-a2e2-6c81-377b-4c8d2147dff8@suse.cz>
 <20210510150230.GA74915@hyeyoo>
 <alpine.DEB.2.22.394.2105101714170.749526@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2105101714170.749526@gentwo.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 05:15:23PM +0200, Christoph Lameter wrote:
> I guess this needs to be reviewed and tested by the users of architectures
> that can use large MAXORDER pages such as powerpc and Itanium.

as Vlastimil Babka said, I think it's fine too. because
KMALLOC_SHIFT_HIGH can't be bigger than 25 regardless of MAX_ORDER
