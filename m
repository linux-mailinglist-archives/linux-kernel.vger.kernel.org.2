Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CB54311FE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 10:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbhJRIRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 04:17:21 -0400
Received: from verein.lst.de ([213.95.11.211]:60908 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231199AbhJRIRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 04:17:20 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EACFB68BEB; Mon, 18 Oct 2021 10:15:05 +0200 (CEST)
Date:   Mon, 18 Oct 2021 10:15:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Zqiang <qiang.zhang1211@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Hao Sun <sunhao.th@gmail.com>,
        Hillf Danton <hdanton@sina.com>, hch@infradead.org,
        willy@infradead.org, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in __init_work
Message-ID: <20211018081505.GA28629@lst.de>
References: <CACkBjsZfAZpOFeYC8mQ03r_JB_eF-dNMEkXf3LNji7_CgOCF2Q@mail.gmail.com> <20210907074432.3711-1-hdanton@sina.com> <CACkBjsYsxNqkup1FQkP4eMzxZ_xNgifPx+gFxEo0gnBUYPp1PQ@mail.gmail.com> <d242861c-5c41-0d1b-3f71-43f50e5a3b68@gmail.com> <20211018044745.GA23657@lst.de> <a46dfeb8-8217-c0cc-bdce-08a7605a5a25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a46dfeb8-8217-c0cc-bdce-08a7605a5a25@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 03:21:18PM +0800, Zqiang wrote:
> I find in add_partition(),  if the device_add() return error, we will drop 
> disk object reference count,
>
> but i find put_device(pdev) (will call part_release())and put_disk(disk), 
> both will reduce the reference of the disk object , however we call 
> get_device(disk_to_dev(disk)) only once
>
> or Did I miss something and didn't analyze it？

Yes, this sounds correct.  Do you want to send a patch or should I
prepare one?
