Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6BF3EC74D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 06:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbhHOE2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 00:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbhHOE2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 00:28:30 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F002FC061764
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 21:28:00 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id w20so27763206lfu.7
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 21:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RPDBJvgcmmwVnSdoq4L47G3x6kVI+kyfM8/GYNK4Bcs=;
        b=bTM1tNUD1EuPz3dUdONRbIv3RzlDX2ySUFkg/DLP3j84/ro+IU6a6xtTplHuwysE6L
         2/bQfS5AV0mlvMROwboKkyVUN/OrjhjN0KDYQcs4XOsRXjklEraBuSjg13AmwUyZch1B
         33x4eMzLGV86J4vksQbCCanecEHPfgu2uYYc4b5dgs6Q+n67WwOmvGCdujZu/RgLPpGE
         GI9NaPxKL9WsXgLJsE7aiA5J4TtUjM1TnepWzbOORxP4zp5GlGaJGKMAmpnnGb5kGnGW
         ZfpXrjUVYndqQSzKPKNs+AccPFDa4pxeHE/6ZWBqfmqHB0G3lKW667tH6yuajP4P2Kb6
         Wyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RPDBJvgcmmwVnSdoq4L47G3x6kVI+kyfM8/GYNK4Bcs=;
        b=NSDSjJYWcQYlV8besjx7e9aCo15QjHLA45JWXVJG7/Cco8X4PFe2ZGagSNtGsF5HdM
         M+RXCR69K3QfMwa8P045rFWUMDoKpYFp/mGeLNxL/WfxLisDDGrGeBUZjTT0eBlcPpGw
         jIvDk2w/miqkhn6o4613Xqn5v8g9oZaOZweRMzZytSPddrn6WLMjEphE3HAk5z3JsuYb
         IGxL2+itNTEdwR6EepwNwO1ZVtT7C+LCVgzYuf9rOm+9tSNc2zGhqBSOlq9NnIqI6lg2
         Ih8OuhZou9/TpqeN5CK/kFMXnL+V/oSURXAWNDbTpuliYb4ZoDXNWNczUHx0DyMwnmRz
         wl0A==
X-Gm-Message-State: AOAM5325Sqt0+pokbM/QedNYE0VNV/cv1kvVA3c/hFzOM1lblV4XJ+4z
        8DanNrQTsDXOPMSQu/Y5htNKnNKQ5SNdkkJrSU4=
X-Google-Smtp-Source: ABdhPJz9cJGpVMQ9H0bVorEUzVp8GKhhmDRp+GkNCCPcJGONuWdEl+I3cf6j9flQIkhKF/RUg3N47LX+hEfs4Kxz4zw=
X-Received: by 2002:a05:6512:c08:: with SMTP id z8mr7086740lfu.533.1629001678062;
 Sat, 14 Aug 2021 21:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210803225542.3487172-1-daeho43@gmail.com> <2a79c1c5-366b-92d9-4025-dbda660b1178@kernel.org>
 <YRWKKQe0bcgjKIIA@google.com> <b1a7b8a6-89dc-9076-2388-ced59aa8c47c@kernel.org>
 <YRbARsMfs2O2fz2s@google.com> <b76b5b09-d806-992b-3256-fe7ebfc4a2df@kernel.org>
In-Reply-To: <b76b5b09-d806-992b-3256-fe7ebfc4a2df@kernel.org>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Sat, 14 Aug 2021 21:27:47 -0700
Message-ID: <CACOAw_zTAFfQGqRVRADq_dyO-Rf++Sn+uhwJZ+4MHv4rPwozCw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: introduce periodic iostat io latency traces
To:     Chao Yu <chao@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, I was working on it, after Chao pointed it out. :)
Merging them into F2FS_IOST and separating it from other files looks better.

