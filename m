Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C881F4067D0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 09:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhIJHje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 03:39:34 -0400
Received: from verein.lst.de ([213.95.11.211]:47359 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231674AbhIJHjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 03:39:15 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 90C8F6736F; Fri, 10 Sep 2021 09:38:00 +0200 (CEST)
Date:   Fri, 10 Sep 2021 09:38:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Zenghui Yu <yuzenghui@huawei.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        fujita.tomonori@lab.ntt.co.jp, martin.petersen@oracle.com,
        hch@lst.de, gregkh@linuxfoundation.org, wanghaibin.wang@huawei.com
Subject: Re: [PATCH] scsi: bsg: Fix device unregistration
Message-ID: <20210910073800.GB1193@lst.de>
References: <20210909034608.1435-1-yuzenghui@huawei.com> <78c3c08b-ebba-8d46-7eae-f82d0b1c50fe@kernel.dk> <ac61cf8b-061e-dd96-1730-edec5a886c62@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac61cf8b-061e-dd96-1730-edec5a886c62@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 02:42:10PM -0600, Jens Axboe wrote:
> Actually, let's move this through the SCSI tree, as the offending patch
> went that way (and my branches are behind that point).

Btw, should we move bsg.c and bsg-lib.c to drivers/scsi/?  They very much
are SCSI infrastructure now.
