Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D2838C802
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 15:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbhEUN3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 09:29:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27457 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231601AbhEUN3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 09:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621603689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CGLBV8K7x2fEQpqwhoWVH4NFN4drtGHGFPA8dLbVVYE=;
        b=ByRrE0MbmZmQy3oaVKhyYo4tnU8n8FW+RD0Andw8NlhYPHtpLzpZ/nOLn4chxg0KpWNBuj
        ggzk6XkLfW2w2PX7PQlS9EAKwzSvvaXIQQnIi99ezyV783vwoQPNawOQRv5rQWPbYAxpuA
        yw9YntKruCeSNhdxm3WxWX9O6x2i+w8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-M-M_s5czMuGilSWDtBYllg-1; Fri, 21 May 2021 09:28:07 -0400
X-MC-Unique: M-M_s5czMuGilSWDtBYllg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5F0D107ACC7
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 13:28:06 +0000 (UTC)
Received: from f33vm.wilsonet.com.wilsonet.com (dhcp-17-185.bos.redhat.com [10.18.17.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D2588100AE43;
        Fri, 21 May 2021 13:28:02 +0000 (UTC)
From:   Jarod Wilson <jarod@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jarod Wilson <jarod@redhat.com>
Subject: [PATCH net-next v2 0/4] bonding/balance-alb: support VMs behind bridges better
Date:   Fri, 21 May 2021 09:27:52 -0400
Message-Id: <20210521132756.1811620-1-jarod@redhat.com>
In-Reply-To: <20210518210849.1673577-1-jarod@redhat.com>
References: <20210518210849.1673577-1-jarod@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

Jarod Wilson (4):
  bonding: add pure source-mac-based tx hashing option
  bonding/balance-lb: don't rewrite bridged non-local MACs
  bonding/balance-alb: don't tx balance multicast traffic either
  bonding/balance-alb: put all slaves into promisc

 Documentation/networking/bonding.rst | 13 +++++++++++++
 drivers/net/bonding/bond_alb.c       | 24 +++++++++++++++++++++---
 drivers/net/bonding/bond_main.c      | 23 +++++++++++++++--------
 3 files changed, 49 insertions(+), 11 deletions(-)

-- 
2.30.2