On Fri, Aug 13, 2021 at 7:06 PM Chao Yu <chao@kernel.org> wrote:
>
> On 2021/8/14 2:56, Jaegeuk Kim wrote:
> > On 08/13, Chao Yu wrote:
> >> On 2021/8/13 4:52, Jaegeuk Kim wrote:
> >>> On 08/11, Chao Yu wrote:
> >>>> Hi Daeho,
> >>>>
> >>>> On 2021/8/4 6:55, Daeho Jeong wrote:
> >>>>> From: Daeho Jeong <daehojeong@google.com>
> >>>>>
> >>>>> Whenever we notice some sluggish issues on our machines, we are always
> >>>>> curious about how well all types of I/O in the f2fs filesystem are
> >>>>> handled. But, it's hard to get this kind of real data. First of all,
> >>>>> we need to reproduce the issue while turning on the profiling tool like
> >>>>> blktrace, but the issue doesn't happen again easily. Second, with the
> >>>>> intervention of any tools, the overall timing of the issue will be
> >>>>> slightly changed and it sometimes makes us hard to figure it out.
> >>>>>
> >>>>> So, I added F2FS_IOSTAT_IO_LATENCY config option to support printing out
> >>>>> IO latency statistics tracepoint events which are minimal things to
> >>>>> understand filesystem's I/O related behaviors. With "iostat_enable" sysfs
> >>>>> node on, we can get this statistics info in a periodic way and it
> >>>>> would cause the least overhead.
> >>>>>
> >>>>> [samples]
> >>>>>     f2fs_ckpt-254:1-507     [003] ....  2842.439683: f2fs_iostat_latency:
> >>>>> dev = (254,11), iotype [peak lat.(ms)/avg lat.(ms)/count],
> >>>>> rd_data [136/1/801], rd_node [136/1/1704], rd_meta [4/2/4],
> >>>>> wr_sync_data [164/16/3331], wr_sync_node [152/3/648],
> >>>>> wr_sync_meta [160/2/4243], wr_async_data [24/13/15],
> >>>>> wr_async_node [0/0/0], wr_async_meta [0/0/0]
> >>>>>
> >>>>>     f2fs_ckpt-254:1-507     [002] ....  2845.450514: f2fs_iostat_latency:
> >>>>> dev = (254,11), iotype [peak lat.(ms)/avg lat.(ms)/count],
> >>>>> rd_data [60/3/456], rd_node [60/3/1258], rd_meta [0/0/1],
> >>>>> wr_sync_data [120/12/2285], wr_sync_node [88/5/428],
> >>>>> wr_sync_meta [52/6/2990], wr_async_data [4/1/3],
> >>>>> wr_async_node [0/0/0], wr_async_meta [0/0/0]
> >>>>>
> >>>>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> >>>>>
> >>>>> ---
> >>>>> v2: clean up with wrappers and fix a build breakage reported by
> >>>>>        kernel test robot <lkp@intel.com>
> >>>>> ---
> >>>>>     fs/f2fs/Kconfig             |   9 +++
> >>>>
> >>>> I try to apply this patch in my local dev branch, but it failed due to
> >>>> conflicting with below commit, it needs to rebase this patch to last dev
> >>>> branch.
> >>>
> >>> I applied this in dev branch. Could you please check?
> >>
> >> Yeah, I see.
> >>
> >>>>> +config F2FS_IOSTAT_IO_LATENCY
> >>>>> + bool "F2FS IO statistics IO latency information"
> >>>>> + depends on F2FS_FS
> >>>>> + default n
> >>>>> + help
> >>>>> +   Support printing out periodic IO latency statistics tracepoint
> >>>>> +   events. With this, you have to turn on "iostat_enable" sysfs
> >>>>> +   node to print this out.
> >>>>
> >>>> This functionality looks independent, how about introuducing iostat.h
> >>>> and iostat.c (not sure, maybe trace.[hc])to include newly added structure
> >>>> and functions for dispersive codes cleanup.
> >>
> >> Thoughts? this also can avoid using CONFIG_F2FS_IOSTAT_IO_LATENCY in many places.
> >
> > It seems there's somewhat dependency with iostat which is done by default.
> > How about adding this by default as well in the existing iostat, and then
> > covering all together by F2FS_IOSTAT?
>
> Agreed.
>
> Any thoughts about using separated files to maintain these independent functionality
> codes? like we did in trace.[hc] previously.
>
> Thanks,
>
> >
> >>
> >> Thanks,
