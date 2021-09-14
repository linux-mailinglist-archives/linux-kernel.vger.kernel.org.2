Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C5040B5FE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 19:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhINRge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 13:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhINRgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 13:36:33 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8AEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 10:35:16 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id n18so13406744pgm.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 10:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TCWXyI0dCA3o9LNo2Tto0ba1D/bVTK0K8ReDaSSLteo=;
        b=b7nxWKD6YEmrKpo4dDKxI+5EbtQtIWWCN/82l4Lkzwkyd/S/qHq1dm973Zo7LzF/OU
         MEyVcWvRsrwLgf1pGJhS7goyb4b1mW2+H0mz7yoEDowZAQ8vpX7+8BcGplLhEJUkLS7D
         AdQ7GuYw8N54jt3JZUQ+sPNYxkeHHO67vs3ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TCWXyI0dCA3o9LNo2Tto0ba1D/bVTK0K8ReDaSSLteo=;
        b=NFLToSgmNNa6mZLGam0nqIW1EjeC4GVs6TTR+5fXNZjHl1DhlefGBosdB6nlfGX5hK
         XT1p+iDxc2YUILM1chsuWpbyLGLSqCBi/5B2zL6jqJL1QefT28HjsNhrI3vs0hG2NQvO
         HqgM5JO9ipuSTuy9dZ6rt8zXdxI2vdsvhvBaut24cm77HBtTQcvtvLj5mPosRkjXJ1ke
         PWLGgNgAiP2qGHImiygPdI/4RWgKocXFbqnjG/jZQKVZUngaW/wZYZPjr3VM18Jw81Ey
         9WfZ4NG4dyRyhdHeRmHkaSakJUn6av1MPykzEsI0tGq3rs+PbeqJg/kqlYsrnBqJaufc
         SDow==
X-Gm-Message-State: AOAM532WtAcfVGpVlL6/p2OoKh7+kjld2Qiq2mRrSlrBciVkyt7HV2pW
        Pax8EEYWTTGu/mWvyox4fpn/yg==
X-Google-Smtp-Source: ABdhPJz17jxLnHVx4rwoyOeSwBGAvrT9WBmNn1DeeBhck/kFtTXqcSjH57M0itk9+Z7JC61/lnggCQ==
X-Received: by 2002:a63:1748:: with SMTP id 8mr16027568pgx.350.1631640915889;
        Tue, 14 Sep 2021 10:35:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x26sm11044067pfm.77.2021.09.14.10.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 10:35:15 -0700 (PDT)
Date:   Tue, 14 Sep 2021 10:35:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Ilya Dryomov <idryomov@gmail.com>, Tom Rix <trix@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/29] ABI: pstore: Fix What field
Message-ID: <202109141035.B5444836@keescook>
References: <cover.1631629496.git.mchehab+huawei@kernel.org>
 <b0ad4d3e915f2e1543b3037b43148b76d5480a37.1631629496.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0ad4d3e915f2e1543b3037b43148b76d5480a37.1631629496.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 04:32:25PM +0200, Mauro Carvalho Chehab wrote:
> If both /sys/fs/pstore/... and /dev/pstore/... are possible,
> it should use, instead, two What: fields.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
