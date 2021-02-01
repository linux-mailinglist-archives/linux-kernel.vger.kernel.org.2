Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB61E30A43B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 10:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbhBAJSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 04:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbhBAJRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 04:17:04 -0500
Received: from cc-smtpout1.netcologne.de (cc-smtpout1.netcologne.de [IPv6:2001:4dd0:100:1062:25:2:0:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30CEC061574
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 01:06:42 -0800 (PST)
Received: from cc-smtpin2.netcologne.de (cc-smtpin2.netcologne.de [89.1.8.202])
        by cc-smtpout1.netcologne.de (Postfix) with ESMTP id C65B813693;
        Mon,  1 Feb 2021 10:06:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by cc-smtpin2.netcologne.de (Postfix) with ESMTP id C2CB311F48;
        Mon,  1 Feb 2021 10:06:41 +0100 (CET)
Received: from [213.196.193.186] (helo=cc-smtpin2.netcologne.de)
        by localhost with ESMTP (eXpurgate 4.19.0)
        (envelope-from <kurt@garloff.de>)
        id 6017c4a1-0254-7f0000012729-7f000001abb8-1
        for <multiple-recipients>; Mon, 01 Feb 2021 10:06:41 +0100
Received: from nas2.garloff.de (xdsl-213-196-193-186.nc.de [213.196.193.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by cc-smtpin2.netcologne.de (Postfix) with ESMTPSA;
        Mon,  1 Feb 2021 10:06:39 +0100 (CET)
Received: from [192.168.155.202] (ap4.garloff.de [192.168.155.15])
        by nas2.garloff.de (Postfix) with ESMTPSA id 6AEF6B3B13A5;
        Mon,  1 Feb 2021 10:06:39 +0100 (CET)
Subject: [PATCH 1/1]: turbostat: Fix Pkg Power on Zen
From:   Kurt Garloff <kurt@garloff.de>
To:     Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <1f1fb01e-0616-34ea-ede6-dc7dd679c3d4@garloff.de>
 <c7074c16-5d64-e829-10f6-ef91f5f6222b@garloff.de>
Message-ID: <cc9628ac-d612-6c7d-6bc1-ac13da980659@garloff.de>
Date:   Mon, 1 Feb 2021 10:06:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <c7074c16-5d64-e829-10f6-ef91f5f6222b@garloff.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 5d399d05df42ffcaa2b3836b580631c4024487a0
Author: Kurt Garloff <kurt@garloff.de>
Date:   Mon Feb 1 09:01:47 2021 +0000

    turbostat: Fix Pkg Power tracking on Zen
   
    AMD Zen processors use a different MSR (MSR_PKG_ENERGY_STAT) than intel
    (MSR_PKG_ENERGY_STATUS) to track package power; however we want to record
    it at the same offset in our package_data.
    offset_to_idx() however only recognized the intel MSR, erroring
    out with -13 on Zen.
   
    With this fix, it will support the Zen MSR.
    Tested successfully on Ryzen 3000 & 5000.
   
    Signed-off-by: Kurt Garloff <kurt@garloff.de>

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 389ea5209a83..cb830e73d899 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -325,6 +325,7 @@ int offset_to_idx(int offset)
     int idx;
 
     switch (offset) {
+    case MSR_PKG_ENERGY_STAT:
     case MSR_PKG_ENERGY_STATUS:
         idx = IDX_PKG_ENERGY;
         break;

-- 
Kurt Garloff <kurt@garloff.de>
Cologne, Germany

