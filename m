Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79DE9387FF4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 20:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351673AbhERSyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 14:54:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59376 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbhERSyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 14:54:06 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lj4pj-00005U-AM; Tue, 18 May 2021 18:52:47 +0000
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Colin Ian King <colin.king@canonical.com>
Subject: re: net: dsa: qca8k: handle error with qca8k_read operation
Message-ID: <41e1a058-4c13-479d-68aa-2b017fda95fe@canonical.com>
Date:   Tue, 18 May 2021 19:52:46 +0100
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

Static analysis of linux-next with Coverity has found several repeated
issues in the following commit:

commit 028f5f8ef44fcf87a456772cbb9f0d90a0a22884
Author: Ansuel Smith <ansuelsmth@gmail.com>
Date:   Fri May 14 22:59:55 2021 +0200

    net: dsa: qca8k: handle error with qca8k_read operation


The issues are as following:

322        for (i = 0; i < 4; i++) {
323                val = qca8k_read(priv, QCA8K_REG_ATU_DATA0 + (i * 4));

Unsigned compared against 0 (NO_EFFECT)
unsigned_compare: This less-than-zero comparison of an unsigned value is
never true. val < 0U.

324                if (val < 0)
325                        return val;
326
327                reg[i] = val;
328        }

...


397        /* Check for table full violation when adding an entry */
398        if (cmd == QCA8K_FDB_LOAD) {
399                reg = qca8k_read(priv, QCA8K_REG_ATU_FUNC);

Unsigned compared against 0 (NO_EFFECT)
unsigned_compare: This less-than-zero comparison of an unsigned value is
never true. reg < 0U.

400                if (reg < 0)
401                        return reg;
402                if (reg & QCA8K_ATU_FUNC_FULL)
403                        return -1;
404        }

478        /* Check for table full violation when adding an entry */
479        if (cmd == QCA8K_VLAN_LOAD) {
480                reg = qca8k_read(priv, QCA8K_REG_VTU_FUNC1);

Unsigned compared against 0 (NO_EFFECT)
unsigned_compare: This less-than-zero comparison of an unsigned value is
never true. reg < 0U.

481                if (reg < 0)
482                        return reg;
483                if (reg & QCA8K_VTU_FUNC1_FULL)
484                        return -ENOMEM;
485        }

508        reg = qca8k_read(priv, QCA8K_REG_VTU_FUNC0);

Unsigned compared against 0 (NO_EFFECT)
unsigned_compare: This less-than-zero comparison of an unsigned value is
never true. reg < 0U.

509        if (reg < 0)
510                return reg;

and many others too.

There similar issues with commit:

commit ba5707ec58cfb6853dff41c2aae72deb6a03d389
Author: Ansuel Smith <ansuelsmth@gmail.com>
Date:   Fri May 14 22:59:54 2021 +0200

    net: dsa: qca8k: handle qca8k_set_page errors

for example:

162        val = qca8k_set_page(bus, page);

Unsigned compared against 0 (NO_EFFECT)
unsigned_compare: This less-than-zero comparison of an unsigned value is
never true. val < 0U.

163        if (val < 0)
164                goto exit;

I suspect there are many others. So perhaps a review of recent patches
on this driver would address this unsigned less than zero compare issues.

Colin
