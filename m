Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE0A3668EB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 12:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239003AbhDUKMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 06:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbhDUKMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 06:12:30 -0400
X-Greylist: delayed 494 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 21 Apr 2021 03:11:57 PDT
Received: from sym2.noone.org (sym2.noone.org [IPv6:2a01:4f8:120:4161::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D4CC06174A;
        Wed, 21 Apr 2021 03:11:57 -0700 (PDT)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4FQGNT1gRhzvjfp; Wed, 21 Apr 2021 12:03:53 +0200 (CEST)
Date:   Wed, 21 Apr 2021 12:03:52 +0200
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/26] serial: altera_jtaguart: drop low-latency
 workaround
Message-ID: <20210421100352.vayt5himhl7php4h@distanz.ch>
References: <20210421095509.3024-1-johan@kernel.org>
 <20210421095509.3024-3-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421095509.3024-3-johan@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-04-21 at 11:54:45 +0200, Johan Hovold <johan@kernel.org> wrote:
> Commit 53dd0ba7a6f4 ("tty: serial: altera_jtag: drop uart_port->lock
> before calling tty_flip_buffer_push()") claimed to address a locking
> issue but only provided a dubious lockdep splat from an unrelated
> driver, which in the end turned out to be due a broken local change
> carried by the author.
> 
> Unfortunately these patches were merged before the issue had been
> analysed properly so the commit messages makes no sense whatsoever.
> 
> The real issue was first seen on RT which at the time effectively always
> set the low_latency flag for all serial drivers by patching
> tty_flip_buffer_push(). This in turn revealed that many drivers did not
> handle the infamous low_latency behaviour which meant that data was
> pushed immediately to the line discipline instead of being deferred to a
> work queue.
> 
> Since commit a9c3f68f3cd8 ("tty: Fix low_latency BUG"),
> tty_flip_buffer_push() always schedules a work item to push data to the
> line discipline and there's no need to keep any low_latency hacks
> around.
> 
> Link: https://lore.kernel.org/linux-serial/cover.1376923198.git.viresh.kumar@linaro.org/
> Cc: Tobias Klauser <tklauser@distanz.ch>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Acked-by: Tobias Klauser <tklauser@distanz.ch>

Thanks
