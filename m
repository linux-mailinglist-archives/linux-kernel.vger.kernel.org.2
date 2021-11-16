Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC72453918
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 19:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239280AbhKPSDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 13:03:22 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:49654 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239287AbhKPSDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 13:03:17 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D2887218D5;
        Tue, 16 Nov 2021 18:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637085618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kyoKspNHubmntuojoiakxQgRvVcpyVRSO96mR7W75T8=;
        b=G81YlzInUuiguuUMv+tpmWuHcUzfjsXqHA4ntdGsvok9VtuKuBH8WpeDevTBES3TIbZIEv
        W+7Piog+eR4vlS8lxgUEK4FUCyFPgAy8rKcyVT8W+0xA6dCb7DNxBzqU80kLUDbyTMZVsJ
        5J8w1MDLjqyA3T8c66GQdlfzTekB8YE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC65913BA0;
        Tue, 16 Nov 2021 18:00:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id p7uBKbLxk2EydAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 16 Nov 2021 18:00:18 +0000
Date:   Tue, 16 Nov 2021 19:00:17 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v2] cgroup: pretty format /proc/cgroups
Message-ID: <20211116180013.GA8884@blackbody.suse.cz>
References: <20211115011253.20778-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115011253.20778-1-richard.weiyang@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On Mon, Nov 15, 2021 at 01:12:53AM +0000, Wei Yang <richard.weiyang@gmail.com> wrote:
> Let's align the title and value. After this patch, it looks like this.

For machines this change may come as a surprise (so better not change
it).

For humans (for instance column from util-linux)

$ column -t /proc/cgroups
#subsys_name  hierarchy  num_cgroups  enabled
cpuset        11         2            1
cpu           4          9            1
cpuacct       4          9            1
...

Michal
