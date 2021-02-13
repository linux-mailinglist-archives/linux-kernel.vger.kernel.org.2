Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9CE831AAB6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 11:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbhBMKKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 05:10:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:38772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229475AbhBMKKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 05:10:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8888A64DEE;
        Sat, 13 Feb 2021 10:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613211007;
        bh=CYMMTOcAA6lBjhCnfr8YFrFdgDi7gATKcExkta6oQtk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IgpVntgLx3r+FQEu0EVjVMeV2cb8f2k/bDy0jEZt0zMUDoD/A7nErfwNmZZeKyNcv
         Mn0eh8BPtWUaPN/eam/F4rt+rAzMPPFsvmOeU4TXWVAuTCCWAVmytWRDiXFUxRo3an
         XbiWam4+mLVohTKDuP9sfMwtgAdW1S0anLm0hj0k=
Date:   Sat, 13 Feb 2021 11:10:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        syzkaller-bugs@googlegroups.com, Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+95ce4b142579611ef0a9@syzkaller.appspotmail.com>
Subject: Re: general protection fault in tomoyo_socket_sendmsg_permission
Message-ID: <YCele2WMWvadFd7J@kroah.com>
References: <40617d66-1334-13a0-de9b-bd7cc1155ce5@i-love.sakura.ne.jp>
 <43d8d6bf-53f3-11e6-894d-c257f7f4bd07@linuxfoundation.org>
 <4368349b-fc0c-6da3-a502-2733f953d271@i-love.sakura.ne.jp>
 <92a4c6ae-172d-91cb-b89e-8eb857fdfb3a@linuxfoundation.org>
 <d177302a-3050-41db-cf44-6d614fd0c3a0@i-love.sakura.ne.jp>
 <e5cb1f77-cd4b-9d74-4f28-d613d5478704@linuxfoundation.org>
 <954bd943-8b55-36c8-9cba-a35a03213b2c@i-love.sakura.ne.jp>
 <99d7fba8-3472-3d6e-e825-9c9c115b5776@i-love.sakura.ne.jp>
 <4d49e8fd-f89f-efa7-5583-a6ca2272c67a@linuxfoundation.org>
 <19685ee2-1769-ad9c-941f-53e7e72ff235@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19685ee2-1769-ad9c-941f-53e7e72ff235@i-love.sakura.ne.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 13, 2021 at 07:02:22PM +0900, Tetsuo Handa wrote:
> Greg, will you queue https://lkml.kernel.org/r/20210205135707.4574-1-penguin-kernel@I-love.SAKURA.ne.jp (which can
> close a report which is wasting syzbot's resource with 5300+ crashes) for 5.12 ? The change shown below will be
> too large to test before merge window for 5.12 opens. 
> 
> The patch for fixing "general protection fault in tomoyo_socket_sendmsg_permission" will kill kthread_get_run().
> Closing frequently crashing bug now is the better.
> 
> On 2021/02/11 22:40, Tetsuo Handa wrote:
> > I guess that we need to serialize attach operation and reset/detach operations, for
> > it seems there is a race window that might result in "general protection fault in
> > tomoyo_socket_sendmsg_permission". Details follows...
> 
> Here is untested diff that is expected to be complete.

Please work and test this and get it merged in a normal manner, there is
no "rush" here at all.  Submit it properly and all will be fine.

thanks,

greg k-h
