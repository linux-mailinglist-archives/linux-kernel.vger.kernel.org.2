Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04AB0387B3E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 16:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbhEROhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 10:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbhEROhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 10:37:00 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E20C061756
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 07:35:42 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id cu11-20020a17090afa8bb029015d5d5d2175so1647554pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 07:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8T6TCtXF+SK0PS+gwIPLfEM0HYo27wFg/cd2j5g3ixY=;
        b=ItCs2tgepznBKkOSEZhOls5C3FFwvm4PPun/t5iCs7FG9IQ7R5OlfHEtI3UBB9owRP
         B8v6WsehnUxWW90IkxYHAaZXBmS1qkG/V93jtmnJ3tGyvxZZlxAJqXqk0EwuA7unc/QT
         zm2SaBl3sOsdax34jVdeLxlZdhmCQf6kU8pxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8T6TCtXF+SK0PS+gwIPLfEM0HYo27wFg/cd2j5g3ixY=;
        b=Nhd2oHivqS6Kg4vjrKLN+bs5eRx8KdLTacZRChQWUUey7IIhWkKbzSE+hVbEzoRgls
         BAjyxTYrZzOjKACrBlhbRawRwxed/+2JFXG26/LIKIwSGd03q2W7MKbSh04PRSrEOpSj
         DQwvRLOxUqSmwmG8A3rCyfyUY25P+P+CXa5H3eLoAFSh1i8ulIUbRDtEw9XYfsFSKKmL
         9qwknv1OihtwnVnf6bMbQYFpaWQvQ1bApFUz5YppdILDMQm2g+RGmkT1l+DzkF41NBoa
         2Q5AzJnd9z6Qhnu3xgY0blei9IIOMoVIiI4P0l9ioDnYbLlXUy1uzBS3Gj+2UKqC9EFS
         HOpQ==
X-Gm-Message-State: AOAM531v6elLuZeK2WCTE8R2BfOBPopdf3r/l6PtQzdEusORCNBEISEc
        4PfYyrsG6nbqL3X2rV4mfVB9Tg==
X-Google-Smtp-Source: ABdhPJyDVvFPhrw7UgBjsTg2Du7+vlW8aDxqxzLao1QFauorpGFbgFdIa+S7m/Dkdl9Yg2Kk4nkVCg==
X-Received: by 2002:a17:90a:ab0c:: with SMTP id m12mr5740624pjq.179.1621348541965;
        Tue, 18 May 2021 07:35:41 -0700 (PDT)
Received: from e07e318d3c06 (110-175-118-133.tpgi.com.au. [110.175.118.133])
        by smtp.gmail.com with ESMTPSA id h8sm6969026pfv.60.2021.05.18.07.35.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 May 2021 07:35:41 -0700 (PDT)
Date:   Tue, 18 May 2021 14:35:35 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.12 081/363] net: bridge: propagate error code and
 extack from br_mc_disabled_update
Message-ID: <20210518143531.GA20@e07e318d3c06>
References: <20210517140302.508966430@linuxfoundation.org>
 <20210517140305.339768334@linuxfoundation.org>
 <20210518122449.GA65@ec3d6f83b95b>
 <YKO1jx78HibCUDkD@kroah.com>
 <20210518141238.GA20@416f1e4b4f0c>
 <YKPPDufNZwowyIyb@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKPPDufNZwowyIyb@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 04:28:30PM +0200, Greg Kroah-Hartman wrote:
