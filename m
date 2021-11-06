Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315FA446CDC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 08:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhKFH1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 03:27:46 -0400
Received: from smtprelay0075.hostedemail.com ([216.40.44.75]:56296 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230307AbhKFH1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 03:27:45 -0400
Received: from omf02.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id B49A6837F24A;
        Sat,  6 Nov 2021 07:25:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id B32A11D42FD;
        Sat,  6 Nov 2021 07:25:02 +0000 (UTC)
Message-ID: <a89c8bea1d0c82f3b5567f5972afdd1700cd3440.camel@perches.com>
Subject: Re: [PATCH] checkpatch: relax regexp for COMMIT_LOG_LONG_LINE
From:   Joe Perches <joe@perches.com>
To:     Jerome Forissier <jerome@forissier.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Sat, 06 Nov 2021 00:25:01 -0700
In-Reply-To: <74572362-c45c-b10f-f825-2e8bb4e3b027@forissier.org>
References: <20210923143842.2837983-1-jerome@forissier.org>
         <74572362-c45c-b10f-f825-2e8bb4e3b027@forissier.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 4offg34pbmrog65n7yajjffrfa4x65uq
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: B32A11D42FD
X-Spam-Status: No, score=-2.34
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+sTaN7uY7+CFfxzEcam86v0cFFO4f5Zzk=
X-HE-Tag: 1636183502-825960
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-11-05 at 11:31 +0100, Jerome Forissier wrote:
> On 9/23/21 16:38, Jerome Forissier wrote:
> > One exceptions to the COMMIT_LOG_LONG_LINE rule is a file path followed
> > by :. That is typically some sort diagnostic message from a compiler or
> > a build tool, in which case we don't want to wrap the lines but keep the
> > message unmodified.
> > The regular expression used to match this pattern currently doesn't
> > accept absolute paths or + characters. This can result in false
> > positives as in the following (out-of-tree) example:
[]
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> > @@ -3147,7 +3147,7 @@ sub process {
> >  		    length($line) > 75 &&
> >  		    !($line =~ /^\s*[a-zA-Z0-9_\/\.]+\s+\|\s+\d+/ ||
> >  					# file delta changes
> > -		      $line =~ /^\s*(?:[\w\.\-]+\/)++[\w\.\-]+:/ ||
> > +		      $line =~ /^\s*(?:[\w\.\-\+]*\/)++[\w\.\-\+]+:/ ||
> >  					# filename then :

I looked the number of new matches

$ git log --format=email -100000 | \
  grep -P '^\s*(?:[\w\.\-]+\/)++[\w\.\-]+:' | wc -l
21160
$ git log --format=email -100000 | \
  grep -P '^\s*(?:[\w\.\-\+]*\/)++[\w\.\-]+:' | wc -l
21627

OK, so around 3% more matches.

And then looked only at these new matches

$ git log --format=email -100000 | \
  grep -P '^\s*(?:[\w\.\-\+]*\/)++[\w\.\-]+:' | \
  grep -P -v '^\s*(?:[\w\.\-]+\/)++[\w\.\-]+:'

And all these new matches look OK to me to ignore for long lines.
Out of tree or not...

Acked-by: Joe Perches <joe@perches.com>


