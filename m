Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9EA370048
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 20:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhD3SQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 14:16:47 -0400
Received: from wind.enjellic.com ([76.10.64.91]:47822 "EHLO wind.enjellic.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229750AbhD3SQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 14:16:44 -0400
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 13UIFeDY009486;
        Fri, 30 Apr 2021 13:15:40 -0500
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 13UIFd46009485;
        Fri, 30 Apr 2021 13:15:39 -0500
Date:   Fri, 30 Apr 2021 13:15:39 -0500
From:   "Dr. Greg" <greg@enjellic.com>
To:     linux-kernel@vger.kernel.org
Subject: Do kernel namespaces have a desire to be inclusive to newcomers?
Message-ID: <20210430181539.GA9323@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Fri, 30 Apr 2021 13:15:40 -0500 (CDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I hope the week has gone well for everyone, apologies in advance
for indulging in a bit of political humor for the subject of this
e-mail.

We are rounding the corner for the release of a new security
architecture for Linux that weaves together IMA and the LSM
infrastructure.  It is designed to support what we think the future is
going to be for security when OpenTitan and/or Pluton grow up to be
adults.

Part and parcel to the architecture is the implementation of a
namespace for modeling security event domains.  We chose to update our
code from an initial implementation on 4.4 to 5.4, given the latter's
status as an LTS release, and the availability of the clone3() system
call and the expanded bit field width for the designation of namespace
types.

Using anything for a namespace type designator that translates into
something beyond a 32-bit value seems to run afoul of the fact that an
int is used for the type element of the proc_ns_operations structure.
Since all of this is decidedly outside the kernel, and may never be
appropriate for mainline, this isn't a big issue but if our reasoning
is correct it will be a potential issue for other namespaces once the
remaining lower bits of the flags field is consumed.

Since we currently only need unshare capabilities, we used the bit
position below CLONE_NEWTIME for the time being but are interested in
knowing if this limitation is by design or if a patch would be
acceptable for simply pushing that structure element out to 64 bits,
which in classical technology parlance; 'should be enough for anyone'.

Any thoughts would be appreciated.

Best wishes for a pleasant weekend to everyone.

Dr. Greg

As always,
Dr. Greg Wettstein, Ph.D, Worker      Autonomously self-defensive
Enjellic Systems Development, LLC     IOT platforms and edge devices.
4206 19th Ave. N.
Fargo, ND  58102
PH: 701-281-1686                      EMAIL: greg@enjellic.com
------------------------------------------------------------------------------
"Don't worry about people stealing your ideas.  If your ideas are any
 good, you'll have to ram them down people's throats."
                                -- Howard Aiken
