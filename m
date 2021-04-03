Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02CEE35342F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 15:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbhDCNkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 09:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236689AbhDCNkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 09:40:40 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A31EC061788
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 06:40:37 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id e14so3684531plj.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 06:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0ArNU7gt6dneGNTf37Gm83e3lkSbpvkl1oGeT7Dbgcg=;
        b=pASBcTojxSFlMyEs8ZoQ4UT2DPrY8soJN2PtUTEvPQ+X+BHCBiCu4un3hBvR+T5ZRP
         800UjyINxizBbJuVBojD/5l35/CSQKXLkSu5ECiiWVPUa3wonjf2gOA696z0GMTjAPbp
         R1eebeBhefpfroHpBFeGV82gqy6Vs7P5iHRGXqVlIe8ITuqZimvWU7+L/zyUzvKqqnUf
         UqCP2nvhjij8Npl1RHnJhyiMObZSl69q2FuJA3KRs+31kIbDmkmkb1HW6huVZwx8WqPx
         0cgQDPDxT9x60DwNNlv9JvgtBdY61WO5YISI/t6Xm6+EqejmhRRP6CyK9qzMpOrMJedK
         DVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0ArNU7gt6dneGNTf37Gm83e3lkSbpvkl1oGeT7Dbgcg=;
        b=RZXd63hpioWrCmp5hXzZwLBxBKTB/oZdqsDARo2bkuinhaLsnpQ0+ikjm3PHSeB+fl
         nTfLM0qg4+lj6dRWurS/ZeE5N2wS+WLCVClUV7W3OkZHGrKWASE+Yl4xSOmILvpLIbHf
         5B1f+/qb10urYXMgVgRDFW65Z5l/7T7e0+2yuUfNFmzNTqjV33T0A2UasuD9JKWCz7NU
         1svB6fRQOiYLK21N6b1a0BpR9iVUZZ4pcSxNF9LlOetqN4uNDv5FO0oEzi2gjafCFg+Y
         LGzYEbWvkzZpAaY4WMNPoiZ+jlFLzSdHxroVHjvuNsedKpiqTHVG6Az/VMmZHawS8Cm3
         IrHw==
X-Gm-Message-State: AOAM533K8CrZYQ3WxkZgVnYoPGsQWYCzdqO5nm8WORjTtaxSpLCAWZE6
        rdkSpmRlqre1MIvTPlwUChW9w6ixGzac
X-Google-Smtp-Source: ABdhPJw+qqTyOeGbpzfO2p8wlC0TPoe1z4BLUPGQPpn+fvRzxecxS1G3JJT2WF4J6JkJsWPgjLZZRA==
X-Received: by 2002:a17:902:ec06:b029:e8:e57f:680 with SMTP id l6-20020a170902ec06b02900e8e57f0680mr1440095pld.8.1617457236896;
        Sat, 03 Apr 2021 06:40:36 -0700 (PDT)
Received: from thinkpad ([103.77.37.145])
        by smtp.gmail.com with ESMTPSA id w2sm5926700pfb.174.2021.04.03.06.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 06:40:36 -0700 (PDT)
Date:   Sat, 3 Apr 2021 19:10:32 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: driver-model: Update the documentation for device
 class
Message-ID: <20210403134032.GA3817@thinkpad>
References: <20210403120050.4756-1-manivannan.sadhasivam@linaro.org>
 <YGhn6u3GrWZyrXuI@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGhn6u3GrWZyrXuI@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 03, 2021 at 03:04:42PM +0200, Greg KH wrote:
> On Sat, Apr 03, 2021 at 05:30:50PM +0530, Manivannan Sadhasivam wrote:
> > The current documentation about the device class is out of date such
> > that it refers to non-existent APIs and structures. This commit updates
> > them to the current device class APIs and structures, removes wordings
> > that no longer valid while trying to keep the original content intact.
> 
> Thanks for working on this!
> 
> One thing that instantly jumped out at me:
> 
> > -Class drivers can export attributes using the DEVCLASS_ATTR macro that works
> > -similarly to the DEVICE_ATTR macro for devices. For example, a definition
> > +Class drivers can export attributes using the CLASS_ATTR_* macros that works
> > +similarly to the DEVICE_ATTR_* macros for devices. For example, a definition
> >  like this::
> >  
> > -  static DEVCLASS_ATTR(debug,0644,show_debug,store_debug);
> > +  static CLASS_ATTR_RW(debug, 0644, show_debug, store_debug);
> 
> CLASS_ATTR_RW(debug);
> is the correct way to write the above, what you added there will not
> build.
> 

Oops... I just did a blind replace there, thanks for spotting.

> But a meta-comment, should stuff like this go directly into the .c files
> itself so that the documentation is created automatically?  the fact
> that this lives so "far away" from the source ensures that it will
> always be out of date.  I know other subsystems (graphics, v4l2) have
> tied the documentation into their code files much better so I think the
> build and markup infrastructure is there today to do this.
> 

Well you're right that this documentation is far from its implementation but
that applies to most of the stuffs inside kernel, right? Also, I think if we
move these into .c file, then it will flood the whole file IMO.

We already have the kernel doc for most of the APIs/structures and that should
be enough for the .c/.h code in my perspective. If a developer wants to obtain
more information other than the API/struct definitions, then they should land
in documentation.

It should be responsibility of the maintainer to keep the doc up-to date :)

Thanks,
Mani

> thanks,
> 
> greg k-h
