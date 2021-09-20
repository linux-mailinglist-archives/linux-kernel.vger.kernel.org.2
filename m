Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72790411859
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 17:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237282AbhITPiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 11:38:15 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42934 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbhITPiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 11:38:14 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7E945200E4;
        Mon, 20 Sep 2021 15:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632152206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wua0lHVvfj/el/Kj5RfjOXaDmAyHpwh4ed/Wl4gQksw=;
        b=t+aOpn16yiKlDHLlQ/cyKkKC0kkjuM3A2NRW6mJC5Xvb79F/YV6Du/V3ENzNx2KKcqpgLC
        j+jtceVokgC/6XU9pVulBga4FTdnRVzW8oU+JtEmp45TuBVng/iNyiPAp7a6o0Ygj/9DZM
        S3776Yxose3dRXzC+zL4Dy66d2OiU3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632152206;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wua0lHVvfj/el/Kj5RfjOXaDmAyHpwh4ed/Wl4gQksw=;
        b=nlHigAtUtJEDOLaOIRdBXjmjirTemEWe+r43Ag5JBsWAaWlOTDNjK4HfOVMGdidRAXj+2I
        U7lh3yGBzUsO4cDg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 6A06BA3B9A;
        Mon, 20 Sep 2021 15:36:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 37E5B1E1494; Mon, 20 Sep 2021 17:36:46 +0200 (CEST)
Date:   Mon, 20 Sep 2021 17:36:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Laura Abbott <laura@oxidecomputer.com>, ksummit@lists.linux.dev,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        "tab-elections@lists.linuxfoundation.org" 
        <tab-elections@lists.linuxfoundation.org>
Subject: Re: IMPORTANT: CIVS opt-in for Technical Advisory Board voting
Message-ID: <20210920153646.GK6607@quack2.suse.cz>
References: <44ee2bfe-e4bc-b918-b908-7352ea012524@oxidecomputer.com>
 <bfff8674-a3b1-3f4c-f926-70a66422fd03@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfff8674-a3b1-3f4c-f926-70a66422fd03@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20-09-21 17:16:07, Vlastimil Babka wrote:
> On 9/20/21 3:57 PM, Laura Abbott wrote:
> > Hello,
> > 
> > As in the past we are using CIVS (https://civs1.civs.us/) for voting.
> > This year you need to explicitly opt-in to vote in a private poll. This
> > is a change on the CIVS end and was probably added due to concerns about
> > spam/abuse of the service.
> > 
> > Please opt-in at https://civs1.civs.us/cgi-bin/opt_in.pl
> 
> Hi, did that and it appears that afterwards I could be voting right
> away. But there's no link to the candidate statements yet, or did I miss it?

I found the link at the top:
https://docs.google.com/document/d/1q4uebud-Nk0l7LepMEdjx0ZWot0cgRdg2ZYSrbJCq6c/edit

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
