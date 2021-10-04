Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E0142176A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 21:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239014AbhJDT2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 15:28:32 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36720 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbhJDT2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 15:28:31 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 559462231C;
        Mon,  4 Oct 2021 19:26:41 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 41D0C13A65;
        Mon,  4 Oct 2021 19:26:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id P20sBnBVW2EUfwAAMHmgww
        (envelope-from <dave@stgolabs.net>); Mon, 04 Oct 2021 19:26:40 +0000
Date:   Mon, 4 Oct 2021 12:26:35 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Igor Raits <igor@gooddata.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: rq->tmp_alone_branch != &rq->leaf_cfs_rq_list + RIP:
 0010:enqueue_task_fair+0x268/0x6a0
Message-ID: <20211004192635.nk7opq7bs7yosjtp@offworld>
References: <CA+9S74g77kMvkB7X44bipuN0WfMpHJO6Dgors4HhvLPiDhq5NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CA+9S74g77kMvkB7X44bipuN0WfMpHJO6Dgors4HhvLPiDhq5NA@mail.gmail.com>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Sep 2021, Igor Raits wrote:

>------------[ cut here ]------------
>rq->tmp_alone_branch != &rq->leaf_cfs_rq_list
>WARNING: CPU: 5 PID: 1832 at kernel/sched/fair.c:379
>enqueue_task_fair+0x268/0x6a0

Does this help?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2630cde26711dab0d0b56a8be1616475be646d13

Thanks,
Davidlohr
