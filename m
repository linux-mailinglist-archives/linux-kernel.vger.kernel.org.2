Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADF4427AC3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 16:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbhJIORl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 10:17:41 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41320 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233187AbhJIORk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 10:17:40 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 199EFdAJ011663
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 9 Oct 2021 10:15:40 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 744E615C3E70; Sat,  9 Oct 2021 10:15:39 -0400 (EDT)
Date:   Sat, 9 Oct 2021 10:15:39 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     secret <andreas-stoewing@web.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Unwanted activation of root-processes getting highly activated
Message-ID: <YWGkC00VQkOX2utl@mit.edu>
References: <202110081704.58659.andreas-stoewing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202110081704.58659.andreas-stoewing@web.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 05:04:55PM +0000, secret wrote:
> Date: 08.10.2021
> 
> Subject/Betreff: Unwanted activation of root-processes reading and writing out
> the whole SSD/harddrive ! / Kernel-5.4.134 (pclos, AppArmor / Tor (OpenSuSE)
> usw. etc.: Freigabe von Informationen, Ausführen von Code mit höheren
> Privilegien und beliebiger Kommandos in Linux, Erzeugung, Lesen und
> Überschreiben beliebiger Dateien
> 
> Hi, Greg, dear Linux experts and friends,
> 
> this is one of the most dangerous and worst things, Linux can happen!
> Refering to the actual kernel 5.4.134 ( now up to the actual version 5.4.151
> and higher, additional remark from 10.08.2021), there still is a problem with
> unexpectedly activated, highly active root-processes (making the tower-LED
> causing readwrites onto harddiscs and making the SSD/harddrive blink serious-
> madly hard for about up to 20 minutes). The whole SSD/harddrive seems to get
> read out and overwritten!
> 
> The unwanted, highly by tor (pclos, mga7) resp. firejail activated kernel-
> root-processes are named
> 
> kworker/u2:1-kcryptd/253:2 (escpecially this one, CPU: gt; 10%)
> kworker/0:1H-kblockd
> dmcrypt_write/2 and
> jbd2/dm2--8

Activity by these kernel threads indicate that some userspace program
running on your system is reading (and in the case of the
dmcrypt_write and jbd2 kernel threads, writing) data to your hard
drive.  They are a symptom, not the cause of whatever is causing the
large amount of activity on your SSD/hard drive.

It is not something that can be "patched" in the kernel.  It is an
indication of some program (or possibly malware) running on your
system is doing a lot of file I/O.

It is possible that as a result of some web site that you visited, it
is causing the web browser ("firejail", which sounds like the firefox
browser running some kind of security sandbox) to do a lot of I/O.  So
the first thing you might try is to exit the web browser and see that
causes the I/O to abate.  If it does, and if it starts up again when
you start the web browser and the web browser is not open on any web
pages, then you might have some misbehaving browser extension that
somehow got installed, and you might want to try clearing your browser
profile and uninstalling all of your browser extensions.

If exiting the browser does not cause the SSD/HDD activity to stop
within half a minute or so, then some other userspace program must be
causing it.  It is possible that this might be some background system
indexing (for example, rebuilding the locatedb), although normally if
you've left the system up at night, this sort of activity is done when
the system is idle typically in the wee hours of the morning.

But it is also possible that you have some kind of malware installed
on your system, in which case the only good solution is to reinstall
it.  In any case, this is not something that kernel developers can
help you with.  Perhaps if there is a local Linux User's Group that
you can contact for more assistance, they can help you.  If not,
you'll need to find someone who can help you with Linux system
administration.

Cheers,

						- Ted
