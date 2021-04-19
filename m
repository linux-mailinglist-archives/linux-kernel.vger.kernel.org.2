Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D65363BF0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 08:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbhDSGvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 02:51:02 -0400
Received: from verein.lst.de ([213.95.11.211]:45334 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229473AbhDSGvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 02:51:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4B68D68B05; Mon, 19 Apr 2021 08:50:28 +0200 (CEST)
Date:   Mon, 19 Apr 2021 08:50:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        Alex Deucher <alexander.deucher@amd.com>,
        Prike Liang <Prike.Liang@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] nvme: Favor D3cold for suspend if NVMe device
 supports it
Message-ID: <20210419065027.GA19201@lst.de>
References: <20210416091344.1210803-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416091344.1210803-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 05:13:44PM +0800, Kai-Heng Feng wrote:
> On AMD platforms that use s2idle, NVMe timeouts on s2idle resume,
> because their SMU FW may cut off NVMe power during sleep.

We're already have a discussion on a proper quirk for thse broken
platforms on the linux-nvme list, please take part in that discussion.
