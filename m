Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800333F3ACD
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 15:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbhHUNmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 09:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhHUNmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 09:42:35 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE99C061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 06:41:56 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id d11so26056138eja.8
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 06:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TeKh2a6tL1O7r/BPYMAdDrJPmjZaEASKoGVN1mT54FY=;
        b=KwIHmklndMgpFkH3N6bSWNDQ3P+OQ6J9a1Xfdop6d40wko87+aJh90VyHV9RNp9WXn
         KXZS/8L/XctzYmME5gXp2ke4ih7y7rX6+nJvfhV8bEbLhvEb3VCzpOPCzpylZa0xRk+g
         N5Ia0utM4rqXA9yxatCfGhB1d17+UDiZKsrUWYn6geXOIgXT/YvyJqsUlgGrCQ7N7q2Z
         47ghG0hBbN1VmeNlR/jYu2XASysMzchajEyU+Hl74mIgUQJBfU0DCVp2434pX2UgJtZG
         GvPmCECmCn2/UE5iV+uFySy4tX5l90y/uJncFQVmpr9iUqyJRg4lIj7RwdU/LKVv9fpO
         aJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TeKh2a6tL1O7r/BPYMAdDrJPmjZaEASKoGVN1mT54FY=;
        b=nm5NJNY2iz1KkXnJnto/09rEE+fjtIfS82E94BVHI8wMGiVPVAZ+kNsh/UQumC5g8m
         fmi5idyfL0yVrYjGCg3xbP9v1XZgyM2UR6yuHyr+Wy5dcNlMKz1DJ7TLZ/wD5PbT8Guj
         9vkJC18Es8KxxrmKhHVDrqHsYCASGLHIixnZZ+motRZxNJMo06oPiKcBS/k5d//rfjRZ
         ZeDbv77Eew08zBIrzqpz54Egc80SjGQmjv35vls1yPnTYaGbqnb/pxpjWABnOCWLz7tf
         1Wh3/iJa3Ee2hBGnQVRqCVtrpEe50Ndfmdh5qrdVF8SqfiSczpMOwU+SLNc46DiYIloI
         yMIQ==
X-Gm-Message-State: AOAM531ASk71uP9EnF7CCCDpNpR1GVpt0AhJ3f0hiZ+BZ/+nZVr+R1AG
        HtEGLF6fEtyIN+d1PqaqyCdW8vW8C7xFJA==
X-Google-Smtp-Source: ABdhPJxChwzLPZ7Ks2pQvEd2hNYpHhilpeKntzDccDXdoZYVn99GTdvjAWpdFMWRrnMM6Gx8TFjeJQ==
X-Received: by 2002:a17:906:781:: with SMTP id l1mr26778291ejc.289.1629553314761;
        Sat, 21 Aug 2021 06:41:54 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id rl23sm1700583ejb.50.2021.08.21.06.41.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Aug 2021 06:41:53 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id w21-20020a7bc1150000b02902e69ba66ce6so7727952wmi.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 06:41:53 -0700 (PDT)
X-Received: by 2002:a7b:c351:: with SMTP id l17mr8559189wmj.120.1629553313119;
 Sat, 21 Aug 2021 06:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210819100447.00201b26@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20210821071425.512834-1-chouhan.shreyansh630@gmail.com>
In-Reply-To: <20210821071425.512834-1-chouhan.shreyansh630@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sat, 21 Aug 2021 09:41:14 -0400
X-Gmail-Original-Message-ID: <CA+FuTSeWY-0+VtERqAxNwmHAwmarYh_HQUoF3b0wHiwAaL+h+A@mail.gmail.com>
Message-ID: <CA+FuTSeWY-0+VtERqAxNwmHAwmarYh_HQUoF3b0wHiwAaL+h+A@mail.gmail.com>
Subject: Re: [PATCH 1/2 net] ip_gre: add validation for csum_start
To:     Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
Cc:     davem@davemloft.net, yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        kuba@kernel.org, pshelar@nicira.com,
        willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+ff8e1b9f2f36481e2efc@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2021 at 3:14 AM Shreyansh Chouhan
<chouhan.shreyansh630@gmail.com> wrote:
>
> Validate csum_start in gre_handle_offloads before we call _gre_xmit so
> that we do not crash later when the csum_start value is used in the
> lco_csum function call.
>
> This patch deals with ipv4 code.
>
> Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")
> Reported-by: syzbot+ff8e1b9f2f36481e2efc@syzkaller.appspotmail.com
> Signed-off-by: Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
