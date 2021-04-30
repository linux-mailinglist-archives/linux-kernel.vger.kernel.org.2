Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D4336F3E8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 04:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhD3CEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 22:04:01 -0400
Received: from smtprelay0060.hostedemail.com ([216.40.44.60]:49754 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229577AbhD3CEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 22:04:00 -0400
Received: from omf17.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 61B9F180278B4;
        Fri, 30 Apr 2021 02:03:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id 2A83527DD11;
        Fri, 30 Apr 2021 02:03:11 +0000 (UTC)
Message-ID: <8dc8272b78e2340a4244ded29d342ff0f0f519eb.camel@perches.com>
Subject: Re: [RFC v3] scripts: kernel-doc: reduce repeated regex expressions
 into variables
From:   Joe Perches <joe@perches.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Aditya Srivastava <yashsri421@gmail.com>
Cc:     lukas.bulwahn@gmail.com, willy@infradead.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 29 Apr 2021 19:03:09 -0700
In-Reply-To: <8735v8d5ja.fsf@meer.lwn.net>
References: <20210427165633.GA235567@casper.infradead.org>
         <20210429063729.8144-1-yashsri421@gmail.com> <8735v8d5ja.fsf@meer.lwn.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.60
X-Stat-Signature: xe1pdak8z3o5kcfrqusxzbhj9hisx4we
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 2A83527DD11
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+WL1RP+awhB6YUyhGH9yq3tt1EagZ+/iE=
X-HE-Tag: 1619748191-726048
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-04-29 at 17:39 -0600, Jonathan Corbet wrote:
> Aditya Srivastava <yashsri421@gmail.com> writes:
> 
> > There are some regex expressions in the kernel-doc script, which are used
> > repeatedly in the script.
> > 
> > Reduce such expressions into variables, which can be used everywhere.
> > 
> > A quick manual check found that no errors and warnings were added/removed
> > in this process.
> > 
> > Suggested-by: Jonathan Corbet <corbet@lwn.net>
> > Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
> > ---
> > Changes in v3:
> > - Remove variables for separate qualifiers in "sub dump_struct"
> > - Make a common variable for all the qualifiers
> > - Make $attribute global variable to use it at "sub check_sections" as well
> > 
> > Changes in v2:
> > - Rename $pointer_function to $function_pointer
> > - Combine elsif-block expressions at "sub dump_function" into lesser regex expressions
> > - Combine $prototype_end1,$prototype_end2 expressions into a common $prototype_end
> > 
> >  scripts/kernel-doc | 71 ++++++++++++++++++++++------------------------
> >  1 file changed, 34 insertions(+), 37 deletions(-)
> 
> So this looks good but ... it adds a warning to the build:
> 
> /stuff/k/git/kernel/Documentation/driver-api/media/v4l2-controls:823: ./include/media/v4l2-ctrls.h:964: WARNING: Invalid C declaration: Expected identifier in nested name. [error at 6]
>   const * v4l2_ctrl_get_menu (u32 id)
>   ------^
> 
> So it looks like something isn't being parsed quite identically?

Perhaps a few of the regexes from checkpatch could be used or
maybe a linux specific perl module produced.


