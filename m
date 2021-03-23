Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F8E345E30
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhCWMbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:31:32 -0400
Received: from verein.lst.de ([213.95.11.211]:60313 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230236AbhCWMbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:31:24 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2A7F268B02; Tue, 23 Mar 2021 13:31:22 +0100 (CET)
Date:   Tue, 23 Mar 2021 13:31:21 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Chaitanya.Kulkarni@wdc.com
Subject: Re: [PATCH 1/1] nvme-pci: add the DISABLE_WRITE_ZEROES quirk for a
 Samsung PM1725a
Message-ID: <20210323123121.GA31105@lst.de>
References: <1615377076-3251-1-git-send-email-dmtrmonakhov@yandex-team.ru> <20210310132156.GA12145@lst.de> <20210310134110.GA13063@lst.de> <20210310200030.GA3377333@dhcp-10-100-145-180.wdc.com> <20210311104712.GA16218@lst.de> <CGME20210323083750eucas1p14d21230ac758194d854ca336caf7f3f2@eucas1p1.samsung.com> <20210323083749.r272grolxozf3w2f@mpHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210323083749.r272grolxozf3w2f@mpHalley.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 09:37:49AM +0100, Javier González wrote:
> Quick question. It seems like the current quirk simply disables
> write-zeroes. Would you be open for a quirk that aligns with MDTS for
> models that implemented it this way before TP4040?

Aligning to MDTS is our current behavior, although all kernels up to
5.11 had a bug in the calculation.
