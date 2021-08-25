Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457E83F7169
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 11:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239465AbhHYJFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 05:05:14 -0400
Received: from verein.lst.de ([213.95.11.211]:55365 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232302AbhHYJFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 05:05:12 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0FB9D67357; Wed, 25 Aug 2021 11:04:25 +0200 (CEST)
Date:   Wed, 25 Aug 2021 11:04:24 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     sasaki tatsuya <tatsuya6.sasaki@kioxia.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] nvme: update keep alive interval when kato is
 modified
Message-ID: <20210825090424.GA468@lst.de>
References: <526a1a756d6c4643b15b1b305cc32817@kioxia.com> <05033836-83b9-c060-0348-774a02b60d01@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05033836-83b9-c060-0348-774a02b60d01@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 01:41:44PM -0700, Sagi Grimberg wrote:
>> +{
>> +	/*
>> +	 * Keep alive commands interval on the host should be updated
>> +	 * when KATO is modified by Set Features commands.
>> +	 */
>> +	if (cmd->opcode == nvme_admin_set_features &&
>> +	    (cmd->cdw10 & 0xFF) == NVME_FEAT_KATO) {
>> +		/* ms -> s */
>
> no need for this comment.
>
>> +		unsigned int new_kato = DIV_ROUND_UP(cmd->cdw11, 1000);
>> +
>> +		nvme_update_keep_alive(ctrl, new_kato);
>
> I think you can now inline nvme_update_keep_alive here, no need to keep
> it in a function.

Actually, іf thinking ahead I think one helper per fixup would be really
useful to keep the code organized.  But the DIV_ROUND_UP should move into
nvme_update_keep_alive to keep it self-contained.
We can then restructure the caller a bit to make it easier to expand:

	switch (cmd->opcode) {
	case nvme_admin_set_features:
		switch (cmd->cdw10 & 0xff) {
		case NVME_FEAT_KATO:
			nvme_update_keep_alive(ctrl, cmd);
			break;
		}
	}
