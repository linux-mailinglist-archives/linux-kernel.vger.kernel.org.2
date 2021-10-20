Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9FA4434869
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 11:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhJTJ70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 05:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhJTJ7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 05:59:24 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7740FC061746
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 02:57:10 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id s17so23752387ioa.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 02:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=pcKdTOkR/GZDEmuSn4ASMp6zAcofYzOxflxOqSu54Oc=;
        b=pm0fpYdpR7I6voVoXZMrSCsBruZhzXQPDxSgnDDvr6g3sIvG15ViHq8N4sJkzJfFwa
         w1s7RkdC7ZgPwNXpB5cCcQfKJVARxHJ7RAdCIrHPmC59oTjziufu2FBqLa4ztYP55UwJ
         g2vrmj+f74oqjFmbjr66CIC24oTSyIjGuZn6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=pcKdTOkR/GZDEmuSn4ASMp6zAcofYzOxflxOqSu54Oc=;
        b=EWjUyGvVCbddLXlLPVjCUZwvGo3uvP/9zGLLrG0SKy4N8wwq+848ODCaeKnfc8Uxgo
         Cy4XDHhQl21fnM5Rt6KDb4tIzwUzx0M/ySG47T9oA5EO+WjIXUH/L5LvVYXZg/qmn2I3
         o72RvK/83JT/bvZbXVbJF+a6sDgEf5nkkyzl3SHrNtUfNow+rpDGEI39QAodF33/ozCF
         630rOOXKb7JwrY0as+AxjZRmuuWvdIePljj5fCRDEFEAIEBTP85sYluMWdk4FW7Bb76G
         bMxCuyhN+Y+4ctFO3dyzar3ZMSwMB9DJzpKGSTI2/8OdbgdwFaNi664CbpjKip6iTp9u
         rwfg==
X-Gm-Message-State: AOAM532mbGBiI6XHKsSnNDv02uHmWgsuSo+52jk5kXSEFbh5Q5AHV7gY
        tiN0Z/1xbzXnx5nteb9eF5PEl2pbpK5muA==
X-Google-Smtp-Source: ABdhPJz0OQoa2Mri5JaANHov+KjukRphqSKzpaYKbVIY4O085lIYROKMUupE5TPXEOPN0HXvgB/M8g==
X-Received: by 2002:a02:c65a:: with SMTP id k26mr8060036jan.29.1634723829551;
        Wed, 20 Oct 2021 02:57:09 -0700 (PDT)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id z16sm838652iow.42.2021.10.20.02.57.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Oct 2021 02:57:09 -0700 (PDT)
Date:   Wed, 20 Oct 2021 09:57:07 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Retrieving the network namespace of a socket
Message-ID: <20211020095707.GA16295@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on a problem where I need to determine which network namespace a 
given socket is in. I can currently bruteforce this by using INET_DIAG, and 
enumerating namespaces and working backwards. 

I was wondering if anyone had any suggestions on where to add this capability, 
or suggestions how on how it might look? It appears like using network namespace 
IDs is the thing to do -- I'm unsure of whether this API fits better into 
ioctl_ns, getsockopt, netlink, or even somewhere in proc. I'm curious what 
people think. I think that the "easiest" way would be to drop it into fdinfo
in proc.

Alternatively, I may have overlooked an existing API.

-Thanks,
Sargun
