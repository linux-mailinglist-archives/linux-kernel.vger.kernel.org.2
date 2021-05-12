Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5442937C2A7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 17:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbhELPMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 11:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbhELPFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 11:05:03 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E83BC061360
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 07:58:33 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so16811631oto.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 07:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iykaG1QuO5qEZs1ETSCytVqlMltBctwV3CQakGdsnxQ=;
        b=cNIQOnhGYgXqV/It6z0ALitchnraAAKPlsvAVjx5dDPpiUrnTH6sOwlVipGF5i4mo8
         lvLBghLlGAzTAvaGt/TIjH3vXJaIuDVjqdazab7KWfxvLdcbfuBlxWC7vFecEgGvN9fW
         fCT75y1/IQR7i0C/iUl7UZKFrCybCZQR0wdlZXkKTqILRQgurYrItOZx1W77HvgwyHRo
         DHj33LxMInsbH+/LUui8Mib60JifOPPmoBAdkr3o4xqOFXCpuAMUfPIbs4UffwSuP2OL
         fOkGiH1J4wWKbmSK0qmzj0pOp2iI8pJPUD10BSNwGqsLRebR+MuJGs2bLcscvyjbN7WH
         ihBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iykaG1QuO5qEZs1ETSCytVqlMltBctwV3CQakGdsnxQ=;
        b=IT9fO9YD8Ifm7XnGv6yzxvnY5togU4tALWKfvqHE6G2Qce3FuuHCQmI56ywvWZT3yO
         K2x+yLUXPj/p4UeO71Z+cdNw9ISKLsqp589Lx3sEelA0R9tfoRUDJxQulQayR8ZVhlC1
         0+On0+5/x6V3YfWVoExrj0s1Iw4iHbdXpmH0R5XvRx7ieT14VbnoAwZyzrZWvayNM+8G
         xf6DtrsmD213KVryzMOP43SAJVy7uSbZQ+JBmrnwdNkBWUChjGJlPZ+elMmTvEwIJwoZ
         KdZ9nC1HN45WCFlvu0rKpPdXojjzrmC8FbyVtYMvm9ZMBzRT5rwI8kfztYEIL6L39mAR
         k14A==
X-Gm-Message-State: AOAM530fmyWK0n/OcZEw+k5nOhY9sR8BMiyMEgS1MzFMXrx/8EOYdIYt
        LKuGU8tH4XFCPoGeKRIy5jbWHOwEA60=
X-Google-Smtp-Source: ABdhPJzZN5zhpCNe0QJ+Wt1+7aBQEqm+/EdV3TLqdFy7QVNXxftTOD53gkuuLeTIynk2FFtFgfhZpA==
X-Received: by 2002:a9d:7a56:: with SMTP id z22mr28260086otm.47.1620831513268;
        Wed, 12 May 2021 07:58:33 -0700 (PDT)
Received: from ceres ([2603:300b:7b5:c800:1cf6:4c9f:4e7:d116])
        by smtp.gmail.com with ESMTPSA id w25sm153167otq.40.2021.05.12.07.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 07:58:33 -0700 (PDT)
Date:   Wed, 12 May 2021 08:58:31 -0600
From:   Connor Davis <connojdavis@gmail.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] xen: Export dbgp functions when CONFIG_XEN_DOM0 is
 enabled
Message-ID: <20210512145831.gxmmlimkmnnb6zyc@ceres>
References: <cover.1620776161.git.connojdavis@gmail.com>
 <291659390aff63df7c071367ad4932bf41e11aef.1620776161.git.connojdavis@gmail.com>
 <0c1d6722-138f-62e7-03b3-a644e36d20a5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c1d6722-138f-62e7-03b3-a644e36d20a5@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 12, 21, Boris Ostrovsky wrote:
>
> On 5/11/21 8:18 PM, Connor Davis wrote:
> > Export xen_dbgp_reset_prep and xen_dbgp_external_startup
> > when CONFIG_XEN_DOM0 is defined. This allows use of these symbols
> > even if CONFIG_EARLY_PRINK_DBGP is defined.
> >
> > Signed-off-by: Connor Davis <connojdavis@gmail.com>
> > ---
> >  drivers/xen/dbgp.c | 2 +-
>
>
> Unrelated to your patch but since you are fixing things around that file --- should we return -EPERM in xen_dbgp_op() when !xen_initial_domain()?

Yeah looks like it. That would make patch 3 simpler too.
Do you want me to add a patch that fixes that up?

>
> -boris
>

Thanks,
Connor
