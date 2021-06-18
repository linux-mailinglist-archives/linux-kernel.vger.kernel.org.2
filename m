Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF193AC9D8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 13:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbhFRLax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 07:30:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37743 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232027AbhFRLau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 07:30:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2329A61260;
        Fri, 18 Jun 2021 11:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624015721;
        bh=Sa6qZE3QNHE3M51R0IukZj2WfR63Jf3Sq9L759jl7Ms=;
        h=From:To:Cc:Subject:Date:From;
        b=IRytBE4Op3X7dUSIUjmwFxFrmCN6Y/x0UC3SEr8YvrKu3aJZUTq+qVP77rHQAjUUF
         1/qFSWEyZoMVhM+x97DQLM/hTmt8gfas9bzYaF4CVnXEsHcnIqNUxgxN3y1zvCweGK
         246H1koB/bB1FCkRhOMtc0mZtTaoPpgAZOxrjZ3WaPSuqaZ095LboV8SydRo+DRmxv
         Z9dELcHVNoAl+X8ElXBJrLrwBf3Gi6738iVWyhVZpS7FWP2BrHhnlbB9dwFtayefwh
         J+NXKAR8sMtX1TszlmESvCvIMYVPgECZJv9g0LeSnuzy4HIPBMWSndLf1El8vQhqXM
         8pJZ1YgdTEi1A==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1luCfu-008agJ-Qk; Fri, 18 Jun 2021 13:28:38 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH RFC 0/1] get_abi.pl: add support for ABI valitation in runtime
Date:   Fri, 18 Jun 2021 13:28:36 +0200
Message-Id: <cover.1624014140.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

I was talking today with Jonathan Cameron today about how to ensure that
the ABI is not missing something.

While it would be doable to validate the ABI by searching __ATTR and similar
macros around the driver, this would probably be very complex and would
take a while to parse.

Yet, there's one way that should be quick and easier to implement:

Read the symbols from the current system in runtime, and check if
everything is declared under Documentation/ABI.

As you know, scripts/get_abi.pl has already a search command, that would
allow seeking for a symbol inside the ABI. Using a logic similar to that,
but checking for all symbols under /sys is not hard to implemenent.
That's what patch 1 does.

Right now, the results aren't exaustive (I opted this way for the RFC
version, as otherwise there will be too many symbols that won't match
the regexes generated from the What:  fields).

It basically reports results where the sysfs nodename matches one or
more What, but doesn't match the regex.

This implementation runs very quick on my desktop: it takes less than
2 seconds to run. So, it sounds a good start to help identifying what's
missing.

One of the problems with the ABI definitions is how to define wildcards
there. Different ABI declarations use different notations. For this first
RFC version, it all the above as wildcards[1]:

	<foo>
	{foo}
	[foo]
	/.../
	*

and convert them into:

	.*

[1] perhaps the better would be to just use regex on What:, as this would
    avoid extra heuristics at get_abi.pl, but this is somewhat OOT from
    this patch.

One of the first results is that some /sys symbols that are present
on *lots* of sysfs nodes, but they aren't properly defined at ABI:

	 /sys/.*/(initstate|bind|unbind)

(there are definitions, but those aren't covering all occurrences)

Another problem it caught is that slab definitions are like:
	 /sys/kernel/slab/cache/alloc_calls

Instead of using a wildcard, like:
	/sys/kernel/slab/*/alloc_calls
or:
	/sys/kernel/slab/<cache>/alloc_calls

So, they don't  match the actual symbols found at the system.

What do you think?

Regards,
Mauro

Mauro Carvalho Chehab (1):
  get_abi.pl: Check for missing symbols at the ABI specs

 scripts/get_abi.pl | 72 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 2 deletions(-)

-- 
2.31.1


