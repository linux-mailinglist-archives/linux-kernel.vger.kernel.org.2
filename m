Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C8A373153
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 22:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbhEDUXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 16:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbhEDUXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 16:23:20 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CEDC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 13:22:25 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id g13so6107631qts.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 13:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wZ5rLmppeNysLxYZlMRY8jT3QJH17/ddU1plSVt+R7g=;
        b=cF72n9KhM31XWLCoY/ufX4mETUrZ38iaDoUfd1+xvm43H8mPXEZGI0pqs9f+6D6d9h
         Ok7tJSLf/6lKgmaIwbNlPE+OebT8zWp+FBF0GMExzS90NMR1aABG1Dwh5cCUDZ+JF7TZ
         Fm1lOq+RaqoKoyNVUvMl/vrVH1CInEsX02qRZ0uBlpIfUWRjtWFyQSRYYi4qXcLXk/cs
         kEf/Cjjvt54bG7CGCFcywtU/hQGvUzQ896UGRSabKFc9z+TUis0+3phuclMpKdglKyJx
         aFOJh83FvkUe2ZfvVwvdCMakBnGHOQmMd95NIP4wlSzN/B9/NddTXbKP/ECO3QthX4c7
         r86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wZ5rLmppeNysLxYZlMRY8jT3QJH17/ddU1plSVt+R7g=;
        b=X5CCn2vwU/+axxzNpSXGFVE/1O0BqNpWusnbMyh7UBtHBlGhlwkPli168FFVe3FVTF
         Rw98ydkE6/vaVQBw5UJU59FWYnF82D8xRp0kf7d2z6b8P1QUM+RQ7Ix5L6ruQpp+/JMt
         W8b3RfWmUuQyFDmKNyrJrC/EA2w/3zHQrdZHkyStO/kiq86hzDoqRpz4Zpywkya8yq2Q
         797D6wnCEdJAbbmxTTW4lyHUR2uuyc1LNbRFNqOQlYooWH7+MqGluCCfhLIjfycxFeJN
         b8flrvgdsVaFECka13VCYSKwVRlv4MT+r1H22Nt+hyPo0KXLhBvbGPFRCU0MiBl7F4Aj
         k7fg==
X-Gm-Message-State: AOAM532vD0f+QCrN6UxTYNxH5r+iTPv4wci5cD67W9KRfiXdc1PDEqN7
        +Coz6t64hUvbtbXlT+i9KpoMRg==
X-Google-Smtp-Source: ABdhPJyYRkAsVpmjy6Fc0GkmgaKDAGK58ktBExQWeDqwJMdDAK85VOjhm89/mlyCX6knVm4j1UVIWw==
X-Received: by 2002:ac8:4a19:: with SMTP id x25mr20683950qtq.389.1620159744382;
        Tue, 04 May 2021 13:22:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id f5sm12471396qkk.12.2021.05.04.13.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 13:22:23 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1le1Yk-000nvc-GB; Tue, 04 May 2021 17:22:22 -0300
Date:   Tue, 4 May 2021 17:22:22 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@nvidia.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: CFI violation in drivers/infiniband/core/sysfs.c
Message-ID: <20210504202222.GB2047089@ziepe.ca>
References: <20210402195241.gahc5w25gezluw7p@archlinux-ax161>
 <202104021555.08B883C7@keescook>
 <20210403065559.5vebyyx2p5uej5nw@archlinux-ax161>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210403065559.5vebyyx2p5uej5nw@archlinux-ax161>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021 at 11:55:59PM -0700, Nathan Chancellor wrote:
> > So, I think, the solution is below. This hasn't been runtime tested. It
> > basically removes the ib_port callback prototype and leaves everything
> > as kobject/attr. The callbacks then do their own container_of() calls.
> 
> Well that appear to be okay from a runtime perspective.

This giant thing should fix it, and some of the other stuff Greg observed:

https://github.com/jgunthorpe/linux/commits/rmda_sysfs_cleanup

It needs some testing before it gets posted

Jason
