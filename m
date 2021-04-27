Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D5C36CAB0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 19:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236761AbhD0R5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 13:57:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230219AbhD0R5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 13:57:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CAC0D60FDB;
        Tue, 27 Apr 2021 17:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619546211;
        bh=CLsSmbPTVRvVMX8uRj7Bl5HbFdXWRbxGbg3Fz7lyRZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W3R7hZLMhkC9gsRyPdz7KsDOMUxK185cs2Acli3/TgZ3Dx9xQDrk2kd7VhdGjHwLP
         +qkr4fjzOfFKWBePJ9ayRPsgtYo+oO2nw3vnz3dbnbsT4v49dzBQYNrwDDcqv8ex/5
         H9M8eam+asNCjuhesxZ8xKX6TH79XaRYfnT10X5A=
Date:   Tue, 27 Apr 2021 19:56:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 068/190] Revert "fore200e: Fix incorrect checks of NULL
 pointer dereference"
Message-ID: <YIhQYJancyH7NhBt@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-69-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-69-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:59:03PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit bbd20c939c8aa3f27fa30e86691af250bf92973a.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: Aditya Pakki <pakki001@umn.edu>
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/atm/fore200e.c | 25 +++++++------------------
>  1 file changed, 7 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
> index 495fd0a1f040..e83286e3216e 100644
> --- a/drivers/atm/fore200e.c
> +++ b/drivers/atm/fore200e.c
> @@ -1412,14 +1412,12 @@ fore200e_open(struct atm_vcc *vcc)
>  static void
>  fore200e_close(struct atm_vcc* vcc)
>  {
> +    struct fore200e*        fore200e = FORE200E_DEV(vcc->dev);
>      struct fore200e_vcc*    fore200e_vcc;
> -    struct fore200e*        fore200e;
>      struct fore200e_vc_map* vc_map;
>      unsigned long           flags;
>  
>      ASSERT(vcc);
> -    fore200e = FORE200E_DEV(vcc->dev);
> -
>      ASSERT((vcc->vpi >= 0) && (vcc->vpi < 1<<FORE200E_VPI_BITS));
>      ASSERT((vcc->vci >= 0) && (vcc->vci < 1<<FORE200E_VCI_BITS));
>  
> @@ -1464,10 +1462,10 @@ fore200e_close(struct atm_vcc* vcc)
>  static int
>  fore200e_send(struct atm_vcc *vcc, struct sk_buff *skb)
>  {
> -    struct fore200e*        fore200e;
> -    struct fore200e_vcc*    fore200e_vcc;
> +    struct fore200e*        fore200e     = FORE200E_DEV(vcc->dev);
> +    struct fore200e_vcc*    fore200e_vcc = FORE200E_VCC(vcc);
>      struct fore200e_vc_map* vc_map;
> -    struct host_txq*        txq;
> +    struct host_txq*        txq          = &fore200e->host_txq;
>      struct host_txq_entry*  entry;
>      struct tpd*             tpd;
>      struct tpd_haddr        tpd_haddr;
> @@ -1480,18 +1478,9 @@ fore200e_send(struct atm_vcc *vcc, struct sk_buff *skb)
>      unsigned char*          data;
>      unsigned long           flags;
>  
> -    if (!vcc)
> -        return -EINVAL;
> -
> -    fore200e = FORE200E_DEV(vcc->dev);
> -    fore200e_vcc = FORE200E_VCC(vcc);
> -
> -    if (!fore200e)
> -        return -EINVAL;
> -
> -    txq = &fore200e->host_txq;
> -    if (!fore200e_vcc)
> -        return -EINVAL;
> +    ASSERT(vcc);
> +    ASSERT(fore200e);
> +    ASSERT(fore200e_vcc);
>  
>      if (!test_bit(ATM_VF_READY, &vcc->flags)) {
>  	DPRINTK(1, "VC %d.%d.%d not ready for tx\n", vcc->itf, vcc->vpi, vcc->vpi);
> -- 
> 2.31.1
> 

Wow, the names in this code bring back memories...

Anyway, the original looks correct, but could have been written a lot
better, it's quite "twisty" for something that should have been very
simple to make "obvious".

I'll drop this revert.

thanks,

greg k-h
