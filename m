Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81EC13881DA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 23:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352381AbhERVKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 17:10:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52028 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352364AbhERVKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 17:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621372154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bKwnA5CgI1izhv+JdCwChCvF4HctOc5tlV3dVKPbh5A=;
        b=i4Xkn2q6g0rtyb+U+bJIMK4PyUgmSFvMEPcbouS2siUvXeeFSVXW6YBgk5iAxVcAFHAiHZ
        BZ8T4ajXfFlPb2/MH9q0jLW+K6hFXgR52DdP/HYWR6/KXpELX7RSNuPh17ldEpGwCQZL0y
        /LVYYtERrvEXccACCvhP3mZeZF8D/EA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-tIIB48RJOJO101spDHbfpw-1; Tue, 18 May 2021 17:09:11 -0400
X-MC-Unique: tIIB48RJOJO101spDHbfpw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A45736415B
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 21:09:10 +0000 (UTC)
Received: from f33vm.wilsonet.com (dhcp-17-185.bos.redhat.com [10.18.17.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A46265C257;
        Tue, 18 May 2021 21:09:06 +0000 (UTC)
From:   Jarod Wilson <jarod@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jarod Wilson <jarod@redhat.com>
Subject: [PATCH 0/4] bond_alb: support VMs behind bridges better
Date:   Tue, 18 May 2021 17:08:45 -0400
Message-Id: <20210518210849.1673577-1-jarod@redhat.com>
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

Jarod Wilson (4):
  bonding: add pure source-mac-based tx hashing option
  bond_alb: don't rewrite bridged non-local MACs
  bond_alb: don't tx balance multicast traffic either
  bond_alb: put all slaves into promisc

 Documentation/networking/bonding.rst | 13 ++++++++++++
 drivers/net/bonding/bond_alb.c       | 27 ++++++++++++++++++++++--
 drivers/net/bonding/bond_main.c      | 31 ++++++++++++++++++----------
 drivers/net/bonding/bond_options.c   |  1 +
 include/linux/netdevice.h            |  1 +
 include/uapi/linux/if_bonding.h      |  1 +
 6 files changed, 61 insertions(+), 13 deletions(-)

-- 
2.30.2

