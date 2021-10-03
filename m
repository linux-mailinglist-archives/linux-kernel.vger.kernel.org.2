Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A6242012D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 12:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhJCKUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 06:20:51 -0400
Received: from verein.lst.de ([213.95.11.211]:38923 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229940AbhJCKUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 06:20:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1EEC368B05; Sun,  3 Oct 2021 12:18:58 +0200 (CEST)
Date:   Sun, 3 Oct 2021 12:18:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [RFC PATCH] nvme: allow specific passthrough IOs without
 CAP_SYSADMIN
Message-ID: <20211003101857.GA10943@lst.de>
References: <20211001234017.4519-1-logang@deltatee.com> <f1e00f76-235a-e4b0-ce98-3eabe0a50ea3@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1e00f76-235a-e4b0-ce98-3eabe0a50ea3@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 03, 2021 at 12:29:22PM +0300, Sagi Grimberg wrote:
>> Users that want to send any of these passthrough commands will still
>> require access to the NVMe char device or namespace. Typically, the
>> char device is only accessible by root anyway and namespaces are
>> accessible by root and the disk group. Administrators are free to
>> add udev rules to adjust these permissions for specific devices they
>> want to allow.
>
> I don't understand what is the difference between VS commands and normal
> commands? Why do you consider VS commands safe to relax privileges as
> opposed to any other command?

They are different in that it is cometely undefine what they do.
So relaxing that checks is an absolute non-starter while for simple
things like Read it might be possible if we really care.
