Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C5839E96F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 00:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhFGWUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 18:20:35 -0400
Received: from fgw22-7.mail.saunalahti.fi ([62.142.5.83]:26151 "EHLO
        fgw22-7.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230183AbhFGWUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 18:20:34 -0400
Received: from localhost (88-115-248-186.elisa-laajakaista.fi [88.115.248.186])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id 4a9ea5ed-c7de-11eb-88cb-005056bdf889;
        Tue, 08 Jun 2021 01:18:31 +0300 (EEST)
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 3/3] eeprom: idt_89hpesx: use SPDX-License-Identifier
Date:   Tue,  8 Jun 2021 01:17:57 +0300
Message-Id: <20210607221757.81465-3-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210607221757.81465-1-andy.shevchenko@gmail.com>
References: <20210607221757.81465-1-andy.shevchenko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use SPDX-License-Identifier: GPL-2.0-only, instead of hand writing it.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/misc/eeprom/idt_89hpesx.c | 33 +------------------------------
 1 file changed, 1 insertion(+), 32 deletions(-)

diff --git a/drivers/misc/eeprom/idt_89hpesx.c b/drivers/misc/eeprom/idt_89hpesx.c
index 3e4a594c110b..b0cff4b152da 100644
--- a/drivers/misc/eeprom/idt_89hpesx.c
+++ b/drivers/misc/eeprom/idt_89hpesx.c
@@ -1,38 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
- *   This file is provided under a GPLv2 license.  When using or
- *   redistributing this file, you may do so under that license.
- *
- *   GPL LICENSE SUMMARY
- *
  *   Copyright (C) 2016 T-Platforms. All Rights Reserved.
  *
- *   This program is free software; you can redistribute it and/or modify it
- *   under the terms and conditions of the GNU General Public License,
- *   version 2, as published by the Free Software Foundation.
- *
- *   This program is distributed in the hope that it will be useful, but WITHOUT
- *   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *   FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- *   more details.
- *
- *   You should have received a copy of the GNU General Public License along
- *   with this program; if not, it can be found <http://www.gnu.org/licenses/>.
- *
- *   The full GNU General Public License is included in this distribution in
- *   the file called "COPYING".
- *
- *   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- *   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- *   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
- *   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- *   OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- *   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
- *   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
- *   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
- *   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- *   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
- *   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
  * IDT PCIe-switch NTB Linux driver
  *
  * Contact Information:
-- 
2.32.0

