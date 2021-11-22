Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCEA459412
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 18:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240004AbhKVRml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 12:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbhKVRmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 12:42:38 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387A7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 09:39:31 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so17427171pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 09:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dzjj5orhwwSm2n2J0MVi5GizVnPUNuZLO6AAe4M0hDU=;
        b=I844JISASdOxuOY2hzrnCyH+OXTW8kcT3MnXY7hlgwlWG18LcYCNZLfOfvL2L6kNZv
         8BTX03GrbqmBCUZVFjKUiK1TGFUZ3Mb7uzZZli/XoWQaRJna3f0pLJ0YAr9ozRkhOTm3
         wW8jxAogwrZCyhmon1srSKwt6s8nmLNfJUh+FubhT5KT2NY7qcqyotz4u0ET4P1+jn1H
         ICDkniYNwYvtGXipEtjFf8IKvZk/3ABE2E9CEp1Qd5n8SzrC3hv6wv4a58yddnrU1EJu
         b+ujLMPO8U+LuNCTNyuqD8o6HzqMHBnTpfaj/XjRwCAPpAU70c4dlCjSEe/4N3BB5Yna
         J4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=dzjj5orhwwSm2n2J0MVi5GizVnPUNuZLO6AAe4M0hDU=;
        b=YYneZqHFLefnc+5p4FD9Kj46RETosnYv1O76yYaBcnsUqkewGnW9G0JnLUraLm2tNG
         CDbCESc4uDEa4+eplXllmR8nxIZuf4tB8eXaEb5KOFueou7kgX/EgSoqeDZGupVU9g8N
         wNcpSlH4o0Auax712Ed+4MNgvdGGF8XtXXI2sCdT4vEkMMgWt58PbWj6VsuMM4R9+kxu
         Dd8XF3v6XNLMo6+5nK+FSYzSlUiYdMAhXcFSOoBTgm0ywPVjO73J6SQMTozoz57cGaDA
         rdN5SdBlqIntO+WAGaDYAzN5VnMJJlMFBZWZEapNU5xSu4nMhGEQpc0c87gH216bDYvn
         vN0A==
X-Gm-Message-State: AOAM5301wjcgGVC21uNeYoltrWgwcYjkKxXZ4ZsDBWclZr1BokmSJmvM
        X4tf5OF3bg/sU9fv6eCt5BA=
X-Google-Smtp-Source: ABdhPJzAiU3uG+5IECYMUEv8UQy1I2AL9KJBv9mrIQLqV+C156HIHdLyDSeDEVmGMstiuKqW4hHx3A==
X-Received: by 2002:a17:90a:2fc7:: with SMTP id n7mr33268409pjm.141.1637602770704;
        Mon, 22 Nov 2021 09:39:30 -0800 (PST)
Received: from google.com ([2620:15c:211:201:9276:1454:9a80:3095])
        by smtp.gmail.com with ESMTPSA id t4sm10154265pfq.163.2021.11.22.09.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 09:39:30 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 22 Nov 2021 09:39:28 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernfs: switch global kernfs_rwsem lock to per-fs lock
Message-ID: <YZvV0ESA+zHHqHBU@google.com>
References: <20211118230008.2679780-1-minchan@kernel.org>
 <YZbbxK1F7jY/RBFF@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZbbxK1F7jY/RBFF@slm.duckdns.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 01:03:32PM -1000, Tejun Heo wrote:
> On Thu, Nov 18, 2021 at 03:00:08PM -0800, Minchan Kim wrote:
> > The kernfs implementation has big lock granularity(kernfs_rwsem) so
> > every kernfs-based(e.g., sysfs, cgroup) fs are able to compete the
> > lock. It makes trouble for some cases to wait the global lock
> > for a long time even though they are totally independent contexts
> > each other.
> > 
> > A general example is process A goes under direct reclaim with holding
> > the lock when it accessed the file in sysfs and process B is waiting
> > the lock with exclusive mode and then process C is waiting the lock
> > until process B could finish the job after it gets the lock from
> > process A.
> > 
> > This patch switches the global kernfs_rwsem to per-fs lock, which
> > put the rwsem into kernfs_root.
> > 
> > Suggested-by: Tejun Heo <tj@kernel.org>
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> 
> Greg, I think this is the right thing to do even if there is no concrete
> performance argument (not saying there isn't). It's just weird to entangle
> these completely unrelated users in a single rwsem.
> 
> Thanks.

Greg, Do you mind picking this patch?
