Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD64B37AA32
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 17:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhEKPGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 11:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbhEKPGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 11:06:40 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EDAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 08:05:34 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id o27so19001811qkj.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 08:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=2VkU2pav6JkXqqyi0h0CH3cUzsm505fqgLQnBk2s1z4=;
        b=HvZnoP3hV22y7nfx5wx6TQzfYeSr42FyyNldThjj0nBHRMn//lK/3idYAzRok8ygNp
         06v2EtqF7OKGwsQpcfFXmVQEm5sIWXHQrq09FMJ8ykdClaEmjU3aEi4fhyxIovp8f+VN
         c1irgsFknLxdx8znN2B4wcJy89dL1Hh1OnMliOH6msOeXxCAF8a1yJ38LSCogR5oYjYl
         YKzFpw9rtPk+ij8s4ne3llEemwb2rUkTJDlFAWZGMz/5lkjWBE39jJHFCGQ7UQyZgh5o
         0PlHV8foiTG86dcpGgELlf4Y1B2S4XE5Qd7+RRbYUYUfeeNK72vG8hQ861GE0cxF24VW
         XQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=2VkU2pav6JkXqqyi0h0CH3cUzsm505fqgLQnBk2s1z4=;
        b=iq2YfgJfq5XuLCryL/T3G2doplm0fDV9yqA4JOasgZ6sSr48Sep4GgkTtWdbg4KDjC
         /Dvs0kx/3ckRm41U2T/e0/FmS4qqgdfc28L2CSkckgcUALYaJ8oVH5U7TkvM8jeiUWFV
         e5ITJwsNjP+aIXAPf7VkphoS+FFhn8XnVQlHsdJvfHUJBUxIzZZnoVq1MP3GLyrriaGD
         RlPtzFysB4MBrS/SVowZZxxT55BY/BCSV4SVoo2MC+GtFLM17m6tyx0ZMFlf92mj/G8X
         Dahe91sslY2urMJUZ6a5HQo7x66K/k3ejy4e2IZXtYvoS4EPZzOlty09+nlYfONBQ+je
         JLRQ==
X-Gm-Message-State: AOAM533/MN1+ItT3YYR0tmYJxT5JL89bloF35GtDt0/RvuB3UvfOyjID
        g4RBYcMy7LL+7ierveJbDZntrA==
X-Google-Smtp-Source: ABdhPJzDiBJ3KQj/oylwSjmQSq5h1e6EHdjJa2S75g4UmHfwQxeMyf4fxvIPCqPGST4EHhFfIyyUIQ==
X-Received: by 2002:a37:2705:: with SMTP id n5mr14556556qkn.33.1620745532343;
        Tue, 11 May 2021 08:05:32 -0700 (PDT)
Received: from xanadu.home (modemcable108.170-21-96.mc.videotron.ca. [96.21.170.108])
        by smtp.gmail.com with ESMTPSA id m67sm9334721qkd.108.2021.05.11.08.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 08:05:31 -0700 (PDT)
Date:   Tue, 11 May 2021 11:05:30 -0400 (EDT)
From:   Nicolas Pitre <npitre@baylibre.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Dien Pham <dien.pham.ry@renesas.com>,
        Gaku Inami <gaku.inami.xh@renesas.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: add clock management to the SCMI
 power domain
In-Reply-To: <20210511145349.b3gzogrdhl74oq5o@bogus>
Message-ID: <nnn42849-17s8-25s1-44s2-37o95p872n14@onlyvoer.pbz>
References: <5q88n947-pon-4940-3or6-s54o4r361o5s@onlyvoer.pbz> <20210511145349.b3gzogrdhl74oq5o@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2021, Sudeep Holla wrote:

> Hi Nico,
> 
> On Fri, May 07, 2021 at 04:20:36PM -0400, Nicolas Pitre wrote:
> > Clocks requiring non-atomic contexts are supported by the generic clock
> > PM layer since commit 0bfa0820c274 ("PM: clk: make PM clock layer
> > compatible with clocks that must sleep"). That means we can have
> > SCMI-based clocks be managed by the SCMI power domain now.
> >
> 
> Looks good to me, I will apply this soon for v5.14.
> I will reply with details once it is applied.

Excellent!
Thanks.


Nicolas
