Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6C73FBF3F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 01:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239045AbhH3XD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 19:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238933AbhH3XDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 19:03:21 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD45C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 16:02:27 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so20450640otg.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 16:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=eWM4/3yTwD02gfJC9rFF7KdMYiNQBXaOsLgx6akWtD8=;
        b=PM1pNMQtWGrH46anjSbXZmaMSIzKWW6VD0gew5jdrK3kFfDUleakCbx5IVbIJtpEYa
         Oh2WMagW6w4u+oKA422fnZP3Su+eKmPeqyu/nEjhX0qewMS2UGVT87y/fgLyFFBp6t0D
         cTjAAYsEkR5GZ2oMR36LIt3oLM45RquoPiOqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=eWM4/3yTwD02gfJC9rFF7KdMYiNQBXaOsLgx6akWtD8=;
        b=OVhRp+CYG7/VmOo/B4CQBJcXVTg2Ksw3/BgPCPdE8OcEBmKwFepibUElLOtMOdCbnj
         nn+TukDpJigY4Smb7uPsgyvqtfZvesPjQBMud+Iez48KqbL5fxlpkcCdU+25fMM8R07f
         YGFj1HC/O5gBJfZ+GHfuEGijnGrL4VkHkD6IB/crWiJDm12y8nm6oWejvIooLFWqVS+x
         W9dZ8seE1djpg98dJJREN9u3iD80iSN0WrE7rVkZEHcwLg4U+d7VQLyDouJ6XQXM+9di
         HsBg0cffPChcm/CCiNXn4aHHIiYryuAPN9wXCjfSeqYC7a72ryKroCIzz20GLEWsrwGZ
         ZTuw==
X-Gm-Message-State: AOAM530Rq2vfKJ7frb2AO2KpuCNn0rqLvJkte3q99v5gApSNAMWk7wUG
        0MO9L4EX4SYz/V9scTaLIcSWXmCMuM6PWxaTmfXPpg==
X-Google-Smtp-Source: ABdhPJyyuZmtDRvRnkmfPxPxg0ZfrKKxpTrd0LDO62OHgk8HUhCwm2cmZKKyWMG7q9pTFPFaQCbn6/Fld+sjB6K1R4o=
X-Received: by 2002:a9d:123:: with SMTP id 32mr22341511otu.124.1630364546432;
 Mon, 30 Aug 2021 16:02:26 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 30 Aug 2021 16:02:26 -0700
MIME-Version: 1.0
In-Reply-To: <1630323451-7160-3-git-send-email-deesin@codeaurora.org>
References: <1630323451-7160-1-git-send-email-deesin@codeaurora.org> <1630323451-7160-3-git-send-email-deesin@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 30 Aug 2021 16:02:26 -0700
Message-ID: <CAE-0n500=1tF2V8nTTfPH3P-wCm8xs-J+9pLK=xfeOc1p=PB5A@mail.gmail.com>
Subject: Re: [PATCH V7 2/2] soc: qcom: aoss: Add debugfs entry
To:     Deepak Kumar Singh <deesin@codeaurora.org>,
        bjorn.andersson@linaro.org, clew@codeaurora.org,
        sibis@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, Andy Gross <agross@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Deepak Kumar Singh (2021-08-30 04:37:31)
> Some user space clients may require to change power states of various
> parts of hardware. Add a debugfs node for qmp so messages can be sent
> to aoss from user space.
>
> Signed-off-by: Chris Lew <clew@codeaurora.org>
> Signed-off-by: Deepak Kumar Singh <deesin@codeaurora.org>
> ---

NAK. We don't want userspace to treat debugfs as an ABI. See
https://lore.kernel.org/r/CAE-0n52YXvTzvK4B3Aggg1fcRyjy=+HzNADP315-J0iJ8bMWUQ@mail.gmail.com
