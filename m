Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3F135830B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 14:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbhDHMPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 08:15:52 -0400
Received: from verein.lst.de ([213.95.11.211]:35078 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229921AbhDHMPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:15:51 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B70EE68B05; Thu,  8 Apr 2021 14:15:38 +0200 (CEST)
Date:   Thu, 8 Apr 2021 14:15:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Chaitanya.Kulkarni@wdc.com
Subject: Re: [PATCH 1/1] nvme-pci: add the DISABLE_WRITE_ZEROES quirk for a
 Samsung PM1725a
Message-ID: <20210408121538.GA12948@lst.de>
References: <1615377076-3251-1-git-send-email-dmtrmonakhov@yandex-team.ru> <20210310132156.GA12145@lst.de> <20210310134110.GA13063@lst.de> <20210310200030.GA3377333@dhcp-10-100-145-180.wdc.com> <20210311104712.GA16218@lst.de> <CGME20210323083750eucas1p14d21230ac758194d854ca336caf7f3f2@eucas1p1.samsung.com> <20210323083749.r272grolxozf3w2f@mpHalley.local> <20210323123121.GA31105@lst.de> <20210323124322.qchyk7boyzklwv3v@mpHalley.local> <20210408103016.5girhv5ctkucovmd@mpHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210408103016.5girhv5ctkucovmd@mpHalley.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 12:30:16PM +0200, Javier González wrote:
>>> Aligning to MDTS is our current behavior, although all kernels up to
>>> 5.11 had a bug in the calculation.
>>
>> I see. Let me check internally and see what's going on with
>> write-zeroes on this model.
>
> We still need to confirm, but it seems like MDTS for write-zeroes is
> reported wrong in the FW that Dmitry is using. We can at least reproduce
> it.
>
> Would it be a possibility to add quirk infrastructure to hardcode MDTS
> for FW versions prior TP4040?
>
> Another possibility is to add quirks to the TP4040 support patches to
> enable this - it might also help reduce the list of models currently
> blacklisted for write-zeroes.

I'm not sure I understand you.  Before TP4040 there is only the MDTS,
which only applies to data transfer commands, although we also
"volunarily" apply it to Write Zeroes.  If MDTS is wrong this would
also affect normal I/O, so we really either need a firmware update
or a quirk.  Or is the Write Zeroes limit even smaller than MTDS?
I'd rather not add another quirk with a specific limit in that case,
as well grow way too many of those.  TP4040 is the way to go for that
case.
