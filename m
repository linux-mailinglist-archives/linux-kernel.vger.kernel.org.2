Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF26A43BE78
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 02:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbhJ0A2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 20:28:51 -0400
Received: from smtprelay0007.hostedemail.com ([216.40.44.7]:56674 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229914AbhJ0A2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 20:28:49 -0400
Received: from omf04.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 4C464100E896F;
        Wed, 27 Oct 2021 00:26:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 30217D1517;
        Wed, 27 Oct 2021 00:26:23 +0000 (UTC)
Message-ID: <868c29d45172a151b6a751de4ba32165cbf7a4cc.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Remove cvs keyword check
From:   Joe Perches <joe@perches.com>
To:     Kari Argillander <kari.argillander@gmail.com>, apw@canonical.com
Cc:     dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev
Date:   Tue, 26 Oct 2021 17:26:21 -0700
In-Reply-To: <20211026231637.3750-1-kari.argillander@gmail.com>
References: <20211026231637.3750-1-kari.argillander@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.25
X-Stat-Signature: yrhp8yq6gdmt8bg9ckaftq1j98qbcgoj
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 30217D1517
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+KOql8maOPTfoX2IZXwdHG1FfP0LkMQN8=
X-HE-Tag: 1635294383-507720
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-10-27 at 02:16 +0300, Kari Argillander wrote:
> Time has pass and we do not need these anymore as almost all people are
> using git now days. Those who use cvs for kernel development probably
> will handle cvs pretty well already so this check is not needed anymore.

I think it's a relatively harmless thing to keep.

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -4017,12 +4017,6 @@ sub process {
>  			}
>  		}
>  
> -# check for RCS/CVS revision markers
> -		if ($rawline =~ /^\+.*\$(Revision|Log|Id)(?:\$|)/) {

Looks like this would be better using

		if ($rawline =~ /^\+.*\b\$(?:Revision|Log|Id)\$?\b/) {

> -			WARN("CVS_KEYWORD",
> -			     "CVS style keyword markers, these will _not_ be updated\n". $herecurr);


