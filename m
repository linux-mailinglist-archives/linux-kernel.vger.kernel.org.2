Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71DD33C9DF0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 13:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhGOLrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 07:47:21 -0400
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:48078 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229710AbhGOLrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 07:47:20 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id 30EE9CAE50
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 12:44:26 +0100 (IST)
Received: (qmail 5069 invoked from network); 15 Jul 2021 11:44:25 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 15 Jul 2021 11:44:25 -0000
Date:   Thu, 15 Jul 2021 12:44:24 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     yong w <yongw.pur@gmail.com>
Cc:     wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, nico@fluxnic.net, wang.yong12@zte.com.cn
Subject: Re: Re: [BUG] ramfs system panic when using dd to create files
Message-ID: <20210715114424.GR3809@techsingularity.net>
References: <CAOH5QeChR8s6vENfRdGtUeeqKsSSbeFkY9TArmOyDcUvgAgU7Q@mail.gmail.com>
 <CAOH5QeC0PhnZY6Cpe4zZ8o07XHA4-5B3xGEontkezrYu=Jt0VQ@mail.gmail.com>
 <7074179d.c3fd.17aa3f148cc.Coremail.wuzhouhui14@mails.ucas.ac.cn>
 <CAOH5QeCV3c-=RiwGrUn7214NRZye7wYFmPSyFWxw-0Zvk=j2GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAOH5QeCV3c-=RiwGrUn7214NRZye7wYFmPSyFWxw-0Zvk=j2GQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 10:30:22PM +0800, yong w wrote:
> Thanks for your reply!
> 
> > Limit max size of ramfs.
> It's no use using size to limit the size of ramfs.
> "mount -t ramfs -o size=10M ramfs /ramfs" is the command i use.
> 

ramfs does not support size= limiting, that's what tmpfs is for.

> >
> > The comments already explains why kernel should panic on this situation:
> >             /*
> >              * If we got here due to an actual allocation at the
> >              * system level, we cannot survive this and will enter
> >              * an endless loop in the allocator. Bail out now.
> >              */
>
> But it causes panic, actually , I don't want it panics

Then use tmpfs and specify size=. It's mentioned in filesystems/tmpfs.rst

--8<--
If you compare it to ramfs (which was the template to create tmpfs)
you gain swapping and limit checking. Another similar thing is the RAM
disk (/dev/ram*), which simulates a fixed size hard disk in physical
RAM, where you have to create an ordinary filesystem on top. Ramdisks
cannot swap and you do not have the possibility to resize them.
--8<--

-- 
Mel Gorman
SUSE Labs
