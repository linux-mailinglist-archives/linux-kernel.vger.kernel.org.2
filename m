Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29373BA6E6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 05:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhGCDaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 23:30:01 -0400
Received: from smtprelay0204.hostedemail.com ([216.40.44.204]:55822 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230130AbhGCDaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 23:30:00 -0400
Received: from omf10.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 7314518172CD4;
        Sat,  3 Jul 2021 03:27:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 71B152351F3;
        Sat,  3 Jul 2021 03:27:25 +0000 (UTC)
Message-ID: <791e3b6560056a9dc7a729c72591af6611163f6d.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Add check for common mailing list helper
 checks
From:   Joe Perches <joe@perches.com>
To:     "John 'Warthog9' Hawley (VMware)" <warthog9@eaglescrag.net>,
        linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 02 Jul 2021 20:27:23 -0700
In-Reply-To: <20210702223743.1240694-1-warthog9@eaglescrag.net>
References: <20210702223743.1240694-1-warthog9@eaglescrag.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.40
X-Stat-Signature: ypay3snr36wqspezunpyojicpzctzit4
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 71B152351F3
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19lZVZVYli8dMZybR8Tp6FqE0sr7r0QGt0=
X-HE-Tag: 1625282845-267056
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-07-02 at 15:37 -0700, John 'Warthog9' Hawley (VMware)
wrote:
> From: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
> 
> Mailing lists in an attempt to try and avoid sending certain
> administrative e-mails to the list, will check the first few lines
> (usually ~10) looking for keywords.  If those key words are found it
> shunts the e-mail to the list admin contact instead of potentially
> passing it through to the list.
> 
> This adds a known list of the potential things that are checked for, and
> while it may search deeper into the message (it goes till it believes
> it's into the patch section) than the mailing list software this should
> help give some warning if the wrong word is potentially added in the
> wrong place in the beginning of a patch message.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -2852,6 +2852,40 @@ sub process {
[]
> +# check if this may trip up common mailing list helpers to redirect email to the admin contact
> +		if ($in_commit_log &&
> +		    ($line =~ /\bcancel\b/i ||
> +		    $line =~ /\badd me\b/i ||
> +		    $line =~ /\bdelete me\b/i ||
> +		    $line =~ /\bremove\s+me\b/i ||
> +		    $line =~ /\bchange\b.*\baddress\b/ ||
> +		    $line =~ /\bsubscribe\b/i ||
> +		    $line =~ /^sub\b/i ||
> +		    $line =~ /\bunsubscribe\b/i ||
> +		    $line =~ /^unsub\b/i ||
> +		    $line =~ /^\s*help\s*$/i ||
> +		    $line =~ /^\s*info\s*$/i ||
> +		    $line =~ /^\s*info\s+\S+\s*$/i ||
> +		    $line =~ /^\s*lists\s*$/i ||
> +		    $line =~ /^\s*which\s*$/i ||
> +		    $line =~ /^\s*which\s+\S+\s*$/i ||
> +		    $line =~ /^\s*index\s*$/i ||
> +		    $line =~ /^\s*index\s+\S+\s*$/i ||
> +		    $line =~ /^\s*who\s*$/i ||
> +		    $line =~ /^\s*who\s+\S+\s*$/i ||
> +		    $line =~ /^\s*get\s+\S+\s*$/i ||
> +		    $line =~ /^\s*get\s+\S+\s+\S+\s*$/i ||
> +		    $line =~ /^\s*approve\b/i ||
> +		    $line =~ /^\s*passwd\b/i ||
> +		    $line =~ /^\s*newinfo\b/i ||
> +		    $line =~ /^\s*config\b/i ||
> +		    $line =~ /^\s*newconfig\b/i ||
> +		    $line =~ /^\s*writeconfig\b/i ||
> +		    $line =~ /^\s*mkdigest\b/i)){

Have you checked this list against actual commits?

> +			WARN("MAILING LIST HELPER",

This must use underscores for the spaces

	MAILING_LIST_HELPER


