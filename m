Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9708E41D387
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 08:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348196AbhI3GjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 02:39:20 -0400
Received: from protonic.xs4all.nl ([83.163.252.89]:41616 "EHLO
        protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348144AbhI3GjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 02:39:19 -0400
Received: from fiber.protonic.nl (edge2.prtnl [192.168.1.170])
        by sparta.prtnl (Postfix) with ESMTP id 0381A44A024E;
        Thu, 30 Sep 2021 08:37:36 +0200 (CEST)
MIME-Version: 1.0
Date:   Thu, 30 Sep 2021 08:37:35 +0200
From:   Robin van der Gracht <robin@protonic.nl>
To:     Mianhan Liu <liumh1@shanghaitech.edu.cn>
Cc:     Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] drivers/auxdisplay/ht16k33.c: remove superfluous
 header files from ht16k33.c
Reply-To: robin@protonic.nl
In-Reply-To: <20210928191509.3806-1-liumh1@shanghaitech.edu.cn>
References: <20210928191509.3806-1-liumh1@shanghaitech.edu.cn>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <2a385c2e6fc133a9d93bded92a946e4f@protonic.nl>
X-Sender: robin@protonic.nl
Organization: Protonic Holland
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-28 21:15, Mianhan Liu wrote:
> ht16k33.c hasn't use any macro or function declared in linux/slab.h.
> Thus, these files can be removed from ht16k33.c safely without
> affecting the compilation of the drivers/auxdisplay/ module
> 
> Signed-off-by: Mianhan Liu <liumh1@shanghaitech.edu.cn>
> 
> ---
>  drivers/auxdisplay/ht16k33.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
> index 1e69cc6d2..6502bc00e 100644
> --- a/drivers/auxdisplay/ht16k33.c
> +++ b/drivers/auxdisplay/ht16k33.c
> @@ -13,7 +13,6 @@
>  #include <linux/i2c.h>
>  #include <linux/of.h>
>  #include <linux/fb.h>
> -#include <linux/slab.h>
>  #include <linux/backlight.h>
>  #include <linux/input.h>
>  #include <linux/input/matrix_keypad.h>

Acked-by: Robin van der Gracht <robin@protonic.nl>
