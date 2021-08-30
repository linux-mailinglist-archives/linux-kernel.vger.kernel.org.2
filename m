Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A993FB20C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 09:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbhH3Hpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 03:45:41 -0400
Received: from lb1.peda.net ([130.234.6.152]:18661 "EHLO lb1.peda.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233318AbhH3Hpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 03:45:39 -0400
Received: from [84.251.221.37] (dsl-jklbng12-54fbdd-37.dhcp.inet.fi [84.251.221.37])
        by lb1.peda.net (Postfix) with ESMTPSA id 70DD460000B;
        Mon, 30 Aug 2021 10:44:44 +0300 (EEST)
To:     linux-kernel@vger.kernel.org
From:   Mikko Rantalainen <mikko.rantalainen@peda.net>
Subject: Why is Shmem included in Cached in /proc/meminfo?
Message-ID: <5a42eb2b-fd7b-6296-f5d6-619661ad1418@peda.net>
Date:   Mon, 30 Aug 2021 10:44:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not immediately obvious from fs/proc/meminfo.c function
meminfo_proc_show() but the output of Cached: field seems to always
include all of Shmem: field, too.

Is this intentional? Usually cache is something that can be discarded if
needed but shared memory (e.g. used to contain files in tmpfs) cannot be
discarded without a data-loss. As such, I'd argue that it shouldn't be
included in the Cached: output.

A simple fix could be

-	cached = global_node_page_state(NR_FILE_PAGES) -
-			total_swapcache_pages() - i.bufferram;
+	cached = global_node_page_state(NR_FILE_PAGES) -
+			total_swapcache_pages()
+			- i.bufferram - i.sharedram;

-- 
Mikko
