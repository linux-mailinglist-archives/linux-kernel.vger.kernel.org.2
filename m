Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF645456FCD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 14:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbhKSNqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 08:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235424AbhKSNqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 08:46:37 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2012BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 05:43:36 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id u1so18220075wru.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 05:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=fdzVLHIvHOKblaOiMeNS5qht0FIOmVFmoISZRt5DA9A=;
        b=MQgXtzGpdPvzYD0sfOv1Bnxon272/Osl9aC+Ac1Ip0YHVoQU+f5dYMqaH2wGeUer3l
         nbtbQ4K7Am4HYwB5/j649QL9zlpNRfN+sOEiAthZO8mLu1dtQXeYz3rNVRJ/OXudS+Fz
         Vmz/pYAf0YLTLpQd5sP5XD5nd4BLWTDfHcTjxN7KLUMcK5xFd8fuoAvAT1RpGbIzhSs8
         T6qvowjzet9NYghtNju0ZwLVAB6RbfgPlw/rcPLBhkIkBJyHohKFZMVjB5DjJz3RgbVq
         B7746WC6eGCgKqqDri+ecXPqTSopiN/ZjMqrjWqeD/H8tXUK/6Xi4SCs88lsId2Nf8iL
         nnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=fdzVLHIvHOKblaOiMeNS5qht0FIOmVFmoISZRt5DA9A=;
        b=PCykRVJdZV+CfOMh3ra5/UtRKMV/4WIh3C/tVJjpIGf/X2RJz1jBa4WrEGxVCuzSkn
         FWdA8CvldqUpvceAKeV8UUJ3qVJZg6KdtRuV3eW2YmxUJE1HMJoGGixEeUROd+G8GomG
         y+fwVbetmnC7lvrTx4I8f0YdNWB6bljtFiIgSMJq7DuNaxzH71Zj7+Wxjq5Aqpp0Zieh
         t80Px4+FquyCBQ7LAEewnN8MBE+ivC1Etkxa5Hg9RbcgGNIaMG89cIXbwO5BozjGeOVV
         OhWDUCmZpH4UhM9GQet2OmVUDfqQ22qk4kJCH4/qfmt5qlI+4obQut79ULu9figTO4JU
         whTA==
X-Gm-Message-State: AOAM533K2T7SBZ9ALDf6qY9X7hv6/X/z0fNE+lqgCtAyggxjIE3Q0RLD
        OnTpbce10+moUdvyABcMjXpzFefgiA4=
X-Google-Smtp-Source: ABdhPJx77hiEgDDfma8yvSNRTiI/WzdPYMWTA7D6xzwGvEHZk0MBEh9wCffn9bvZ+Bo/ooRWzG1EYg==
X-Received: by 2002:adf:f012:: with SMTP id j18mr7429234wro.353.1637329414659;
        Fri, 19 Nov 2021 05:43:34 -0800 (PST)
Received: from [192.168.1.10] ([176.251.126.168])
        by smtp.googlemail.com with ESMTPSA id g18sm15322139wmq.4.2021.11.19.05.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 05:43:34 -0800 (PST)
Message-ID: <371c6dde-ee04-cf2e-1463-113ba8a2ac22@googlemail.com>
Date:   Fri, 19 Nov 2021 13:43:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Content-Language: en-GB
To:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael.j.wysocki@intel.com
From:   Chris Clayton <chris2553@googlemail.com>
Subject: Intel bluetooth regression in 5.15.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I built and installed 5.15.3 this morning and found that my bluetooth devices no longer work. 5.15.2 and 5.10.80 are
both OK.

I've bisected it and landed on:

cfc1a472a8d89c0d0bbb3600501eeeebc5ec8039 is the first bad commit
commit cfc1a472a8d89c0d0bbb3600501eeeebc5ec8039
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Date:   Sat Oct 9 16:22:09 2021 +0200

    ACPI: scan: Release PM resources blocked by unused objects

    [ Upstream commit c10383e8ddf4810b9a5c1595404c2724d925a0a6 ]

    On some systems the ACPI namespace contains device objects that are
    not used in certain configurations of the system.  If they start off
    in the D0 power state configuration, they will stay in it until the
    system reboots, because of the lack of any mechanism possibly causing
    their configuration to change.  If that happens, they may prevent
    some power resources from being turned off or generally they may
    prevent the platform from getting into the deepest low-power states
    thus causing some energy to be wasted.

    Address this issue by changing the configuration of unused ACPI
    device objects to the D3cold power state one after carrying out
    the ACPI-based enumeration of devices.

    BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=214091
    Link: https://lore.kernel.org/linux-acpi/20211007205126.11769-1-mario.limonciello@amd.com/
    Reported-by: Mario Limonciello <mario.limonciello@amd.com>
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    Tested-by: Mario Limonciello <mario.limonciello@amd.com>
    Signed-off-by: Sasha Levin <sashal@kernel.org>

 drivers/acpi/glue.c     | 25 +++++++++++++++++++++++++
 drivers/acpi/internal.h |  1 +
 drivers/acpi/scan.c     |  6 ++++++
 3 files changed, 32 insertions(+)

5.15.3 with that commit reverted works fine.

Let me know if you need any additional diagnostics or patches tested but please cc me as I'm not subscribed.

Chris
