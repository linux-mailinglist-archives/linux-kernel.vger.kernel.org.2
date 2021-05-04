Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C062372C31
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 16:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbhEDOjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 10:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhEDOjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 10:39:11 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA37C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 07:38:15 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id w3so13552234ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 07:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Z5D40mY54B3wfJNIwzdry65d4frpdouUa5/Vn7+nC4=;
        b=THiE6sx5F1Jt1Q46OoMR1OUvw/mLdHS1Txc5IbyMsFnhEaVj254Ts9TWOeYFEotf4w
         Zy1yV8EOzSIcj13Wu03GShkDdUg/HDRTFZ7IF8YV7EGtmeG2xi03oOMSbbvY4pAa2Yx8
         Nt3ko999+qHYdONNiwiPUQD4tWxe7yI/OMZ6UQ4CyB43uu67+P0E6WzlAuO74nz2pUfE
         q31xcUSDKiAvqROSdFQ/6aoGFxCx1CqPcVJSxYhqyzB7lEOM58NqWdEJZmMbAj83lq1A
         50EcjTC+tKdVX2R4TeJEpMTgEpJWbMfUUQ+HRe0upQObwq9xMMai+7pAH5OoLQ5wbJY8
         ajXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Z5D40mY54B3wfJNIwzdry65d4frpdouUa5/Vn7+nC4=;
        b=e28Va9V6f6D1dtJa3S1wIfPv/N/qTOOgxws227YQoyFnn412laIx08VW5/usKAX3rh
         UUrOM2HZVQBbWIy0Q5suY2txRCY01F/F1ix3Gjk6MIXD6+MlJtuiT5BF3WLMTQrnhv+W
         pkq33PKFHcMxK5/LnKUmdQpHAB+Dt5jY/k2W3ThIQrwXB9jIF6d/TumWfh+gkmlJpJDM
         tFO3Fu24gIj3DfzFtqQHtnY/gBUSKikPW57avsq5ZbBna6WxQZwyEDH5sl1W4uOXiqUN
         9B87nCnXdXL3PWqsUsPaafZnCr5y6lTQCEFwrNzETkhNu8Q2jz4XrbQZ4RKm6ELr8sCH
         QT1w==
X-Gm-Message-State: AOAM531hAyIGzylRUxLkkWzOj+vfum6T6yy/LKrnSpPtuWg7j4R+YFfA
        03W7jlFNDmAck0rcXEGRss4=
X-Google-Smtp-Source: ABdhPJxpwcwemKlTUN6Gg0sSWeEW0gVTFmNbMFQKYu7PcsAG+WURifeW/Xjxah+OvBWAyiv0/hkl5Q==
X-Received: by 2002:a17:907:1b1e:: with SMTP id mp30mr22540827ejc.532.1620139094307;
        Tue, 04 May 2021 07:38:14 -0700 (PDT)
Received: from linux.local (host-79-52-107-152.retail.telecomitalia.it. [79.52.107.152])
        by smtp.gmail.com with ESMTPSA id dj17sm11129322edb.7.2021.05.04.07.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 07:38:13 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     outreachy-kernel@googlegroups.com,
        David Kershner <david.kershner@unisys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sparmaintainer@unisys.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [Outreachy kernel] Re: [PATCH v7] staging: unisys: visorhba: Convert module from IDR to XArray
Date:   Tue, 04 May 2021 16:38:11 +0200
Message-ID: <810075373.q0sU067TuV@linux.local>
In-Reply-To: <20210504140119.GH1847222@casper.infradead.org>
References: <20210504133253.32269-1-fmdefrancesco@gmail.com> <3550993.e1xmc6yJDa@linux.local> <20210504140119.GH1847222@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, May 4, 2021 4:01:19 PM CEST Matthew Wilcox wrote:
> On Tue, May 04, 2021 at 03:58:02PM +0200, Fabio M. De Francesco wrote:
> > On Tuesday, May 4, 2021 3:42:16 PM CEST Matthew Wilcox wrote:
> > > On Tue, May 04, 2021 at 03:32:53PM +0200, Fabio M. De Francesco wrote:
> > > > Changes from v6; Added a call to xa_destroy() that I had forgotten.
> > > 
> > > What?  No!  Go back and re-read what I wrote about this previously.
> > 
> > I remember that explanation you gave me some days ago for not using it. 
But I
> > was mislead by a comment ("Do we not have to call xa_destroy()?") by Dan 
and
> > your "Correct" soon after the above comment. So I thought that I had
> > misunderstand and the put back that call to xa_destroy(). I lost something 
in
> > following the flow of the reviews, I suppose.
> 
> English doesn't have the equivalent of the French 'si' or German 'doch',
> unfortunately.  I imagine Italian does.
>
Yes, Italian does :-) Despite this, I still think that English is less prone 
to give raise to misunderstandings (obviously, if_and_only_if one knows how to 
use the language).

Back to the style of the code... in particular to (1) avoid unnecessary 
'else', and to (2) check for failure (i.e., not for success) (3) don't 
(always) trust checkpatch.pl because often people don't want their code 
changed according to its output.

Start with (3): Steven Rostedt refused to apply a patch that I did upon a  
checkpatch warning: "replace "unsigned" with "unsigned int". He says he's 
perfectly comfortable with 'unsigned' and that he _prefers_ 'unsigned'. That's 
OK, I think; no problem.

As far as (1) and (2) are regarded, I've been told that when one modifies code 
she/he should not diverge from the style of the subsystem/driver maintainer/
author. If you look at visorhba_main.c, you'll find a lot of unnecessary 
'else' and 'if (success)'...

So what are the general rules one should follow when changing (trivial) Linux 
code? Please note that my question has no other (hidden) purposes than 
learning to work properly with the Linux community and to reduce the 
unnecessary noise consequential to submitting a high number of patch versions.

Thanks a lot for any help,

Fabio



