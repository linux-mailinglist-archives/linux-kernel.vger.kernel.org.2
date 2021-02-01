Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E35130AE9D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhBASAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:00:20 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37786 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229555AbhBASAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:00:18 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 111HxPfR028486
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 1 Feb 2021 12:59:25 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 15A5B15C39D9; Mon,  1 Feb 2021 12:59:25 -0500 (EST)
Date:   Mon, 1 Feb 2021 12:59:25 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Joe Perches <joe@perches.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-kernel-mentees] Patches from the future - can checkpatch
 help?
Message-ID: <YBhBfdZecMscxPOE@mit.edu>
References: <CABJPP5AxB8-kafFEpsMydg8eMx8bH5ooT5g7r0fKWV2T2Hjtng@mail.gmail.com>
 <YBguQ/dENrfvtptJ@kroah.com>
 <CAKXUXMwtXTYfs_9Asnmpd09zsucg8tRehMi2Shv8V49H-rs4xA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKXUXMwtXTYfs_9Asnmpd09zsucg8tRehMi2Shv8V49H-rs4xA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 05:50:45PM +0100, Lukas Bulwahn wrote:
> 
> Dwaipayan, there are two ways:
> - We build a bot listening to mailing lists and check. I like that
> implementation idea for various other checks.
> - Stephen Rothwell could include this as a check on linux-next and
> inform the git author and committer.
> 
> I am wondering though if that is worth the effort, three instances of
> a wrong date among 1M commits seems to be very seldom and the harm of
> that mistake is quite small as well.

Another solution might be to ask the git developers if they would be
willing to have "git am" print a warning if the date is sufficiently
insane (say, more than 3 months in the past or present).

One could also imagine a request that "git log" would have a new
format where normally the author time is printed, but if it's
sufficiently different from the commit time, the commit time is also
printed in parenthesis.

Or you could set up your git config so that "git log" uses
--pretty=fuller by default, which prints both the author date and
commit date.

Like Lukas, I'm not really sure it's worth the effort, however.

     	    	    	   	     - Ted
