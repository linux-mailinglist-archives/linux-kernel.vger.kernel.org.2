Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262043ABF03
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 00:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbhFQWiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 18:38:14 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46770 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbhFQWiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 18:38:13 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3B3251FD68;
        Thu, 17 Jun 2021 22:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623969364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cV2NE8rEWBmZDfrtXKLfyFZ8c/X4r6DiAAuSsUO6DA8=;
        b=rDXJnATdWYSr69kKXMTVE9dP5gncBYGdgr3GUIjHRui/3n2j10pItkszIea/OUzY3+hrpz
        m5Y03yZ0RBddw/KkZEyglzsNQP/XqQYFnNAhXXSyhHvyQACoBXSzQ1DbLE9B6+o27ZlvFu
        m18WdJkng41VCTi1FoOKTBUgW5kZ/Iw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623969364;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cV2NE8rEWBmZDfrtXKLfyFZ8c/X4r6DiAAuSsUO6DA8=;
        b=v9wQxqIe7asZmS+7Z8rjrVZh0dD8nVrpqwgngUo6epZLjj0ZWFfIVtDrDdmmqOXa08n4nJ
        AlEq+lsufIbSeRCg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 20F13118DD;
        Thu, 17 Jun 2021 22:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623969364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cV2NE8rEWBmZDfrtXKLfyFZ8c/X4r6DiAAuSsUO6DA8=;
        b=rDXJnATdWYSr69kKXMTVE9dP5gncBYGdgr3GUIjHRui/3n2j10pItkszIea/OUzY3+hrpz
        m5Y03yZ0RBddw/KkZEyglzsNQP/XqQYFnNAhXXSyhHvyQACoBXSzQ1DbLE9B6+o27ZlvFu
        m18WdJkng41VCTi1FoOKTBUgW5kZ/Iw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623969364;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cV2NE8rEWBmZDfrtXKLfyFZ8c/X4r6DiAAuSsUO6DA8=;
        b=v9wQxqIe7asZmS+7Z8rjrVZh0dD8nVrpqwgngUo6epZLjj0ZWFfIVtDrDdmmqOXa08n4nJ
        AlEq+lsufIbSeRCg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id Wtj0MFDOy2AXOwAALh3uQQ
        (envelope-from <neilb@suse.de>); Thu, 17 Jun 2021 22:36:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Fox Chen" <foxhlchen@gmail.com>
Cc:     "Fox Chen" <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v3 00/13] docs: path-lookup: Update pathlookup docs
In-reply-to: <20210527091618.287093-1-foxhlchen@gmail.com>
References: <20210527091618.287093-1-foxhlchen@gmail.com>
Date:   Fri, 18 Jun 2021 08:35:57 +1000
Message-id: <162396935764.29912.16256561662425331146@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2021, Fox Chen wrote:
> The Path lookup is a very complex subject in VFS. The path-lookup
> document provides a very detailed guidance to help people understand
> how path lookup works in the kernel. This document was originally
> written based on three lwn articles five years ago. As times goes by,
> some of the content is outdated. This patchset is intended to update
> the document to make it more relevant to current codebase.
> 

Thanks for persisting.  Sorry for the delay.

All:
  Reviewed-by: NeilBrown <neilb@suse.de>

I've noted a couple of little issues with one patch.  Hopefully Jon can
simply fix those up rather than requiring a resubmission of the whole
series.

To be honest, I haven't examined patch 4 in as much detail as I'd like,
and it required the biggest change since last time.  But I think it is
good enough.  It might even be excellent.

NeilBrown
