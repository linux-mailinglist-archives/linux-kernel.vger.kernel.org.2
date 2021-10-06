Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63608423FFA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 16:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238904AbhJFOYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 10:24:22 -0400
Received: from mail-4325.protonmail.ch ([185.70.43.25]:60945 "EHLO
        mail-4325.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbhJFOYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 10:24:18 -0400
Date:   Wed, 06 Oct 2021 14:22:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1633530145;
        bh=0UicmB9OvRpogv82YJVzbcOGO7vYJYt9JENdlpvpBv0=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=d5wmDgxQvWwdFem6G0hFMmmfsf6Zqju0InSZzNiWl6PHcGyg2M0k6D5WGAl9WMn9K
         c9C2KGYH+pxt0c0UpSYB540ue3JD7ycxKmVnCoP7SBj4FFpDTD8mkzXZoBW0CjoJUB
         ZpYT+wmfsCaCfvJyupsRu0pb31rKI37FJbM7qGIE=
To:     Borislav Petkov <bp@alien8.de>
From:   Ser Olmy <ser.olmy@protonmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        x86-ml <x86@kernel.org>
Reply-To: Ser Olmy <ser.olmy@protonmail.com>
Subject: Re: [x86] Kernel v5.14 series panic on Celeron Mendocino CPU
Message-ID: <f0EaZtO29WDhyAmh9vNfb-GcAbQsiJ1Nc5Fh7THzZdKVi2BGt4jl3MQPhAQEhsFFdj6a_OzdY9upf9_FIjvQwpayJoKgs4gcLe92S_1Jq8s=@protonmail.com>
In-Reply-To: <YV2l+1oIGd2p/Gt5@zn.tnic>
References: <CPeoI7yf4421QpWLM-CbgeDR17BBmhlLoixeYI3mu2WbDkgrZItfgImOO6BZez7CXQXXO9liq-rmZzgRVB95TP5MN0xUA8-d7-fSQZdyIZE=@protonmail.com> <YVtA67jImg3KlBTw@zn.tnic> <lxqAtqDf_kLUxIlvmYPvuKB36LOK-z_cVbS9OOl0MbjZKZEaCaEFmHCbSy5sWBer6f9V_WAPLxUuSNrDBvyzEeQOJXepkVUztPXAOhPZniQ=@protonmail.com> <YVwjY9TX6XMxkM2f@zn.tnic> <YqPgABmVMzvEllmeYzm8tkSaqtC-Q8nzeNjgNBXVPnQtPCHAeFg7IdwpzBECDcFGjrCBkFVegcYvqh_KoGnyOsbK4oC91VHw5G-qUlwlCvM=@protonmail.com> <YV2l+1oIGd2p/Gt5@zn.tnic>
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

On Wednesday, October 6th, 2021 at 3:34 PM, Borislav Petkov <bp@alien8.de> =
wrote:
>
> On Wed, Oct 06, 2021 at 12:42:47AM +0000, Ser Olmy wrote:
>
> > [ 21.670972] fpu->state.fxsave.mxcsr: 0xb7be13b4, mxcsr_feature_mask: 0=
xffbf
> >
> > [ 21.754383] WARNING: CPU: 0 PID: 1 at arch/x86/kernel/fpu/signal.c:384=
 __fpu_restore_sig+0x51f/0x540
>
> As tglx expected.
>
> I guess this fixes your issue (replace with previous diff pls):
>

I can confirm that with the patch installed, the system does indeed boot no=
rmally with nothing out of the ordinary in the dmesg log. Thanks.

Best Regards,

Olmy
