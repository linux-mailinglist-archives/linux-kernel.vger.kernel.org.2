Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C672142A0E9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 11:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbhJLJXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 05:23:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39347 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235230AbhJLJXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 05:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634030457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NQvvX7DYevVvifiKrUIFSDiboyiIsSpy6G0Ys71FCOg=;
        b=c/qUJUm23gubkCjkKaJTg0BJoNmbmO/zqoqec20IGXYP3x5gtxnGqgbdn1WPt1jjsOy3nJ
        xoxz4yCVncxZ/nJtPA6Z2MFMYlP6PvogEXXR1pSwklIcT1w2d3SBZOGkPxL16tBOggIz4r
        r9TWaDid2L5PdXKPWrVuQIkrnWu4kIM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-1IHrZk8TORG6CBfObcz0nQ-1; Tue, 12 Oct 2021 05:20:56 -0400
X-MC-Unique: 1IHrZk8TORG6CBfObcz0nQ-1
Received: by mail-wr1-f72.google.com with SMTP id r25-20020adfab59000000b001609ddd5579so15256590wrc.21
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 02:20:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=NQvvX7DYevVvifiKrUIFSDiboyiIsSpy6G0Ys71FCOg=;
        b=RXCDeYfadP0pk+T0V2EdGT+MuUaL4ZKAaiQw1UzJlyFONDHHLtUQm5a9vDJLIE2s4J
         jCpFEfWCCD63gDh78QyrqVSO3Fdz+vlXxwujHgFRP/1MN38yO6idyZGWiC0zQuZ/T01C
         IaPg3kahy9Ly6ptV5AbYSar+q4cTQ5VnIjy25BR6R/ni0ZODzGv4wt02ptMP5R27Vb6V
         HblDxPLPooOE4RkxzrDZNndrOFAcz2GCgINAvkFX64y8no1zLzpR4CZzobkgI2LaNNSN
         Ltm6xJVDxrPvkOS3ZF/lAvF9jW+6aUbRdpm0R7nEgL94tttmyT0+fJEQ09o9/hC58zHT
         49Zg==
X-Gm-Message-State: AOAM531iEK5iqjZR0jmMahb8z/vra/Dz9FvLeWBh3UvB+9XJ+tS9P+2W
        bHj4Zb3bllpKQP4rm+zVlmuKD0zeqbjTnZW8MFnE+Poa3QdjJCIcQExI4Vm2tE/HuqeUEN6ACkc
        i8yquIQjvni+UfB999lnp+Gy3
X-Received: by 2002:a1c:a9d5:: with SMTP id s204mr4267010wme.193.1634030455617;
        Tue, 12 Oct 2021 02:20:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywk9hzf7x2/zkP49ad7b+yMh+89MNX7bHIg+1V/CfDIKZ/l9tK1gZVUSfBDowQDZu+/gW3aA==
X-Received: by 2002:a1c:a9d5:: with SMTP id s204mr4266983wme.193.1634030455431;
        Tue, 12 Oct 2021 02:20:55 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-16.dyn.eolo.it. [146.241.231.16])
        by smtp.gmail.com with ESMTPSA id p11sm2137819wmi.0.2021.10.12.02.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 02:20:55 -0700 (PDT)
Message-ID: <b6441514ee17eb12934dad304854939308f5c4c1.camel@redhat.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in veth_xdp_rcv
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>,
        syzbot <syzbot+67f89551088ea1a6850e@syzkaller.appspotmail.com>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, hawk@kernel.org,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com,
        Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>
Date:   Tue, 12 Oct 2021 11:20:53 +0200
In-Reply-To: <20211011164747.303ffcd0@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <000000000000c1524005cdeacc5f@google.com>
         <20211011164747.303ffcd0@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-10-11 at 16:47 -0700, Jakub Kicinski wrote:
> CC: Paolo, Toke

Thanks for the head-up! will look at this soon.

Cheers,

Paolo

