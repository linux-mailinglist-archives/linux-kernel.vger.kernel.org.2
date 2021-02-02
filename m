Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4EC30CD18
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 21:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbhBBU3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 15:29:50 -0500
Received: from audible.transient.net ([24.143.126.66]:45780 "HELO
        audible.transient.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S233785AbhBBU1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 15:27:37 -0500
Received: (qmail 31260 invoked from network); 2 Feb 2021 20:26:48 -0000
Received: from cucamonga.audible.transient.net (192.168.2.5)
  by canarsie.audible.transient.net with QMQP; 2 Feb 2021 20:26:48 -0000
Received: (nullmailer pid 3418 invoked by uid 1000);
        Tue, 02 Feb 2021 20:26:48 -0000
Date:   Tue, 2 Feb 2021 20:26:48 +0000
From:   Jamie Heilman <jamie@audible.transient.net>
To:     Karol Herbst <kherbst@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        nouveau <nouveau@lists.freedesktop.org>
Subject: Re: [Nouveau] nouveau regression post v5.8, still present in v5.10
Message-ID: <YBm1iJXeDvf/Z7B4@audible.transient.net>
Mail-Followup-To: Karol Herbst <kherbst@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        nouveau <nouveau@lists.freedesktop.org>
References: <X+WV8OiQzTIfLdgW@audible.transient.net>
 <CACO55tt9GbwBU6igAJ_8RjwzSZcDbu+_1wGWKiye3TosgoiHyw@mail.gmail.com>
 <X/NO9kAlCd/k8Di2@audible.transient.net>
 <X/NT0iN9KlSXQJJ7@audible.transient.net>
 <X/UsBWwFR+V0hIOS@audible.transient.net>
 <CACO55ttrFCOzREQxi3+SSaCSsAP1bEUBEt78ajkRGQQU1xYxtw@mail.gmail.com>
 <YAjn9jR+d2zRfNjb@audible.transient.net>
 <CACO55tu+5vv3dU3+O=DGDo9EdcyqFtpF4WR-VNj5eo89WMSfpw@mail.gmail.com>
 <YAtMEGJxlRklqYw8@audible.transient.net>
 <YAtxgP6YJJwcotuA@audible.transient.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAtxgP6YJJwcotuA@audible.transient.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Heilman wrote:
> Jamie Heilman wrote:
> > Karol Herbst wrote:
> > > fyi, there is a patch which solves a maybe related issue on your GPU,
> > > mind giving it a try before we dig further?
> > > https://gitlab.freedesktop.org/drm/nouveau/-/issues/14#note_767791
> > 
> > So, I tried that.  Turns out, I can still trigger a problem.  Is it
> > the same problem?  Maybe?  I also tried applying the patch from 
> > 
> > ca386aa7155a ("drm/nouveau/kms/nv50-gp1xx: add WAR for EVO push buffer HW bug")
> > to 5.8.0-rc6-01516-g0a96099691c8 and very interestingly, it changed
> > the mode of failure to same thing I saw with 5.10.9 patched with the patch
> > from that bug report.  In both cases I get this in the log:
> > 
> > kern.err: nouveau 0000:01:00.0: Xorg[2243]: nv50cal_space: -16
> > kern.err: nouveau 0000:01:00.0: Xorg[2243]: nv50cal_space: -16
> > kern.err: nouveau 0000:01:00.0: Xorg[2243]: nv50cal_space: -16
> > kern.err: nouveau 0000:01:00.0: Xorg[2243]: nv50cal_space: -16
> > ...
> > and so on
> > 
> > In one incident my monitor would't even wake up anymore after this.
> > 
> > 
> > I'm trying to repo it now on an unpatched 5.8.0-rc6-01515-gae09163ac27c
> > right now, as running glxgears does seem to help reproduce problems
> > faster which is nice, I'm just not entirely sure it's the same set of
> > problems; hopefully that version is free from issues, but we'll
> > see...
> 
> Ugh, well I can crash 5.8.0-rc6-01515-gae09163ac27c and 5.8.18 in
> basically the same way running glxgears and a xset dpms force off
> loop.  So I'm starting to think it's not the same thing, and that
> problem has been latent from before I started having periodic issues.
> 
> I should note that my exact testing technique for the above was to run
> 4 copies of glxgears and the xset force dpms off loop at the same
> time.  Really looks more like it triggers a resource starvation issue
> maybe.  The crash is also worse, particularly if I don't do anything
> about it right away as my workstation eventually falls off the network
> and I'm forced to power cycle it; the crashes I was chasing after
> wouldn't do quite that much violence, normally I could still log in,
> rebuild a kernel, and shut things down cleanly.
> 
> More than one bug here I suspect.

OK, I went back and bisected again while patching known issues to get
a better idea what was causing the problem I've been having and I'm
confident it was the bug which Bastian Beranek's patch (now in
mainline) addressed.  My original bisection got confused by the
EVO push buffer HW bug which was fixed in ca386aa7155a54.  Once I
bisected with the patch from ca386aa7155a54 applied, my bisection
landed on f844eb485eb05 and Bastian Beranek's patch fixed that right
up.

'course I remain mildly concerned I can crash the kernel with little
more than glxgears and xset ... but the original stability problem I
reported I can safely say has been fixed.  If I can figure out the
nature of what I suspect is unrecoverable resource starvation, I'll
start a new thread for that.


-- 
Jamie Heilman                     http://audible.transient.net/~jamie/
