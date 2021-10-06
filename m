Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E350424691
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 21:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239248AbhJFTQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 15:16:36 -0400
Received: from mail-oo1-f53.google.com ([209.85.161.53]:44892 "EHLO
        mail-oo1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhJFTQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 15:16:35 -0400
Received: by mail-oo1-f53.google.com with SMTP id e16-20020a4ad250000000b002b5e1f1bc78so1156053oos.11;
        Wed, 06 Oct 2021 12:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F2u+l/lmYmOhB5qG5+bzuACvdjgmAdllAL4afyPVf8I=;
        b=H/8M+xtGLAMoA1hJD/tcKHuQqN3VtwrXtrDiK09757ynvABp+3mdEnAEGm2vlwbjAs
         w9bWnhlEQLPKR+3qzk7Ih8/wZzSfBKlnvKd34O8NPcvSHqIPDSJGhUY5hsQXNE0kPgnv
         k8EJd+CS3tAfp0J8qEilhtKWstrXrWVNd6edolCCsFJejg5nvGcVgfTZFfC/dhQIr4D7
         2WtiP3rJ8aCeBCD+HgBYS1IT627xyB7gVQQME6WVOqAzJaXbA67bpebdrQDEssb7aYWw
         pzoZk+yhTtv5pf5ubMYOKmB+LCoQFHv9oPmjr1vSaS/wJJkbVEA9BejlsJI2t2kGu5qu
         AHHQ==
X-Gm-Message-State: AOAM532F1kaqqg6UINSfXiD5p2GrYrYxeO5u3JC/ADCbdSRmVD2SGCXK
        RvJdjugMi6F/9NU7j9gu5Q==
X-Google-Smtp-Source: ABdhPJyGrxWCOpNPPLGYwRvElOIPV41kNWMelDN9N+FeSrmez82iHIoUOO7fZBPy3ySVbVV/8PSdWA==
X-Received: by 2002:a4a:d088:: with SMTP id i8mr64515oor.17.1633547682230;
        Wed, 06 Oct 2021 12:14:42 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o42sm2875975ooi.9.2021.10.06.12.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 12:14:41 -0700 (PDT)
Received: (nullmailer pid 2249766 invoked by uid 1000);
        Wed, 06 Oct 2021 19:14:40 -0000
Date:   Wed, 6 Oct 2021 14:14:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: remove duplicate declarations of __of_*_sysfs()
 functions
Message-ID: <YV31oO+MV6z2qoDO@robh.at.kernel.org>
References: <20211006061943.8472-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006061943.8472-1-zev@bewilderbeest.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Oct 2021 23:19:42 -0700, Zev Weiss wrote:
> When CONFIG_OF_KOBJ was introduced in commit b56b5528f5b3 ("of: make
> kobject and bin_attribute support configurable") and #ifdef-ed
> versions of these declarations got added, the originals didn't get
> removed.
> 
> Fixes: b56b5528f5b3 ("of: make kobject and bin_attribute support configurable")
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  drivers/of/of_private.h | 8 --------
>  1 file changed, 8 deletions(-)
> 

Applied, thanks!
