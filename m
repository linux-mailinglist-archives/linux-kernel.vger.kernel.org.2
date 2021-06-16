Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3D93AA2C8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 19:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhFPSCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 14:02:00 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50108 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhFPSBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 14:01:52 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3BAE31FD3F;
        Wed, 16 Jun 2021 17:59:45 +0000 (UTC)
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id B9EFD118DD;
        Wed, 16 Jun 2021 17:59:41 +0000 (UTC)
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id wIL/Ig08ymBbSQAALh3uQQ
        (envelope-from <dave@stgolabs.net>); Wed, 16 Jun 2021 17:59:41 +0000
Date:   Wed, 16 Jun 2021 10:59:35 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     paulmck@kernel.org, liam.howlett@oracle.com, willy@infradead.org,
        michel@lespinasse.org, andrealmeid@collabora.com,
        peterz@infradead.org, alex.kogan@oracle.com, longman@redhat.com,
        tglx@linutronix.de, tim.c.chen@intel.com, anthony.yznaga@oracle.com
Subject: LPC 2021: Plumbers Performance and Scalability track
Message-ID: <20210616175935.pnnkjrtzywasmdso@offworld>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        paulmck@kernel.org, liam.howlett@oracle.com, willy@infradead.org,
        michel@lespinasse.org, andrealmeid@collabora.com,
        peterz@infradead.org, alex.kogan@oracle.com, longman@redhat.com,
        tglx@linutronix.de, tim.c.chen@intel.com, anthony.yznaga@oracle.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This year the Performance and Scalability track for Plumbers is back and with this email,
we are hoping to 1) confirm some of the key participants, 2) suggestions for other key
participants and 3) more topics so that we can have a big enough pool to screen correctly
for what's really worth discussing.

Here is a first very loose list of ideas, which are obviously specific to things that
interest us.

https://www.linuxplumbersconf.org/event/11/page/104-accepted-microconferences#cont-perform

As such, if you would like to attend and/or have specific topics that would like discussed,
please do submit it at (ensuring selecting the Performance and Scalability MC):

https://www.linuxplumbersconf.org/event/11/abstracts/#submit-abstract

With performance and scalability being a bit generic terms, this track should only cover
related topics that are not specific to other tracks.

Thank you.

On behalf of Daniel, Pavel and myself.
