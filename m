Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23ABF3D3CC2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 17:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235673AbhGWPIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 11:08:22 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:58316 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbhGWPIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 11:08:20 -0400
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.2.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id D27C02012A4;
        Fri, 23 Jul 2021 15:48:52 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 3F034208E9; Fri, 23 Jul 2021 16:51:41 +0200 (CEST)
Date:   Fri, 23 Jul 2021 16:51:41 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pcmcia: i82092: fix a null pointer dereference bug
Message-ID: <YPrXfVs6/CvVBQeS@light.dominikbrodowski.net>
References: <1624345891-4215-1-git-send-email-zheyuma97@gmail.com>
 <YPpbu8YFx9bKa343@light.dominikbrodowski.net>
 <CAMhUBjnzw78UBX+iFyi5MDcWVCFpAz2JixPLzaNJF2juKWKz7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMhUBjnzw78UBX+iFyi5MDcWVCFpAz2JixPLzaNJF2juKWKz7Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fri, Jul 23, 2021 at 05:48:35PM +0800 schrieb Zheyu Ma:
> On Fri, Jul 23, 2021 at 2:20 PM Dominik Brodowski
> <linux@dominikbrodowski.net> wrote:
> >
> > Applied to pcmcia-next, thanks. Are you aware of the last version where this
> > driver worked correctly? It seems that this bug has been present there for
> > ages.
> >
> > Thanks,
> >         Dominik
> 
> Sorry, I don't know. Judging from the commit log, I even suspect that
> this bug has existed since the introduction of this driver......

Indeed. I've tagged it for stable.

Thanks,
	Dominik
