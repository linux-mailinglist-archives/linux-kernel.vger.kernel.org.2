Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE89C44F780
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 12:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbhKNLGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 06:06:43 -0500
Received: from lithium.sammserver.com ([168.119.122.30]:49104 "EHLO
        lithium.sammserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbhKNLGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 06:06:41 -0500
X-Greylist: delayed 404 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Nov 2021 06:06:41 EST
Received: from mail.sammserver.com (sammserver.wg [10.32.40.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by lithium.sammserver.com (Postfix) with ESMTPS id 04A1F31108F4;
        Sun, 14 Nov 2021 11:57:02 +0100 (CET)
Received: from fastboi.localdomain (fastboi.wg [10.32.40.5])
        by mail.sammserver.com (Postfix) with ESMTP id 8839C1682B;
        Sun, 14 Nov 2021 11:56:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1636887421; bh=Ttu6ajWxrhdt8BUJQ8G/ycJ8924uXkAw3eshrgRzoAs=;
        h=Date:From:To:Cc:Subject:From;
        b=hFpbUzY05DrGjG+AjVCFVlw5rcTd9Rswrs6/uHyZIvv0+rZifR67NU4XqYWR3TkLT
         svktiLKL7XMDr8+p8HyI7ECaCSoKPHwo6H9mYjiS6Izdn12z/nhiyDpWfjxmAjcp9Z
         UDYX/A4FzXfLybFb6f1C/H7Hx5M7eq9L+ltT7FLo=
Received: by fastboi.localdomain (Postfix, from userid 1000)
        id 764891421378; Sun, 14 Nov 2021 11:56:57 +0100 (CET)
Date:   Sun, 14 Nov 2021 11:56:57 +0100
From:   Samuel =?utf-8?B?xIxhdm9q?= <samuel@cavoj.net>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Backlight control broken on UM325 (OLED) on 5.15 (bisected)
Message-ID: <20211114105657.b57pjojiv72iopg5@fastboi.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sammserver.tu
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the backlight control no longer works on my ASUS UM325 (Ryzen 5700U)
OLED laptop. I have bisected the breakage to commit 7fd13baeb7a3a48.

    commit 7fd13baeb7a3a48cae12c36c52f06bf4e9e7d728 (HEAD, refs/bisect/bad)
    Author: Alex Deucher <alexander.deucher@amd.com>
    Date:   Thu Jul 8 16:31:10 2021 -0400
     
        drm/amdgpu/display: add support for multiple backlights
        
        On platforms that support multiple backlights, register
        each one separately.  This lets us manage them independently
        rather than registering a single backlight and applying the
        same settings to both.
        
        v2: fix typo:
        Reported-by: kernel test robot <lkp@intel.com>
        
        Reviewed-by: Roman Li <Roman.Li@amd.com>
        Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

I have encountered another user with the same issue on reddit[0].

The node in /sys/class/backlight exists, writing to it just does
nothing. I would be glad to help debugging the issue. Thank you very
much.

Regards,
Samuel Čavoj

[0]: https://www.reddit.com/r/AMDLaptops/comments/qst0fm/after_updating_to_linux_515_my_brightness/
