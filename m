Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9D835F631
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 16:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348407AbhDNOaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 10:30:11 -0400
Received: from smtprelay0135.hostedemail.com ([216.40.44.135]:46038 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231451AbhDNOaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 10:30:07 -0400
Received: from omf15.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 64A83180F3243;
        Wed, 14 Apr 2021 14:29:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id 30F93C417C;
        Wed, 14 Apr 2021 14:29:41 +0000 (UTC)
Message-ID: <b22ffa716ee871f7e09ad7321213a897156edab0.camel@perches.com>
Subject: Re: [PATCH] staging: greybus: Match parentheses alignment
From:   Joe Perches <joe@perches.com>
To:     Alex Elder <elder@ieee.org>, Greg KH <gregkh@linuxfoundation.org>,
        Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
Cc:     johan@kernel.org, elder@kernel.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Wed, 14 Apr 2021 07:29:37 -0700
In-Reply-To: <1607b040-6bc4-9a58-ae81-4ea0adf5885d@ieee.org>
References: <20210406124259.GA96537@zhans> <YGxhrLZPIPjILWUH@kroah.com>
         <7d7be8bcc0e80d826083890ed7791070ad25e603.camel@perches.com>
         <1607b040-6bc4-9a58-ae81-4ea0adf5885d@ieee.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 30F93C417C
X-Spam-Status: No, score=0.10
X-Stat-Signature: qxmpd7uwx1trgicc8moxoesttq4xqzoj
X-Rspamd-Server: rspamout04
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+1NzsPGZWu9MVb0Y9a001YjgapTn4QqE4=
X-HE-Tag: 1618410581-635424
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-04-14 at 08:17 -0500, Alex Elder wrote:
> Perhaps (like the -W options for GCC) there
> could be a way to specify in a Makefile which checkpatch
> messages are reported/not reported?  I don't claim that's
> a good suggestion, but if I could optionally indicate
> somewhere that "two consecutive blank lines is OK for
> Greybus" (one example that comes to mind) I might do so.

checkpatch already has --ignore=<list> and --types=<list>
for the various classes of messages it emits.

see: $ ./scripts/checkpatch.pl --list-types --verbose

Dwaipayan Ray (cc'd) is supposedly working on expanding
the verbose descriptions of each type.

