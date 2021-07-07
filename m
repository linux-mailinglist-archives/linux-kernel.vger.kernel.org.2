Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8782B3BEC6E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 18:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhGGQoi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Jul 2021 12:44:38 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:51428 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbhGGQog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 12:44:36 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 165941C0B7C; Wed,  7 Jul 2021 18:41:55 +0200 (CEST)
Date:   Wed, 7 Jul 2021 18:41:48 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Nishanth Menon <nm@ti.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Rahul T R <r-ravikumar@ti.com>
Subject: Re: [PATCH] LICENSES/dual/CC-BY-4.0: Lets switch to utf-8
Message-ID: <20210707164148.GA5380@localhost>
References: <20210703012931.30604-1-nm@ti.com>
 <87eecaqytu.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <87eecaqytu.ffs@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-07-07 11:04:45, Thomas Gleixner wrote:
> Nishanth,
> 
> On Fri, Jul 02 2021 at 20:29, Nishanth Menon wrote:
> > Lets drop the unicode characters that peeped in and replace with
> 
> Again: s/Lets// 
> 
> > equivalent utf-8 characters. This makes the CC-BY-4.0 file inline with
> > rest of license files.

s/utf-8/ASCII/? otherwise the description makes no sense...

> >  its public licenses to material it publishes and in those instances
> > -will be considered the “Licensor.” The text of the Creative Commons
> > +will be considered the "Licensor." The text of the Creative Commons
> 
> In theory the License text should be a verbatim copy. But yes, this
> unicode stuff is a pain.

But we use unicode elsewhere for random stuff, and license should
be verbatim, so I'm not sure this is good idea.

			      		  	   Pavel
						   
-- 
