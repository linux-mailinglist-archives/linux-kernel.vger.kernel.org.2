Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2185F3BBB66
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 12:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhGEKos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 06:44:48 -0400
Received: from verein.lst.de ([213.95.11.211]:56476 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230168AbhGEKor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 06:44:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5450D68AFE; Mon,  5 Jul 2021 12:42:08 +0200 (CEST)
Date:   Mon, 5 Jul 2021 12:42:08 +0200
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
Message-ID: <20210705104208.GA14891@lst.de>
References: <20210705101157.1009135-1-sshivamurthy@micron.com> <20210705101554.GA12803@lst.de> <BLAPR08MB6900B02E65B542A2C2F174E1B81C9@BLAPR08MB6900.namprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BLAPR08MB6900B02E65B542A2C2F174E1B81C9@BLAPR08MB6900.namprd08.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2021 at 10:40:21AM +0000, Shivamurthy Shastri (sshivamurthy) wrote:
> Micron Confidential
> 
> Hi Christoph,
> 
> > 
> > 
> > On Mon, Jul 05, 2021 at 10:11:57AM +0000, shiva.linuxworks@gmail.com wrote:
> > > From: Shivamurthy Shastri <sshivamurthy@micron.com>
> > >
> > > Enabling the abrupt shutdown support. In this shutdown type host does
> > > not need to send Delete I/O Submission Queue and Delete I/O Completion
> > > queue commands to the device.
> > 
> > Why?
> 
> This is to achieve faster shutdown at the cost of data in-flight.

What is the actual use case, and why would a module paramter be a good
interface?
