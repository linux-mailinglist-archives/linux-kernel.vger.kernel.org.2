Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C813B6FD1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 11:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbhF2JEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 05:04:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24135 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232591AbhF2JEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 05:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624957291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pCMVXVrREB+3xGNYng722JG4/x5ib1E9Ik1DbsMH2eo=;
        b=XvP2DgnLTfPulSVOprFj2Sy72RsqC2V+WuaBzVxit+av8Uqh5NJRprFl1hQHeXxLASHvcG
        Kpujbvl45hqaFjf36UxoWWZ82dmSi0fuBP7WR+xV72eBWT5Eoh6BH8ckJrwi3ybrSySwg1
        b1EGigmfBqfvoQV1eObSQ99DxsPTS1U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576---DtsV0JMHiHA9ooIgDEmw-1; Tue, 29 Jun 2021 05:01:29 -0400
X-MC-Unique: --DtsV0JMHiHA9ooIgDEmw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5ED0BBF0B;
        Tue, 29 Jun 2021 09:01:28 +0000 (UTC)
Received: from T590 (ovpn-13-8.pek2.redhat.com [10.72.13.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FFBC5C1D1;
        Tue, 29 Jun 2021 09:01:21 +0000 (UTC)
Date:   Tue, 29 Jun 2021 17:01:16 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Wen Xiong <wenxiong@us.ibm.com>, james.smart@broadcom.com,
        linux-kernel@vger.kernel.org, sagi@grimberg.me,
        wenxiong@linux.vnet.ibm.com
Subject: Re: [PATCH 1/1] block: System crashes when cpu hotplug + bouncing
 port
Message-ID: <YNrhXFgv/gEWbhbl@T590>
References: <YNp1Bho5yypHkPfW@T590>
 <1624850072-17776-1-git-send-email-wenxiong@linux.vnet.ibm.com>
 <20210628090703.apaowrsazl53lza4@beryllium.lan>
 <YNmdhqd+W3XbJCwd@T590>
 <71d1ce491ed5056bfa921f0e14fa646d@imap.linux.ibm.com>
 <OFE573413D.44652DC5-ON00258703.000DB949-00258703.000EFCD4@ibm.com>
 <OF8889275F.DC758B38-ON00258703.001297BC-00258703.00143502@ibm.com>
 <YNqX6w8YHO61oqvY@T590>
 <20210629082542.vm3yh6k36d2zh3k5@beryllium.lan>
 <20210629083549.unco3f7atybqypw3@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629083549.unco3f7atybqypw3@beryllium.lan>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 10:35:49AM +0200, Daniel Wagner wrote:
> On Tue, Jun 29, 2021 at 10:25:43AM +0200, Daniel Wagner wrote:
> > On Tue, Jun 29, 2021 at 11:47:55AM +0800, Ming Lei wrote:
> > > >    >>data.ctx = __blk_mq_get_ctx(q, cpu);
> > > >    cpu=2048 if hctx_idx = 4
> > > 
> > > Yeah, that is the issue I mentioned, any CPU in hctx->cpumask becomes
> > > offline, please try the following patch and see if it makes a
> > > difference:
> > 
> > Given that cpumask_first_and() will return nr_cpu_ids in this case,
> > can't we just bail out here and have to caller handle the error?
> 
> To answer my own question, you want to avoid adding the if into the
> hotpath.

No, this way fails the request allocation, which isn't expected from
NVMe fc/rdma/tcp/loop, since io queue can't be connected in this way.


Thanks,
Ming

