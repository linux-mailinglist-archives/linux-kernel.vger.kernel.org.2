Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9870436BD1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 22:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbhJUUOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 16:14:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32810 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230413AbhJUUOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 16:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634847121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aFYKsPrcwfBy35Olv20MwJ8hyViFI7xaEIkbUwuO4+c=;
        b=C5nwh+c6b8d0FmBTtsYFBSxqMYMmHCxlxfSw9MMAscPe6wOZEFakEZJFteCk0DUOAukEsA
        SiQYgKN6SivmjDlOZZShlSmmkA0bUibUKXNAX83eivZfaNV+7P46ONh/SKH/A5PI9KwHq5
        ok1OZR+VytJojon3+EcMMAVIab+s92E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-ZWFVvhYoM7alfGCnoFPBLA-1; Thu, 21 Oct 2021 16:11:58 -0400
X-MC-Unique: ZWFVvhYoM7alfGCnoFPBLA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0230C806688;
        Thu, 21 Oct 2021 20:11:57 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4DF3B5D9DE;
        Thu, 21 Oct 2021 20:11:56 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     bp@suse.de, seanjc@google.com, dave.hansen@linux.intel.com,
        jarkko@kernel.org, yang.zhong@intel.com, x86@kernel.org
Subject: [PATCH v4 0/2] x86: sgx_vepc: implement ioctl to EREMOVE all pages
Date:   Thu, 21 Oct 2021 16:11:53 -0400
Message-Id: <20211021201155.1523989-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add to /dev/sgx_vepc a ioctl that brings vEPC pages back to uninitialized
state with EREMOVE.  This is useful in order to match the expectations
of guests after reboot, and to match the behavior of real hardware.

The ioctl is a cleaner alternative to closing and reopening the
/dev/sgx_vepc device; reopening /dev/sgx_vepc could be problematic in
case userspace has sandboxed itself since the time it first opened the
device, and has thus lost permissions to do so.

If possible, I would like these patches to be included in 5.15 through
either the x86 or the KVM tree.

Thanks,

Paolo

Changes from RFC:
- improved commit messages, added documentation
- renamed ioctl from SGX_IOC_VEPC_REMOVE to SGX_IOC_VEPC_REMOVE_ALL

Change from v1:
- fixed documentation and code to cover SGX_ENCLAVE_ACT errors
- removed Tested-by since the code is quite different now

Changes from v2:
- return EBUSY also if EREMOVE causes a general protection fault

Changes from v3:
- keep the warning if EREMOVE causes a #PF (or any other fault
  than a general protection fault)

Paolo Bonzini (2):
  x86: sgx_vepc: extract sgx_vepc_remove_page
  x86: sgx_vepc: implement SGX_IOC_VEPC_REMOVE_ALL ioctl

 Documentation/x86/sgx.rst       | 35 +++++++++++++++++++++
 arch/x86/include/uapi/asm/sgx.h |  2 ++
 arch/x86/kernel/cpu/sgx/virt.c  | 63 ++++++++++++++++++++++++++++++---
 3 files changed, 95 insertions(+), 5 deletions(-)

-- 
2.27.0

