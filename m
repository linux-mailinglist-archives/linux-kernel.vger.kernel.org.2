Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF60322622
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 08:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbhBWHEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 02:04:54 -0500
Received: from verein.lst.de ([213.95.11.211]:32925 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230452AbhBWHEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 02:04:53 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4E93968D0E; Tue, 23 Feb 2021 08:04:09 +0100 (CET)
Date:   Tue, 23 Feb 2021 08:04:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        David Anderson <dvander@google.com>,
        Alistair Delva <adelva@google.com>,
        Todd Kjos <tkjos@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        YongQin Liu <yongqin.liu@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
        Satya Tangirala <satyat@google.com>
Subject: Re: [REGRESSION] "split bio_kmalloc from bio_alloc_bioset" causing
 crash shortly after bootup
Message-ID: <20210223070408.GA16980@lst.de>
References: <CALAqxLUWjr2oR=5XxyGQ2HcC-TLARvboHRHHaAOUFq6_TsKXyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLUWjr2oR=5XxyGQ2HcC-TLARvboHRHHaAOUFq6_TsKXyw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is that the blk-crypto fallback code calls bio_split
with a NULL bioset.  That was aready broken before, as the mempool
needed to guarantee forward progress was missing, but is not fatal.

Satya, can you look into adding a mempool that can guarantees forward
progress here?
