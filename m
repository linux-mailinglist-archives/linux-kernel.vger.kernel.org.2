Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326D13E3718
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 23:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhHGV04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 17:26:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31775 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229578AbhHGV0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 17:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628371597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ql473xDetlxsytlL7rANAqL7UeihJd6f7EVjv1H0164=;
        b=MrEILaE/GqYRS9lpXX/ga5I1eKz3qrR0rCgyZohAvG+FeGQNynjcrNrb3ucAmm/Xf5n2AS
        poGPbSmiumfuJ2tBzkIjV0inELuTGITNKTCW6b3IBqkat9ud4RsPDNSSpuqHSLFdt2wUiF
        AKzGHBDriNeNv/b9cECrKyV+vqi0TYc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-Vx_3igS9MaeU2Ih7EWXxOA-1; Sat, 07 Aug 2021 17:26:36 -0400
X-MC-Unique: Vx_3igS9MaeU2Ih7EWXxOA-1
Received: by mail-qv1-f70.google.com with SMTP id z25-20020a0ca9590000b029033ba243ffa1so9127046qva.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 14:26:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Ql473xDetlxsytlL7rANAqL7UeihJd6f7EVjv1H0164=;
        b=ApQPizWCeNUy8BpCuwhSehc5gWPwj6E0IWXNVNJCiwDIATGrdb0ewAOsyCIqgkCMVA
         vknUOslfS8gU0/sYNGMSqdm/XcCOwt96KqFL/HgA6qobYOaewJPe1yJVfTbTAtOypBou
         skpcjnjAD7ZX+/YUMI4XDgP8vQIlY25d/r7o5vdstoMiC7rUTukhQmqhAlSJhjazBPq3
         C1bBNuJt6ThvFAIyKdY3zrqCjVNflrLFr6MbAU0GlucF2K0fsIlL8NkL0Seyi4c6jBBC
         Lq6x/VxnmchHiEbkiTjpYvJWUbWdT31ueUxWazQ9X7NiARkOFWouEfdugZvOkzrkdO97
         kN6A==
X-Gm-Message-State: AOAM532Xb3Xnx3Na4ruzIgCL5dstXmiABZjMvhUDw6vOwnvizJu1PFfk
        nDSrAptgmfI/2R5o5L/8bjEAEiY6RBebDF5LOl1a9kBt5y/E1YF5hyd2we/wfafDx2tT5UX3clG
        o0m0tFzYzX8hkWKjLIgZTfKFQBz1CimW4LSUacvUhp/dp2/zwQAY7VzawZH1Zq+DJeG/VMFmwhP
        ia
X-Received: by 2002:ad4:54ae:: with SMTP id r14mr17350059qvy.1.1628371595757;
        Sat, 07 Aug 2021 14:26:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzC5zDGpPjn1+I+DTLwfT/IPU19lPrvDGE5/skNWFSqRPsdfvGiv3FS3SsFxZZvPeAxWUEudg==
X-Received: by 2002:ad4:54ae:: with SMTP id r14mr17350041qvy.1.1628371595547;
        Sat, 07 Aug 2021 14:26:35 -0700 (PDT)
Received: from jtoppins.rdu.csb ([107.15.110.69])
        by smtp.gmail.com with ESMTPSA id c1sm5164245qtj.36.2021.08.07.14.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Aug 2021 14:26:35 -0700 (PDT)
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc:     Veaceslav Falico <vfalico@gmail.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Jonathan Toppins <jtoppins@redhat.com>
Subject: bonding: link state question
Message-ID: <020577f3-763d-48fd-73ce-db38c3c7fdf9@redhat.com>
Date:   Sat, 7 Aug 2021 17:26:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any reason why bonding should have an operstate of up when none 
of its slaves are in an up state? In this particular scenario it seems 
like the bonding device should at least assert NO-CARRIER, thoughts?

$ ip -o -d link show | grep "bond5"
2: enp0s31f6: <NO-CARRIER,BROADCAST,MULTICAST,SLAVE,UP> mtu 1500 qdisc 
fq_codel master bond5 state DOWN mode DEFAULT group default qlen 1000\ 
  link/ether 8c:8c:aa:f8:62:16 brd ff:ff:ff:ff:ff:ff promiscuity 0 
minmtu 68 maxmtu 9000 \    bond_slave state ACTIVE mii_status UP 
link_failure_count 0 perm_hwaddr 8c:8c:aa:f8:62:16 queue_id 0 
numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535
41: bond5: <BROADCAST,MULTICAST,MASTER,UP,LOWER_UP> mtu 1500 qdisc 
noqueue state UP mode DEFAULT group default qlen 1000\    link/ether 
8c:8c:aa:f8:62:16 brd ff:ff:ff:ff:ff:ff promiscuity 0 minmtu 68 maxmtu 
65535 \    bond mode balance-xor miimon 0 updelay 0 downdelay 0 
peer_notify_delay 0 use_carrier 1 arp_interval 0 arp_validate none 
arp_all_targets any primary_reselect always fail_over_mac none 
xmit_hash_policy layer2 resend_igmp 1 num_grat_arp 1 all_slaves_active 0 
min_links 0 lp_interval 1 packets_per_slave 1 lacp_rate slow ad_select 
stable tlb_dynamic_lb 1 numtxqueues 16 numrxqueues 16 gso_max_size 65536 
gso_max_segs 65535

$ cat /sys/class/net/enp0s31f6/operstate
down

$ cat /sys/class/net/bond5/operstate
up

This is an older kernel (4.18.0-305.7.1.el8_4.x86_64) but I do not see 
any changes upstream that would indicate a change in this operation.

Thanks,
-Jon

