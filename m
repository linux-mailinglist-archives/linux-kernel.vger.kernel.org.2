Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5058440FFB7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 21:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242524AbhIQTVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 15:21:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:50126 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242389AbhIQTV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 15:21:29 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Sep 2021 15:21:28 EDT
Received: (qmail 11786 invoked by uid 109); 17 Sep 2021 19:13:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Sep 2021 19:13:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20772 invoked by uid 111); 17 Sep 2021 19:13:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Sep 2021 15:13:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 17 Sep 2021 15:13:24 -0400
From:   Jeff King <peff@peff.net>
To:     Rolf Eike Beer <eb@emlix.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        Git List Mailing <git@vger.kernel.org>,
        Tobias Ulmer <tu@emlix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: data loss when doing ls-remote and piped to command
Message-ID: <YUTo1BTp7BXOw6K9@coredump.intra.peff.net>
References: <6786526.72e2EbofS7@devpool47>
 <CAHk-=wgyk0mwYcMRC8HakzoAKL2Y3gwzD433tqKYYhV+r1PLnA@mail.gmail.com>
 <xmqq7dfgtfpt.fsf@gitster.g>
 <2722184.bRktqFsmb4@devpool47>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2722184.bRktqFsmb4@devpool47>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 08:59:07AM +0200, Rolf Eike Beer wrote:

> What you need is a _fast_ git server. kernel.org or github.com seem to be too 
> slow for this if you don't sit somewhere in their datacenter. Use something in 
> your local network, a Xeon E5 with lot's of RAM and connected with 1GBit/s 
> Ethernet in my case.

One thing that puzzled me here: is the bad output between the server and
ls-remote, or between ls-remote and its output pipe?

I'd guess it has to be the latter, since otherwise ls-remote itself
would barf with an error message.

In that case, I'd think "git ls-remote ." would give you the fastest
outcome, because it's talking to upload-pack on the local box. But I'm
also confused how the speed could matter, as ls-remote reads the entire
input into an in-memory array, and then formats it.

We do the write using printf(). Is it possible your libc's stdio may
drop bytes when the pipe is full, rather than blocking? In general, I'd
expect write() to block, so libc doesn't have to care at all. But might
there be something in your environment putting the pipe into
non-blocking mode, and we get EAGAIN or something? If so, I'd expect
stdio to return the error.

Maybe patching Git like this would help:

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index f4fd823af8..5936b2b42c 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -146,7 +146,8 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		const struct ref_array_item *ref = ref_array.items[i];
 		if (show_symref_target && ref->symref)
 			printf("ref: %s\t%s\n", ref->symref, ref->refname);
-		printf("%s\t%s\n", oid_to_hex(&ref->objectname), ref->refname);
+		if (printf("%s\t%s\n", oid_to_hex(&ref->objectname), ref->refname) < 0)
+			die_errno("printf failed");
 		status = 0; /* we found something */
 	}
 

> And the reader must be "somewhat" slow. Using sha256sum works reliably for me. 
> Using "wc -l" does not, also md5sum and sha1sum are too fast as it seems.

If a slow pipe is involved, maybe:

  git ls-remote . | (sleep 5; cat) | sha256sum

would help reproduce. Assuming ls-remote's output is bigger than your
system pipe buffer (which is another interesting thing to check), then
it should block for 5 seconds on write() midway through the output,
which you can verify with strace.

-Peff
