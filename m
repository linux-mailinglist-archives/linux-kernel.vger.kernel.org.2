Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A47378F92
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237763AbhEJNtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 09:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353182AbhEJNjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 09:39:45 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6169CC0611B5
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 06:27:06 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id zg3so24522173ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 06:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XnLqubyFOR9LLpachU5WliqicYmoNsbEP8N7g/v6r6U=;
        b=k/bfDeWhlQNeG23nj64PAeOmwKRfvE2ovDxO6X2A1L3YeT5UYbWjRhbwVJPMGptd6Z
         sH4Y89NMdaZjDLOUhBtTf+rKgJzWHy7HcEyydPkWaP8Z5seKbE2/6TCydWgBdzt2Rtv5
         UHJ9Q+w5V7q4/qL2E5Bn8cqBbbCH4wAzHq6kgdHMm6/HmBNQ7piu0+rlSQBnNml9HySx
         oACdJ9WoZL98kwXnxAv+dQcVxFetvguq1eNonYQp2bhpAc2SlK+/LUfeiNmZjMzAHNWp
         cTaBJfVirHbCslxUU9nyAE2dDvWRa8NdNE4VsuqKZFKTq+shDGPk7eVoRTNtea38SV61
         O/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XnLqubyFOR9LLpachU5WliqicYmoNsbEP8N7g/v6r6U=;
        b=dXA9SdFOpCdB+EtsuVE2gKyLCRgZesK6TOrCs9E9AMwXQH4pjqN21p7UdFBOUyZGJY
         NPJ56Vf6NAwcR9Lq3wVvMO41n/rxlM+7zMPWnbQN2v3DoUFau7LQyxDKMVRiU+lkdXsF
         TlQf/c1WiIM8hhOfTIFFS/ggadftnhscJKXpF9BKoXfVtBtVmWi4MaCkkvv6oBA+Gw4w
         FiMAkSTi2CRTtAWsvGZzT+ovQ2Zp5awlWitA5UDzCD/y4+eRe26smFMcy0meCYVmCR5k
         UGm5/o3YSOKXuivkb8MIO9tR94m6f17NITbGL4cx43OPcEl5IdpLvvTkSSadj3Y8h7C9
         5ZSg==
X-Gm-Message-State: AOAM530J7dwt4OIdM9ooKZdoUoKc0bxFSyasH8ap41qcWQzh86R897ot
        B9rCj+6bMLb3KKP4BP3050aWcvcKVb/kwg==
X-Google-Smtp-Source: ABdhPJwxHs5niNjEJfA7MRA809Evlkagl8I0PUe2HjQEqlz7VBMNj4Z683LgKySYBjDIOlv2S9/6Iw==
X-Received: by 2002:a17:906:c0c6:: with SMTP id bn6mr25251622ejb.436.1620653224901;
        Mon, 10 May 2021 06:27:04 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id b9sm11157529edt.2.2021.05.10.06.27.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 06:27:04 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id g65so9195311wmg.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 06:27:04 -0700 (PDT)
X-Received: by 2002:a1c:c385:: with SMTP id t127mr26715596wmf.169.1620652820784;
 Mon, 10 May 2021 06:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20210429102143epcas2p4c8747c09a9de28f003c20389c050394a@epcas2p4.samsung.com>
 <1619690903-1138-1-git-send-email-dseok.yi@samsung.com> <8c2ea41a-3fc5-d560-16e5-bf706949d857@iogearbox.net>
 <02bf01d74211$0ff4aed0$2fde0c70$@samsung.com> <CA+FuTScC96R5o24c-sbY-CEV4EYOVFepFR85O4uGtCLwOjnzEw@mail.gmail.com>
 <02c801d7421f$65287a90$2f796fb0$@samsung.com> <CA+FuTScUJwqEpYim0hG27k39p_yEyzuW2A8RFKuBndctgKjWZw@mail.gmail.com>
 <001801d742db$68ab8060$3a028120$@samsung.com> <CAF=yD-KtJvyjHgGVwscoQpFX3e+DmQCYeO_HVGwyGAp3ote00A@mail.gmail.com>
 <436dbc62-451b-9b29-178d-9da28f47ef24@huawei.com> <CAF=yD-+d0QYj+812joeuEx1HKPzDyhMpkZP5aP=yNBzrQT5usw@mail.gmail.com>
 <007001d7431a$96281960$c2784c20$@samsung.com> <CAF=yD-L9pxAFoT+c1Xk5YS42ZaJ+YLVQVnV+fvtqn-gLxq9ENg@mail.gmail.com>
 <00c901d74543$57fa3620$07eea260$@samsung.com>
In-Reply-To: <00c901d74543$57fa3620$07eea260$@samsung.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 10 May 2021 09:19:43 -0400
X-Gmail-Original-Message-ID: <CA+FuTSepShKoXUJo7ELMMJ4La11J6CsZggJWsQ5MB2_uhAi+OQ@mail.gmail.com>
Message-ID: <CA+FuTSepShKoXUJo7ELMMJ4La11J6CsZggJWsQ5MB2_uhAi+OQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: check for data_len before upgrading mss when 6
 to 4
To:     Dongseok Yi <dseok.yi@samsung.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > That generates TCP packets with different MSS within the same stream.
> >
> > My suggestion remains to just not change MSS at all. But this has to
> > be a new flag to avoid changing established behavior.
>
> I don't understand why the mss size should be kept in GSO step. Will
> there be any issue with different mss?

This issue has come up before and that has been the feedback from
TCP experts at one point.

> In general, upgrading mss make sense when 6 to 4. The new flag would be
> set by user to not change mss. What happened if user does not set the
> flag? I still think we should fix the issue with a general approach. Or
> can we remove the skb_increase_gso_size line?

Admins that insert such BPF packets should be aware of these issues.
And likely be using clamping. This is a known issue.

We arrived that the flag approach in bpf_skb_net_shrink. Extending
that  to bpf_skb_change_proto would be consistent.
