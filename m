Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2C03B4938
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 21:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhFYT2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 15:28:30 -0400
Received: from kanga.kvack.org ([205.233.56.17]:39544 "EHLO kanga.kvack.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229531AbhFYT23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 15:28:29 -0400
Received: by kanga.kvack.org (Postfix, from userid 63042)
        id 8E5606B0078; Fri, 25 Jun 2021 15:26:07 -0400 (EDT)
Date:   Fri, 25 Jun 2021 15:26:07 -0400
From:   Benjamin LaHaise <ben@communityfibre.ca>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: linux-mm@kvack.org - limping on a backup
Message-ID: <20210625192607.GH4058@kvack.org>
References: <20210622145954.GA4058@kvack.org> <214c41fae1f1b148e5b04a58c1b018fb091d7e83.camel@HansenPartnership.com> <20210625171259.GG4058@kvack.org> <6f309c63f5b7be968ae679e81ab959db05681e8a.camel@HansenPartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f309c63f5b7be968ae679e81ab959db05681e8a.camel@HansenPartnership.com>
User-Agent: Mutt/1.4.2.2i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 12:21:24PM -0700, James Bottomley wrote:
> On Fri, 2021-06-25 at 13:12 -0400, Benjamin LaHaise wrote:
> > On Fri, Jun 25, 2021 at 10:00:15AM -0700, James Bottomley wrote:
> > > Perhaps it's time to move this list over to vger or the linux.dev
> > > infrastructure now that it's being brought up?  We already migrated
> > > the containers list without too much pain.
> > 
> > Maybe the btrfs bugs should get fixed.
> 
> I believe we can do both.

If I were unresponsive at fixing issues, I would understand the need to
migrate services, but steps to address the failures have already been
taken and additional mitigations are planned.  If we migrated services
every time a piece of hardware failed or we hit a kernel bug, then we
wouldn't have any infrastructure left.

		-ben
--
"Thought is the essence of where you are now."
