Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E475F32CAEC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 04:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhCDDl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 22:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbhCDDln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 22:41:43 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037D5C061756
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 19:41:02 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id x9so1152044edd.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 19:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ctdwcy3w021/XfAUg4TkaZecW5irl6CDz7k2Rv83QVU=;
        b=dRfjnbRjfljwbo6rfVlJdJWSjlo2hEdcoJnu0H29poV1QYXv3XQhg6mxj1FVOpsyoE
         YreUIY4mvu4eSJUniP4iG8Dgci95/0YkIadYy2zNiMam7QnO2KTtzG+bpn9Jhm1hPtmT
         yqPVc4Oy1M0A1FMw8t6fwkkgxX59C8eg2JqKKPf1XLEG0i5VsUh92Kb91QToAyBBii5Y
         FaXKB98LYcrPs9B8Clx8TqA/Hrz++oIkrcQ/94dn2yYarauK+m3RbNYKq3qhyc/DtJ/u
         oQo4CdGpFjwsXi6m7vp6J2wDB6TkevCa+02u+LfN+HXcCocm5JuoQNfpSc9Jr8nJCfc7
         oHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ctdwcy3w021/XfAUg4TkaZecW5irl6CDz7k2Rv83QVU=;
        b=q1k31PfKtJ73IaHkj6Ubc/M5SYCvxOJX+y2gR43UcbikciXOF55EpaxIZtZkkFhICf
         Dnxp7563F7yySzYdxWM4v1hdmUYUmT73cwW/tJAP2aXmGdYGWZ8zWY5iHRwsmsf6QR0E
         mZdx13qT7PtevS12CY0NAqWjOn0h2p7QCk7NtQzw71d1zd5oc4xPklEnSVE84nYVWSxv
         YHeEf67UjZdlz2QPf8w4JkONL+EdewittYUS2Dx9O8FCGW5GekTBvZ3wDAXouBaa1RC1
         Nj9vzH278WLzgVH7SRnFbeXucfCxIsuXbZPXKodsjDkBb2PJEU735liKNkq7LDAQU1As
         w2Ow==
X-Gm-Message-State: AOAM533Ksakpl/9fRMtC1fqNGCzwXUr503CaO/nPBJVNbXfXrMjYKkKJ
        ZrfDaHMm5RvVq4QWSb5WE9Im01/QsHM=
X-Google-Smtp-Source: ABdhPJydIlIAol5CTr1yZLdoWSqNbjcAhneXdU5GocfmzS6dqrKV3rNUwGyYFUuZf1tMyoD7TdIscg==
X-Received: by 2002:a50:e882:: with SMTP id f2mr2256868edn.184.1614829261308;
        Wed, 03 Mar 2021 19:41:01 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id lu26sm21637337ejb.33.2021.03.03.19.41.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Mar 2021 19:41:00 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id v15so26040138wrx.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 19:41:00 -0800 (PST)
X-Received: by 2002:adf:fa08:: with SMTP id m8mr1805401wrr.12.1614829260152;
 Wed, 03 Mar 2021 19:41:00 -0800 (PST)
MIME-Version: 1.0
References: <20210303123338.99089-1-hxseverything@gmail.com>
 <CA+FuTSfY0y7Y2XSKO-rqPY5mX83NWgAWbQeVukFA94eJVu2B2g@mail.gmail.com> <5D5B444A-FE98-46CF-80D2-DEEBE9C1D74A@gmail.com>
In-Reply-To: <5D5B444A-FE98-46CF-80D2-DEEBE9C1D74A@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 3 Mar 2021 22:40:22 -0500
X-Gmail-Original-Message-ID: <CA+FuTSdLQPvEChSDDAoN+qk2vOVmhA1OCvJ5T38OvOY1=5HQpQ@mail.gmail.com>
Message-ID: <CA+FuTSdLQPvEChSDDAoN+qk2vOVmhA1OCvJ5T38OvOY1=5HQpQ@mail.gmail.com>
Subject: Re: [PATCH/v4] bpf: add bpf_skb_adjust_room flag BPF_F_ADJ_ROOM_ENCAP_L2_ETH
To:     Xuesen Huang <hxseverything@gmail.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>, bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Zhiyong Cheng <chengzhiyong@kuaishou.com>,
        Li Wang <wangli09@kuaishou.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Instead of untyped macros, I'd define encap_ipv4 as a function that
> > calls __encap_ipv4.
> >
> > And no need for encap_ipv4_with_ext_proto equivalent to __encap_ipv4.
> >
> I defined these macros to try to keep the existing  invocation for encap_=
ipv4/6
> as the same, if we define this as a function all invocation should be mod=
ified?

You can leave the existing invocations the same and make the new
callers caller __encap_ipv4 directly, which takes one extra argument?
Adding a __ prefixed variant with extra args is a common pattern.

> >>        /* add L2 encap (if specified) */
> >> +       l2_hdr =3D (__u8 *)&h_outer + olen;
> >>        switch (l2_proto) {
> >>        case ETH_P_MPLS_UC:
> >> -               *((__u32 *)((__u8 *)&h_outer + olen)) =3D mpls_label;
> >> +               *(__u32 *)l2_hdr =3D mpls_label;
> >>                break;
> >>        case ETH_P_TEB:
> >> -               if (bpf_skb_load_bytes(skb, 0, (__u8 *)&h_outer + olen=
,
> >> -                                      ETH_HLEN))
> >
> > This is non-standard indentation? Here and elsewhere.
> I thinks it=E2=80=99s a previous issue.

Ah right. Bad example. How about in __encap_vxlan_eth

+               return encap_ipv4_with_ext_proto(skb, IPPROTO_UDP,
+                               ETH_P_TEB, EXTPROTO_VXLAN);

> >> @@ -278,13 +321,24 @@ static __always_inline int encap_ipv6(struct __s=
k_buff *skb, __u8 encap_proto,
> >>        }
> >>
> >>        /* add L2 encap (if specified) */
> >> +       l2_hdr =3D (__u8 *)&h_outer + olen;
> >>        switch (l2_proto) {
> >>        case ETH_P_MPLS_UC:
> >> -               *((__u32 *)((__u8 *)&h_outer + olen)) =3D mpls_label;
> >> +               *(__u32 *)l2_hdr =3D mpls_label;
> >>                break;
> >>        case ETH_P_TEB:
> >> -               if (bpf_skb_load_bytes(skb, 0, (__u8 *)&h_outer + olen=
,
> >> -                                      ETH_HLEN))
> >> +               flags |=3D BPF_F_ADJ_ROOM_ENCAP_L2_ETH;
> >
> > This is a change also for the existing case. Correctly so, I imagine.
> > But the test used to pass with the wrong protocol?
> Yes all tests pass. I=E2=80=99m not sure should we add this flag for the =
existing tests
> which encap eth as the l2 header or only for the Vxlan test?

It is correct in both cases. If it does not break anything, I would do both=
.

Thanks,

  Willem
