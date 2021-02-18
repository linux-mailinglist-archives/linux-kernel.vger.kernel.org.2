Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D3D31EF22
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbhBRTBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:01:36 -0500
Received: from mail-02.mail-europe.com ([51.89.119.103]:34162 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbhBRRW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 12:22:26 -0500
Date:   Thu, 18 Feb 2021 17:19:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1613668797;
        bh=eMQ9wejdkfSy6ufKo1ig20AOpgFlxP2XLZYAMHxn5PE=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=o+azsuTIG+EvZecrrKxGl56aKVz1cmVL9f8VvRBmZMGKJTW9peGWaSQybqp6L89He
         tmVG+ISK8dtHYa/uuQcnDkFDvxr5CTnGwNy0if5VBHkNK4GwZkDTpobGzjfqkYCSqF
         RZ3CYUfOJQR01rb1rVHF3zog/NDNVBywuQ5qCTEU=
To:     Willy Tarreau <w@1wt.eu>
From:   Jari Ruusu <jariruusu@protonmail.com>
Cc:     Jari Ruusu <jariruusu@users.sourceforge.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Reply-To: Jari Ruusu <jariruusu@protonmail.com>
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
Message-ID: <dbLhDu5W6LMrWDRrgzNQJGLZPMWGkRtOcxFUbghT-Uuc8zmQObV5KjhYqVBo2U6k7r2rNVtVEaMjev_lyz8eNQGvksSTjVrHd8LaPrO_6Qs=@protonmail.com>
In-Reply-To: <20210218143341.GB13671@1wt.eu>
References: <ef30af4d-2081-305d-cd63-cb74da819a6d@broadcom.com> <YA/E1bHRmZb50MlS@kroah.com> <8cf503db-ac4c-a546-13c0-aac6da5c073b@broadcom.com> <YBBkplRxzzmPYKC+@kroah.com> <YCzknUTDytY8gRA8@kroah.com> <c731b65a-e118-9d37-79d1-d0face334fc4@broadcom.com> <YC4atKmK7ZqlOGER@kroah.com> <20210218113107.GA12547@1wt.eu> <602E766F.758C74D8@users.sourceforge.net> <20210218143341.GB13671@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, February 18, 2021 4:33 PM, Willy Tarreau <w@1wt.eu> wrote:
> Usually you pick an LTS kernel for a specific hardware. If it
> works that's great. But you cannot expect hardware to suddenly start to
> work in the middle of a stable kernel. Sometimes it happens (PCI IDs) but
> that's basically all and that's not their purpose.

It was the other way around. Fine working in-tree driver got
broken by backported "fixes". I did mention bit-rot.

In-tree iwlwifi worked half-ok on early 4.9.y stable. If
connection somehow de-autheticated (out of radio range or
whatever) it crashed the kernel spectacularly. Eventually that was
fixed and in-tree iwlwifi worked fine on 4.9.y and 4.14.y stable
kernels. On second half of year 2020 (don't remember exactly when)
iwlwifi started causing erratic behavior when some random process
terminated, as if some exit processing left some resources
un-freed or something weird like that. Upgraded to 4.19.y kernels
in hope to fix the issue. Nope, same problems continued there as
well. Replacing in-tree iwlwifi with out-of-tree upstream Intel
version solved the problem for me.

--
Jari Ruusu=C2=A0 4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD=C2=A0 ACDF F073 3C=
80 8132 F189

