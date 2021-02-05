Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3A43115F1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 23:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbhBEWqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 17:46:09 -0500
Received: from verein.lst.de ([213.95.11.211]:60901 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232230AbhBEOqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:46:01 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5255C67373; Fri,  5 Feb 2021 17:22:21 +0100 (CET)
Date:   Fri, 5 Feb 2021 17:22:21 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Liu Xiang <liu.xiang@zlingsmart.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        liuxiang_1999@126.com, Christoph Hellwig <hch@lst.de>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: block: use REQ_HIPRI flag to complete request
 directly in own complete workqueue
Message-ID: <20210205162221.GA27114@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpOFRGdd0L4Sx9ynV3O_9YJvO=2VBxvWYTfBHjabiDaUg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 03:24:06PM +0100, Ulf Hansson wrote:
> On Thu, 21 Jan 2021 at 09:13, Liu Xiang <liu.xiang@zlingsmart.com> wrote:
> >
> > After commit "40d09b53bfc557af7481b9d80f060a7ac9c7d314", request is
> > completed in softirq. This may cause the system to suffer bad preemptoff
> > time.
> > The mmc driver has its own complete workqueue, but it can not work
> > well now.
> > The REQ_HIPRI flag can be used to complete request directly in its own
> > complete workqueue and the preemptoff problem could be avoided.
> 
> I am trying to understand all of the problem, but I don't quite get
> it, sorry. Would it be possible for you to extend the description in
> the commit message a bit?

Yes, the message sounds weird.  The mentioned commit should obviously
not make any difference for drivers not using it.

> More exactly, what will happen if we tag a request with REQ_HIPRI
> before completing it? Apologize for my ignorance, but I am currently a
> bit overwhelmed with work, so I didn't have the time to really look it
> up myself.

Drivers must never set REQ_HIPRI!  This is a flag that is set by
the submitter, and actually cleared for most drivers that don't support
it by the block layer.
