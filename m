Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B7839470C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 20:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhE1Sbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 14:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhE1Sbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 14:31:36 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC1EC061760
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 11:30:02 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id r1so3147034pgk.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 11:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=EGHqrEMGXipW260wL9e/5m8Y+Rr91bjvhaCLdwVTOKE=;
        b=TMBHE7Dzx+kLtluO0DfnSmpBZslI24A9D/yX/xIXihPnuu3ALZ0CELPmpIoudA2UIu
         nINyYNbLQXm2qqMTzPPl0BR7fcXQFbZbZrlaXcJzje4zjWTClXplinM7maHj8S6xSfgJ
         cg3lKhv22C3bgSZF6T3a/NL8QW29BwARD2YO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EGHqrEMGXipW260wL9e/5m8Y+Rr91bjvhaCLdwVTOKE=;
        b=QWbW2rxReb+2rkxO1dfQu9+j3OyRPTJ/CoYOidEyFVMJCm5a5BaUz9HH/lx5vPOvGm
         Yzu2QFmTqwB3D58UKgNXTfsp49ibWN/sfdewBabSoZhAVo9cwoaVM9jwveoN3Ygv4fR6
         ltXdn7LqcLKLoFTjBdMomaDK0CWDyB6k41YdzEfpH9d+L9mYNvBoS//+NDWpjxTMtNXo
         +PLng6H+DhgbDShEeAiuXccKOPpQsoTv9phCnAxzmQQI2a2KrArfrP98HbGIHIBqVaPp
         f4oP+4MMdmNWiWPdGFxK/Yxt+SCwfnvbMvzqsHG4JvnvdWOMyl7rLQJm7VwJWRRrc9vU
         UonQ==
X-Gm-Message-State: AOAM532oyoOZMAhNgbVp9u7po/Tx4tQH7t5eL+CRNGVwkJKS+Afksfc4
        EZmgDb3Gz7/yzjouMBa8bpivEw==
X-Google-Smtp-Source: ABdhPJznNQfA46ySsxcKLEL5mjP1zAQ71CJPkoHDxgnWnwhq4gTfJtmOGNYv7yDtzcdsaNGoqO0JVw==
X-Received: by 2002:a63:1e1a:: with SMTP id e26mr10105503pge.240.1622226601419;
        Fri, 28 May 2021 11:30:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q23sm5066362pgt.42.2021.05.28.11.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 11:30:00 -0700 (PDT)
Date:   Fri, 28 May 2021 11:29:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bradley Grove <linuxdrivers@attotech.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/3] scsi: fcoe: Statically initialize flogi_maddr
Message-ID: <202105281129.530BBAF694@keescook>
References: <20210528181337.792268-1-keescook@chromium.org>
 <20210528181337.792268-2-keescook@chromium.org>
 <8a64b62949477b85576ab47e4705ca13fb555a9c.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a64b62949477b85576ab47e4705ca13fb555a9c.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 11:28:59AM -0700, Joe Perches wrote:
> On Fri, 2021-05-28 at 11:13 -0700, Kees Cook wrote:
> > In preparation for FORTIFY_SOURCE performing compile-time and run-time
> > field bounds checking for memcpy() using memcpy() with an inline const
> > buffer and instead just statically initialize the destination array
> > directly.
> []
> > diff --git a/drivers/scsi/fcoe/fcoe.c b/drivers/scsi/fcoe/fcoe.c
> []
> > @@ -293,7 +293,7 @@ static int fcoe_interface_setup(struct fcoe_interface *fcoe,
> >  	struct fcoe_ctlr *fip = fcoe_to_ctlr(fcoe);
> >  	struct netdev_hw_addr *ha;
> >  	struct net_device *real_dev;
> > -	u8 flogi_maddr[ETH_ALEN];
> > +	u8 flogi_maddr[ETH_ALEN] = FC_FCOE_FLOGI_MAC;
> 
> static const
> 
> > @@ -442,7 +441,7 @@ static void fcoe_interface_remove(struct fcoe_interface *fcoe)
> >  {
> >  	struct net_device *netdev = fcoe->netdev;
> >  	struct fcoe_ctlr *fip = fcoe_to_ctlr(fcoe);
> > -	u8 flogi_maddr[ETH_ALEN];
> > +	u8 flogi_maddr[ETH_ALEN] = FC_FCOE_FLOGI_MAC;
> 
> etc...

Hm, good point.

-- 
Kees Cook
