Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A29307386
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 11:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhA1KRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 05:17:44 -0500
Received: from verein.lst.de ([213.95.11.211]:56846 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232254AbhA1KRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 05:17:17 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 433B568AFE; Thu, 28 Jan 2021 11:16:34 +0100 (CET)
Date:   Thu, 28 Jan 2021 11:16:33 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Nick Hu <nickhu@andestech.com>
Cc:     Christoph Hellwig <hch@lst.de>, green.hu@gmail.com,
        deanbo422@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nds32: use get_kernel_nofault in dump_mem
Message-ID: <20210128101633.GA6249@lst.de>
References: <20200720114448.205876-1-hch@lst.de> <20200720114448.205876-2-hch@lst.de> <20200721110717.GA19721@atcfdc88> <20200721112800.GA27356@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721112800.GA27356@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 01:28:00PM +0200, Christoph Hellwig wrote:
> Can you pich the patches up in the nds32 tree for Linus?  There are
> not short-term dependencies on them.

It seems like these patches are still sitting in linux-next and never
made it to Linus/
