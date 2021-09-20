Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5076410F54
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 07:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbhITFf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 01:35:56 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51446 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbhITFfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 01:35:53 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 608481FFFF;
        Mon, 20 Sep 2021 05:34:26 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 949F713AC7;
        Mon, 20 Sep 2021 05:34:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BeDAF2AdSGHATwAAMHmgww
        (envelope-from <dave@stgolabs.net>); Mon, 20 Sep 2021 05:34:24 +0000
Date:   Sun, 19 Sep 2021 22:34:19 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Michal Clapinski <mclapinski@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>, 1vier1@web.de
Subject: Re: [PATCH] ipc/ipc_sysctl.c: Remove fallback for !CONFIG_PROC_SYSCTL
Message-ID: <20210920053419.zdaqhcinpfnjhtqc@offworld>
References: <20210918145337.3369-1-manfred@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210918145337.3369-1-manfred@colorfullife.com>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Sep 2021, Manfred Spraul wrote:

>Compilation of ipc/ipc_sysctl.c is controlled by
>obj-$(CONFIG_SYSVIPC_SYSCTL)
>[see ipc/Makefile]
>
>And CONFIG_SYSVIPC_SYSCTL depends on SYSCTL
>[see init/Kconfig]
>
>An SYSCTL is selected by PROC_SYSCTL.
>[see fs/proc/Kconfig]
>
>Thus: #ifndef CONFIG_PROC_SYSCTL in ipc/ipc_sysctl.c is impossible, the
>fallback can be removed.
>
>Signed-off-by: Manfred Spraul <manfred@colorfullife.com>

Acked-by: Davidlohr Bueso <dbueso@suse.de>
