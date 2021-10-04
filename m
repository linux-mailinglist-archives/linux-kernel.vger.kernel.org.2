Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC35A42067E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 09:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhJDHRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 03:17:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229720AbhJDHR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 03:17:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3683610E6;
        Mon,  4 Oct 2021 07:15:38 +0000 (UTC)
Date:   Mon, 4 Oct 2021 09:15:36 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, christian@brauner.io,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH] RISC-V: Include clone3() on rv32
Message-ID: <20211004071536.hloqmba6y4cw3hli@wittgenstein>
References: <20211003002120.198752-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211003002120.198752-1-palmer@dabbelt.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 02, 2021 at 05:21:20PM -0700, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmerdabbelt@google.com>
> 
> As far as I can tell this should be enabled on rv32 as well, I'm not
> sure why it's rv64-only.  checksyscalls is complaining about our lack of
> clone3() on rv32.
> 
> Fixes: 56ac5e213933 ("riscv: enable sys_clone3 syscall for rv64")
> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
> ---

Thanks!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
