Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156D8350EF2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 08:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbhDAGUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 02:20:50 -0400
Received: from verein.lst.de ([213.95.11.211]:38287 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233227AbhDAGUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 02:20:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 20EC268B05; Thu,  1 Apr 2021 08:20:32 +0200 (CEST)
Date:   Thu, 1 Apr 2021 08:20:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     "Ewan D. Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>,
        Daniel Wagner <dwagner@suse.de>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] nvme-tcp: Check if request has started before
 processing it
Message-ID: <20210401062031.GA25424@lst.de>
References: <20210301175601.116405-1-dwagner@suse.de> <6b51a989-5551-e243-abda-5872411ec3ff@grimberg.me> <20210311094345.ogm2lxqfuszktuhp@beryllium.lan> <70af5b02-10c1-ab0b-1dfc-5906216871b4@grimberg.me> <2fc7a320c86f75507584453dd2fbd744de5c170d.camel@redhat.com> <ed3ccac0-79ed-fe10-89eb-d403820b4c6a@grimberg.me> <20210330232813.GA1935968@dhcp-10-100-145-180.wdc.com> <e4bee13c-647a-55ff-2017-27ccfc314973@suse.de> <ad2fcbcd6707de4e219b39b012f6e42cb03dc92d.camel@redhat.com> <5715ef78-eaf1-dcb6-c2a2-f4725e1a01c4@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5715ef78-eaf1-dcb6-c2a2-f4725e1a01c4@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 03:24:49PM -0700, Sagi Grimberg wrote:
>
>>> What we can do, though, is checking the 'state' field in the tcp
>>> request, and only allow completions for commands which are in a state
>>> allowing for completions.
>>>
>>> Let's see if I can whip up a patch.
>>
>> That would be great.  BTW in the crash dump I am looking at now, it
>> looks like pdu->command_id was zero in nvme_tcp_recv_data(), and
>> blk_mq_tag_to_rq() returned a request struct that had not been used.
>> So I think we do need to check that the tag was actually allocated.
>
> request tag can't be zero? I forget...

Of course it can.  But the reserved tags are before the normal tags,
so 0 would be a reserved tag for nvme.
