Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620B8408C1E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 15:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbhIMNNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 09:13:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37985 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235759AbhIMNNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 09:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631538717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fy9mvgIdV9oY9XF5VY1l7ljIvXqXbTfyzWN80Pw9vSg=;
        b=AvOHSIdjVJRphLL6xGj63zRQbXA5DlLVXfbpGeODnC9dTvQs0px/21ZvfAZatSG5qyrxi0
        7h9g9Ugbwya+q6Nr/roPabBZmPm2zD1juraRjsFiqlEtUplgdkMLWrzAwcmKVZqMRdeyOS
        xsmDc62/pXu1QwY3D+tEJeGX22WD3ms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-WbFXue24OjquLLFoG_Qw2Q-1; Mon, 13 Sep 2021 09:11:56 -0400
X-MC-Unique: WbFXue24OjquLLFoG_Qw2Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7730710144E1;
        Mon, 13 Sep 2021 13:11:54 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C8D4D6D01F;
        Mon, 13 Sep 2021 13:11:53 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     x86@kernel.org, linux-sgx@vger.kernel.org, jarkko@kernel.org,
        dave.hansen@linux.intel.com, yang.zhong@intel.com
Subject: [RFC/RFT PATCH 0/2] x86: sgx_vepc: implement ioctl to EREMOVE all pages
Date:   Mon, 13 Sep 2021 09:11:51 -0400
Message-Id: <20210913131153.1202354-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on discussions from the previous week(end), this series implements
a ioctl that performs EREMOVE on all pages mapped by a /dev/sgx_vepc
file descriptor.  Other possibilities, such as closing and reopening
the device, are racy.

The patches are untested, but I am posting them because they are simple
and so that Yang Zhong can try using them in QEMU.

Paolo

Paolo Bonzini (2):
  x86: sgx_vepc: extract sgx_vepc_remove_page
  x86: sgx_vepc: implement SGX_IOC_VEPC_REMOVE ioctl

 arch/x86/include/uapi/asm/sgx.h |  2 ++
 arch/x86/kernel/cpu/sgx/virt.c  | 48 ++++++++++++++++++++++++++++++---
 2 files changed, 47 insertions(+), 3 deletions(-)

-- 
2.27.0

