Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443A43BBC70
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 13:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhGEL43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 07:56:29 -0400
Received: from verein.lst.de ([213.95.11.211]:56725 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230174AbhGEL42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 07:56:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B8CC268B05; Mon,  5 Jul 2021 13:53:49 +0200 (CEST)
Date:   Mon, 5 Jul 2021 13:53:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shiva.linuxworks@gmail.com" <shiva.linuxworks@gmail.com>
Subject: Re: [EXT] Re: [PATCH] nvme: Add abrupt shutdown support
Message-ID: <20210705115349.GA20266@lst.de>
References: <20210705101157.1009135-1-sshivamurthy@micron.com> <20210705101554.GA12803@lst.de> <BLAPR08MB6900B02E65B542A2C2F174E1B81C9@BLAPR08MB6900.namprd08.prod.outlook.com> <20210705104208.GA14891@lst.de> <BLAPR08MB690003D5D175FC784DE844F8B81C9@BLAPR08MB6900.namprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BLAPR08MB690003D5D175FC784DE844F8B81C9@BLAPR08MB6900.namprd08.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2021 at 11:15:51AM +0000, Shivamurthy Shastri (sshivamurthy) wrote:
> For systems with passive electronic components to handle power-loss/battery-removal,
> CC.SHN=10b will help to achieve safer shutdown with relatively lower power back-up 
> requirements (at lower cost).
> 
> The module parameter gives flexibility to the host to decide shutdown type even during
> boot failure. 

If you have a device that always prefers an abrupt please introduce a TP
in the NVMe technical working group so that the hosts automatically
do the right thing.  Requiring sysadmin intervention using a global
kernel parameter is not the way to do this.
