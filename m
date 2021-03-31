Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6EF534F5E0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbhCaBKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:10:55 -0400
Received: from ozlabs.org ([203.11.71.1]:51867 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233136AbhCaBK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:10:26 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4F97Xd4Tm5z9sXh; Wed, 31 Mar 2021 12:10:25 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Paul Mackerras <paulus@samba.org>
In-Reply-To: <20210303124603.3150175-1-lee.jones@linaro.org>
References: <20210303124603.3150175-1-lee.jones@linaro.org>
Subject: Re: [RESEND 1/1] powerpc: asm: hvconsole: Move 'hvc_vio_init_early's prototype to shared location
Message-Id: <161715296598.226945.6217795321816645614.b4-ty@ellerman.id.au>
Date:   Wed, 31 Mar 2021 12:09:25 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Mar 2021 12:46:03 +0000, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/tty/hvc/hvc_vio.c:385:13: warning: no previous prototype for ‘hvc_vio_init_early’ [-Wmissing-prototypes]
>  385 | void __init hvc_vio_init_early(void)
>  | ^~~~~~~~~~~~~~~~~~

Applied to powerpc/next.

[1/1] powerpc: asm: hvconsole: Move 'hvc_vio_init_early's prototype to shared location
      https://git.kernel.org/powerpc/c/13b8219bd00d953cad60431cb47db96eb835c71d

cheers
