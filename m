Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673DF3B7023
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 11:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbhF2Jie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 05:38:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24039 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232614AbhF2Jid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 05:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624959366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hzJ7KD+FefvY+PA5Kqxiz47KxgMjEOLWX6jpOn12NMs=;
        b=GWbEGsst04hM4yEW5Z6ehk555m6wGFMv3nqE4pgEAKVdkXwYgKqrrTyCNYVz1rwzFZo3HM
        DW6r9R1QoFOqqFKOx2VEqsxqT45h6cRvf/+m2zVauzQgQTurThNqrZF4CtDcypPo9usyvc
        EZk5PBwZWpzILp2TxMwNy15dhzwWzt0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-l4KEPThVPf-MeR8oJmQ4gA-1; Tue, 29 Jun 2021 05:36:04 -0400
X-MC-Unique: l4KEPThVPf-MeR8oJmQ4gA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05BB6800D62;
        Tue, 29 Jun 2021 09:36:03 +0000 (UTC)
Received: from T590 (ovpn-13-8.pek2.redhat.com [10.72.13.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 314C260C0F;
        Tue, 29 Jun 2021 09:35:55 +0000 (UTC)
Date:   Tue, 29 Jun 2021 17:35:51 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Wen Xiong <wenxiong@us.ibm.com>, james.smart@broadcom.com,
        linux-kernel@vger.kernel.org, sagi@grimberg.me,
        wenxiong@linux.vnet.ibm.com
Subject: Re: [PATCH 1/1] block: System crashes when cpu hotplug + bouncing
 port
Message-ID: <YNrpdy3pJ/3DIxpW@T590>
References: <20210628090703.apaowrsazl53lza4@beryllium.lan>
 <YNmdhqd+W3XbJCwd@T590>
 <71d1ce491ed5056bfa921f0e14fa646d@imap.linux.ibm.com>
 <OFE573413D.44652DC5-ON00258703.000DB949-00258703.000EFCD4@ibm.com>
 <OF8889275F.DC758B38-ON00258703.001297BC-00258703.00143502@ibm.com>
 <YNqX6w8YHO61oqvY@T590>
 <20210629082542.vm3yh6k36d2zh3k5@beryllium.lan>
 <20210629083549.unco3f7atybqypw3@beryllium.lan>
 <YNrhXFgv/gEWbhbl@T590>
 <20210629092719.n33t2pnjiwwe6qun@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629092719.n33t2pnjiwwe6qun@beryllium.lan>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 11:27:19AM +0200, Daniel Wagner wrote:
> On Tue, Jun 29, 2021 at 05:01:16PM +0800, Ming Lei wrote:
> > No, this way fails the request allocation, which isn't expected from
> > NVMe fc/rdma/tcp/loop, since io queue can't be connected in this way.
> 
> But __nvme_submit_sync_cmd() can return errors too and they need to be
> handled in the connect path. So why is this so special? Not that I am
> against your patch, I just like to understand the reasoning.

With the two patches I posted, __nvme_submit_sync_cmd() shouldn't return
error, can you observe the error?


Thanks, 
Ming

