Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13F13A3917
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 03:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhFKBDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 21:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhFKBDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 21:03:20 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C618C061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 18:01:09 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id g20so1993947ejt.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 18:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yq2QYhJB6hm03YYKhLG5zisJwTxSTIgBD+SOci+75gw=;
        b=XcaUm4oXdmCyJQ0NCKOjk+gpaK7K8hMKw1YsbfspadmxLJOxuvm8auwGOrtnxY5Gw4
         StRX+EdgdjqP5fGUkvIYIA1JluE8wywjs5zexf7/gT8oyUYR85NAkBpx9/PUncGh/uPn
         POQbzgZMEBSx1xh2wJ9OAMFb0nZ8j2dB6CxaXSksiByKxYhcIU65iR20JHzsl1wSgY45
         ujElFYk9FgN3EflZRCwCqdfsqchwD75p81M6LT/WjSTAYvzxQZq3VBhTQvzkEzbiW+kK
         xDtJpejPwPcs3FZwJekIKfVYkuiVkGfYUnIZAr7S2fQB94EElni33RndQcGQaxvAhkxL
         7Pww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yq2QYhJB6hm03YYKhLG5zisJwTxSTIgBD+SOci+75gw=;
        b=tdP4x11YoaJPKF9+wp+sxgyRrkROaOsPUPAjkTrHiIBaw8FEGZT9yiBz52B3q7P/Z+
         wFCIpjXBEwTGB6p1Z8JrJB0n1npsZwZH3e2sCaCd9NlSFp8oVSZz8NcPVU64x59cmMcz
         ZVcMRGJyNqGlr+/eCl9SCgJkU0ZNGKGGBbjVCnzRzkHWn7Qo4vI5clRjH/9wvWiSdlRe
         jQYjTNQQDegjj3xThyH4MoUB83npK1EqTuyeP/uccLjZFHcK5XiYI5aSNFpnRIBfJ+Bl
         XLBXeLdcAhkf1E0SSHgtSVhH41Qwf+uS+6DXWPXGXVhlAPD1dkcmQ8Pa45+cR1nZlz4k
         KTMA==
X-Gm-Message-State: AOAM530ecK797eNzNStAJ0kSWjygPd1PEdWK8JZxIkJIiRNCIJgh6It3
        S1OtYakTVFEy8FkeWXK6MtJz6MKlJ3NhVrjAMX87
X-Google-Smtp-Source: ABdhPJwua3KX651p54f7ICbzNSUiTJF180YdKbL/H2ldeYiSZ590yYnziu0L1wLG6QFLeKprc9tpuUmeuIc3FLAE+6o=
X-Received: by 2002:a17:907:3d8e:: with SMTP id he14mr1094680ejc.178.1623373267854;
 Thu, 10 Jun 2021 18:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210609022701.13768-1-thunder.leizhen@huawei.com> <20210609022701.13768-2-thunder.leizhen@huawei.com>
In-Reply-To: <20210609022701.13768-2-thunder.leizhen@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 10 Jun 2021 21:00:57 -0400
Message-ID: <CAHC9VhSsJnSanER8XCXkatcyn5_KLkrFDvTRtctL=yvCiMcWCw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] audit: remove trailing spaces and tabs
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        Eric Paris <eparis@redhat.com>,
        linux-audit <linux-audit@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 8, 2021 at 10:27 PM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> Run the following command to find and remove the trailing spaces and tabs:
>
> sed -r -i 's/[ \t]+$//' <audit_files>
>
> The files to be checked are as follows:
> kernel/audit*
> include/linux/audit.h
> include/uapi/linux/audit.h
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  include/uapi/linux/audit.h | 4 ++--
>  kernel/audit.h             | 2 +-
>  kernel/auditsc.c           | 8 ++++----
>  3 files changed, 7 insertions(+), 7 deletions(-)

Merged into audit/next.

-- 
paul moore
www.paul-moore.com
