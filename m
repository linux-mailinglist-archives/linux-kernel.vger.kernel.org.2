Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF9D3522CD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 00:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbhDAWeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 18:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbhDAWeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 18:34:07 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC6EC0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 15:34:07 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id e14so5082473ejz.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 15:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JwcjbJLuM+EQBpQBaYXeeiUQ+PAdC8SwyIK2hsMA+cM=;
        b=ArrtknezTEhO1CbNH/4AuLxj39IAsAhS8HfkNL1rCTftdshfkOd8L47P6zhArH91AQ
         qdz+isC5+X4wzKL+rSuJltVSyDLDd/XnzkyZwmvUTKbgLrfW4LpgQkDVNX0TM3LyQgZZ
         UsJyvEyzk91eLiQhU1OE7VrOP+tZDW59yW6n2YuDi7XFvh+d56Sp9qvwiKMOiKU9oISr
         WURK5c7OhcFHEmZOOL94RieBve3I/RGgYcBJWnwWJdWeiAwBHGOlbE7kh5I9Ecgj/1zq
         cGbWbeMO5fGht+6/ZoRaX93QkqyM2EkyfinvlnnciVnDq3Wsq0ko3kmPzEb2lvT+MmNc
         mUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JwcjbJLuM+EQBpQBaYXeeiUQ+PAdC8SwyIK2hsMA+cM=;
        b=Zp9Ij7bF3F8bkw/iReGlG1CMxpuMw5AzUzUvs2MRDovhQnfDtAnErpE3V1uZBL1XS9
         /rZSfEpGzLHAmxSwMEv9mjKprL4HRDBHmvHTvotyxUespvsDKQyM4Np7Vj3FDbBqoF/U
         ZuqkXdpCF7BsEcBydXpla7PbbWCnDojh/YVCVY8bh9m9kfgfFckcK5EfGVrOBSCUGaQz
         /4UyhYRjT9iNr6EstPBckCM4pp/5gaM30l3pV6JLmADRbKMo2yjp5XJtJP3QVhUbqKSF
         6idzermws7o/L4FgMoPsTk/r5rSme2gXKPtNwyjk3IBN30Ab8l6PJ4czg4EOW3tgjM2q
         xCqg==
X-Gm-Message-State: AOAM533XwxerxyUK8UcqBo0qq4dEVtODpTrz79CHC1x0T4VRfDtAQHEk
        /5jEwKxWGXCub05nU6qboem2JnpL3IZNbgCjBAR4
X-Google-Smtp-Source: ABdhPJxYWvOvGnocVpSGrtJOWnm5EYFUlzKhq4aZsQnf53wQs7vQnFDt9HwxI+R7ZOEiFenWayr3lkhLV1BUE3aVwas=
X-Received: by 2002:a17:906:3d62:: with SMTP id r2mr11255187ejf.488.1617316446452;
 Thu, 01 Apr 2021 15:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <ea7f2e3b49b1cae523b58f128c8419c9b8565d9d.1617303032.git.rgb@redhat.com>
In-Reply-To: <ea7f2e3b49b1cae523b58f128c8419c9b8565d9d.1617303032.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 1 Apr 2021 18:33:55 -0400
Message-ID: <CAHC9VhQRYEaHWQLZjj8kqfZ-WHuTnRC1bXMybvzSYVpz2VU-wg@mail.gmail.com>
Subject: Re: [PATCH] audit: drop /proc/PID/loginuid documentation Format field
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 1, 2021 at 3:11 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Drop the "Format:" field from the /proc/PID/loginuid documentation and
> integrate the information into the Description field since it is not
> recognized by the "./scripts/get_abi.pl validate" command which causes a
> warning.  Documentation/ABI/README describes the valid fields.
>
> Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  .../ABI/stable/procfs-audit_loginuid          | 22 +++++++++----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Merged into audit/next, thanks.

-- 
paul moore
www.paul-moore.com
