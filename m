Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA169331599
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 19:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhCHSMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 13:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhCHSMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 13:12:13 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29633C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 10:12:13 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id b13so16143967edx.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 10:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OqopxqISgbDC0SR+TF4LgpGs83P68cEOgU0oL+9mBy0=;
        b=rK4orARib+uFue26kj7MItzjbMeCQujuEDB+aGDeIbin57sP23YVBgNZsvAxZ2H28v
         YnNz46zJWdkav61XGtp4BuQc2/KlwBhX3wlN0n6jMM9STBkezask2A7Fl3DxRM5R0mbb
         8SeMgsh5Y7LeqSf/6iRHsTYBPkntQaOqEogzT5gszPvnQAWC9LpHNHLYhh0r3hcZI5Yr
         9i5A84YYMdUZUcQnGNPFpp2FmYojMQuyy2aOPKeQg6OxP5w3ey768Pwtajg1mBjHRNpH
         PDLfuJ0VviolFVEl/DEyob/fNM0ZzFnJfYRt1685C/d7RqbZKTIriWmB+y0DuwtUsLK7
         GjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OqopxqISgbDC0SR+TF4LgpGs83P68cEOgU0oL+9mBy0=;
        b=kn9I2hBXwCFwSihTzP6eQuITLdIuDqg5WjzHkQKAeuLQHmbm8uR66GeFpwFbU4Qzwi
         mC3G7lJ5kDBAQuhxNvVlUbrVhXuTIkHsAKVfTOIFW6YPwZfGfoAGPrI1IRKOK59BBez/
         vL5Y0SXkJ7MB7m++8PK4vRPfW7G2vPxQQ1vAGzcyexUWbpyIlntUIhQMmk+SqR09sFZ4
         x95xNJyxXgNqBh7ByXlCX7MTD/Dk9CwDZnxqJrscW+LTcTr8CDbXUWO6hhKq5HNs3Ge9
         vD9LfEHrDb7SWn1k1DMl7A0Gmo8Y6qEHxDPQhMtnBn1dGSYa4j71vv1ChWHjta52ibso
         tozg==
X-Gm-Message-State: AOAM530YWEo+RMpFsgsi66DWvqxvXpa8gexeZtXGWXCURF3D91CNmk8Y
        KSi+7ugEC2j0mnGlZvx2IcjsSsLmQFU=
X-Google-Smtp-Source: ABdhPJzksP5iJVoFq5Csb78/S0B+2GwxfweASVMdXBsF9sabhTgyQSG+WhL/XwSLIsw95ZGUuuIDMQ==
X-Received: by 2002:a05:6402:b41:: with SMTP id bx1mr23679479edb.69.1615227131173;
        Mon, 08 Mar 2021 10:12:11 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id n25sm7838979edq.55.2021.03.08.10.12.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 10:12:10 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id u16so12458257wrt.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 10:12:10 -0800 (PST)
X-Received: by 2002:adf:ee92:: with SMTP id b18mr22954054wro.275.1615227129949;
 Mon, 08 Mar 2021 10:12:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1615199056.git.bnemeth@redhat.com> <85e04e1e6367f19c8f538d145b32f5bb93788d8a.1615199056.git.bnemeth@redhat.com>
 <CA+FuTSdWSCzkB7sDn+_0Oxy8JqmqL=nsQXP_3bnb4Xdd=0A=KQ@mail.gmail.com>
 <718e4f13-31a8-037c-9725-08ae3cd93ccd@gmail.com> <543ebc518aa31f04bb6a85b66f37d984ede4b031.camel@redhat.com>
 <f1fc417e-946b-6e92-3650-865834c289f3@gmail.com>
In-Reply-To: <f1fc417e-946b-6e92-3650-865834c289f3@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 8 Mar 2021 13:11:30 -0500
X-Gmail-Original-Message-ID: <CA+FuTSdZyePKSOz=r48VaoiF_yFGYxHFnh+FYYCh4KrOpPJ-xw@mail.gmail.com>
Message-ID: <CA+FuTSdZyePKSOz=r48VaoiF_yFGYxHFnh+FYYCh4KrOpPJ-xw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] net: avoid infinite loop in mpls_gso_segment when
 mpls_hlen == 0
To:     David Ahern <dsahern@gmail.com>
Cc:     Balazs Nemeth <bnemeth@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        David Miller <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 8, 2021 at 11:43 AM David Ahern <dsahern@gmail.com> wrote:
>
> On 3/8/21 9:26 AM, Balazs Nemeth wrote:
> > On Mon, 2021-03-08 at 09:17 -0700, David Ahern wrote:
> >> On 3/8/21 9:07 AM, Willem de Bruijn wrote:
> >>>> diff --git a/net/mpls/mpls_gso.c b/net/mpls/mpls_gso.c
> >>>> index b1690149b6fa..cc1b6457fc93 100644
> >>>> --- a/net/mpls/mpls_gso.c
> >>>> +++ b/net/mpls/mpls_gso.c
> >>>> @@ -27,7 +27,7 @@ static struct sk_buff *mpls_gso_segment(struct
> >>>> sk_buff *skb,
> >>>>
> >>>>         skb_reset_network_header(skb);
> >>>>         mpls_hlen = skb_inner_network_header(skb) -
> >>>> skb_network_header(skb);
> >>>> -       if (unlikely(!pskb_may_pull(skb, mpls_hlen)))
> >>>> +       if (unlikely(!mpls_hlen || !pskb_may_pull(skb,
> >>>> mpls_hlen)))
> >>>>                 goto out;
> >>>
> >>> Good cathc. Besides length zero, this can be more strict: a label
> >>> is
> >>> 4B, so mpls_hlen needs to be >= 4B.
> >>>
> >>> Perhaps even aligned to 4B, too, but not if there may be other
> >>> encap on top.

On second thought, since mpls_gso_segment pulls all these headers, it
is correct to require it to be a multiple of MPLS_HLEN.
