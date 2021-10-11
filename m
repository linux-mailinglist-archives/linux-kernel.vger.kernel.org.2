Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F89742963C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 20:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbhJKSDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 14:03:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234164AbhJKSDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 14:03:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 316A860C41;
        Mon, 11 Oct 2021 18:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633975260;
        bh=4/+YntBNV5/w3ng5djSjZdGKqSo18/DR2D/M+OvZxno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KS0q01UBnmpOLoXLA0HdFSarXsWoI3XTIupotWA9HE9ynY/7z5eQp5li5vgGI7RAE
         pAWMZStlUlbRKv3hODPICLUjyraLVOiwBEO1o1ZlFNXsKV21v396K72uuBG4lcmDNa
         B3e6bt7AB4O9xKBvXeK6tMCGzXs1s2NxpDA1iUGBWXIumg/YP8Bt4GF4pifCf2br0C
         +rSsXh2THIl0Zoi0HDtL1+hmiaIwZaS50HO1IFG7GgbD/D3Ssxk7vw9qGy/I3/Oz1e
         6N4uoCxs6ayE2lKLwRkx8y8a9DlyhVQHbcrvcxSIu486EgF2VH21bqdMaVtfa+yRkX
         Be9MVCSH7dqOQ==
Date:   Mon, 11 Oct 2021 11:00:58 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, Dell.Client.Kernel@dell.com
Subject: Re: SK hynix BC511: warning: nvme nvme0: missing or invalid SUBNQN
 field.
Message-ID: <20211011180058.GA635062@dhcp-10-100-145-180.wdc.com>
References: <67f74c8e-9d5e-22a1-f1c2-a4284b07ba56@molgen.mpg.de>
 <20210817161638.GC223727@dhcp-10-100-145-180.wdc.com>
 <f3f78d3c-d3f7-67f5-4263-f306b4f623d1@molgen.mpg.de>
 <20210817170222.GA224912@dhcp-10-100-145-180.wdc.com>
 <f02a8989-d255-26ee-2fca-c9db2d1e158c@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f02a8989-d255-26ee-2fca-c9db2d1e158c@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 03:08:15PM +0200, Paul Menzel wrote:
> Am 17.08.21 um 19:02 schrieb Keith Busch:
> > 
> > In the section for "Identify Controller Data Structure" (section
> > 5.17.2.1, figure 257 in spec version 2.0), the NQN definition says:
> > 
> >    "Support for this field is mandatory if the controller supports revision
> >    1.2.1 or later"
> > 
> > The driver does confirm the controller's reported revision meets this
> > requirement before emitting the warning.
> 
> The Dell support came back to me, and said, that Hynix refuses to publish a
> fixed firmware unless I show them a use case, where I need that field.
> 
> Can somebody think of a use case, 

Spec compliance certification. UNH test 1.1 case 2, for example.

> and why this field was made mandatory in
> the specification?

A dependable way to uniquely identify a specific device is generally
useful. The NVMe TWG determined the previous methods were inadequate.

The linux kernel will continue to use the device without this capability
since the low level driver doesn't need it to interact with a
controller, but the driver will warn about the non-compliance in case
host software is relying on this field.
