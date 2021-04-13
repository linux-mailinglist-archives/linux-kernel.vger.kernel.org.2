Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA7635E90E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 00:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240383AbhDMWda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 18:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbhDMWd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 18:33:28 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A32C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 15:33:08 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id c8-20020a9d78480000b0290289e9d1b7bcso3522435otm.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 15:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p1ePcMHRiUHLqxmNB1ISxMsad9RE0A3Rj2w0thaVuAM=;
        b=sc3Iy3Io/zqAZ1NI1n2LzcYMRbU2Hma6K4SwDp4iga7kYT+vQraryaQQvCIjMiJhH6
         /2Mr0xEIB3Og5qIFkgBaW9+KVTq+NpAGdu3qPIDma23CpGF64AjixfPfM7vn0nGrustq
         mu/8Buy/oWwuGB+dHSiP+PCo6vACvJgwSbDg8GeWlHznDKnOm///BErcT//t4uhwjmeE
         MNaA8j3EYnAH3J7C1OCLgni7yE22riSLdJzD64DRHYaitRi70c3mFImQnmwNzQIcc2WG
         Vk3E0YMudZxsgINQXCx9rNRKFcP09rCtGCdkhaM0eIqATqH9W4DwuBNVx8MP4d8/PM1l
         LW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p1ePcMHRiUHLqxmNB1ISxMsad9RE0A3Rj2w0thaVuAM=;
        b=sM/6G9MXD1Mq3WYp6B/f87j7b6L92mdr8aIaUigwCx7FbAeKeZjS/raVSI5DU+4xYN
         1MUNlaev3B2TDmr5g5GJJdfcQ5q5g+o9+zING5EF9/zYnmdgWBHK5SgSwLL63d1rpQR/
         7v6G/Tpq1lurW6sjsHKWAl8iGtoyuoBziHhT9gkJ5N1tRvPHU5UPq15ZykBEKT2Rr/Mq
         /afa+MpH8aM9P+7zexckEDxZD3Bha14FfT/cKOmWyQq1Y2MDp5vG4STwSid2HHrTWKTG
         3LuCt3HnWue8W1Mok/kdvyveVOvlLhJDQwJBK8h56ORCTB3kb5fAgcRFnDZvc84XcSK6
         MKSQ==
X-Gm-Message-State: AOAM533mE0yJoZTdH0fd0g7LZpzyDVgkObfTGgGi6u1ah9LzOQSdI129
        /BPB94OzK3X94is0Yhht5IUKtcKF6daToNDzRi1ZTw==
X-Google-Smtp-Source: ABdhPJyJi2RekjwUCi3f9BBegVtt9gF6yyk5dHlwVdmGKFv4Q3NOtFEaSkK8Ue82hymvSus3Wmj7/c1lCdBXCZTZHVE=
X-Received: by 2002:a9d:5c0f:: with SMTP id o15mr29399427otk.279.1618353187987;
 Tue, 13 Apr 2021 15:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210406183112.1150657-1-jiang.wang@bytedance.com>
 <1D46A084-5B77-4803-8B5F-B2F36541DA10@vmware.com> <CAP_N_Z-KFUYZc7p1z_-9nb9CvjtyGFkgkX1PEbh-SgKbX_snQw@mail.gmail.com>
 <4FE66B72-E16B-474D-9A17-70B3BCCD5A19@vmware.com>
In-Reply-To: <4FE66B72-E16B-474D-9A17-70B3BCCD5A19@vmware.com>
From:   "Jiang Wang ." <jiang.wang@bytedance.com>
Date:   Tue, 13 Apr 2021 15:32:57 -0700
Message-ID: <CAP_N_Z8Jp4jbEZ5MjDO7Cj=WsPgB=rZ-ANcPW=4vfpsrDryBRw@mail.gmail.com>
Subject: Re: [RFC] vsock: add multiple transports support for dgram
To:     Jorgen Hansen <jhansen@vmware.com>
Cc:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "cong.wang@bytedance.com" <cong.wang@bytedance.com>,
        "duanxiongchun@bytedance.com" <duanxiongchun@bytedance.com>,
        "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Colin Ian King <colin.king@canonical.com>,
        Norbert Slusarek <nslusarek@gmx.net>,
        Andra Paraschiv <andraprs@amazon.com>,
        Alexander Popov <alex.popov@linux.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 2:02 AM Jorgen Hansen <jhansen@vmware.com> wrote:
>
>
>
> > On 7 Apr 2021, at 20:25, Jiang Wang . <jiang.wang@bytedance.com> wrote:
> >
> > On Wed, Apr 7, 2021 at 2:51 AM Jorgen Hansen <jhansen@vmware.com> wrote=
:
> >>
> >>
> >>> On 6 Apr 2021, at 20:31, Jiang Wang <jiang.wang@bytedance.com> wrote:
> >>>
> >>> From: "jiang.wang" <jiang.wang@bytedance.com>
> >>>
> >>> Currently, only VMCI supports dgram sockets. To supported
> >>> nested VM use case, this patch removes transport_dgram and
> >>> uses transport_g2h and transport_h2g for dgram too.
> >>
> >> Could you provide some background for introducing this change - are yo=
u
> >> looking at introducing datagrams for a different transport? VMCI datag=
rams
> >> already support the nested use case,
> >
> > Yes, I am trying to introduce datagram for virtio transport. I wrote a
> > spec patch for
> > virtio dgram support and also a code patch, but the code patch is still=
 WIP.
>
> Oh ok. Cool. I must have missed the spec patch - could you provide a refe=
rence to
> it?

Sure. here is the link:
https://lists.linuxfoundation.org/pipermail/virtualization/2021-April/05354=
3.html

> > When I wrote this commit message, I was thinking nested VM is the same =
as
> > multiple transport support. But now, I realize they are different.
> > Nested VMs may use
> > the same virtualization layer(KVM on KVM), or different virtualization =
layers
> > (KVM on ESXi). Thanks for letting me know that VMCI already supported n=
ested
> > use cases. I think you mean VMCI on VMCI, right?
>
> Right, only VMCI on VMCI.

Got it. thanks.

> I=E2=80=99ll respond to Stefano=E2=80=99s email for the rest of the discu=
ssion.
>
> Thanks,
> Jorgen
