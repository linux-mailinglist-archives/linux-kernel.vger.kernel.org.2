Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CE632EDF4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 16:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhCEPJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 10:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhCEPJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 10:09:00 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428BEC061756
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 07:09:00 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id w9so2995576edt.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 07:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JjTJfcQAXeOWcp9QkQJCNvSpKl1Ds2qR5zvC+5VzgvI=;
        b=CpyWh+9m1kcl9bm6CS/WtsL7nEetdYXq/2VszRk50K4nPPdMtT736vpXI66iJE+BnP
         t8M5VYEFLqkXwIEad8lE8fLWYnkJMGaBvSLvWwSvibSg8gdi+vB6cm6o3ema3ymJDQCr
         eF5qaICjAyLicS6JRBJ5Q+SM4a9temU0s9hUkJtp/QsB3KWbgOJRQFC9XJr14GCTDkj8
         MsijxkYsXAqGstSCZWDAn3d9H/XiLJICOFqB2MaG/DRPPjEHUTt7cfphfPT0TdG1PRnF
         TFVOapdBPLFDGav+yFTXhp7qDZ/uuVWuH++U/k3g/b2dk2ztzQksQfKYu6AC3nr/AftS
         zG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JjTJfcQAXeOWcp9QkQJCNvSpKl1Ds2qR5zvC+5VzgvI=;
        b=t43wTcrjgL9+tMujtUryChya7tZypynebFZbNi1AFn4mOPYsNQ2j/IXqcVWxGXqgUf
         muy1/a+xrHpxiZWN6vX9sOdY9L9RlC8zVI3yOdq/uPvUoh9nhJAYLVE6kz9zbpkEG2Yb
         Y+lSotCOyjFB2tlmLs4SYjxWPF2EKUmeTYricLsLZF0EazeCF1gV1lda+Rg0uRtT7rim
         m+NyhLuRRJLsaWgDN669Wy91efgAx7r1Mr3MNR3WaPPJ0ABp56kPihLAaX9Rw714KOpv
         Rd3ajXLewb2QMkxKBrHTu29YoPHEQnkRo1RRU5B4e8c9disK2jaYd7RYEZWeIlg51k2S
         bp7w==
X-Gm-Message-State: AOAM532sUhDpX7xYAsPL4opL3XX3QeHt7+KOBr6PlDIgKqtyiAQvFbQ1
        R/pM9OGdS+E3ottnlYuDlOIdxWmmI1Q=
X-Google-Smtp-Source: ABdhPJxEc/rrcrWHQeRgxjIsdE1j+HeMJksQCkPL69b+mMWxx2dpwxrs4iv/Qx7u9byhSki4ylKShg==
X-Received: by 2002:a05:6402:1c1b:: with SMTP id ck27mr9514354edb.223.1614956938719;
        Fri, 05 Mar 2021 07:08:58 -0800 (PST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id f11sm1636142eje.107.2021.03.05.07.08.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 07:08:58 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id a18so2420216wrc.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 07:08:56 -0800 (PST)
X-Received: by 2002:a5d:640b:: with SMTP id z11mr9605831wru.327.1614956936586;
 Fri, 05 Mar 2021 07:08:56 -0800 (PST)
MIME-Version: 1.0
References: <20210305123347.15311-1-hxseverything@gmail.com>
In-Reply-To: <20210305123347.15311-1-hxseverything@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 5 Mar 2021 10:08:20 -0500
X-Gmail-Original-Message-ID: <CA+FuTSc_RDHb8dmMzfwatt89pXsX2AA1--X98pEGkmmfpVs-Vg@mail.gmail.com>
Message-ID: <CA+FuTSc_RDHb8dmMzfwatt89pXsX2AA1--X98pEGkmmfpVs-Vg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests_bpf: extend test_tc_tunnel test with vxlan
To:     Xuesen Huang <hxseverything@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>, bpf <bpf@vger.kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Xuesen Huang <huangxuesen@kuaishou.com>,
        Li Wang <wangli09@kuaishou.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 5, 2021 at 7:34 AM Xuesen Huang <hxseverything@gmail.com> wrote:
>
> From: Xuesen Huang <huangxuesen@kuaishou.com>
>
> Add BPF_F_ADJ_ROOM_ENCAP_L2_ETH flag to the existing tests which
> encapsulates the ethernet as the inner l2 header.
>
> Update a vxlan encapsulation test case.
>
> Signed-off-by: Xuesen Huang <huangxuesen@kuaishou.com>
> Signed-off-by: Li Wang <wangli09@kuaishou.com>
> Signed-off-by: Willem de Bruijn <willemb@google.com>


Please don't add my signed off by without asking.

That said,

Acked-by: Willem de Bruijn <willemb@google.com>
