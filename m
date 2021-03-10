Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7877C334070
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 15:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhCJOjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 09:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbhCJOi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 09:38:58 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36831C061762
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 06:38:58 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id bm21so39154877ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 06:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=HYCLqA53maJHtDOIOMcEaDFTMvtnWMHgzuENqB5jKYA=;
        b=JTz0aBiiLSYkrsl7DN1AZneyeKq9xVkbcgwZtvM3VbKD4XqxfSMdPkd4SWwtfO3/yi
         HspGT2SZWW/sPR/69+qBUBD7Gz4hLIfj+oDdtWRyWQJiL0TtJL3vJCjGl7JzLDW9Oz6V
         RNp+RKVpALu35ZMoMQRH/AWoa0FPIc6ZDPlfhN2tQIuC/6UI7AEGm37uzhbe4rSbPkrs
         OCWVP81bP7+KpHDwNE40ZuOi0DFSWAOq5E3wTr4jEE09+kxEXaJHK+kcYji00AT7A9I5
         /tzZ7dyfiDlQ1VRS4cf6DnvzJf3eVVw27XgGwC3451U/rr0CJmHIMn5JxKnP0UA0bvkq
         jq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=HYCLqA53maJHtDOIOMcEaDFTMvtnWMHgzuENqB5jKYA=;
        b=h5yXeXIw7cIY0BdGnbB9DXrWWHScMHoMHyUPjIrljvaCyLNhDY/wLrOZsoQdtGUG8N
         /BC5yVHlvR77DpcG1CENjHxjnv7WCXLMFmTfiQht00xINey86k4Nuo3f9muFBrVjNMYe
         4qEnbULL0f/0hvvCTxgw8C1OC4frmVP7+0CQIZqaKrlZ3ZySAaYFBlIlMEco7n6czz+5
         zyZMM+pRPsy9Hsa3AiUvC6lMcN9bAnEWl7iF6rTXMm67PftKc8zbPuL95CYjWFTaJhuk
         Wc6uJxc3CpDzYJiVC72q5+TEAh61pa26rrVtXryLAcWpKC93ZFKf8554VgKJFSiinlet
         j+4w==
X-Gm-Message-State: AOAM533YXMaZnkQFasJ1MZQH4jkXFlamQy6ejXisiNTiZcjSwfPc1jDq
        8HrIshV3h4yFQMbR5BTChy0Nqw==
X-Google-Smtp-Source: ABdhPJz4FawO4HAsVbK1Cq6FgQZsFGM1z6rkhokx6OSKmnf2PIOORjxcApuvCoIMEsmZAxUJR/ggfQ==
X-Received: by 2002:a17:906:3882:: with SMTP id q2mr3913521ejd.540.1615387136918;
        Wed, 10 Mar 2021 06:38:56 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id s20sm6615548edu.93.2021.03.10.06.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 06:38:56 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 659671FF7E;
        Wed, 10 Mar 2021 14:38:55 +0000 (GMT)
References: <20210303135500.24673-1-alex.bennee@linaro.org>
 <20210309132725.638205-1-avri.altman@wdc.com>
User-agent: mu4e 1.5.8; emacs 28.0.50
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Avri Altman <avri.altman@wdc.com>
Cc:     Matti.Moell@opensynergy.com, arnd@linaro.org, bing.zhu@intel.com,
        hmo@opensynergy.com, ilias.apalodimas@linaro.org,
        joakim.bech@linaro.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-nvme@vger.kernel.org,
        linux-scsi@vger.kernel.org, maxim.uvarov@linaro.org,
        ruchika.gupta@linaro.org, tomas.winkler@intel.com,
        yang.huang@intel.com
Subject: Re: [RFC PATCH  0/5] RPMB internal and user-space API + WIP
 virtio-rpmb frontend
Date:   Wed, 10 Mar 2021 14:29:15 +0000
In-reply-to: <20210309132725.638205-1-avri.altman@wdc.com>
Message-ID: <87y2ev6pkw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Avri Altman <avri.altman@wdc.com> writes:

> The mmc driver has some hooks to support rpmb access, but access is
> mainly facilitated from user space, e.g. mmc-utils.
>
> The ufs driver has no concept of rpmb access - it is facilitated via
> user space, e.g. ufs-utils and similar.
>
> Both for ufs and mmc, rpmb access is defined in their applicable jedec
> specs. This is the case for few years now - AFAIK No new rpmb-related
> stuff is expected to be introduced in the near future.
>
> What problems, as far as mmc and ufs, are you trying to solve by this
> new subsystem?

Well in my case the addition of virtio-rpmb. As yet another RPMB device
which only supports RPMB transactions and isn't part of a wider block
device. The API dissonance comes into play when looking to implement it
as part of wider block device stacks and then having to do things like
fake 0 length eMMC devices with just an RPMB partition to use existing
tools.

I guess that was the original attraction of having a common kernel
subsystem to interact with RPMB functionality regardless of the
underlying HW. However from the other comments it seems the preference
is just to leave it to user-space and domain specific tools for each
device type.

>
> Thanks,
> Avri


--=20
Alex Benn=C3=A9e
