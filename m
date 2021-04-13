Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A2D35E7F4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 23:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbhDMVCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 17:02:45 -0400
Received: from ms.lwn.net ([45.79.88.28]:46252 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229832AbhDMVCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 17:02:43 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2A16E9A6;
        Tue, 13 Apr 2021 21:02:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2A16E9A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1618347742; bh=wVSp4RSQ4L05NKFpyUO+TSUmthwRID+uUqxyo2Y9fJw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=em1+ots0iaxdxDiuOo4TgLB6Qv+QppNx4oNLYZN5kB7GJBue3PZTY4p4SPahEPGZQ
         lEyt1Qjw8Bwzfcwud2ErlPMaUc6Jjotp9/alEHtR2gu35WqcRATYHVhDcle8DZx6Z9
         T4k1F2khvaZ0JoXRkcWUoPjhimsADWlu1t69SGIf/3KAsH6Q9sWV+NIAr61kRRqy48
         84HWLAmg3CPhmCybmi4xhs38aocuuoltpREkili11RjuJPP4X1Aa0HZpgxi5vD2i8e
         CN38aefQZDwmCUA8eX1zZbQpjUJ9E88LQLWpy4OcduIVWzbPRlyRUFi4hDWws3PpXS
         oEKr0OPhbo2Hw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation/submitting-patches: Document RESEND tag
 on patches
In-Reply-To: <20210413113834.GE16519@zn.tnic>
References: <20201217183756.GE23634@zn.tnic> <20210413113834.GE16519@zn.tnic>
Date:   Tue, 13 Apr 2021 15:02:21 -0600
Message-ID: <87pmyxsxsy.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:

> Hi Jon,
>
> here's the next piece of documentation which should be generic enough.
>
> Thx.
>
> ---
> From: Borislav Petkov <bp@suse.de>
> Date: Tue, 13 Apr 2021 13:26:29 +0200
>
> Explain when a submitter should tag a patch or a patch series with the
> "RESEND" tag.
>
> This has been partially carved out from a tip subsystem handbook
> patchset by Thomas Gleixner:
>
>   https://lkml.kernel.org/r/20181107171010.421878737@linutronix.de
>
> and incorporates follow-on comments.
>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  Documentation/process/submitting-patches.rst | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index ab92d9ccd39a..9284735e0b34 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -346,6 +346,16 @@ that you have sent your patches to the right place.  Wait for a minimum of
>  one week before resubmitting or pinging reviewers - possibly longer during
>  busy times like merge windows.
>  
> +It's also ok to resend the patch or the patch series after a couple of
> +weeks with the word "RESEND" added to the subject line::
> +
> +   [PATCH Vx RESEND] sub/sys: Condensed patch summary
> +
> +Don't add "RESEND" when you are submitting a modified version of your
> +patch or patch series - "RESEND" only applies to resubmission of a
> +patch or patch series which have not been modified in any way from the
> +previous submission.
> +

Makes sense, applied.

For future installments, could you send them in their own thread as an
ordinary patch so I don't need to edit in the changelog after applying
them?

Thanks,

jon
