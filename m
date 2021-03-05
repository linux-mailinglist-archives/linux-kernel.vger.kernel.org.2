Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC64532EFD6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 17:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhCEQQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 11:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbhCEQPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 11:15:54 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83369C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 08:15:54 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id b13so3382735edx.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 08:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Xb9UOY2Gv704gb88GvqIXJCorlDWMU6wr0g3R4KLys=;
        b=iYvuQ4Os3tabOH7OdwSRvUwYplKP8jS7hGpza4luZLaNFt2WLB96jzDnKG+OG46WtD
         RTUQT4Qhjb0fe11zcPjkcF1TPwYMW+N+cvlLRDEKqtIue0Mm231x8Bd1gLXp+xbUtIPG
         ckfuflB0QndyFZyKtw95cWRkmfF38x6/ztGnLfOdFghW1Q1WagxYr/qvQslf6XBRuQsM
         TJS6hNzQh/PEZzI4+L+dbw1KxSF/i+T1TZ84TlbYDwohcdmpB0kRP4n5oYsqv13eZQmC
         phONRhT5uOWG6GF5AGWo8oyef5U7epYq8xjhS7q5462MlK1+FAeQOeRraVUoqKZyWYfv
         Tnww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Xb9UOY2Gv704gb88GvqIXJCorlDWMU6wr0g3R4KLys=;
        b=Ybi5g9iyLjrfgAlq86/VsjcapWkixTTgmZGZ5kbuV0rAEHufVUsTgrIrzU08ERaWtW
         DGWnStiEzQ46HV/eB07iX2PitizkbHgJTr9BF3tHYnkL12lu9VoZ1yRYlqc+ZgJceY+q
         KtuvBQot1VKa8cdIDzkXvT+HMTNJebd4FKv13TJRODtCpyoPT80S/5fNyD64fnsvb2mX
         hC74DhmJdseNzA03nJcHMdDuVOALewsjnba3N3X4DIrxOeVQ/iodxYWryXG1sh6xk9s3
         9eg7oc//8V+Gvy74tTtUSGo3DYSzQkUibqMDtm/KNhiyTPurwCzNUOZwufmYcVfUZawT
         sswA==
X-Gm-Message-State: AOAM5308jZeMvYH+DRdfvmCrvwnh2dfy3xO25zJNg5S3AKZdqE8obOyl
        PmJIPMslDRYKzHT50DvplLBug9xoNUc=
X-Google-Smtp-Source: ABdhPJynCB58PClRkLkw/CFnwBxgTAyhKKyzNupAIEEf3Mt0y3pq6GOlIzJOOOujlnkSfh+TnDNzIA==
X-Received: by 2002:aa7:db53:: with SMTP id n19mr10084604edt.330.1614960953090;
        Fri, 05 Mar 2021 08:15:53 -0800 (PST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id m14sm1810058edd.63.2021.03.05.08.15.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 08:15:52 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id h98so2657558wrh.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 08:15:52 -0800 (PST)
X-Received: by 2002:a05:6000:1803:: with SMTP id m3mr9809122wrh.50.1614960952213;
 Fri, 05 Mar 2021 08:15:52 -0800 (PST)
MIME-Version: 1.0
References: <20210305123347.15311-1-hxseverything@gmail.com>
 <CA+FuTSc_RDHb8dmMzfwatt89pXsX2AA1--X98pEGkmmfpVs-Vg@mail.gmail.com> <dfde1c9f-cd2d-6e7d-ea3e-58b486a1388b@iogearbox.net>
In-Reply-To: <dfde1c9f-cd2d-6e7d-ea3e-58b486a1388b@iogearbox.net>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 5 Mar 2021 11:15:15 -0500
X-Gmail-Original-Message-ID: <CA+FuTSfk2HOupSwUfOjsNQBA4Z8HKUgfkQmyTViY5icbt4ujHg@mail.gmail.com>
Message-ID: <CA+FuTSfk2HOupSwUfOjsNQBA4Z8HKUgfkQmyTViY5icbt4ujHg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests_bpf: extend test_tc_tunnel test with vxlan
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Xuesen Huang <hxseverything@gmail.com>,
        David Miller <davem@davemloft.net>, bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Xuesen Huang <huangxuesen@kuaishou.com>,
        Li Wang <wangli09@kuaishou.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 5, 2021 at 11:10 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 3/5/21 4:08 PM, Willem de Bruijn wrote:
> > On Fri, Mar 5, 2021 at 7:34 AM Xuesen Huang <hxseverything@gmail.com> wrote:
> >>
> >> From: Xuesen Huang <huangxuesen@kuaishou.com>
> >>
> >> Add BPF_F_ADJ_ROOM_ENCAP_L2_ETH flag to the existing tests which
> >> encapsulates the ethernet as the inner l2 header.
> >>
> >> Update a vxlan encapsulation test case.
> >>
> >> Signed-off-by: Xuesen Huang <huangxuesen@kuaishou.com>
> >> Signed-off-by: Li Wang <wangli09@kuaishou.com>
> >> Signed-off-by: Willem de Bruijn <willemb@google.com>
> >
> > Please don't add my signed off by without asking.
>
> Agree, I can remove it if you prefer while applying and only keep the
> ack instead.

That would be great. Thanks, Daniel!
