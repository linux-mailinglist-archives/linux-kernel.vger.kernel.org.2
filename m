Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E20F3A47DA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 19:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhFKR01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 13:26:27 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:37871 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhFKR00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 13:26:26 -0400
Received: by mail-ej1-f47.google.com with SMTP id ce15so5652583ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 10:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pzkhQR4zj2j9hClx4qSj3DSk3XkJw57raw7U4YCqfCM=;
        b=U2frkNF0K/FlqX1WkHWwlRnqAMcYLf8zEeUtVCqb3KE1JE1NzKF0vFh3ERUIwk2n++
         Oo0k3X9VcxVDVZ7OJyQb8XGjZVXyoFz/ciRqqIHnPqNFyF4uryTELkx2kRkFG+PDzpOH
         ugWGsGFPNO5q16y7J/G8/SQTgC3+GKDSUp4YaYMBoWexhJYxCDZkh0ovHJhSafllWgRO
         GQ4chkWYor0fRoI2e9sWbMcXD/QS7tFP0Jt3dY55AapfEO9ZnjUkP2Kl7YgYq0Aivs3a
         Z8KpqeqRaKrnUkm6v1vjRyVKAQfdmA4+ozRaq5k4KMRhG+kVkz1Q1mtYeZ98sqoOGJSI
         V2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pzkhQR4zj2j9hClx4qSj3DSk3XkJw57raw7U4YCqfCM=;
        b=if8jnrnwk+CozF2l4Ov6LAk19+MblMiUVs7R0jn4aqkpGmas4Bc0GtoK7CT2lMU/v4
         InkKVDcv8hJxR0yUGZYhRBQbbO5SnDqdiK3pc4lsVhgVFY9JqwbyyBh8mPMKTA4XP50a
         iJiDpLGLjzZOeVpv7ReaCs4Dp3x8OD7woR2+XyMoKpHOHRc6TmV8F+7MZXmLB1x3kU9m
         B5727kWOgDD3/PQVUSdSHnVDt1qqvQ+B+OaTryQhQcUHKee8WPdsqcLn/QC22PvRY1Bn
         a1dJuErKhfs7a9F2rLmcNuN1ZP5HkKIpSmNZpQvkBZSJAQe/sk46M1HGva0XQP6f6Ehm
         XRVQ==
X-Gm-Message-State: AOAM530P2VAwC+s0ylis3HT9tMtxWI0lVo7oXMAS7Zbk3DHl2PPoIhO3
        FJ2cfTGEcwzioHKFHGd7Lylbx3C4IGIivTKQaZUNy3zUPg==
X-Google-Smtp-Source: ABdhPJzai4y37jLuVr7Y1UpUR8ztAxvH8hM/u6AmWg96iF9OzzxgsicmwMxu6GLIo5jiIh6IsoiyoahG/pIqtUX7Deo=
X-Received: by 2002:a17:906:1113:: with SMTP id h19mr4568382eja.398.1623432194550;
 Fri, 11 Jun 2021 10:23:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210611022835.GA1031@raspberrypi>
In-Reply-To: <20210611022835.GA1031@raspberrypi>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 11 Jun 2021 13:23:03 -0400
Message-ID: <CAHC9VhQvq0uimX+S+M-NJfz=W-1-G1QY96d79od=1X6UYYKUKA@mail.gmail.com>
Subject: Re: [PATCH] audit: remove unnecessary 'ret' initialization
To:     Austin Kim <austindh.kim@gmail.com>
Cc:     James Morris <jmorris@namei.org>, Serge Hallyn <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, austin.kim@lge.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 10:30 PM Austin Kim <austindh.kim@gmail.com> wrote:
>
> From: Austin Kim <austin.kim@lge.com>
>
> The variable 'ret' is set to 0 when declared.
> The 'ret' is unused until it is set to 0 again.
>
> So it had better remove unnecessary initialization.
>
> Signed-off-by: Austin Kim <austin.kim@lge.com>
> ---
>  security/lsm_audit.c | 1 -
>  1 file changed, 1 deletion(-)

Merged into audit/next, thanks.

-- 
paul moore
www.paul-moore.com
