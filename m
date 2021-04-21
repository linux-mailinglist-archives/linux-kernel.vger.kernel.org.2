Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45BFB366EF6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 17:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243921AbhDUPUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 11:20:40 -0400
Received: from ciao.gmane.io ([116.202.254.214]:40106 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234308AbhDUPUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 11:20:37 -0400
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glk-linux-kernel-4@m.gmane-mx.org>)
        id 1lZEe2-0005hj-2h
        for linux-kernel@vger.kernel.org; Wed, 21 Apr 2021 17:20:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   Tavis Ormandy <taviso@gmail.com>
Subject: Re: [PATCH 186/190] Revert "virt: vbox: Only copy_from_user the
 request-header once"
Date:   Wed, 21 Apr 2021 15:14:29 -0000 (UTC)
Message-ID: <s5pfgl$all$1@ciao.gmane.io>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-187-gregkh@linuxfoundation.org>
User-Agent: slrn/pre1.0.4-5 (Linux)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-04-21, Greg Kroah-Hartman wrote:
> This reverts commit bd23a7269834dc7c1f93e83535d16ebc44b75eba.
>
> -	*((struct vbg_ioctl_hdr *)buf) = hdr;
> -	if (copy_from_user(buf + sizeof(hdr), (void *)arg + sizeof(hdr),
> -			   hdr.size_in - sizeof(hdr))) {
> +	if (copy_from_user(buf, (void *)arg, hdr.size_in)) {
>  		ret = -EFAULT;
>  		goto out;
>  	}

This one seems like a real bugfix, otherwise there's a double-fetch from
userspace, and a TOCTOU with the hdr fields that could cause a OOB read.

Reviewed-by: Tavis Ormandy <taviso@gmail.com>

Tavis.


-- 
 _o)            $ lynx lock.cmpxchg8b.com
 /\\  _o)  _o)  $ finger taviso@sdf.org
_\_V _( ) _( )  @taviso

