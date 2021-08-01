Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4AD93DCE36
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 01:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhHAX74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 19:59:56 -0400
Received: from smtprelay0195.hostedemail.com ([216.40.44.195]:60360 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231361AbhHAX74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 19:59:56 -0400
Received: from omf07.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id BF429100E7B52;
        Sun,  1 Aug 2021 23:59:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id AE3E5315D75;
        Sun,  1 Aug 2021 23:59:45 +0000 (UTC)
Message-ID: <67be9ed47831f09620e2eff8c90a496e4ceb9294.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Support wide strings
From:   Joe Perches <joe@perches.com>
To:     Simon Glass <sjg@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Sun, 01 Aug 2021 16:59:44 -0700
In-Reply-To: <20210801170733.1.I3f9784fd3c1007d08ec2e70b151d137687575495@changeid>
References: <20210801170733.1.I3f9784fd3c1007d08ec2e70b151d137687575495@changeid>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.59
X-Stat-Signature: a9637swzg9hsxd7nmqhqx177pt414gej
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: AE3E5315D75
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18fQg+e8GFhznEJwpbVhA/tEXxiefiQRU8=
X-HE-Tag: 1627862385-423797
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-08-01 at 17:07 -0600, Simon Glass wrote:
> From: Joe Perches <joe@perches.com>
> 
> Allow prefixing typical strings with L for wide strings and u for
> unicode strings.


I believe the kernel didn't need this when I wrote it.
There were no wide or unicode strings in the kernel sources.

But looking now, there _are_ wide strings in the kernel sources.

So:

Acked-by: Joe Perches <joe@perches.com>

(with some false positives, but hey it shows some...)

$ git grep -P '\b[Lu]"[A-Za-z0-9 \.]*?"'
Documentation/sphinx/cdomain.py:u"""
Documentation/sphinx/cdomain.py:        u"""Handles signatures of function-like macros.
Documentation/sphinx/kernel_abi.py:u"""
Documentation/sphinx/kernel_abi.py:    u"""KernelABI (``kernel-abi``) directive"""
Documentation/sphinx/kernel_abi.py:        u"""Run command ``cmd`` and return it's stdout as unicode."""
Documentation/sphinx/kernel_feat.py:u"""
Documentation/sphinx/kernel_feat.py:    u"""KernelFeat (``kernel-feat``) directive"""
Documentation/sphinx/kernel_feat.py:        u"""Run command ``cmd`` and return it's stdout as unicode."""
Documentation/sphinx/kernel_include.py:u"""
Documentation/sphinx/kernel_include.py:    u"""KernelInclude (``kernel-include``) directive"""
Documentation/sphinx/kfigure.py:u"""
Documentation/sphinx/kfigure.py:    u"""
Documentation/sphinx/kfigure.py:    u"""KernelImage directive
Documentation/sphinx/kfigure.py:    u"""KernelImage directive
Documentation/sphinx/kfigure.py:    u"""KernelRender directive
Documentation/sphinx/load_config.py:    u"""Load an additional configuration file into *namespace*.
Documentation/sphinx/maintainers_include.py:u"""
Documentation/sphinx/maintainers_include.py:    u"""MaintainersInclude (``maintainers-include``) directive"""
Documentation/sphinx/rstFlatTable.py:u"""
Documentation/sphinx/rstFlatTable.py:    u"""FlatTable (``flat-table``) directive"""
Documentation/sphinx/rstFlatTable.py:    u"""Builds a table from a double-stage list"""
Documentation/sphinx/rstFlatTable.py:        u"""parses the node from a :py:class:`FlatTable` directive's body"""
Documentation/sphinx/rstFlatTable.py:        u"""Round off the table definition.
arch/x86/platform/efi/quirks.c:static const efi_char16_t efi_dummy_name[] = L"DUMMY";
arch/x86/xen/efi.c:             efi_systab_xen.fw_vendor = __pa_symbol(L"UNKNOWN");
arch/x86/xen/efi.c:     status = efi.get_variable(L"MokSBStateRT", &shim_guid,
drivers/firmware/efi/libstub/secureboot.c:static const efi_char16_t shim_MokSBState_name[] = L"MokSBState";
drivers/firmware/efi/libstub/tpm.c:     L"MemoryOverwriteRequestControl";
drivers/firmware/efi/libstub/x86-stub.c:static const efi_char16_t apple[] = L"Apple";
drivers/input/keyboard/applespi.c:#define EFI_BL_LEVEL_NAME     L"KeyboardBacklightLevel"
drivers/net/wireless/intel/iwlwifi/fw/uefi.h:#define IWL_UEFI_OEM_PNVM_NAME             L"UefiCnvWlanOemSignedPnvm"
drivers/net/wireless/intel/iwlwifi/fw/uefi.h:#define IWL_UEFI_REDUCED_POWER_NAME        L"UefiCnvWlanReducedPower"
drivers/platform/mellanox/mlxbf-tmfifo.c:static efi_char16_t mlxbf_tmfifo_efi_name[] = L"RshimMacAddr";
fs/ceph/file.c:         dout("aio_write %p %llx.%llx %llu~%u" "got EOLDSNAPC, retrying\n",
include/linux/efi.h:    status = get_var(L"SecureBoot", &EFI_GLOBAL_VARIABLE_GUID, NULL, &size,
include/linux/efi.h:    get_var(L"SetupMode", &EFI_GLOBAL_VARIABLE_GUID, NULL, &size, &setupmode);
security/integrity/platform_certs/load_uefi.c:  status = efi.get_variable(L"MokIgnoreDB", &guid, NULL, &size, &db);
security/integrity/platform_certs/load_uefi.c:  mok = get_cert_list(L"MokListRT", &mok_var, &moksize, &status);
security/integrity/platform_certs/load_uefi.c:          db = get_cert_list(L"db", &secure_var, &dbsize, &status);
security/integrity/platform_certs/load_uefi.c:  dbx = get_cert_list(L"dbx", &secure_var, &dbxsize, &status);
security/integrity/platform_certs/load_uefi.c:  mokx = get_cert_list(L"MokListXRT", &mok_var, &mokxsize, &status);


