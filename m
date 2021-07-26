Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F7C3D65B0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 19:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbhGZQqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 12:46:43 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49432 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237394AbhGZQqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 12:46:37 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 055E61FEC6;
        Mon, 26 Jul 2021 17:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627320425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=drwSswYjaqXt+R8keQ8tn2ECB9MnkEVK6sFZPPriypY=;
        b=V+H5wEJ9xp39BB8KJSgKpbiilfRE9vbZKJFAynQScSnhOClyh13HxfZi97GV0sFmyDW1Yf
        scMxBp/DW8X5ES/7/u7oPkvB7PJGnd/IlqjL2+i6NhZZRm+z/uD6WvKVP8e6jcWlmaiTvP
        55tBOHx4DTBONm1NlXidkVTTL/WZdZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627320425;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=drwSswYjaqXt+R8keQ8tn2ECB9MnkEVK6sFZPPriypY=;
        b=mN9vfW5upwlrhKcpzEtNBxpcESJP1Bqb3Ri1ba1WR6O0MMUzF/o5WOzvuCbmQ5vpwobJXP
        Ff4EmnrQJj9O6rBg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id E3E5D13A96;
        Mon, 26 Jul 2021 17:27:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id tAA/N2jw/mC2RAAAGKfGzw
        (envelope-from <dwagner@suse.de>); Mon, 26 Jul 2021 17:27:04 +0000
Date:   Mon, 26 Jul 2021 19:27:04 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 0/6] Handle update hardware queues and queue freeze
 more carefully
Message-ID: <20210726172704.j6cbv2qmox2cl2dz@beryllium.lan>
References: <20210720124353.127959-1-dwagner@suse.de>
 <20210720124800.i2lo3hal7kjfc7rk@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720124800.i2lo3hal7kjfc7rk@beryllium.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 02:48:00PM +0200, Daniel Wagner wrote:
> On Tue, Jul 20, 2021 at 02:43:47PM +0200, Daniel Wagner wrote:
> > v1:
> >  - https://lore.kernel.org/linux-nvme/20210625101649.49296-1-dwagner@suse.de/
> > v2:
> >  - https://lore.kernel.org/linux-nvme/20210708092755.15660-1-dwagner@suse.de/
> >  - reviewed tags collected
> >  - added 'update hardware queues' for all transport
> >  - added fix for fc hanger in nvme_wait_freeze_timeout
> > v3:
> >  - dropped 'nvme-fc: Freeze queues before destroying them'
> >  - added James' two patches
> 
> Forgot to add Hannes' reviewed tag. Sorry!

FTR, I've tested the 'prior_ioq_cnt != nr_io_queues' case. In this
scenario the series works. Though in the case of 'prior_ioq_cnt ==
nr_io_queues' I see hanging I/Os.
