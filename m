Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FCE30718F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 09:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbhA1Ibw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 03:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbhA1Iaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 03:30:46 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02865C061573
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 00:30:06 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d13so2938626plg.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 00:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lLx2GM7oGfSXnUAyxW1G0ulvLAw88x2lMXgNDEjl+LU=;
        b=VJHV+LdxhKUiwgrz7BV90s7UqJPI5SXslFodc7Au21SsGZW50fLz4G1yJRvoddfw79
         3sVq7e2Ge4H+53veRfM2fmj2cFcu64Hc/sbfXyR0w3ksocIuuklSUS4QJ09izx8MiMW/
         WkxolrLmIPOUh0z+zZPJ1qngJkt5hIyAqmeIBt/gCriGwsdjUPUnDGkdvLmQXfnpEu+a
         BHJP3UhHhEL6uj+zuPVSgho/frG2TE0jy/o85/46jZ+ZmSUEf3N3wnxhme4JWkQebbNG
         3MSZYfUH5SzUHAEMvh0LJ6vHcnK03a/VN211UXR4dUSq2RHZ8MuRylmXg/PO2HxY7qz2
         ck7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lLx2GM7oGfSXnUAyxW1G0ulvLAw88x2lMXgNDEjl+LU=;
        b=jy1YsqHbKX1ixyYfNn8zXDq2vxOT0QVE34bo9kjcUqhbRQDeUbJ0bx4XNCo9WMHHQ1
         XIse8EC55idF1A+vnjvp3T493yXCn/TkaV6i40mk2qfM3djela+Zs4kRrwKvs/K/9lr9
         TdOKxTPsPKRSC8DlZ31HRgoFZ76OhqXkysCSONYErSxVn0bxXvLxawJO0nloPqrsEKMW
         gQ4VG8cnWyskaVSci3Hau6uUmr7OS59aszqGdf6NOSm76U7FDevQ7bkYh5grk3H0jdBA
         k656PPsy1+38cBFnp9FU0vDPzNBXYMpWmrIqrIDg6sXS3Wv5u+5QCat9uUM4QaPPkcx9
         VFog==
X-Gm-Message-State: AOAM5324D+NzB6QKk8WNkc0eA/9qXAujHw9T1uXQL0HHcTnS9j9whEBx
        UdzzP7WFmwVys0YCuhWxD7k=
X-Google-Smtp-Source: ABdhPJyRi9XLCUm4I9VuceCq47G1KRRNJ4KNcOHVwhkKM4AoQjF5REu9oZQ2Z1wd9O6vjfaC2/yY4g==
X-Received: by 2002:a17:903:1cc:b029:de:98bb:d46d with SMTP id e12-20020a17090301ccb02900de98bbd46dmr15550868plh.54.1611822605414;
        Thu, 28 Jan 2021 00:30:05 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id h2sm5052311pfk.4.2021.01.28.00.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 00:30:04 -0800 (PST)
Date:   Thu, 28 Jan 2021 17:30:02 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        kernel test robot <oliver.sang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, zhengjun.xing@linux.intel.com
Subject: Re: [printk]  b031a684bf: INFO:rcu_tasks_detected_stalls_on_tasks
Message-ID: <YBJ2CjN2YntC1o3j@jagdpanzerIV.localdomain>
References: <20210122081311.GA12834@xsang-OptiPlex-9020>
 <YAr7d6A4CkMpgx+g@alley>
 <YA+gAV1kW8Ru1+Bo@jagdpanzerIV.localdomain>
 <87bldaaxcc.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bldaaxcc.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/01/27 22:28), John Ogness wrote:
> 
> # modprobe rcutorture onoff_interval=3 onoff_holdoff=30 torture_type=tasks
> 
> (Those are the same modprobe parameters used by the lkp job.)
> 
> After about a minute I see:
> 
> [   47.268292] tasks-torture: rcu_torture_read_exit: Start of episode
> [   51.273365] tasks-torture: rcu_torture_read_exit: End of episode
> [   55.823306] smpboot: do_boot_cpu failed(-1) to wakeup CPU#0
> [   55.824350] tasks-torture:torture_onoff task: online 0 failed: errno -5
> [   55.830661] tasks-torture:torture_onoff task: online 0 failed: errno -5
> [   55.848524] tasks-torture:torture_onoff task: online 0 failed: errno -5

Just out of curious, this is seen only with the printk commit in
question applied? do_boot_cpu() doesn't seem to call a lot of printk-s,
only pr_debug("Setting warm reset code and vector.\n"), as far as I can
tell.

I can't repro this on my arm64 board. Maybe it's too slow. Race condition?

	-ss
