Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB3F387FA6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 20:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351593AbhERSdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 14:33:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58911 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbhERSdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 14:33:31 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lj4Vo-0006zx-1L; Tue, 18 May 2021 18:32:12 +0000
To:     Tong Zhang <ztong0001@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Colin Ian King <colin.king@canonical.com>
Subject: re: misc: alcor_pci: fix null-ptr-deref when there is no PCI bridge
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <cb099c69-0d59-7a12-b0bc-2ce71264363e@canonical.com>
Date:   Tue, 18 May 2021 19:32:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Static analysis on linux-next with Coverity has detected an issue in
drivers/misc/cardreader/alcor_pci.c in function
alcor_pci_init_check_aspm  with the following commit:

commit 3ce3e45cc333da707d4d6eb433574b990bcc26f5
Author: Tong Zhang <ztong0001@gmail.com>
Date:   Thu May 13 00:07:33 2021 -0400

    misc: alcor_pci: fix null-ptr-deref when there is no PCI bridge

The analysis is as follows:

135 static void alcor_pci_init_check_aspm(struct alcor_pci_priv *priv)
136 {
137        struct pci_dev *pci;
138        int where;
139        u32 val32;
140
141        priv->pdev_cap_off    = alcor_pci_find_cap_offset(priv,
priv->pdev);
142        /*
143         * A device might be attached to root complex directly and
144         * priv->parent_pdev will be NULL. In this case we don't
check its
145         * capability and disable ASPM completely.
146         */

   1. Condition !priv->parent_pdev, taking true branch.
   2. var_compare_op: Comparing priv->parent_pdev to null implies that
priv->parent_pdev might be null.

147        if (!priv->parent_pdev)

   Dereference after null check (FORWARD_NULL)
   3. var_deref_model: Passing null pointer priv->parent_pdev to
alcor_pci_find_cap_offset, which dereferences it.

148                priv->parent_cap_off = alcor_pci_find_cap_offset(priv,
149
priv->parent_pdev);

When !priv->parent_pdev is true, then priv->parent_pdev is NULL and
hence the call to alcor_pci_find_cap_offset() is dereferencing a null
pointer in the priv->parent_pdev argument.

I suspect the logic in the if statement is inverted, the ! should be
removed. This seems too trivial to be wrong. Maybe I'm missing something
deeper.

Colin

