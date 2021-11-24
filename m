Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864E445B8BF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 12:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241648AbhKXLFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 06:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236994AbhKXLFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 06:05:13 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F3DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 03:02:03 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id h16so1210058ila.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 03:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yqs7UO20QBiMFAJfpF/diqDYZue+bE75pRvgshNCsYc=;
        b=nFmZ9VjnsUdbjNsC1o0gZcZn9kKQQS3PuQ0Q4/H3QaCpBs7QooscML6xNoob4nKKAW
         YHAkfQlbf/rYXuJoASTTneX1gdLYm0VqtY8kNA71DChG9PjAD8B7DaKcS3rTRvmzpvkw
         t2SzmJSsKTb/4fBuZNyCk9z6U86lbOP2gnPZNBlrr+3/sBGLg1UGYAatJLqvI2lZCOrM
         xFsSGqjDr4j7yjJD0ydqxolGx2KBMgwZGCMNIZxP+JjNKDAI1SbLCvaWI8AZh1kub/L5
         AKAhhLde8a1VRpxxA/dHMCi8Yc4siA1B5DHbe+ekFiLWfz8riEZwxBclXsd06jBqCcDx
         +8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yqs7UO20QBiMFAJfpF/diqDYZue+bE75pRvgshNCsYc=;
        b=U2hoxbgBIQiku4ilPQ//2isKRmm9liCuWMAJzfbHubSRlDnUP2iXBX1aZdpj/vVISm
         YYBhLSqJBrW21FXl6Ok8AZyJ5tleppDnkHYI+vXXuiXiX9ekzC/HBxfhUXZ95LHgFGmy
         wp5QqhzNPAq7TmTNg6MFXLZAYpu/GmIWwAXP+zWUz0+OT3JZbgW82Nqif2IfdUHyUoQs
         dSnlfvOjGNd431p2gV5ZV+5bZltBamfGyeqsk+fHq2U4HXQWpElrGy9hEoGwM4VstBFo
         IzDlcLFPLc9z8MKeLnaz9wvLWLJl/Q05xvxjpZkysIvY3Y8ajnxL2NXb5It93FcGmX1A
         DKjA==
X-Gm-Message-State: AOAM530ArNXe0mpZm41ru3iUrmNWV3nppmcLV0veJlvxu9YLV9ejXTdz
        HtQNOPkRHtSCbyM+9wKeS/+1n6OesVSS+PG2qJQ87ZpR6uU=
X-Google-Smtp-Source: ABdhPJw7AyIldn6gXFqsCsYNeAzCljAimtMEwOA/yAPFJtSXKH9Kt6oKrklsGW3n6r5CcBgSemXRc4TX0BpFfF/cvF8=
X-Received: by 2002:a92:c26f:: with SMTP id h15mr11927761ild.72.1637751722963;
 Wed, 24 Nov 2021 03:02:02 -0800 (PST)
MIME-Version: 1.0
References: <CANiq72kgm-5CidoN8VRLnWokiDSWsQcMFbaUd4WKOnbPsON9RQ@mail.gmail.com>
 <20211109220732.7973-1-sampaio.ime@gmail.com> <20211109220732.7973-3-sampaio.ime@gmail.com>
In-Reply-To: <20211109220732.7973-3-sampaio.ime@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 24 Nov 2021 12:01:51 +0100
Message-ID: <CANiq72=sKCpVuAOeXGT80xkCUL-Ve-my_=Fefzp0HmmLER2D4w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] auxdisplay: charlcd: checking for pointer
 reference before dereferencing
To:     Luiz Sampaio <sampaio.ime@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 9, 2021 at 11:07 PM Luiz Sampaio <sampaio.ime@gmail.com> wrote:
>
> Check if the pointer lcd->ops->init_display exists before dereferencing it.
> If a driver called charlcd_init() without defining the ops, this would
> return segmentation fault, as happened to me when implementing a charlcd
> driver.  Checking the pointer before dereferencing protects from
> segmentation fault.
>
> Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>

Queued up, thanks!

Cheers,
Miguel
