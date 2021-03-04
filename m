Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72F632D4B7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 14:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235755AbhCDN5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 08:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237751AbhCDN4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 08:56:47 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5B9C061756
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 05:56:06 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id v13so18499847edw.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 05:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zNqt364yKc9AWMgU3gsE1glWEHnIX0hXdX9QnycDgAE=;
        b=h2MDWr0x+l/RRdWo87aMtBHYHL/EZs/ptnrUUCflnO+hIHY6vAI41jyhBF0syGZn/p
         Op3XhjCGwMm/0GobwqzZwPc69RXJUMVBpaN54DUECA4S9O2T7SxDqu9P5GR5Jr7JAbBi
         3xonWuM81lIInxPJBH7AABQqrezhq0wiLKqZ3ZlAe+DGtoWj1MDjKFDuYmVNT7cnvCPF
         T0rSDDmILzCUYwmNsoKGMDS9ZJL5wEpQlVfEbc3MQ7EJiBMu/tmUiZ8qVGTACDpnUggm
         P3z4cHSInsJnZ/lId4G3SFSzObh7UJ/sVc/zw8IB+ofkt/INH7XSoSiqfsvpVZu6L36d
         KfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zNqt364yKc9AWMgU3gsE1glWEHnIX0hXdX9QnycDgAE=;
        b=asgAjll4y/CewT5WSKm85htngJ/rcjYfWfiT5ZWNSMKMkZSa2OqANjUrCfv8UvYucE
         DWo90O1bTdNZVB2ZfXSPXMEasd3LcCJMCSmkUCwbhh3POGbFrWQ3hD9K/JKEhMk/D10I
         tK3Fg5nWwgTmj8EVfHduGNYWkN2s/tKwIStoaQEq7VMDnNfsZX20Y97Kixg8KDliskvr
         zTZQhff2sIaEr0qjXMin9FcpuPbq2ZUBu52lfDjKxUMXtksvqhZUUYCYgqUEV4FS5aHw
         ChjszLcRTPV3b6CtY9tJMGGaZhZYxGn0fro+6a8hNjf3Hu7hGpwGCM2ZM1t46wW1ZDB6
         UYIw==
X-Gm-Message-State: AOAM532v23QZtAVVCB3fcRtURa2pODrZOKCrlNchQxbo2VwEXNADRNuo
        NzwoiVCCo7xD08Tn73aCtsrjsGXpnLs=
X-Google-Smtp-Source: ABdhPJxABD1m4RfAtGxcmIh/kkkBtCNGxrk9fSq31TJd+X1XVylEf4N1lO0Gw/OMnZNhjkrQ0stQlw==
X-Received: by 2002:a05:6402:27d3:: with SMTP id c19mr4493523ede.129.1614866165218;
        Thu, 04 Mar 2021 05:56:05 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id r5sm24155280ejx.96.2021.03.04.05.56.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 05:56:04 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id v15so27765432wrx.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 05:56:04 -0800 (PST)
X-Received: by 2002:adf:fa08:: with SMTP id m8mr4317031wrr.12.1614866163865;
 Thu, 04 Mar 2021 05:56:03 -0800 (PST)
MIME-Version: 1.0
References: <20210304064046.6232-1-hxseverything@gmail.com>
In-Reply-To: <20210304064046.6232-1-hxseverything@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 4 Mar 2021 08:55:26 -0500
X-Gmail-Original-Message-ID: <CA+FuTSc3W9jcL97OF+ctRWLhFoUdNxb3P0MyPm9k7W8nTvWX0Q@mail.gmail.com>
Message-ID: <CA+FuTSc3W9jcL97OF+ctRWLhFoUdNxb3P0MyPm9k7W8nTvWX0Q@mail.gmail.com>
Subject: Re: [PATCH/v5] bpf: add bpf_skb_adjust_room flag BPF_F_ADJ_ROOM_ENCAP_L2_ETH
To:     Xuesen Huang <hxseverything@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>, bpf <bpf@vger.kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Xuesen Huang <huangxuesen@kuaishou.com>,
        Zhiyong Cheng <chengzhiyong@kuaishou.com>,
        Li Wang <wangli09@kuaishou.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 4, 2021 at 1:41 AM Xuesen Huang <hxseverything@gmail.com> wrote:
>
> From: Xuesen Huang <huangxuesen@kuaishou.com>
>
> bpf_skb_adjust_room sets the inner_protocol as skb->protocol for packets
> encapsulation. But that is not appropriate when pushing Ethernet header.
>
> Add an option to further specify encap L2 type and set the inner_protocol
> as ETH_P_TEB.
>
> Suggested-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Xuesen Huang <huangxuesen@kuaishou.com>
> Signed-off-by: Zhiyong Cheng <chengzhiyong@kuaishou.com>
> Signed-off-by: Li Wang <wangli09@kuaishou.com>

Acked-by: Willem de Bruijn <willemb@google.com>
