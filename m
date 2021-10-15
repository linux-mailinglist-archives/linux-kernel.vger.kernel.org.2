Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1933B42F84D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 18:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241386AbhJOQgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 12:36:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235078AbhJOQgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 12:36:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07F2F60E0C;
        Fri, 15 Oct 2021 16:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634315665;
        bh=CeRkCWgGmv/lIzYdYu8TkmPyC9GDgaOguZhhWXNJNFY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OAneOMA7XZSFOfZz+nHz+4YXLFXmDwnHzcWC4zY6bn20z/F83fiY2OWgIcZ4C3Ijp
         U/kfatfek+/t6NhOK9eYmxHYG/EWHm+UGxGtwMZiPqlbDC8nUHYskjewvHnxJnQ1od
         jA4aZ/pUQ2VK0jZkcrAjqLPnR+P+mKmFb1OTDJ2JYzsLnW1BjWHI8cYHoZGdbVcsHn
         qexoVBqm6mUGlFC/34RkVMaWg5Ej7m+/T2iNVvPWNbjDuBE+0z/8aN8KhHv+vCOjKY
         U9fnn7e0HePffvnKv9p9aBvuPub8zLiMZlR1uhMzw0kndBseFhetz8LUVr2/0Lgubh
         dygurnBytBxfQ==
Received: by mail-ed1-f51.google.com with SMTP id g10so40482556edj.1;
        Fri, 15 Oct 2021 09:34:24 -0700 (PDT)
X-Gm-Message-State: AOAM530uhwk4D1cAmCUX0fNE4uG675D7uo29UikXIMsRLfflY31BbpVa
        ljrrGOdTxBWlknfe04GSQqvUvJPc1KGkrxI1dg==
X-Google-Smtp-Source: ABdhPJyib4rggH0EElJoYb3M6MGXjTs3c3OVEluVFhpPqQmG+CA7o8G7W5ifQ9eqdM31IDo3cVTH/0BnZYFo2iafnjg=
X-Received: by 2002:a17:906:6a1d:: with SMTP id qw29mr7817053ejc.147.1634315663388;
 Fri, 15 Oct 2021 09:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211013220532.24759-1-agust@denx.de>
In-Reply-To: <20211013220532.24759-1-agust@denx.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 15 Oct 2021 11:34:12 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+ThrytPNx06bD4EOBGMQ8NHqJFUX8JuR-4q5KrzJbO_g@mail.gmail.com>
Message-ID: <CAL_Jsq+ThrytPNx06bD4EOBGMQ8NHqJFUX8JuR-4q5KrzJbO_g@mail.gmail.com>
Subject: Re: [PATCH 0/4] Update mpc5200 dts files to fix warnings
To:     Anatolij Gustschin <agust@denx.de>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 5:05 PM Anatolij Gustschin <agust@denx.de> wrote:
>
> This series fixes localbus, memory and pci node build warnings.
> It was tested with current linux-next on digsy_mtc and tqm5200
> boards.
>
> Anatolij Gustschin (4):
>   powerpc/5200: dts: add missing pci ranges
>   powerpc/5200: dts: fix pci ranges warnings
>   powerpc/5200: dts: fix memory node unit name
>   powerpc/5200: dts: fix localbus node warnings

For patches 1-3:

Reviewed-by: Rob Herring <robh@kernel.org>
