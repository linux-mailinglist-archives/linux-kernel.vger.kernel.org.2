Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAFD3F50B9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 20:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhHWStu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 14:49:50 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:43541 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhHWStm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 14:49:42 -0400
Received: by mail-ot1-f46.google.com with SMTP id x10-20020a056830408a00b004f26cead745so38971638ott.10;
        Mon, 23 Aug 2021 11:48:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=swLmS8dln0Ehdh1sdZK176wtzs4bGul0tSVOf3axF3o=;
        b=NId2QF6CkIeCYj8DmwIGdwbX4lYXRt3ipMUJkkwIQf+xTKTzLVRuh0Qcz1YgaOq1vc
         wrbCx+7RLA00WTE4CjLlzIq9GhJg9DahIsn6NpBNqk0i6Vkq6nzxMub/eVJp78lYYrfZ
         1kcqBtcbj97bQbDSPx1DSLRFSZu2zah+mfgsfQdxfDdktUqinCMt0i94b6sUzJpifaCh
         T47eC+ogVP/TtOwSMXx64D1tvFe5v3b18mLq02CXc1jrIs9YS19d2kP34Ht0ukluOKCc
         F0m/2iWU2/b9WgsseUH4+9YasC6onM5OglL3Rv8wCgSxpWEveYyYGwnI/Wa2XmE5XYLO
         jVtA==
X-Gm-Message-State: AOAM530FW0k76MMK5lRdu0MpzJea5s7U2Rpuotz/2jFzzTZjmdpQ9qwz
        lLEbN2bMGdpIf3Uwdm5zkg==
X-Google-Smtp-Source: ABdhPJzbiYvIhLFVg000oCidSwerke7p+fuoWxweGqRFcnwU6auCpuzkdA0vBTnAKFu5MO7A5QMwoQ==
X-Received: by 2002:aca:bfc6:: with SMTP id p189mr12432055oif.167.1629744539483;
        Mon, 23 Aug 2021 11:48:59 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c37sm2566570otu.60.2021.08.23.11.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 11:48:58 -0700 (PDT)
Received: (nullmailer pid 2507541 invoked by uid 1000);
        Mon, 23 Aug 2021 18:48:58 -0000
Date:   Mon, 23 Aug 2021 13:48:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        frowand.list@gmail.com, robh+dt@kernel.org, kernel-team@android.com
Subject: Re: [PATCH] of: Don't allow __of_attached_node_sysfs() without
 CONFIG_SYSFS
Message-ID: <YSPtmp1eyQdSKITz@robh.at.kernel.org>
References: <20210820144722.169226-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820144722.169226-1-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2021 15:47:22 +0100, Marc Zyngier wrote:
> Trying to boot without SYSFS, but with OF_DYNAMIC quickly
> results in a crash:
> 
> [    0.088460] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000070
> [...]
> [    0.103927] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.14.0-rc3 #4179
> [    0.105810] Hardware name: linux,dummy-virt (DT)
> [    0.107147] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
> [    0.108876] pc : kernfs_find_and_get_ns+0x3c/0x7c
> [    0.110244] lr : kernfs_find_and_get_ns+0x3c/0x7c
> [...]
> [    0.134087] Call trace:
> [    0.134800]  kernfs_find_and_get_ns+0x3c/0x7c
> [    0.136054]  safe_name+0x4c/0xd0
> [    0.136994]  __of_attach_node_sysfs+0xf8/0x124
> [    0.138287]  of_core_init+0x90/0xfc
> [    0.139296]  driver_init+0x30/0x4c
> [    0.140283]  kernel_init_freeable+0x160/0x1b8
> [    0.141543]  kernel_init+0x30/0x140
> [    0.142561]  ret_from_fork+0x10/0x18
> 
> While not having sysfs isn't a very common option these days,
> it is still expected that such configuration would work.
> 
> Paper over it by bailing out from __of_attach_node_sysfs() if
> CONFIG_SYSFS isn't enabled.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/of/kobj.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