> On Tue, May 18, 2021 at 02:12:42PM +0000, Rudi Heitbaum wrote:
> > On Tue, May 18, 2021 at 02:39:43PM +0200, Greg Kroah-Hartman wrote:
> > > On Tue, May 18, 2021 at 12:24:57PM +0000, Rudi Heitbaum wrote:
> > > > On Mon, May 17, 2021 at 03:59:07PM +0200, Greg Kroah-Hartman wrote:
> > > > > From: Florian Fainelli <f.fainelli@gmail.com>
> > > > > 
> > > > > [ Upstream commit ae1ea84b33dab45c7b6c1754231ebda5959b504c ]
> > > > > 
> > > > > Some Ethernet switches might only be able to support disabling multicast
> > > > > snooping globally, which is an issue for example when several bridges
> > > > > span the same physical device and request contradictory settings.
> > > > > 
> > > > > Propagate the return value of br_mc_disabled_update() such that this
> > > > > limitation is transmitted correctly to user-space.
> > > > > 
> > > > > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > > > > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > > > > Signed-off-by: David S. Miller <davem@davemloft.net>
> > > > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > > > ---
> > > > >  net/bridge/br_multicast.c | 28 +++++++++++++++++++++-------
> > > > >  net/bridge/br_netlink.c   |  4 +++-
> > > > >  net/bridge/br_private.h   |  3 ++-
> > > > >  net/bridge/br_sysfs_br.c  |  8 +-------
> > > > >  4 files changed, 27 insertions(+), 16 deletions(-)
> > > > 
> > > > This patch results in docker failing to start, and a regression between
> > > > 5.12.4 and 5.12.5-rc1
> > > > 
> > > > A working dmesg output is like:
> > > > 
> > > > [   11.545255] device eth0 entered promiscuous mode
> > > > [   11.693848] process 'docker/tmp/qemu-check643160757/check' started with executable stack
> > > > [   17.233059] br-92020c7e3aea: port 1(veth17a0552) entered blocking state
> > > > [   17.233065] br-92020c7e3aea: port 1(veth17a0552) entered disabled state
> > > > [   17.233098] device veth17a0552 entered promiscuous mode
> > > > [   17.292839] docker0: port 2(veth9d227f5) entered blocking state
> > > > [   17.292848] docker0: port 2(veth9d227f5) entered disabled state
> > > > [   17.292946] device veth9d227f5 entered promiscuous mode
> > > > [   17.293070] docker0: port 2(veth9d227f5) entered blocking state
> > > > [   17.293075] docker0: port 2(veth9d227f5) entered forwarding state
> > > > 
> > > > with this patch "device veth17a0552 entered promiscuous mode" never
> > > > shows up.
> > > > 
> > > > the docker error itself is:
> > > > 
> > > > docker: Error response from daemon: failed to create endpoint
> > > > sleepy_dijkstra on network bridge: adding interface veth8cbd8f9 to
> > > > bridge docker0 failed: operation not supported.
> > > 
> > > Ick.
> > > 
> > > Does 5.13-rc1 also show this same problem?
> > > 
> > > And thanks for testing!
> > > 
> > > greg k-h
> > 
> > Hi Greg,
> > 
> > I can confirm that docker starts correctly with 5.13-rc1
> > 
> > # dmesg | head
> > [    0.000000] Linux version 5.13.0-rc1 (rudi@0e5f93d4a8a2) (x86_64-libreelec-linux-gnu-gcc-10.3.0 (GCC) 10.3.0, GNU ld (GNU Binutils) 2.36.1) #1 SMP Tue May 18 14:00:41 UTC 2021
> > [    0.000000] Command line: BOOT_IMAGE=/KERNEL boot=LABEL=LIBREELEC disk=LABEL=STORAGE i915.enable_guc=2 quiet
> > ...
> > [   11.214582] docker0: port 1(veth2b37ac4) entered blocking state
> > [   11.214589] docker0: port 1(veth2b37ac4) entered disabled state
> > [   11.214649] device veth2b37ac4 entered promiscuous mode
> > [   11.214752] docker0: port 1(veth2b37ac4) entered blocking state
> > [   11.214755] docker0: port 1(veth2b37ac4) entered forwarding state
> 
> Great, can you try 5.12.5-rc2 now?
> 
> thanks,
> 
> greg k-h

confirmed working now.

Thanks
Rudi
