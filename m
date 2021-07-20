Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32A83CF228
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 04:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345479AbhGTCBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 22:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345004AbhGTCB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 22:01:26 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD45C061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 19:41:59 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id oz7so28217535ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 19:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n1YXgHc+ezOqvxdobU2Or1lpisrGL5UT86WTPLP2AnM=;
        b=xLab9Dl/Rl/vnupJKYQlDWwU1QSKDMw0BSJMXz6DETJqby5Ed/xOiuexAJFRzrgPIn
         H57Lcr/S/Ft/RtcxOjZddo7YgBtJJPuCNMJ1pjkHXYPZ1xwNv/9h3rWBg8k9hkJSKL14
         YnfG78Ws0vm2cw9LEo9b58L19K59ukKkyxfnZLe+h7lytOoKAe9Rf4vK9kCCQqS5VosY
         zj45aLeDOkWI4Yhlmy6fboqPXe+hc+LeXg987KwKjLX+g3Ke23d6cKeGsPGirRe2rDeo
         6uxmAFjTZrq3SkCBBcdg6126XLE5RTiHh9Cx2/WRPWrYDY1oeWKT7pXrpi3+YTVlqu6B
         UM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n1YXgHc+ezOqvxdobU2Or1lpisrGL5UT86WTPLP2AnM=;
        b=q8E1mRMusQ4uN50KeNDctlXmUFb34JIuP5sz5K6Ng+D1KJ8d/Wr0N+mD3ZuUeExoPD
         +tnXzWTNJ7ggtxbHvhUn2FD1rofpPVScUUhyhX7y7+fz1whtzgsC3q3SHa16V02rOm43
         HwUjJ9mhYNESFooFSEb25Pa9TP/KN+TzdZZt6SLcj2QFestmsEa7yyEKqf/ob0S27oq5
         PeFDrNkuvqtpJJQ3VRlp2sJW9ccCnJkAhCgM81nE+e7tz5PWMpSCGj317GWIge8WmF2I
         JZ3jN3T0vn6rYWyLGabOO1lRlViTfpD0u5SS7gIbhURTzU4NJVxMT/Dfe6ouvWYNz3tr
         R9xg==
X-Gm-Message-State: AOAM533nseWrihKH3DYLO9T70BOK3drGKtFy7bBomu9mAQwu+0tRW4r0
        i52vApINSJfp6vNbRcaz0/Adm1CTmeC19Oiamljh
X-Google-Smtp-Source: ABdhPJzMuizC+4cmRt9Mot9YDT/kG6cfPoSmsHHec1OOuKN3wDOX2oTNmuG5BSJLJ53pji/FmiRnojtr2JtnNYCKQz4=
X-Received: by 2002:a17:906:33d9:: with SMTP id w25mr30016598eja.91.1626748918016;
 Mon, 19 Jul 2021 19:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <ME2PR01MB5458F90334AA98CF1AF969A7C2169@ME2PR01MB5458.ausprd01.prod.outlook.com>
In-Reply-To: <ME2PR01MB5458F90334AA98CF1AF969A7C2169@ME2PR01MB5458.ausprd01.prod.outlook.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 19 Jul 2021 22:41:47 -0400
Message-ID: <CAHC9VhRFOo0SbVDSZckM6mOHwip4_QZ7h9zjh_t4As_KkLth6w@mail.gmail.com>
Subject: Re: [PATCH] Audit: fix coding style
To:     mayuming77@hotmail.com
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 8:30 AM <mayuming77@hotmail.com> wrote:
> From: MaYuming <mayuming77@hotmail.com>
>
>         avoid include file to multi include.
>
> Signed-off-by: MaYuming <mayuming77@hotmail.com>
> ---
>  kernel/audit.h | 5 +++++
>  1 file changed, 5 insertions(+)

Merged into audit/next, thanks.

-- 
paul moore
www.paul-moore.com
