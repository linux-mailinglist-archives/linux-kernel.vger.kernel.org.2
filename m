Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01290399202
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 19:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbhFBR6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 13:58:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229467AbhFBR6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 13:58:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7F2061DAA;
        Wed,  2 Jun 2021 17:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622656600;
        bh=di7qnIoRuVmUc7S1bq5974ayyTkJke4QQK1OYu5tyZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j2uvTS0gAKA+jwF0zh05OfPHjiNe0Bcep4HlCGs3mRSiv4ZrSX6xTj9nOAZKvgd0v
         WsOnD9we8mBqYnIjeHcRVV9blSycelD9hJMdkfjYGOCZAOQxuAkaTBQvjOYsgNlFIw
         hRxi472lh7DJKUhyl+ii47XUbeKwPIcuICloFbQc=
Date:   Wed, 2 Jun 2021 19:56:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     SyzScope <syzscope@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        syzbot <syzbot+9b91d635e2b51efd6371@syzkaller.appspotmail.com>,
        Martin Fuzzey <mfuzzey@parkeon.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, sunjunyong@xiaomi.com, sunjy516@gmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Read in fw_load_sysfs_fallback
Message-ID: <YLfGUNpTU5BE27IT@kroah.com>
References: <000000000000721b1305bf043595@google.com>
 <20210403013143.GV4332@42.do-not-panic.com>
 <07acfc7a-cfa4-5f14-b2ee-14790ff58363@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07acfc7a-cfa4-5f14-b2ee-14790ff58363@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 10:08:39AM -0700, SyzScope wrote:
> Hi,
> We have analyzed this bug and realize that it is security-critical.
> Specifically, according to our investigation, it will lead to a
> use-after-free write (instead of the originally reported use-after-free
> read) and thus highly likely exploitable. More details can be found at:
> 
> https://sites.google.com/view/syzscope/kasan-use-after-free-read-in-fw_load_sysfs_fallback <https://sites.google.com/view/syzscope/kasan-use-after-free-read-in-fw_load_sysfs_fallback>
> 
> 
> We understand that creating a patch can be time-consuming and there is
> probably a long list of bugs pending fixes. We hope that our security
> analysis can enable an informed decision on which bugs to fix first
> (prioritization).
> 
> Since the bug has been on syzbot for over two months (first found on
> 03-22-2020), it is best to have the bug fixed early enough to avoid it being
> weaponized.

Great, please work to provide a fix!  See the archives for more details
if you are curious about this.

thanks,

greg k-h
