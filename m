Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E1A42F8B5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 18:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241665AbhJOQx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 12:53:27 -0400
Received: from smtprelay0140.hostedemail.com ([216.40.44.140]:60616 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236997AbhJOQxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 12:53:13 -0400
Received: from omf04.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id EEC578384364;
        Fri, 15 Oct 2021 16:51:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id C92EBD1517;
        Fri, 15 Oct 2021 16:50:59 +0000 (UTC)
Message-ID: <8536d4a99103982688de6cdaeea51bc92a67af90.camel@perches.com>
Subject: Re: [PATCH 1/2] checkpatch: Add check item for RFC tags is outside
 the subject prefix
From:   Joe Perches <joe@perches.com>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 15 Oct 2021 09:50:58 -0700
In-Reply-To: <20211015075853.4038-1-caihuoqing@baidu.com>
References: <20211015075853.4038-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.65
X-Stat-Signature: pqmsez3o4czcb891jrtsp7wfi11fphbg
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: C92EBD1517
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+6HaJSlAtVEd4O7sPpjarRmFmgrMz/hgc=
X-HE-Tag: 1634316659-100383
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-10-15 at 15:58 +0800, Cai Huoqing wrote:
> Some patches have been sent, the RFC tag of which is
> outside the subject prefix is incorrect. like this:
> "Subject: [PATCH v2] RFC:"
> 
> Perfer "Subject: [RFC PATCH v2]" to "Subject: [PATCH v2] RFC:",
> so add check item for it.

typo of prefer but does this matter enough to make it a test?

Same typo in next patch.

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3121,6 +3121,12 @@ sub process {
>  			     "A patch subject line should describe the change not the tool that found it\n" . $herecurr);
>  		}
>  
> +# Check if RFC tags is outside the subject prefix
> +		if ($in_header_lines && $line =~ /^Subject:.*patch\s*.*]\s*rfc:/i) {
> +			WARN("RFC_TAG_PREFIX",
> +			     "RFC tag is outside subject prefix, try \"git format-patch --rfc\"\n" . $herecurr);
> +		}
> +
>  # Check for Gerrit Change-Ids not in any patch context
>  		if ($realfile eq '' && !$has_patch_separator && $line =~ /^\s*change-id:/i) {
>  			if (ERROR("GERRIT_CHANGE_ID",


