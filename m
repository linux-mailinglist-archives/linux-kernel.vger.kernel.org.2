Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783E93F15BB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 11:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237503AbhHSJFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 05:05:52 -0400
Received: from verein.lst.de ([213.95.11.211]:36660 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234517AbhHSJFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 05:05:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B4D3368AFE; Thu, 19 Aug 2021 11:05:10 +0200 (CEST)
Date:   Thu, 19 Aug 2021 11:05:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+aa0801b6b32dca9dda82@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] general protection fault in wb_timer_fn
Message-ID: <20210819090510.GA12194@lst.de>
References: <00000000000072e53a05c983ab22@google.com> <20210816091041.3313-1-hdanton@sina.com> <20210816093336.GA3950@lst.de> <yt9dim01iz69.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dim01iz69.fsf@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 11:03:42AM +0200, Sven Schnelle wrote:
> I'm seeing a similar crash in our CI:

This series:

https://lore.kernel.org/linux-block/20210816131910.615153-1-hch@lst.de/T/#t

should fi it.  Can you give it a spin?
