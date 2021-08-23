Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168093F472C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 11:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbhHWJOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 05:14:50 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35644 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhHWJOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 05:14:49 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 28EFC21F3D;
        Mon, 23 Aug 2021 09:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629710046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jf4RvD/mw/nbQWr8Y9Fj9qty0PSRsJZCDwZff4vyIj4=;
        b=e5X2ULVlQDy65O/CjPGxNBz/QjcZsHpbBKeGbk8jRdn28yHdab/k6Td5kP61d5/IgeDqqv
        42FRngk97eHUjHxqGBWtZPB27pJyClm3rXYHJwh/9T5AimnMbWFCqcC1fYCRh2wFZg1sgQ
        AUyCq3FuPmuUOJuKAeONyui0jD2eOAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629710046;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jf4RvD/mw/nbQWr8Y9Fj9qty0PSRsJZCDwZff4vyIj4=;
        b=9bgUG/61TFYHpAaTjyONrAWKS/pIPZ/dvmgjy2+ewwQT6ss4s2K5sBUDJ7F1U4/26uMfV8
        dd8w0NzSJ+f6l4Cw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1233613A92;
        Mon, 23 Aug 2021 09:14:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id O/0EBN5mI2EKbQAAGKfGzw
        (envelope-from <dwagner@suse.de>); Mon, 23 Aug 2021 09:14:06 +0000
Date:   Mon, 23 Aug 2021 11:14:05 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v5 0/3] Handle update hardware queues and queue freeze
 more carefully
Message-ID: <20210823091405.pmmkubzgxodwgjij@carbon.lan>
References: <20210818120530.130501-1-dwagner@suse.de>
 <YSNV6vpaEnzc0Yv4@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSNV6vpaEnzc0Yv4@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Mon, Aug 23, 2021 at 09:01:46AM +0100, Christoph Hellwig wrote:
> applied to nvme-5.15.

Could you drop these patches again? James just sent me a new version of
the series which addresses the points we discussed in this thread. They
look good to me but I'd like to give them a spin and will post them
shortly. Also James is giving them a test run.

Daniel
