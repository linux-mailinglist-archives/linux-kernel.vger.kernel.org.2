Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5BE316095
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 09:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbhBJIHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 03:07:39 -0500
Received: from sym2.noone.org ([178.63.92.236]:34376 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229834AbhBJIHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:07:32 -0500
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4DbC5d0JN9zvjhQ; Wed, 10 Feb 2021 09:06:44 +0100 (CET)
Date:   Wed, 10 Feb 2021 09:06:44 +0100
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, shuah@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, vincenzo.frascino@arm.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] selftests/vDSO: fix ABI selftest on riscv
Message-ID: <20210210080644.gc3wyt4fq72u3khz@distanz.ch>
References: <20210204145042.7345-1-tklauser@distanz.ch>
 <mhng-1ed0f9e8-84ec-4f2e-ac42-5a608726e2fe@palmerdabbelt-glaptop>
 <20210205075745.jlf3vsjkp3n3rwss@distanz.ch>
 <5a8923b2-0c5e-ab6c-52fd-f00bc1361a3f@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a8923b2-0c5e-ab6c-52fd-f00bc1361a3f@linuxfoundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-09 at 00:37:24 +0100, Shuah Khan <skhan@linuxfoundation.org> wrote:
> On 2/5/21 12:57 AM, Tobias Klauser wrote:
> > On 2021-02-05 at 08:06:37 +0100, Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > > On Thu, 04 Feb 2021 06:50:42 PST (-0800), tklauser@distanz.ch wrote:
> > 
> > [...]
> > 
> > > Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> > > Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
> > 
> > Thank you!
> > 
> > > Not sure if you want this through the RISC-V tree, so I'm leaving it out for
> > > now and assuming it'll go through a kselftest tree.
> > 
> > Either way is fine for me.
> > 
> 
> Thank you. Applied to linux-kselftest next for 5.12-rc1

Thank you Shuah!
