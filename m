Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFAA3E05CC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 18:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbhHDQWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 12:22:47 -0400
Received: from smtprelay0154.hostedemail.com ([216.40.44.154]:36738 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236749AbhHDQWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 12:22:46 -0400
Received: from omf08.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 05B16182331CE;
        Wed,  4 Aug 2021 16:22:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id 6C0E71A29F6;
        Wed,  4 Aug 2021 16:22:32 +0000 (UTC)
Message-ID: <2d594d0b06401887debd5ec462edcffdc813318a.camel@perches.com>
Subject: Re: [PATCH] get_maintainer: Append parenthesis back to trimmed
 subsystem name
From:   Joe Perches <joe@perches.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     open list <linux-kernel@vger.kernel.org>
Date:   Wed, 04 Aug 2021 09:22:31 -0700
In-Reply-To: <20210804160949.592227-1-kai.heng.feng@canonical.com>
References: <20210804160949.592227-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 6C0E71A29F6
X-Spam-Status: No, score=5.07
X-Stat-Signature: ztnketacw4su1hmsag9us5zshb99755u
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/eZrSB/Pnseq3IyCJxQT3hFmhSyNOHdgw=
X-HE-Tag: 1628094152-530424
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-08-05 at 00:09 +0800, Kai-Heng Feng wrote:
> When a closing parenthesis gets trimmed, there can be unmatched
> parenthesis in the subsystem name. This doesn't play well with
> git-send-email:
> (cc-cmd) Adding cc: intel-gfx@lists.freedesktop.org (open list:INTEL DRM DRIVERS (excluding Poulsbo, Moorestow...) from: 'scripts/get_maintainer.pl'
> Unmatched () '(open list:INTEL DRM DRIVERS (excluding Poulsbo, Moorestow...)' '' at /usr/lib/git-core/git-send-email line 554.
> error: unable to extract a valid address from: intel-gfx@lists.freedesktop.org (open list:INTEL DRM DRIVERS (excluding Poulsbo, Moorestow...)
> 
> So append parenthesis back if it was trimmed to make git-send-email
> work again:
> (cc-cmd) Adding cc: intel-gfx@lists.freedesktop.org (open list:INTEL DRM DRIVERS (excluding Poulsbo, Mooresto...)) from: 'scripts/get_maintainer.pl'

Probably better just to add --norolestats to the invoking command-line.

> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
[]
> @@ -1252,9 +1252,10 @@ sub get_subsystem_name {
>  
> 
>      my $subsystem = $typevalue[$start];
>      if ($output_section_maxlen && length($subsystem) > $output_section_maxlen) {
> -	$subsystem = substr($subsystem, 0, $output_section_maxlen - 3);
> +	my $parenthesis = substr($subsystem, -1) eq ")";
> +	$subsystem = substr($subsystem, 0, $output_section_maxlen - ($parenthesis ? 4 : 3));
>  	$subsystem =~ s/\s*$//;
> -	$subsystem = $subsystem . "...";
> +	$subsystem = $subsystem . "..." . ($parenthesis ? ")" : "");

Given an $output_section_maxlen number of possible parentheses, this should
probably use a while...


