Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B5D3F50AA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 20:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhHWSrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 14:47:46 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:38690 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhHWSro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 14:47:44 -0400
Received: by mail-ot1-f48.google.com with SMTP id i8-20020a056830402800b0051afc3e373aso27698555ots.5;
        Mon, 23 Aug 2021 11:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3/McVAfQzdWCgsaBYCI92abaGtNzjiUr1eGcfPA6e9I=;
        b=h1qT2W7ynmMkyEFj/3HVsRvBiK3X6BDil5kH64PJcEh+Vn04qcSL6UBA2crZ3c/xQF
         1vPWlG8JbOB1yfKQ+KikeGeY77LRibM2lXTeE1D0ECXUOXPeJL4W0YTN555Mz/+whGmR
         wINwdrcwQMQPvVCS6Q8jQEZTtA8oUVetFexJJcdxYmlAO+C0e9i2QlXPnY9MnYaQLGGW
         XmG/XnjTCfrBNiH8afkRtRJJTpdDDyqRr/V/tGaG2h6QinTcfo/CRslj+IPTiM95MlQG
         Se+B8P645zViG2yf/kfFwwfebCFaOGMl2p41KFxV+k5/y1sbXhzRvBBKEjOlK2OpgFR0
         dAKA==
X-Gm-Message-State: AOAM533DmFrrn4/t+eNz9kUGFSIJGsqCvo2775JTtrKAnX7jpY00T66a
        mFaC6nj3j5B6NQYCunyXwA==
X-Google-Smtp-Source: ABdhPJxbcjQiojN1mwIrX21huEkSPMH+Qj+DGDKN7au8gtOH1WuXaaNQMQAdldSwuAJqA0nhnhb6pQ==
X-Received: by 2002:aca:3156:: with SMTP id x83mr12568758oix.124.1629744421524;
        Mon, 23 Aug 2021 11:47:01 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c37sm2565548otu.60.2021.08.23.11.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 11:47:00 -0700 (PDT)
Received: (nullmailer pid 2504374 invoked by uid 1000);
        Mon, 23 Aug 2021 18:46:59 -0000
Date:   Mon, 23 Aug 2021 13:46:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH] of: Don't allow __of_attached_node_sysfs() without
 CONFIG_SYSFS
Message-ID: <YSPtI//SJh1CpHRP@robh.at.kernel.org>
References: <20210820144722.169226-1-maz@kernel.org>
 <a67743f9-869b-28df-d714-db15da4ebe06@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a67743f9-869b-28df-d714-db15da4ebe06@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2021 at 11:01:15PM -0500, Frank Rowand wrote:
> Hi Marc,
> 
> On 8/20/21 9:47 AM, Marc Zyngier wrote:
> > Trying to boot without SYSFS, but with OF_DYNAMIC quickly
> > results in a crash:
> > 
> > [    0.088460] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000070
> > [...]
> > [    0.103927] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.14.0-rc3 #4179
> > [    0.105810] Hardware name: linux,dummy-virt (DT)
> > [    0.107147] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
> > [    0.108876] pc : kernfs_find_and_get_ns+0x3c/0x7c
> > [    0.110244] lr : kernfs_find_and_get_ns+0x3c/0x7c
> > [...]
> > [    0.134087] Call trace:
> > [    0.134800]  kernfs_find_and_get_ns+0x3c/0x7c
> > [    0.136054]  safe_name+0x4c/0xd0
> > [    0.136994]  __of_attach_node_sysfs+0xf8/0x124
> > [    0.138287]  of_core_init+0x90/0xfc
> > [    0.139296]  driver_init+0x30/0x4c
> > [    0.140283]  kernel_init_freeable+0x160/0x1b8
> > [    0.141543]  kernel_init+0x30/0x140
> > [    0.142561]  ret_from_fork+0x10/0x18
> > 
> > While not having sysfs isn't a very common option these days,
> > it is still expected that such configuration would work.
> > 
> > Paper over it by bailing out from __of_attach_node_sysfs() if
> > CONFIG_SYSFS isn't enabled.
> 
> CONFIG_SYSFS should be automatically selected when CONFIG_OF_DYNAMIC
> is enabled, and it should not be possible to disable CONFIG_SYSFS
> in this case.

That used to be true, but isn't now.

Rob
