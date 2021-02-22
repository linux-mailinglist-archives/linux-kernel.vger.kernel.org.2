Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5E1322204
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 23:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhBVWQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 17:16:08 -0500
Received: from smtprelay0203.hostedemail.com ([216.40.44.203]:57388 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229967AbhBVWQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 17:16:07 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 4C69D180F8B93;
        Mon, 22 Feb 2021 22:15:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3867:3868:3872:3874:4043:4321:5007:7652:7974:10004:10400:11026:11232:11658:11914:12297:12555:12740:12760:12895:13069:13311:13357:13439:13972:14659:21080:21451:21611:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: dock96_5e1373f2767b
X-Filterd-Recvd-Size: 1266
Received: from [192.168.43.37] (unknown [172.58.35.73])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Mon, 22 Feb 2021 22:15:24 +0000 (UTC)
Message-ID: <f5d688e872eb838fa5851802a4ea1ef1e047177b.camel@perches.com>
Subject: Re: checkpatch warnings for references to earlier commits
From:   Joe Perches <joe@perches.com>
To:     "Luck, Tony" <tony.luck@intel.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 22 Feb 2021 14:15:21 -0800
In-Reply-To: <20210222211415.GA163057@agluck-desk2.amr.corp.intel.com>
References: <20210222211415.GA163057@agluck-desk2.amr.corp.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-02-22 at 13:14 -0800, Luck, Tony wrote:
> Would it be possible to teach checkpatch not to warn about
> canonical references to earlier commits?  E.g.
> 
> WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
> #7:
> commit e80634a75aba ("EDAC, skx: Retrieve and print retry_rd_err_log registers")

No, not really.  It's possible and typical for commit descriptions
to span multiple lines.  checkpatch accepts that.

