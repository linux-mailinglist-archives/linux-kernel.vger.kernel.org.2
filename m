Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8613246CA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 23:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbhBXWWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 17:22:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:55570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230174AbhBXWV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 17:21:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B96464EDB;
        Wed, 24 Feb 2021 22:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614205277;
        bh=dhFpuKsDsNFgNsNZNtktfznFb3WT5Rlb6q1kbx1TSRU=;
        h=From:To:Cc:Subject:Date:From;
        b=mXxJV0REs53v5rF/+3/4A5UtFF8YnPG9DgRdhC6lBryrBqDFVQYTzMRQLTr0N3LKA
         bmXf/ed9KFeXNyI5VliOdOIdffc4qRK399zoXTohKYNR56zNlrRBgLr2vd17QWXdGC
         IKwDJGUjm9M2mhEfUkMWIyvOV++r44zoe1OakHe3mGrgwwAHAA0hr0Fk+6/Q3Y1Mb9
         YGMI0Hg2w+EJFg5hQ5v1hsvPAEzsDXXRFMHvqGAaFD2zoprSwBNv5Mph1SwNgJG6eC
         2YpUhc28NC8KC6t0A/qbH2XI6hHEMRyHT3Bq5ZRqGi5H4pNQtv6v8zG79oVUeDE51f
         mzpUVHSl5Mtsg==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     haitao.huang@intel.com, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, bp@alien8.de, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH 0/3] Introduce version array structure: sgx_va
Date:   Thu, 25 Feb 2021 00:20:46 +0200
Message-Id: <20210224222049.240754-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce an xarray based version array (VA) structure: struct sgx_va.

The use of sgx_va can be later on extended to the following use cases:

- A global VA for reclaimed SECS pages.
- A global VA for reclaimed VA pages.

Testing done while developing the patch:

- With NUC7PJYH: https://www.intel.com/content/www/us/en/products/boards-kits/nuc/kits/nuc7pjyh.html
- seq 10000 | xargs -I {} -P10000 ./test_sgx > /dev/null
- The EPC size was set from BIOS to 32 MB.

Jarkko Sakkinen (3):
  x86/sgx: Move struct sgx_va_page creation to sgx_alloc_va_page()
  x86/sgx: Add a version array (VA) structure
  x86/sgx: Use sgx_va for the enclave's version array

 arch/x86/kernel/cpu/sgx/driver.c |   3 +-
 arch/x86/kernel/cpu/sgx/encl.c   | 180 ++++++++++++++++++++++---------
 arch/x86/kernel/cpu/sgx/encl.h   |  36 ++++---
 arch/x86/kernel/cpu/sgx/ioctl.c  |  77 +++++--------
 arch/x86/kernel/cpu/sgx/main.c   |  19 +---
 5 files changed, 184 insertions(+), 131 deletions(-)

-- 
2.30.1

