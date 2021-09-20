Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24674117F8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 17:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241314AbhITPSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 11:18:24 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38698 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbhITPSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 11:18:22 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DFC3A200E4;
        Mon, 20 Sep 2021 15:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632151013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uly+9NTflkmoprkKo6i7pBrEopNdwo0bo3c7NejzLUg=;
        b=sEn+W73WHTARPT0WrT3kvF1iO4FiNAqLaZQcfDnHYTpuWZs6EO0KCE43AJE31kVq5FZOOs
        74jB/l+CUFYQh/7sCr8NgGGjaDFwTjJWAZ6VpWLhYxtJscV8o8pmEGQ4befzOjkzUbgSc7
        16zxKOvGcb7tIFzV3Mt2+8+2uMFJrvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632151013;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uly+9NTflkmoprkKo6i7pBrEopNdwo0bo3c7NejzLUg=;
        b=WRPCl7pnU2YMFygVZVOnA2SAjrOBxcU0HjiG2gyQBqDYodmyv/jSZmPbSzZZ0KK9FLzeSH
        N6jqRQVOnN10gXAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C2B1613A61;
        Mon, 20 Sep 2021 15:16:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PH/ZLuWlSGGOHQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 20 Sep 2021 15:16:53 +0000
Subject: Re: IMPORTANT: CIVS opt-in for Technical Advisory Board voting
To:     Laura Abbott <laura@oxidecomputer.com>, ksummit@lists.linux.dev,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>
Cc:     "tab-elections@lists.linuxfoundation.org" 
        <tab-elections@lists.linuxfoundation.org>
References: <44ee2bfe-e4bc-b918-b908-7352ea012524@oxidecomputer.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <bfff8674-a3b1-3f4c-f926-70a66422fd03@suse.cz>
Date:   Mon, 20 Sep 2021 17:16:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <44ee2bfe-e4bc-b918-b908-7352ea012524@oxidecomputer.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/21 3:57 PM, Laura Abbott wrote:
> Hello,
> 
> As in the past we are using CIVS (https://civs1.civs.us/) for voting.
> This year you need to explicitly opt-in to vote in a private poll. This
> is a change on the CIVS end and was probably added due to concerns about
> spam/abuse of the service.
> 
> Please opt-in at https://civs1.civs.us/cgi-bin/opt_in.pl

Hi, did that and it appears that afterwards I could be voting right
away. But there's no link to the candidate statements yet, or did I miss it?

> If you have any questions please feel free to e-mail
> tab-elections@lists.linuxfoundation.org
> 
> Thanks,
> Laura
> 

