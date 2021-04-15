Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0760361023
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 18:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbhDOQ2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 12:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbhDOQ2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 12:28:17 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B596AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 09:27:52 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so23087698otk.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 09:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sv8ShlWCFYrRvkMTcwOZXNbuS9oUEdPA5USpJjouThE=;
        b=FOOM/KGf5hmW0LDCmdb7lpl3uQgy3UEwO5PjMunL+/tdyf8NWyML93As/uk5No4kVh
         3/iXatPA+uyl4WU4kwgTde2JNYOYaA2k8gyZG2KwJVXV4KAOnN5NjCCyWeTP+Ud0ZITN
         pE6MFRRf6HPHNAGmDLKh/JT3gm5Bi/4d3N+KLC/ChSptzig+a2yUe7WQn8hzzu+KkUSM
         JkJ6fdVOKnXn7dV07WRwH2ec7QWF5jouXuqqnUvEmpY+rbfm+Kf+mD9md/PoGFXfD6BE
         K/n8ukXWUAe7R+IA3uMA3HQyoBCZYyU6u9t8uq7UYz9Zbeaw9uwsADCmwN+TckTsGJRV
         4RVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sv8ShlWCFYrRvkMTcwOZXNbuS9oUEdPA5USpJjouThE=;
        b=aia1EvF4LwmKdauo01f5Vlf5U/BYaLk/G0HR4M6iuDpk+AlxLaJqz4Hos5ojGeHMDv
         yoILK6kKRG7+14+/34Cmp3h54SYrPv1V774jaWMHiA/OP2tzhunT+x09NPwQTHSbApHZ
         oSBSvwiRD4zuB71dN4tqAqWdxPkpjRBu/233oIkX33Q4OQ/VH5ZPpT/sgydc0ma3aSR6
         pHdHbW/hnDpyZGEqjIfxjtF+wMdYzm2gnsDWEEqwJCKu4e6Tbhz6mlV/UezPW7LJ/qWi
         opWOSkuVKcXAvbdbNtdXqboeDDegzCoH98TFPg6tHedYHEq6XppNS0u9UXkyyyu6UNAU
         8RcQ==
X-Gm-Message-State: AOAM531qe2M3XMJWlpMIh7cosTdVU7Ox0JIp1rb74rtgnObMnv2jvYP9
        nFFfS64XyRk9m8upC+8cDPRa+imKAjCXH9NdAXgKuBcPXVmBWA==
X-Google-Smtp-Source: ABdhPJwn2G/eQ/cTmZ4tw/XztL2pHSPpSZmCTo0b2P4Qui2SzWi6hDRqjufrC2EUtW2Zd42jmLZarDzkmZOZXrf+qWk=
X-Received: by 2002:a05:6830:1697:: with SMTP id k23mr115526otr.132.1618504072201;
 Thu, 15 Apr 2021 09:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <1618479020-38198-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1618479020-38198-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 15 Apr 2021 12:27:41 -0400
Message-ID: <CADnq5_OzUTQnTFjp2KFij3M8g3Fgq+dfMJyn8dkjzU+mR3yceA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon/si: Fix inconsistent indenting
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Apr 15, 2021 at 5:30 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Kernel test robot throws below warning ->
>
> smatch warnings:
> drivers/gpu/drm/radeon/si.c:4514 si_vm_packet3_cp_dma_check() warn:
> inconsistent indenting
>
> Fixed the inconsistent indenting.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/gpu/drm/radeon/si.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
> index 88731b79..d0e94b1 100644
> --- a/drivers/gpu/drm/radeon/si.c
> +++ b/drivers/gpu/drm/radeon/si.c
> @@ -4511,7 +4511,7 @@ static int si_vm_packet3_cp_dma_check(u32 *ib, u32 idx)
>                         } else {
>                                 for (i = 0; i < (command & 0x1fffff); i++) {
>                                         reg = start_reg + (4 * i);
> -                               if (!si_vm_reg_valid(reg)) {
> +                                       if (!si_vm_reg_valid(reg)) {
>                                                 DRM_ERROR("CP DMA Bad DST register\n");
>                                                 return -EINVAL;
>                                         }
> --
> 1.8.3.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
