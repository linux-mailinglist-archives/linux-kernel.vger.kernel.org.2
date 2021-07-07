Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD3B3BE138
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 04:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhGGCtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 22:49:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24029 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229894AbhGGCtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 22:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625625989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/hCAFrVBwva4FwAQ3R2O2B3lOY1+NpCIdMOPkZ0H35U=;
        b=b0/ChPqJvZlioC2f9ydwjKeoIWh482qJMAuKN4uMWPc5SoE4PQo50rCkuGf7vPNR07YYqA
        MnzmXU2/eklhnny+GHI+3F41ZqZ+PlVfFwCrZZ+lTP4jT+12Kr1F+JVcJARrQ7HxByhRKT
        e9cReuPFXqef/jKtTSCMUH779k6RLS0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-P-HCtpRpNxexINy-Kay7Sg-1; Tue, 06 Jul 2021 22:46:28 -0400
X-MC-Unique: P-HCtpRpNxexINy-Kay7Sg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B80605074B;
        Wed,  7 Jul 2021 02:46:26 +0000 (UTC)
Received: from T590 (ovpn-12-27.pek2.redhat.com [10.72.12.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B954719C44;
        Wed,  7 Jul 2021 02:46:19 +0000 (UTC)
Date:   Wed, 7 Jul 2021 10:46:15 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/2] nvme-fc: Wait with a timeout for queue to freeze
Message-ID: <YOUVdx6VasZNANvW@T590>
References: <20210625101649.49296-1-dwagner@suse.de>
 <20210625101649.49296-3-dwagner@suse.de>
 <YNp50pmlzN6M0kNX@T590>
 <20210705162519.qqlklisxcsiopflw@beryllium.lan>
 <YOQGRwLfLaFGqlVA@T590>
 <20210706081010.dqmg7bxik5gnym5k@beryllium.lan>
 <YOQYKn+POVR2g/h1@T590>
 <20210706085906.asz7cp7ydiid6yz5@beryllium.lan>
 <20210706122121.qicyihexk2qawvef@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706122121.qicyihexk2qawvef@beryllium.lan>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 02:21:21PM +0200, Daniel Wagner wrote:
> A nvme_start_freeze() before nvme_wait_freeze() fixes the hangers. It is this
> simple?

Yeah, it can be the issue, also nvme_start_freeze() has to be paired
with nvme_unfreeze().


Thanks, 
Ming

