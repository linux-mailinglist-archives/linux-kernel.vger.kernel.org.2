Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB3F30FF3B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 22:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhBDVVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 16:21:09 -0500
Received: from ms.lwn.net ([45.79.88.28]:50094 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229572AbhBDVVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 16:21:08 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 023FB1E77;
        Thu,  4 Feb 2021 21:20:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 023FB1E77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1612473626; bh=2OvAOj50zgqTaHGlWFPjhvRwd0m8RHr6DEjLCAMm980=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NNxME403VqDsaZ+hmKsA/fHO3aDtcuVEJ3Gq+vPB8cp3rzMub2lvgWDgIdIbwg2Lw
         YogFyi09ssn6OWggWbesjzA/F+6ibRZmSR1nqBqwh5RMnZCWE954gXLw7vXjZXt8r7
         G/tJzSZe8cftbeGoILL97swkNGIbj8D4+BRDCXCaE7xE9Ult++M5Szz2u/wytjQhpI
         3uooHzHTqAfMi01zP4H28bqHGvG2UIGyGzwCnbGq+ZKPJDyf2N/L2SMkyac+k4XgIz
         Aoitf6V37w8Eb/XRwN0tUZV6xvaGomaJFq4aEgZBCKw2ku/5tv6E8w/EzYI+WCNzGH
         yKXaIyNAnCTeQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation/submitting-patches: Add blurb about
 backtraces in commit messages
In-Reply-To: <20210202154339.GE18075@zn.tnic>
References: <20201217183756.GE23634@zn.tnic>
 <20201221095425.6da68163@lwn.net> <20201222130555.GA13463@zn.tnic>
 <20210104161911.38eb3e1e@lwn.net> <20210105104805.GC28649@zn.tnic>
 <20210202154339.GE18075@zn.tnic>
Date:   Thu, 04 Feb 2021 14:20:25 -0700
Message-ID: <87tuqrfs2u.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:

> On Tue, Jan 05, 2021 at 11:48:05AM +0100, Borislav Petkov wrote:
> Lemme ping here quick - my TODO list still has it. :-)

Yeah, it's been languishing on mine as well.  Nobody seems to have any
objections, so I applied it, sorry for sitting on it for so long.

Thanks,

jon
