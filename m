Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25AA3F60E3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 16:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237891AbhHXOr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 10:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237755AbhHXOr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:47:28 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AA2C061764
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:46:43 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a25so18205098ejv.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jIny/2XICcZOy9+/It3NCvu/RbXYv1VpP1UfIOelqj8=;
        b=eORvwxytiEn3npkHgQ7aJgxdcXk4YBzH3LVD52Yk372cD9MczuNNJUEEu22Ye69KGM
         hBgwAz4e7R1fvDmOGHc2FgPvNz5VcSrWh/OlYYfaCG+TaknZ0LlSB9rUPRISlhkgVy2O
         +Wl3H32GHR5g5KobNlJJIW9q0x3otVYUbO0PuRyVy4d5ujRHE0mobZ6yJp1UL/NfZMUn
         K6GiKDTKbgCM/tqna24eOtDMIqubsdRbSunfKpVsAY6PoIzMpEjwSeyIfx5xs+hXptgf
         KCU5ugL/jLEpjnj/k5LNuUDGZLF0nj6OksHEwhMi7HfhUqKdO5roB2uhy/sf5jV7CAl3
         c3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jIny/2XICcZOy9+/It3NCvu/RbXYv1VpP1UfIOelqj8=;
        b=VVXDnYdZqAcrYAJ/V08ABlVMa0YENGxJZ+eIwCgwcjvfiOeAvQjEMjQ0bOTyrekyCW
         +TZXQUDf3jx1cRDyJ5eW2PJH9CNYbode/koVq0KFvBjMIsZBo+UXRnzn016TUoTWlb2u
         ZfTxerz8nc5iJtHhvDWVg2pkQIsFV1kUIgbzqijfjawBdDM8zfkJBLFHcMd67Mboc28B
         nOLwH9TZ+vHl3T2dWnqy4LMHW8WZZcXANDiw3WoaNzH6EbEZStBZZxo5M7vzRWyWEMe4
         eRgmNfK3gSDievfvvZpbk2DKu9cEbmEtHhGnqZSDwtAvAK6cc/YMkbaKFqBTqf40HH1w
         MGNw==
X-Gm-Message-State: AOAM532r39FqWJEDrokn3JG/mCdknhRPsQPlkt3kjJ3hp5ZYYexqdtFU
        PlLqj21tg3BOws4MFzO3W0YMHPyDGgGSDBrsYUXV
X-Google-Smtp-Source: ABdhPJxHY1BXJtysnDWWYVN5F+p1XnYFcZCzBbZCk3J14JGdG7JGGOiKkYOVFxCU1B21Tnz+buLko3irsMOZW7fwelk=
X-Received: by 2002:a17:906:2cd6:: with SMTP id r22mr8733409ejr.398.1629816402264;
 Tue, 24 Aug 2021 07:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210824022247.GA22908@raspberrypi>
In-Reply-To: <20210824022247.GA22908@raspberrypi>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 24 Aug 2021 10:46:31 -0400
Message-ID: <CAHC9VhTgeSbRDrK-HHaZLxyR7ezFrW-0TbGRfutF1NwXVHnXWg@mail.gmail.com>
Subject: Re: [PATCH] selinux: remove duplicated initialization of 'i' for clean-up
To:     Austin Kim <austindh.kim@gmail.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        austin.kim@lge.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 10:22 PM Austin Kim <austindh.kim@gmail.com> wrote:
>
> From: Austin Kim <austin.kim@lge.com>
>
> The local variable 'i' is used to be incremented inside while loop
> within sidtab_convert_tree(). Before while loop, 'i' is set to 0
> inside if/else statement.
>
> Since there is no 'goto' statement within sidtab_convert_tree(),
> it had better initialize 'i' as 0 once before if/else statement.
>
> Signed-off-by: Austin Kim <austin.kim@lge.com>
> ---
>  security/selinux/ss/sidtab.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Let's leave the existing code as-is for now.

-- 
paul moore
www.paul-moore.com
