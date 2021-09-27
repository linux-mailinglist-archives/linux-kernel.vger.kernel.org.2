Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56AB1419D93
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 19:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235825AbhI0Ryx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 13:54:53 -0400
Received: from smtprelay0154.hostedemail.com ([216.40.44.154]:37166 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235693AbhI0Ryr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:54:47 -0400
Received: from omf10.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 06005182CF66A;
        Mon, 27 Sep 2021 17:53:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id EEE282351FD;
        Mon, 27 Sep 2021 17:53:06 +0000 (UTC)
Message-ID: <06f4c72fefeedb5145a940e5a78d50e610acdcc4.camel@perches.com>
Subject: Re: [PATCH] Documentation: checkpatch: Document some more message
 types
From:   Joe Perches <joe@perches.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Utkarsh Verma <utkarshverma294@gmail.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 27 Sep 2021 10:53:05 -0700
In-Reply-To: <875yulj4m8.fsf@meer.lwn.net>
References: <20210925201746.15917-1-utkarshverma294@gmail.com>
         <875yulj4m8.fsf@meer.lwn.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.24
X-Stat-Signature: jdo8rn3iu85ra5dgdfz9s646q3uffz3s
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: EEE282351FD
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/rK5szfXkBwjy2oIFBr8NmlE5PEiJTWk8=
X-HE-Tag: 1632765186-292574
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-09-27 at 11:43 -0600, Jonathan Corbet wrote:
> Utkarsh Verma <utkarshverma294@gmail.com> writes:
> 
> > Added and documented 3 new message types:
> > - UNNECESSARY_INT
> > - UNSPECIFIED_INT
> > - UNNECESSARY_ELSE
> > 
> > Signed-off-by: Utkarsh Verma <utkarshverma294@gmail.com>
> > ---
> >  Documentation/dev-tools/checkpatch.rst | 47 ++++++++++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> 
> So...when you send multiple patches with the same subject line that's
> always a bad sign.  We really want a "git --oneline" listing to give a
> good idea of what the patch does, and that depends on more descriptive
> subject lines.
> 
> In this case, something like:
> 
>   docs: checkpatch: add UNNECESSARY/UNSPECIFIED_INT and UNNECESSARY_ELSE
> 
> I can fix up these two patches, but please try to keep this in mind for
> future work.
> 
> (applying the patches now).

The unnecessary_else description isn't particularly good as the
checkpatch output doesn't describe multiple if/else if/else if type
returns where the message should not apply.

For this type of use, the checkpatch message is not necessarily correct
and because it could be a patch context, there's no way for checkpatch
to know if it's correct or not.

	if (foo) {
		...
	} else if (bar) {
		...
		return [val];
	} else {
		...
	}



