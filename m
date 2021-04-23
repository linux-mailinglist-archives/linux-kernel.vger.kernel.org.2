Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB80369455
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 16:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhDWOEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 10:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbhDWOEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:04:51 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF9FC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:04:14 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id j3so23801640qvs.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kepstin.ca; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=jznFfXH3MtqfGVEkrmhJP6Yon0zk22CxcT972mFmMA4=;
        b=bMLJrk/obukUJZhrL88+f/Mr4C5z1brKgVvbH5SGUK+6xF3icV6HMSnn4mu5z2RFfw
         sHkhzitXYS5uQTEtjfD8WixNiZMw26GUZcF4KXBQyL4GxBED56IBwpv3osG/OvU/+h0G
         4Xmh/GXKoz0tvGImHNmNgjJ63SqlsxeXQKgI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=jznFfXH3MtqfGVEkrmhJP6Yon0zk22CxcT972mFmMA4=;
        b=DkAbHYyLkPVkFYfLMWvGlAThvM0yfqD5psUi9b7T1ywiw+yi7rvA13ORdKKbVZaHBm
         AabXcnzw3eO2UHZqyssP+NIetjqpeGyXwBKklN5BZESqWV4CKncHU0tZUJNrasQq06qJ
         SD9Ezvxpu5bCJAV9dBI3vl4/2h/9N7VSYsmDNu3FXN3XbEyIPSLEj9aArOA9idGj2lSS
         F5jgbtfLP77q5LtjeS1Lg56HtnottF+/gC2XdR13SC3MXM/TNiyqrdG6h73myMGhNCAU
         P2lfQ0n+e0DpWODoxbGPAoRxFbNndtFvIve9znig7uBbZ/e1YfvmE3wR12tYKgVZ96V4
         E6Lg==
X-Gm-Message-State: AOAM530Wb2wjjR2N2UhcYBNfK+gYw8tTsj7Sluv0WVgMNN9OvecKRfMA
        FSEL7Z9NlLdcpDvfiVKW329fNg==
X-Google-Smtp-Source: ABdhPJxEfjGtvWvCfKDAANDT+k/Jjh5S5JBQr5QdKg5uBo3ZpDbhCVS3n7TnZc3tkqPjTRcEa0iHNw==
X-Received: by 2002:ad4:52e2:: with SMTP id p2mr4304303qvu.21.1619186654083;
        Fri, 23 Apr 2021 07:04:14 -0700 (PDT)
Received: from sasami.kepstin.ca (dhcp-108-168-125-232.cable.user.start.ca. [108.168.125.232])
        by smtp.gmail.com with ESMTPSA id u21sm4311482qtq.11.2021.04.23.07.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:04:13 -0700 (PDT)
Message-ID: <4080ac25f6c8ca4088a950eb9d63da641c020941.camel@kepstin.ca>
Subject: Re: [PATCH v2] tools/power turbostat: Fix RAPL summary collection
 on AMD processors
From:   Calvin Walton <calvin.walton@kepstin.ca>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Borislav Petkov <bp@suse.de>, Terry Bowman <terry.bowman@amd.com>,
        lenb@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, wei.huang2@amd.com, aros@gmx.com,
        rui.zhang@intel.com
Date:   Fri, 23 Apr 2021 10:04:10 -0400
In-Reply-To: <20210423121607.GA426003@chenyu-desktop>
References: <20210419195812.147710-1-terry.bowman@amd.com>
         <20210420020336.GA386151@chenyu-desktop> <20210420080701.GA2326@zn.tnic>
         <20210420131541.GA388877@chenyu-desktop>
         <4cbb1eff77de1e843912267ade4686cfa1acd610.camel@kepstin.ca>
         <20210420143754.GA390118@chenyu-desktop>
         <5cf35f3742d1181421d955174b1aa9434d042c96.camel@kepstin.ca>
         <20210423121607.GA426003@chenyu-desktop>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-04-23 at 20:16 +0800, Chen Yu wrote
> 
> Calvin, could you please take a look at the following version if it
> is suitible?

I assume this patch is adapted from my earlier submission of the
complete fix to be an incremental fix on top of the already applied
patch? If so, you are OK to add

Signed-off-by: Calvin Walton <calvin.walton@kepstin.ca>

> From b2e63fe4f02e17289414b4f61237da822df115fb Mon Sep 17 00:00:00
> 2001
> From: Calvin Walton <calvin.walton@kepstin.ca>
> Date: Fri, 23 Apr 2021 17:32:13 +0800
> Subject: [PATCH 3/5] tools/power turbostat: Fix offset overflow issue
> in index
>  converting
> 
> The idx_to_offset() function returns type int (32-bit signed), but
> MSR_PKG_ENERGY_STAT is greater than INT_MAX (or rather, would be
> interpreted as a negative number). The end result is that it hits
> the if (offset < 0) check in update_msr_sum() resulting in the timer
> callback for updating the stat in the background when long durations
> are used to not happen. The similar issue exists in offset_to_idx()
> and update_msr_sum().
> 
> This patch fixes this issue by converting the 'int' type to 'off_t'
> accordingly.

This patch covers all of the places I know about which had type issues
- it should be good. Thanks!

-- 
Calvin Walton <calvin.walton@kepstin.ca>

