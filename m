Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71AB36DCBF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 18:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240384AbhD1QOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 12:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240442AbhD1QOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 12:14:15 -0400
Received: from valentin-vidic.from.hr (valentin-vidic.from.hr [IPv6:2001:470:1f0b:3b7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CE5C061573;
        Wed, 28 Apr 2021 09:13:29 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at valentin-vidic.from.hr
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
        id 517E85C15; Wed, 28 Apr 2021 18:13:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=valentin-vidic.from.hr; s=2020; t=1619626398;
        bh=/lA99jJWibpe5bvPiHlWkky33Jv0Kq+2qr2RiYH1/Ys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2CL4fRBsjojjoP9FfYt0RHIW5vde/X/hiDSzq2Haax14TiKhzqhafCu2UKWIH8qbk
         Mu7Etn6zix1oDvT1QztIkSrRJbHpBN+VQ7hMvXWuGMMm82cWRdVlAcSVIxJobi/Fkx
         J4oiT6ll/RSCspkvg4VaMOb9qgKzze4zDQTy0lhyI/flyTnCBHMzMrXeOQBzchAT7h
         vn4uJat08ACxoBInk4uoL698HydQkI/DDD4byUfHf6UlbUtz47zEaQ4lLnb/t7ymBa
         6NsJ4VDBgurd7F7LNmfdedoAn6AFX223pUDQ7aMmVkFAKJW8MhEtH+DdwddLCa/7ea
         8kXPG130Xm6fCrPRAkfa86ERczcdMit5vVnNOYb7LwkyYFdu++LIssCiKzsw2iyaTQ
         Kcq6Q+tpCKFo82p30V5cZBVXaDcMS6nvjeJpl7qYmRzz71hSYB2GfsJqsAH7/3cVZt
         Bcxtr6siyjPepIYw7uQCkioDC7wTuswMhvMd0YDhCASNsJtOEygXcNqG9b/8Xeo82T
         eiEcHPu79egTQEH+92HgWVd3ka10/5KWTkmHTGFkA8l92W3Apm2IWxyY5iS0dfieO+
         qDo9HJ7CfQy55JNHimu5BjaNmTkgQynE3WTSgZCEVt2CuK9l8aaA5JiReoosyGc+J+
         0Fm/GpKUjqRrTXcDZEebTJdc=
Date:   Wed, 28 Apr 2021 18:13:18 +0200
From:   Valentin =?utf-8?B?VmlkacSH?= <vvidic@valentin-vidic.from.hr>
To:     Hendrik Brueckner <brueckner@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Philipp Kern <pkern@debian.org>,
        Benjamin Zimmermann <dave@oss.volkswagen.com>,
        debian-s390@lists.debian.org,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: Re: [PATCH v2] s390/sclp_vt220: Fix console name to match device
Message-ID: <20210428161318.GX4672@valentin-vidic.from.hr>
References: <20200519181654.16765-1-vvidic@valentin-vidic.from.hr>
 <20210427194010.9330-1-vvidic@valentin-vidic.from.hr>
 <20210428133836.GD21939@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428133836.GD21939@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 03:38:36PM +0200, Hendrik Brueckner wrote:
> It is been a while ago when working on consoles. However, consoles are
> typically devices without having a device node associated. There is special
> handling for /dev/console wrt. to the preferred console in the tty layer.
> 
> A console device might be associated with a tty device but this is not a
> requirement. For example, consider the net console that streams console
> messages thru UDP and is not associated with a tty.
> 
> Because console and tty are different devices, names can also be different
> which is, unfortunately, the case on s390.
> 
> Therefore my suggestion here is not derive the tty device from the name
> of the console, but rather looking at the associated tty being reported
> as major minor number in /proc/console.

Yes, I see what you mean. Loading netconsole produces a line in
/proc/consoles without the major:minor numbers:

  tty0                 -WU (EC p  )    4:7
  netcon0              -W- (E  p  )

On the other hand /proc/consoles documentation seems to suggest these
are character device names:
https://www.kernel.org/doc/html/latest/filesystems/proc.html#proc-consoles

Since sclp_vt220 seems to be the only know exception we are trying
to solve in that direction now.

If this does not work out, the alternative is as you suggested to take
the major:minor numbers and read the char device name from the symlink:

lrwxrwxrwx 1 root root 0 Apr 28 17:00 /sys/dev/char/4:7 -> ../../devices/virtual/tty/tty7

-- 
Valentin
