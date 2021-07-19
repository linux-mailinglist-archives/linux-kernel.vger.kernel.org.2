Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7513CCEE6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 09:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbhGSHzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 03:55:21 -0400
Received: from smtprelay0003.hostedemail.com ([216.40.44.3]:55836 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235086AbhGSHzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 03:55:20 -0400
Received: from omf10.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id A9BE9182CF669;
        Mon, 19 Jul 2021 07:52:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 7A474235201;
        Mon, 19 Jul 2021 07:52:18 +0000 (UTC)
Message-ID: <4e42f2580d8b473ac7e25642b039adf73b5efe06.camel@perches.com>
Subject: Re: [PATCH v3] checkpatch: add a rule to check general block
 comment style
From:   Joe Perches <joe@perches.com>
To:     Ani Sinha <ani@anisinha.ca>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        anirban.sinha@nokia.com, mikelley@microsoft.com,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Mon, 19 Jul 2021 00:52:17 -0700
In-Reply-To: <alpine.DEB.2.22.394.2107191221570.12107@anisinha-lenovo>
References: <20210714063422.2164699-1-ani@anisinha.ca>
         <alpine.DEB.2.22.394.2107162145100.3277407@anisinha-lenovo>
         <CAKXUXMzxyQxYKdnuVbZnUFbYFuKMq+Vc5LxSR-_fKtH2dv-4wA@mail.gmail.com>
         <alpine.DEB.2.21.2107181853320.55905@ani-ubuntu>
         <c32293fc03a8673ade348ed4451c60dfdf9bb2c1.camel@perches.com>
         <alpine.DEB.2.22.394.2107191054260.9400@anisinha-lenovo>
         <CAKXUXMyJ9Ab_Fvpk8WAimEnDjcOhJRe2uODkC=RxCgsN8T0WyQ@mail.gmail.com>
         <alpine.DEB.2.22.394.2107191221570.12107@anisinha-lenovo>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.20
X-Stat-Signature: z3bsa5p4w1wukmhaczxk57wqwsy56yu9
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 7A474235201
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+zW0MKnEInLFW/aU2/8WJF+hl9TzGV3m0=
X-HE-Tag: 1626681138-267745
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-07-19 at 12:25 +0530, Ani Sinha wrote:

> I do not see why we cannot add this rule to checkpatch. If the
> reviewer likes the other style of commenting they can always ask for a
> correction. Having checkpatch agree with Linus' preferred style of
> commenting and the preferred documeted style of commenting (which seems to
> be the same) does make everything uniform and agreeable.

Too many novice developers take checkpatch output as dicta.

It's not.

It's just produces suggestions that should _always_ be taken
not very seriously.  Those suggestions should perhaps be
considered, but good taste should always override a brainless
script.

_Very_ few senior developers really care that much about any
particular comment style.

These are the same senior developers that would be burdened
with unnecessary patches to review from those novice developers
that believe checkpatch should always be followed.

Do not unnecessarily burden senior developers.
They are generally have other priorities.

