Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5FB417F13
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 03:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346610AbhIYBtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 21:49:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232003AbhIYBtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 21:49:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A59761212;
        Sat, 25 Sep 2021 01:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632534449;
        bh=waW2Ab7Qq+0PFYknh2YodFrEZP6Ya5zSNBIAdu9AOZA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QR9lsY4BHuxmk2m9/Ui3sGQWmCIwnXPDF00jVDSTF1qcm4SHPnPTRYsutoOekIqpf
         Kfks5eC3NDYFMelXGnMJqp6Nw5veIxUBiVlohibRdvBZxOFl9mrPxipTTkRWg4E7T/
         Cw7MVnLXTdAFyMAddxUROmPAKx3Mo05pXz89ClumlCKt4kixW0wIcfb1Tv5Ja8Flxh
         JZ2ZjB8ZDCG2XVAtUFllFoXQGQgaBUhlm/T8Vt7MqTR9Av58TGytKLEpcNhDjsX+mF
         iFIRoulQy1HpNxZwBvj5iYSx88vUiHuhdnHJXusDdI2FvSY0Xlc8LV1mp/ovisJSQj
         Vgjsx3YJ0WlvQ==
Date:   Sat, 25 Sep 2021 10:47:26 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     kernel test robot <lkp@intel.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kprobes: convert tests to kunit
Message-Id: <20210925104726.043885d4c8f7ec80de2746c9@kernel.org>
In-Reply-To: <yt9dlf3ln8ev.fsf@linux.ibm.com>
References: <20210914070816.3516994-1-svens@linux.ibm.com>
        <202109150545.FABUL0Nv-lkp@intel.com>
        <yt9dlf3ln8ev.fsf@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2021 20:19:20 +0200
Sven Schnelle <svens@linux.ibm.com> wrote:

> kernel test robot <lkp@intel.com> writes:
> 
> > Hi Sven,
> >
> > Thank you for the patch! Yet something to improve:
> >
> [..]
> >    ia64-linux-ld: kernel/test_kprobes.o: in function `entry_handler':
> >>> test_kprobes.c:(.text+0x150): undefined reference to `kunit_unary_assert_format'
> >>> ia64-linux-ld: test_kprobes.c:(.text+0x212): undefined reference to `kunit_do_assertion'
> >    ia64-linux-ld: kernel/test_kprobes.o: in function `return_handler2':
> >>> test_kprobes.c:(.text+0x2f0): undefined reference to `kunit_binary_assert_format'
> >    ia64-linux-ld: test_kprobes.c:(.text+0x452): undefined reference to `kunit_do_assertion'
> >    ia64-linux-ld: test_kprobes.c:(.text+0x522): undefined reference to `kunit_do_assertion'
> 
> I missed that kunit can be built as module. I'll fix it an send a v3.

Does this mean we can not use KUnit for the feature which is not exposed to module?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
