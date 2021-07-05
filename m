Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0EB3BBD4F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 15:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbhGENHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 09:07:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:53664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231279AbhGENHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 09:07:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5144761351;
        Mon,  5 Jul 2021 13:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625490298;
        bh=rhu2C/NJvXmLufyGGG+4o0IrZSoZN3Ig3jMmdCKp5jA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q42OkISM7qr/q4hU1YD3VWodsnnzFtDU4z9IBaNMxDxhi2gssatq4DRiLh3EbhR7f
         I7G73KlI0NysDPfSySe84LItkb7lwE9LwsW6tRiF3oQNP4/zilgAin0CLFJsS1fRf3
         WK0FzcQiA6iE4I5aX9X51vvepkv0IhWG62MP7DeLqnifvToH1lhvkaS26BXElAoVZ8
         3kftJKkJPj4wU4nJJSQa3ONRvjMCQJAInj/44wVOc8Ysa4mg7hV+7Z7KYDj+AU2fSu
         8yqDgexORymmdZVabVUvejAR3PGFpJJ8/rnKOaiEVpG7BQiuaHPqbQNtzr9kldJblP
         kC62oemhgBo4g==
Date:   Mon, 5 Jul 2021 06:04:56 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>,
        "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shiva.linuxworks@gmail.com" <shiva.linuxworks@gmail.com>
Subject: Re: [EXT] Re: [PATCH] nvme: Add abrupt shutdown support
Message-ID: <20210705130456.GA239714@dhcp-10-100-145-180.wdc.com>
References: <20210705101157.1009135-1-sshivamurthy@micron.com>
 <20210705101554.GA12803@lst.de>
 <BLAPR08MB6900B02E65B542A2C2F174E1B81C9@BLAPR08MB6900.namprd08.prod.outlook.com>
 <20210705104208.GA14891@lst.de>
 <BLAPR08MB690003D5D175FC784DE844F8B81C9@BLAPR08MB6900.namprd08.prod.outlook.com>
 <20210705115349.GA20266@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705115349.GA20266@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2021 at 01:53:49PM +0200, Christoph Hellwig wrote:
> On Mon, Jul 05, 2021 at 11:15:51AM +0000, Shivamurthy Shastri (sshivamurthy) wrote:
> > For systems with passive electronic components to handle power-loss/battery-removal,
> > CC.SHN=10b will help to achieve safer shutdown with relatively lower power back-up 
> > requirements (at lower cost).
> > 
> > The module parameter gives flexibility to the host to decide shutdown type even during
> > boot failure. 
> 
> If you have a device that always prefers an abrupt please introduce a TP
> in the NVMe technical working group so that the hosts automatically
> do the right thing.  Requiring sysadmin intervention using a global
> kernel parameter is not the way to do this.

Is it the device that wants an abrupt shutdown or the platform? If the
platform's power is running on limited back-up supply, and could inform
the kernel's power management subsystem of this, then a driver could use
that to determine if the quick shutdown is appropriate.
