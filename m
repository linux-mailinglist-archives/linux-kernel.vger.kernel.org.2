Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272E54078C4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 16:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbhIKOVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 10:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235788AbhIKOVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 10:21:36 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B69C061574
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 07:20:24 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1mP3rg-0006kU-3D; Sat, 11 Sep 2021 16:20:20 +0200
Date:   Sat, 11 Sep 2021 16:20:20 +0200
From:   Martin Kaiser <lists@kaiser.cx>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/18] staging: r8188eu: remove unused functions from
 odm_interface.c
Message-ID: <20210911142020.zdau6mvkopv6iaiw@viti.kaiser.cx>
References: <20210911132635.30369-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210911132635.30369-1-straube.linux@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Michael Straube (straube.linux@gmail.com):

> This series removes unused and/or empty functions from the file
> hal/odm_interface.c.

> Tested on x86_64 with Inter-Tech DMG-02.

> Michael Straube (18):
>   staging: r8188eu: remove empty ODM_ReleaseTimer()
>   staging: r8188eu: remove unused ODM_AcquireSpinLock()
>   staging: r8188eu: remove unused ODM_ReleaseSpinLock()
>   staging: r8188eu: remove unused ODM_FillH2CCmd()
>   staging: r8188eu: remove unused ODM_sleep_us()
>   staging: r8188eu: remove unused ODM_InitializeWorkItem()
>   staging: r8188eu: remove unused ODM_StartWorkItem()
>   staging: r8188eu: remove unused ODM_StopWorkItem()
>   staging: r8188eu: remove unused ODM_FreeWorkItem()
>   staging: r8188eu: remove unused ODM_ScheduleWorkItem()
>   staging: r8188eu: remove unused ODM_IsWorkItemScheduled()
>   staging: r8188eu: remove unused ODM_SetTimer()
>   staging: r8188eu: remove unused ODM_Read2Byte()
>   staging: r8188eu: remove unused ODM_FreeMemory()
>   staging: r8188eu: remove unused ODM_AllocateMemory()
>   staging: r8188eu: remove unused prototype ODM_InitializeTimer()
>   staging: r8188eu: remove unused ODM_CancelAllTimers()
>   staging: r8188eu: remove unused ODM_InitAllTimers()

>  drivers/staging/r8188eu/hal/odm.c             | 17 ----
>  drivers/staging/r8188eu/hal/odm_interface.c   | 80 -------------------
>  drivers/staging/r8188eu/include/odm.h         |  6 --
>  .../staging/r8188eu/include/odm_interface.h   | 45 -----------
>  4 files changed, 148 deletions(-)


Looks good to me.

Acked-by: Martin Kaiser <martin@kaiser.cx>

for all patches.

Thanks,
Martin
