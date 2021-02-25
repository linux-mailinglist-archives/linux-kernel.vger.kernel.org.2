Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D756C325491
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 18:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhBYReb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 12:34:31 -0500
Received: from smtprelay0086.hostedemail.com ([216.40.44.86]:37152 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229548AbhBYRe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 12:34:28 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id A1E62180364DB;
        Thu, 25 Feb 2021 17:33:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2731:2828:2895:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:3873:4321:4605:5007:6119:6691:7652:7875:7903:9010:10004:10400:11232:11658:11783:11914:12043:12291:12296:12297:12555:12740:12895:13095:13138:13231:13439:13894:14181:14659:14721:21080:21433:21611:21627:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: view71_120217127693
X-Filterd-Recvd-Size: 3052
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Thu, 25 Feb 2021 17:33:41 +0000 (UTC)
Message-ID: <bcee822d1934772f47702ee257bc735c8f467088.camel@perches.com>
Subject: Re: [PATCH v7 0/2] checkpatch: add verbose mode
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 25 Feb 2021 09:33:40 -0800
In-Reply-To: <20210222075205.19834-1-dwaipayanray1@gmail.com>
References: <20210222075205.19834-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-02-22 at 13:22 +0530, Dwaipayan Ray wrote:
> Add a new verbose mode to checkpatch. The verbose test
> descriptions are read from the checkpatch documentation
> file at `Documentation/dev-tools/checkpatch.rst`.
> 
> The verbose mode is optional and can be enabled by the
> flag -v or --verbose.
> 
> The documentation file is only parsed by checkpatch.pl
> if the verbose mode is enabled. The verbose mode can
> not be used together with the --terse option.

I don't have any real objection to this patch set, but as this
might be added to the Documentation tree and in .rst format,
perhaps Jonathan Corbet and/or Mauro Carvalho Chehab might have
some opinion.

Also I do not want to be a maintainer of this .rst file and
likely neither Jon nor Mauro would either.  Perhaps you?

Ideally, the patch order would be reversed so the .rst file
is added first, then checkpatch updated to use it.

And _a lot_ more types and descriptive content should be added.

> 
> Changes in v7:
> - Add color coding support to --list-types option
> 
> Changes in v6:
> - Allow using verbose mode with --list-types option
> 
> Changes in v5:
> - Change the reference format to use absolute links.
> - Print verbose descriptions only for the first time
>   a message type is encountered.
> 
> Changes in v4:
> - Change the type description format
> - Group the message types by usage
> - Make handling of --terse with --verbose simpler
> 
> Changes in v3:
> - Simplify documentation file parsing in checkpatch
> - Document a total of 33 message types for checkpatch
> 
> Changes in v2:
> - Use .rst Field Lists to specify the type descriptions.
> - Add a few more type descriptions to documentation.
> 
> Dwaipayan Ray (2):
>   checkpatch: add verbose mode
>   docs: add documentation for checkpatch
> 
>  Documentation/dev-tools/checkpatch.rst | 525 +++++++++++++++++++++++++
>  Documentation/dev-tools/index.rst      |   1 +
>  scripts/checkpatch.pl                  | 133 ++++++-
>  3 files changed, 639 insertions(+), 20 deletions(-)
>  create mode 100644 Documentation/dev-tools/checkpatch.rst
> 


