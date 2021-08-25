Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67DB43F7587
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 15:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240659AbhHYNFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 09:05:10 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55068 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240538AbhHYNFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 09:05:10 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C7C63221A6;
        Wed, 25 Aug 2021 13:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629896663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ihsN4xOKUhY3bLwnMqowm8Mza45SPZ5/Nz1hzigkS5E=;
        b=Q4heCSpauOFtmTxA1j8v01hm93NGSHPEoSkME7BXMvXSYMBzhddDXB+eH90A5T+0rvvpx1
        jCyW4gtQ9eGpJeUd0fPeHU8W/SaJTY8wwdRt0f56++NjsWlmf3inxAEOcl4GgU6OxM7A6R
        qeFHtyZG1OzfP01ldtbBGUZHvlU4KnA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629896663;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ihsN4xOKUhY3bLwnMqowm8Mza45SPZ5/Nz1hzigkS5E=;
        b=BEj/qJuDaLlxNbgQhHSvcOzi1ix9No6GdBxuPJ7zxPUFo4h4NLx1snItJJBMKlVgRZp/JN
        Ek0vZa3B0jlb+tCg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B740513887;
        Wed, 25 Aug 2021 13:04:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 93OOLNc/JmGFNQAAGKfGzw
        (envelope-from <dwagner@suse.de>); Wed, 25 Aug 2021 13:04:23 +0000
Date:   Wed, 25 Aug 2021 15:04:23 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH v6 3/3] nvme-fc: Remove freeze/unfreeze around
 update_nr_hw_queues
Message-ID: <20210825130423.7tpeysh4xtcy2ark@carbon.lan>
References: <20210823112351.82899-1-dwagner@suse.de>
 <20210823112351.82899-4-dwagner@suse.de>
 <025942a6-4f57-b005-eb77-e9eed143522c@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <025942a6-4f57-b005-eb77-e9eed143522c@grimberg.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 01:38:20PM -0700, Sagi Grimberg wrote:
> > freeze before calling update_hr_hw_queues". It's not an exact revert as
> > it leaves the adjusting of hw queues only if the count changes.
> 
> I see that fc doesn't freeze the queues, so it obviously wrong to
> unfreeze them. But is it correct to not freeze the queues?

nvme-fc is draining the queues in the error recovery path
(__nvme_fc_abort_outstanding_ios). There are no request in the queues
hence we don't have to freeze.

The only reason to keep the freeze/unfreeze in this path would be to
make it look alike the other transport. But it would be a no-op.
