Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8DC33203B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 09:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhCIIFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 03:05:20 -0500
Received: from foss.arm.com ([217.140.110.172]:48942 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhCIIFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 03:05:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AADBD6E;
        Tue,  9 Mar 2021 00:05:01 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9D803F71B;
        Tue,  9 Mar 2021 00:04:58 -0800 (PST)
Date:   Tue, 9 Mar 2021 08:04:56 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lukasz.luba@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, thara.gopinath@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        cristian.marussi@arm.com
Subject: Re: [PATCH v6 36/37] firmware: arm_scmi: add protocol modularization
 support
Message-ID: <20210309080456.GB47884@e120937-lin>
References: <20210202221555.41167-1-cristian.marussi@arm.com>
 <20210202221555.41167-37-cristian.marussi@arm.com>
 <20210308073425.g7zkpoamxu2m67tj@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308073425.g7zkpoamxu2m67tj@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On Mon, Mar 08, 2021 at 07:34:25AM +0000, Sudeep Holla wrote:
> On Tue, Feb 02, 2021 at 10:15:54PM +0000, Cristian Marussi wrote:
> > Extend SCMI protocols accounting mechanism to address possible module
> > usage and add the support to possibly define new protocols as loadable
> > modules.
> >
> > Keep Standard protocols built into the SCMI core.
> >
> 
> The changes look good, however without any users I am bit hesitant to add
> this yet. However if you think it is hard to maintain it outside the tree
> until first user gets merged, we can merge provided we test this every
> release. Let me know your thoughts.
> 

On one side this series aimed not only at simplifying the API exposed to
the drivers/protocols but also to unify such API betweeen custom and standard
protocols and drivers, so that whatever custom proto and driver you wrote, you
are anyway going to exercise the same API and triggering the same internals
as the standard protos, so to avoid the issue of having to expose/support
an API not used by anyone (still)....

...on the other side, indeed, you are right that this specific thin patch
WON'T be really tested/exercised indeed until a custon protocol module is
upstreamed...if ever.

For me it's fine to test it every cycle with my custom dummy protocol,
and maybe it could be an incentive for partners to post finally upstream
their protos if all the support is already there in the mainline (I know,
I'm a dreamer :D), but better would be as a future alternative (not for
this series though) to enable (in some well guarded/controlled form) the
optional modularization of core standard protocols too (also to possibly
comply with ACK extreme modularization policies...), so that this patch
would be constantly exercised by our std protocol too.

But I have not really a strong opinion on this, if you want to keep this
out and merge only once a real custom proto appears or once we modularize
the core standard protocols (in a controlled manner as said), it's fine
for me too.

Thanks

Cristian

> Also any comment from users requesting this would be useful.
> 

> --
> Regards,
> Sudeep
