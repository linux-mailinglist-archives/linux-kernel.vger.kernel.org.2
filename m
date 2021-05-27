Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26DA3936C9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 22:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbhE0UDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 16:03:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25447 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235783AbhE0UDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 16:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622145686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VPf97PB5Jd4U3KAa9l79Ys8IXNWTpjSo3ttws8hPSUs=;
        b=TGlEgk3vvNcpogQw7HAMtx/WWohaHd00iofeSXTy+8eZSiZit1WKRd3BjU+8hLU/PuGhNw
        4bazOYUKX/9l3OwqdLntk9IUCuV9Xv8rGCQrVZF3EBFJQxesTY73DPoa8Fq0zoNmdsNNni
        TniiXCotwO21Z9ZZfo/s/K9JGIxk7c8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-0iSS90zyP26SGmlAQ1NCnw-1; Thu, 27 May 2021 16:01:09 -0400
X-MC-Unique: 0iSS90zyP26SGmlAQ1NCnw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1814419251A4
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 20:01:08 +0000 (UTC)
Received: from f33vm.wilsonet.com (dhcp-17-185.bos.redhat.com [10.18.17.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 806A45C290;
        Thu, 27 May 2021 20:01:04 +0000 (UTC)
From:   Jarod Wilson <jarod@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jarod Wilson <jarod@redhat.com>
Subject: [PATCH net-next v3 0/2] bonding/balance-alb: support VMs behind bridges better
Date:   Thu, 27 May 2021 16:00:49 -0400
Message-Id: <20210527200051.1871092-1-jarod@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been further educated on a use case, where a bridge sits on top of
a bond, with multiple vnetX interfaces attached to virtual machines,
also acting as ports of the bridge. Each leg of the bond goes to a
different switch, but there is NO mlag/vpc in play, the bonding driver
has to handle traffic that loops back appropriately to avoid breaking
transmission. Rather than adding some sort of mac filtering to
balance-xor mode, we switched to using balance-alb, which already does
some of this, and with the tweaks provided in this series, empirically
seems to behave as desired in actual operation.

v2 attempts to support srcmac-only hashing via a modparam instead of by
adding yet another hashing mode, as well as cleaning up and clarifying
commit messages.

v3 omits two patches from the series that prove unnecessary when all
slaves get promiscuity propagated to them.

Jarod Wilson (2):
  bonding: add pure source-mac-based tx hashing option
  bonding/balance-alb: put all slaves into promisc

 Documentation/networking/bonding.rst | 13 +++++++++++++
 drivers/net/bonding/bond_main.c      | 23 +++++++++++++++--------
 2 files changed, 28 insertions(+), 8 deletions(-)

-- 
2.30.2

