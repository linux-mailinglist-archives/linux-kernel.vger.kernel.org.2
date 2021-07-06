Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877B73BDAD1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 18:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhGFQDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 12:03:25 -0400
Received: from smtprelay0156.hostedemail.com ([216.40.44.156]:47534 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230231AbhGFQDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 12:03:24 -0400
Received: from omf20.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 2B597100EAD6D;
        Tue,  6 Jul 2021 16:00:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id 9376518A60C;
        Tue,  6 Jul 2021 16:00:43 +0000 (UTC)
Message-ID: <19a701a8d5837088aa7d8ba594c228c0e040e747.camel@perches.com>
Subject: Re: [PATCH] get_maintainer: only show lkml as last resort
From:   Joe Perches <joe@perches.com>
To:     Hannu Hartikainen <hannu@hrtk.in>, linux-kernel@vger.kernel.org
Date:   Tue, 06 Jul 2021 09:00:42 -0700
In-Reply-To: <20210706083354.214826-1-hannu@hrtk.in>
References: <20210706083354.214826-1-hannu@hrtk.in>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9376518A60C
X-Spam-Status: No, score=-2.90
X-Stat-Signature: n5tjdm7htxehmtn9hrpae81gxzq3ssjy
X-Rspamd-Server: rspamout03
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18UX6e3BY9qM1T/GKO0oXiBBiwTc4OcKyY=
X-HE-Tag: 1625587243-747413
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-07-06 at 11:33 +0300, Hannu Hartikainen wrote:
> The documentation implies that patches should be primarily sent to a
> subsystem-specific mailing list [0]. Make get_maintainer only return the
> generic linux-kernel@vger.kernel.org ("THE REST") list when no other
> matching mailing list is found.
> 
> Most patches sent to lkml today are also sent to some other list. This
> change should lower the message volume on lkml in the long run, making
> the list more useful for those cases where it's the only option.
> 
> [0]: Documentation/process/submitting-patches.rst:
> > You should also normally choose at least one mailing list to receive a
> > copy of your patch set. linux-kernel@vger.kernel.org functions as a
> > list of last resort, but the volume on that list has caused a number of
> > developers to tune it out. Look in the MAINTAINERS file for a
> > subsystem-specific list; your patch will probably get more attention
> > there.
> 
> Signed-off-by: Hannu Hartikainen <hannu@hrtk.in>
> ---
> 
> I'm not sure if this is technically the best solution so I'm looking
> forward to review comments. But process-wise I think this should be a
> good change.

Almost no one reads lkml directly anyway and I rather like that lkml
gets all copies.

This allows lore.kernel.org/lkml to have a relatively complete searchable
database of all kernel related patch submissions.

Another solution might be an searchable aggregation mechanism at lore,
but I believe one currently does not exist.

That _might_ allow a similar search mechanism.

> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl

The proposed patch seems overly complicated.


