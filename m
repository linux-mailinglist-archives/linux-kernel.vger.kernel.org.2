Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D82535C7EC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 15:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239854AbhDLNsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 09:48:53 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:38655 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237043AbhDLNsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 09:48:51 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MWAjC-1l3sDU3zAo-00XfTX for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021
 15:48:30 +0200
Received: by mail-wr1-f53.google.com with SMTP id w4so9275959wrt.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 06:48:30 -0700 (PDT)
X-Gm-Message-State: AOAM531ammDz68nLX8+eac9wEti1wSyYCAuRhopdSqimRd62DagGdMcu
        1SIoPowNwpyXu58jZbKJXq0MSOmob1N1l872Qj0=
X-Google-Smtp-Source: ABdhPJzRKsuHD0/zPPicEoAxxZxBRdHEuIhju2Sjyhs6U3CtpsN5iiGtWexs/UH9JtENKAiPv0Fc8B0whXOW4BsN5Zc=
X-Received: by 2002:a5d:6a11:: with SMTP id m17mr32604882wru.361.1618235310703;
 Mon, 12 Apr 2021 06:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210216074929.29033-1-patrice.chotard@foss.st.com>
 <1cd91834-6df8-a655-a3b1-0e16f5fe470d@foss.st.com> <52c32145-7f29-8944-58dc-dc2fb406ffb0@foss.st.com>
In-Reply-To: <52c32145-7f29-8944-58dc-dc2fb406ffb0@foss.st.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 12 Apr 2021 15:48:14 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1upDuztHd0pH_dM+OpMp8WtiMPAZN8p=9xxtCSVJGZMw@mail.gmail.com>
Message-ID: <CAK8P3a1upDuztHd0pH_dM+OpMp8WtiMPAZN8p=9xxtCSVJGZMw@mail.gmail.com>
Subject: Re: [Linux-stm32] [RESEND PATCH 0/3] MAINTAINERS: update
 STMicroelectronics email
To:     Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SoC Team <soc@kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:CNjKl+DGou3v4BG3VP5H3JCzKEpI4DZ9gDb5LCskRse0m5fX8VE
 sTWvxGAq6f74t8GCfBOYDz+H6Q/zVz8/pQdqcNbpRrkNlxgA7PPvY7QWx/l2YpPfX3vB6nT
 GGEBnweEP1ylEzONPSDzxSZMdrJi6H07e+QHdpBYN4v+twu9YrqXIWyLdzWErlmfx/rd/cw
 gXUHuvTnVain8vzPIDtaw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZMe/dcY9Ciw=:QlrR9o4mMCu6RCe73ytn7+
 FlVHSB8QiJ0pWJsNOKfi7j+Pv7VZHSVRU7/xAaqX3L+w1ncGEqUm6fniSVlt78+n7/kbCUL4J
 SGT0NeSstVEG//uCTywtE8fq3+jhg2PkwdobyA9mvOaagZVVKoB03WTnSt2I2yW+ssO0UCs2d
 0kviFrIIjn5n4L4C/c1OoA9pzRDl2yiDf2jWIj+m6L+OVRRPBURgjIBHxI7b9RK+M8IhZeZ4A
 iWY42nbmnEf17/YwGACBr+x4XJreP7iZDp6XXyWZcaslXl04p7Mo4CxQ7ijBnR8Ggo6Fmw1v+
 carKfcbMV3ULtU/OlfVo0lqjqbbbIB01jUJvGLXFcuC/i5e5/NCBmv4Fe16VuF9mSGUfCaDm/
 kyHRTWDEkNjxdtKglz4WAHboOwSYpO1M3AMnU9ORIr62EVHj5fR2PZTs02M2PU7hEXp1JGhv2
 T8VTJGkFMvu8ZlpvqTrBS6ZIAxuAViQ=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 12:19 PM Patrice CHOTARD
<patrice.chotard@foss.st.com> wrote:
>
> Hi
>
> I think this series has been forgotten, any chance to see it merged into v5.13 ?

It's in -rc7, but it appears that my email reply went missing when I merged it.

      Arnd
